using System;
using System.Collections.Generic;
using System.IO;

namespace Assembler.Core
{
    public class MPUAssembler
    {
        public MPUAssembler(string path)
        {
            System.Console.WriteLine("Reading code...");
            ReadCode(path);
            CodeBinaryList = new List<BinaryCode>(CodeStringList.Count);
            System.Console.WriteLine("Processing code...");
            ProcessCode();
            System.Console.WriteLine("Process complete");
        }

        /// <summary>
        /// 해석이 완료된 코드의 바이트 배열을 가져옴
        /// </summary>
        /// <returns></returns>
        public byte[] GetMachineCode()
        {
            //byte[] a = { 0x00, 0x01, 0x02 };
            byte[] result = new byte[CodeBinaryList.Count * 4];
            for (int i = 0; i < CodeBinaryList.Count; i++)
            {
                result[4*i] = CodeBinaryList[i].Bin[0];
                result[4*i+1] = CodeBinaryList[i].Bin[1];
                result[4*i+2] = CodeBinaryList[i].Bin[2];
                result[4*i+3] = CodeBinaryList[i].Bin[3];
            }

            return result;
        }

        /// <summary>
        /// 해석이 완료된 코드를 바이너리 파일 형태로 저장
        /// </summary>
        /// <param name="path">저장될 파일의 경로(파일명.확장자 포함)</param>
        /// <returns>저장 성공 여부</returns>
        public bool SaveMachineCode(string path)
        {
            FileStream fileStream = new FileStream(path, FileMode.Create);
            using (BinaryWriter writer = new BinaryWriter(fileStream))
            {
                writer.Write(GetMachineCode());
            }

            System.Console.WriteLine("Saved binary file");
            return true;
        }

        private void ReadCode(string path)
        {
            try
            {
                System.IO.StreamReader file =
                    new System.IO.StreamReader(path);

                CodeStringList = new List<string>();
                string line;
                while ((line = file.ReadLine()) != null)
                {
                    //System.Console.WriteLine(line);
                    CodeStringList.Add(line);
                }

                file.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
        }

        private void ProcessCode()
        {
            interpreter = new MPUInterpreter();
            System.Console.WriteLine("Preprocessing code...");
            interpreter.Preprocess(CodeStringList);
            System.Console.WriteLine("Interpreting code...");
            CodeBinaryList = interpreter.Interpret();
        }

        private MPUInterpreter interpreter;
        private List<string> CodeStringList { get; set; }
        private List<BinaryCode> CodeBinaryList { get; set; }
    }
}

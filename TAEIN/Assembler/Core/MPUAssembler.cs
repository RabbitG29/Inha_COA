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

        public byte[] getMachineCode()
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

        public bool SaveMachineCode(string path)
        {
            FileStream fileStream = new FileStream(path, FileMode.Create);
            using (BinaryWriter writer = new BinaryWriter(fileStream))
            {
                writer.Write(getMachineCode());
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
            // throw new MPUException("test exception");
            MPUInterpreter interpreter = new MPUInterpreter();
            System.Console.WriteLine("Preprocessing code...");
            interpreter.Preprocess(CodeStringList);
            System.Console.WriteLine("Interpreting code...");
            CodeBinaryList = interpreter.InterPret();
        }

        private List<string> CodeStringList { get; set; }
        private List<BinaryCode> CodeBinaryList { get; set; }
    }
}

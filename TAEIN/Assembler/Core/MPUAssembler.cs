using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/*
 * JMP begin
 * x0 6
 * x1 36
 * x2 6
 * x3 36
 * y0 36
 * y1 6
 * y2 36
 * y3 6
 * begin:
 * MLD D1, x0
 * MLD D2, y0
 * MADD D1, D2
 */
namespace Assembler.Core
{
    public class MPUAssembler
    {
        public MPUAssembler(string path)
        {
            ReadCode(path);
            CodeBinaryList = new List<BinaryCode>(CodeStringList.Count);
            ProcessCode();
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

        public bool saveMachineCode(string path)
        {
            FileStream fileStream = new FileStream(path, FileMode.Create);
            using (BinaryWriter writer = new BinaryWriter(fileStream))
            {
                writer.Write(getMachineCode());
            }

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
            MAUInterpreter interpreter = new MAUInterpreter();
            interpreter.Preprocess(CodeStringList);
            CodeBinaryList = interpreter.InterPret();
        }

        private List<string> CodeStringList { get; set; }
        private List<BinaryCode> CodeBinaryList { get; set; }
    }
}

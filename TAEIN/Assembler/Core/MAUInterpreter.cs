using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler.Core
{
    public class MAUInterpreter
    {
        public BinaryCode InterpretCode(string code)
        {
            BinaryCode binaryCode = new BinaryCode("00000001000000000000000000000100");
            string[] words = code.Split(delimiters);
            switch (words[0])
            {
                // I???, I???I는 미구현
                case "MLD":
                    binaryCode = makeMLD(code);
                    break;
                case "MSTR":
                    binaryCode = makeMSTR(code);
                    break;
                case "MADD":
                    binaryCode = makeMADD(code);
                    break;
                case "MSUB":
                    binaryCode = makeMSUB(code);
                    break;
                case "MMUL":
                    binaryCode = makeMMUL(code);
                    break;
                case "SMUL":
                    binaryCode = makeSMUL(code);
                    break;
                case "MCMP":
                    binaryCode = makeMCMP(code);
                    break;
                case "ICMP":
                    binaryCode = makeICMP(code);
                    break;
                case "JMP":
                    binaryCode = makeJMP(code);
                    break;
                case "JEQ":
                    binaryCode = makeJEQ(code);
                    break;
                case "JGT":
                    binaryCode = makeJGT(code);
                    break;
                case "JLS":
                    binaryCode = makeJLS(code);
                    break;
                case "ZERO":
                    binaryCode = makeZERO(code);
                    break;
            }

            return binaryCode;
        }

        /* Label이 가리키는 주소 & 변수 공간의 주소를 addressDictionary에 추가하고,
         명령어에서 Label 혹은 변수 공간을 가리키는 경우 실제 address로 대체
        */
        public void Preprocess(List<string> codeStringList)
        {
            // 1. Label이 가리키는 주소 & 변수 공간의 주소를 addressDictionary에 추가
            int foundCount = 0;
            for (int i = 0; i < codeStringList.Count; i++)
            {
                string code = codeStringList[i];
                string[] words = code.Split(delimiters);
                if (words[0].Contains(":"))
                {
                    int address = i - foundCount;
                    addressDictionary.Add(code.Substring(0, code.IndexOf(":", StringComparison.Ordinal)), address);
                    foundCount++;
                } else if (!COMMANDS.Contains(words[0]))
                {
                    int address = i - foundCount;
                    addressDictionary.Add(words[0], address);
                    preprocessedCodeStringList.Add(code);
                }
                else
                {
                    preprocessedCodeStringList.Add(code);
                }
            }
            // 2. 명령어에서 Label 혹은 변수 공간을 가리키는 경우 실제 address로 대체
            for (int i = 0; i < preprocessedCodeStringList.Count; i++)
            {
                var code = preprocessedCodeStringList[i];
                string[] words = code.Split(delimiters);
                for (int j = 1; j < words.Length; j++)
                {
                    string word = words[j];
                    // ex) MLD D1, x0
                    foreach (var kv in addressDictionary)
                    {
                        if (word.Equals(kv.Key))
                        {
                            preprocessedCodeStringList[i] = preprocessedCodeStringList[i].Replace(kv.Key, kv.Value.ToString());
                        }
                    }
                }
            }
        }

        private BinaryCode makeMLD(string code)
        {
            /* MLD D2 x0  (x0가 두 번째 코드줄에 있다고 가정)
             000000 01 0000000000000000000001 00 // 32bit
            */
            string[] words = code.Split(delimiters);
            StringBuilder result = new StringBuilder();
            result.Append("000000"); // OPCode

            // D[n]
            if (words[1] == "D1")
            {
                result.Append("00");
            }
            else if (words[1] == "D2")
            {
                result.Append("01");
            }
            else if (words[1] == "D3")
            {
                result.Append("10");
            }
            else
            {
                throw new MPUException("Unknown D[n] in MLD");
            }

            // 

            return new BinaryCode(result.ToString());
        }

        private BinaryCode makeMSTR(string code)
        {
            throw new NotImplementedException();
        }

        private BinaryCode makeMADD(string code)
        {
            throw new NotImplementedException();
        }

        private BinaryCode makeMSUB(string code)
        {
            throw new NotImplementedException();
        }

        private BinaryCode makeMMUL(string code)
        {
            throw new NotImplementedException();
        }

        private BinaryCode makeSMUL(string code)
        {
            throw new NotImplementedException();
        }

        private BinaryCode makeMCMP(string code)
        {
            throw new NotImplementedException();
        }

        private BinaryCode makeICMP(string code)
        {
            throw new NotImplementedException();
        }

        private BinaryCode makeJMP(string code)
        {
            throw new NotImplementedException();
        }

        private BinaryCode makeJEQ(string code)
        {
            throw new NotImplementedException();
        }

        private BinaryCode makeJGT(string code)
        {
            throw new NotImplementedException();
        }

        private BinaryCode makeJLS(string code)
        {
            throw new NotImplementedException();
        }

        private BinaryCode makeZERO(string code)
        {
            throw new NotImplementedException();
        }

        private static List<string> preprocessedCodeStringList = new List<string>();
        private static Dictionary<string, int> addressDictionary = new Dictionary<string, int>();
        private static readonly string[] COMMANDS = {
            "MLD", "MSTR", "MADD", "MSUB", "MMUL", "SMUL", "MCMP", "ICMP", "JMP", "JEQ", "JGT", "JLS", "ZERO"
        };
        private readonly char[] delimiters = { ' ', '\t', ',' };
    }
}

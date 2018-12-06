﻿using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler.Core
{
    public class MAUInterpreter
    {
        public List<BinaryCode> InterPret()
        {
            List<BinaryCode> codeBinaryList = new List<BinaryCode>(preprocessedCodeStringList.Count);

            foreach (string code in preprocessedCodeStringList)
            {
                codeBinaryList.Add(InterpretCode(code));
            }

            return codeBinaryList;
        }
        private BinaryCode InterpretCode(string code)
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
                default:
                    binaryCode = new BinaryCode("00000000000000000000000000000000");
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
                }
                else if (!COMMANDS.Contains(words[0]))
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
            string[] words = code.Split(delimiters).Where(x => !string.IsNullOrEmpty(x)).ToArray();
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

            // 주소값 to 이진수 string
            result.Append(Convert.ToString(Convert.ToUInt32(words[2]), 2).PadLeft(22, '0'));
            result.Append("00"); // UNUSED

            if(result.Length != 32) { throw new MPUException("Command length is not 32"); }
            return new BinaryCode(result.ToString());
        }

        private BinaryCode makeMSTR(string code)
        {
            /* MSTR z0, D3  (x0가 두 번째 코드줄에 있다고 가정)
             000001 0000000000000000000001 01 00 // 32bit
            */
            string[] words = code.Split(delimiters).Where(x => !string.IsNullOrEmpty(x)).ToArray();
            StringBuilder result = new StringBuilder();
            result.Append("000001"); // OPCode

            // 주소값 to 이진수 string
            result.Append(Convert.ToString(Convert.ToUInt32(words[1]), 2).PadLeft(22, '0'));

            // D[n]
            if (registerDictionary.TryGetValue(words[2], out var binaryRegisterN))
            {
                result.Append(binaryRegisterN);
            }
            else
            {
                throw new MPUException("Unknown D[n] in MLD");
            }
            result.Append("00"); // UNUSED

            if (result.Length != 32) { throw new MPUException("Command length is not 32"); }
            return new BinaryCode(result.ToString());
        }

        private BinaryCode makeMADD(string code)
        {
            /* MADD D1, D2
             001000 00 01 0000000000000000000000 // 32bit
            */
            string[] words = code.Split(delimiters).Where(x => !string.IsNullOrEmpty(x)).ToArray();
            StringBuilder result = new StringBuilder();
            result.Append("001000"); // OPCode

            // D[n]
            if (registerDictionary.TryGetValue(words[1], out var binaryRegisterN))
            {
                result.Append(binaryRegisterN);
            }
            else
            {
                throw new MPUException("Unknown D[n] in MLD");
            }
            // D[m]
            if (registerDictionary.TryGetValue(words[2], out var binaryRegisterM))
            {
                result.Append(binaryRegisterM);
            }
            else
            {
                throw new MPUException("Unknown D[n] in MLD");
            }

            result.Append("0000000000000000000000"); // UNUSED

            if(result.Length != 32) { throw new MPUException("Command length is not 32"); }
            return new BinaryCode(result.ToString());
        }

        private BinaryCode makeMSUB(string code)
        {
            /* MSUB D1, D2
             001001 00 01 0000000000000000000000 // 32bit
            */
            string[] words = code.Split(delimiters).Where(x => !string.IsNullOrEmpty(x)).ToArray();
            StringBuilder result = new StringBuilder();
            result.Append("001001"); // OPCode

            // D[n]
            if (registerDictionary.TryGetValue(words[1], out var binaryRegisterN))
            {
                result.Append(binaryRegisterN);
            }
            else
            {
                throw new MPUException("Unknown D[n] in MLD");
            }
            // D[m]
            if (registerDictionary.TryGetValue(words[2], out var binaryRegisterM))
            {
                result.Append(binaryRegisterM);
            }
            else
            {
                throw new MPUException("Unknown D[n] in MLD");
            }

            result.Append("0000000000000000000000"); // UNUSED

            if (result.Length != 32) { throw new MPUException("Command length is not 32"); }
            return new BinaryCode(result.ToString());
        }

        private BinaryCode makeMMUL(string code)
        {
            /* MMUL D1, D2
             001100 00 01 0000000000000000000000 // 32bit
            */
            string[] words = code.Split(delimiters).Where(x => !string.IsNullOrEmpty(x)).ToArray();
            StringBuilder result = new StringBuilder();
            result.Append("001100"); // OPCode

            // D[n]
            if (registerDictionary.TryGetValue(words[1], out var binaryRegisterN))
            {
                result.Append(binaryRegisterN);
            }
            else
            {
                throw new MPUException("Unknown D[n] in MLD");
            }
            // D[m]
            if (registerDictionary.TryGetValue(words[2], out var binaryRegisterM))
            {
                result.Append(binaryRegisterM);
            }
            else
            {
                throw new MPUException("Unknown D[n] in MLD");
            }

            result.Append("0000000000000000000000"); // UNUSED

            if(result.Length != 32) { throw new MPUException("Command length is not 32"); }
            return new BinaryCode(result.ToString());
        }

        private BinaryCode makeSMUL(string code)
        {
            /* SMUL D1, 36
             001101 00 0000000000000000100100 00 // 32bit
            */
            string[] words = code.Split(delimiters).Where(x => !string.IsNullOrEmpty(x)).ToArray();
            StringBuilder result = new StringBuilder();
            result.Append("001101"); // OPCode

            // D[n]
            if (registerDictionary.TryGetValue(words[1], out var binaryRegisterN))
            {
                result.Append(binaryRegisterN);
            }
            else
            {
                throw new MPUException("Unknown D[n] in MLD");
            }
            result.Append(Convert.ToString(Convert.ToUInt32(words[2]), 2).PadLeft(22, '0'));

            result.Append("00"); // UNUSED

            if(result.Length != 32) { throw new MPUException("Command length is not 32"); }
            return new BinaryCode(result.ToString());
        }

        private BinaryCode makeMCMP(string code)
        {
            /* MCMP D1, D2
             011000 00 01 0000000000000000000000 // 32bit
            */
            string[] words = code.Split(delimiters).Where(x => !string.IsNullOrEmpty(x)).ToArray();
            StringBuilder result = new StringBuilder();
            result.Append("011000"); // OPCode

            // D[n]
            if (registerDictionary.TryGetValue(words[1], out var binaryRegisterN))
            {
                result.Append(binaryRegisterN);
            }
            else
            {
                throw new MPUException("Unknown D[n] in MLD");
            }
            // D[m]
            if (registerDictionary.TryGetValue(words[2], out var binaryRegisterM))
            {
                result.Append(binaryRegisterM);
            }
            else
            {
                throw new MPUException("Unknown D[n] in MLD");
            }

            result.Append("0000000000000000000000"); // UNUSED

            if (result.Length != 32) { throw new MPUException("Command length is not 32"); }
            return new BinaryCode(result.ToString());
        }

        private BinaryCode makeICMP(string code)
        {
            /* ICMP D1, 0, D2, 3
             011001 00 00 01 11 0000000000000000000000 // 32bit
            */
            string[] words = code.Split(delimiters).Where(x => !string.IsNullOrEmpty(x)).ToArray();
            StringBuilder result = new StringBuilder();
            result.Append("011001"); // OPCode

            // D[n]
            if (registerDictionary.TryGetValue(words[1], out var binaryRegisterN))
            {
                result.Append(binaryRegisterN);
            }
            else
            {
                throw new MPUException("Unknown D[n] in MLD");
            }

            // TODO: Test 필요
            // npos값 to 이진수 string
            result.Append(Convert.ToString(Convert.ToUInt32(words[2]), 2).PadLeft(2, '0'));

            // D[m]
            if (registerDictionary.TryGetValue(words[3], out var binaryRegisterM))
            {
                result.Append(binaryRegisterM);
            }
            else
            {
                throw new MPUException("Unknown D[n] in MLD");
            }

            // TODO: Test 필요
            // mpos값 to 이진수 string
            result.Append(Convert.ToString(Convert.ToUInt32(words[4]), 2).PadLeft(2, '0'));

            result.Append("0000000000000000000000"); // UNUSED

            if (result.Length != 32) { throw new MPUException("Command length is not 32"); }
            return new BinaryCode(result.ToString());
        }

        private BinaryCode makeJMP(string code)
        {
            /* JMP begin  (x0가 열네 번째 코드줄에 있다고 가정)
             011100 0000000000000000001110 0000 // 32bit
            */
            string[] words = code.Split(delimiters).Where(x => !string.IsNullOrEmpty(x)).ToArray();
            StringBuilder result = new StringBuilder();
            result.Append("011100"); // OPCode

            // 주소값 to 이진수 string
            result.Append(Convert.ToString(Convert.ToUInt32(words[1]), 2).PadLeft(22, '0'));
            result.Append("0000"); // UNUSED

            if (result.Length != 32) { throw new MPUException("Command length is not 32"); }
            return new BinaryCode(result.ToString());
        }

        private BinaryCode makeJEQ(string code)
        {
            /* JEQ begin  (x0가 열네 번째 코드줄에 있다고 가정)
             011101 0000000000000000001110 0000 // 32bit
            */
            string[] words = code.Split(delimiters).Where(x => !string.IsNullOrEmpty(x)).ToArray();
            StringBuilder result = new StringBuilder();
            result.Append("011101"); // OPCode

            // 주소값 to 이진수 string
            result.Append(Convert.ToString(Convert.ToUInt32(words[1]), 2).PadLeft(22, '0'));
            result.Append("0000"); // UNUSED

            if (result.Length != 32) { throw new MPUException("Command length is not 32"); }
            return new BinaryCode(result.ToString());
        }

        private BinaryCode makeJGT(string code)
        {
            /* JGT begin  (x0가 열네 번째 코드줄에 있다고 가정)
             011110 0000000000000000001110 0000 // 32bit
            */
            string[] words = code.Split(delimiters).Where(x => !string.IsNullOrEmpty(x)).ToArray();
            StringBuilder result = new StringBuilder();
            result.Append("011110"); // OPCode

            // 주소값 to 이진수 string
            result.Append(Convert.ToString(Convert.ToUInt32(words[1]), 2).PadLeft(22, '0'));
            result.Append("0000"); // UNUSED

            if (result.Length != 32) { throw new MPUException("Command length is not 32"); }
            return new BinaryCode(result.ToString());
        }

        private BinaryCode makeJLS(string code)
        {
            /* JLS begin  (x0가 열네 번째 코드줄에 있다고 가정)
             011111 0000000000000000001110 0000 // 32bit
            */
            string[] words = code.Split(delimiters).Where(x => !string.IsNullOrEmpty(x)).ToArray();
            StringBuilder result = new StringBuilder();
            result.Append("011111"); // OPCode

            // 주소값 to 이진수 string
            result.Append(Convert.ToString(Convert.ToUInt32(words[1]), 2).PadLeft(22, '0'));
            result.Append("0000"); // UNUSED

            if (result.Length != 32) { throw new MPUException("Command length is not 32"); }
            return new BinaryCode(result.ToString());
        }

        private BinaryCode makeZERO(string code)
        {
            /* ZERO D1
             100100 00 000000000000000000000000 // 32bit
            */
            string[] words = code.Split(delimiters).Where(x => !string.IsNullOrEmpty(x)).ToArray();
            StringBuilder result = new StringBuilder();
            result.Append("100100"); // OPCode

            // D[n]
            if (registerDictionary.TryGetValue(words[1], out var binaryRegisterN))
            {
                result.Append(binaryRegisterN);
            }
            else
            {
                throw new MPUException("Unknown D[n] in MLD");
            }

            result.Append("000000000000000000000000"); // UNUSED

            if (result.Length != 32) { throw new MPUException("Command length is not 32"); }
            return new BinaryCode(result.ToString());
        }

        private static readonly List<string> preprocessedCodeStringList = new List<string>();
        private static readonly Dictionary<string, int> addressDictionary = new Dictionary<string, int>();

        private static readonly Dictionary<string, string> registerDictionary = new Dictionary<string, string>
        {
            { "D1", "00" },
            { "D2", "01" },
            { "D3", "10" }
        };
        private static readonly string[] COMMANDS = {
            "MLD", "MSTR", "MADD", "MSUB", "MMUL", "SMUL", "MCMP", "ICMP", "JMP", "JEQ", "JGT", "JLS", "ZERO"
        };
        private readonly char[] delimiters = { ' ', '\t', ',' };
    }
}
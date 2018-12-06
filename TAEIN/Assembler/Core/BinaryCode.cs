using System;

namespace Assembler.Core
{
    public class BinaryCode
    {
        public const int BYTESIZE = 4;
        public BinaryCode(string binaryString)
        {
            Str = binaryString;
            Bin = ConvertStringToBinaryBytes(Str);
        }

        public readonly string Str;
        public readonly byte[] Bin;

        private static byte[] ConvertStringToBinaryBytes(string str)
        {
            System.Console.WriteLine(str);
            byte[] bin = new byte[BYTESIZE];
            /* MLD D2 [1]
             000000 01 0000000000000000000001 00 // 32bit
            */
            for (int i = 0; i < BYTESIZE; i++)
            {
                bin[i] = Convert.ToByte(str.Substring(8 * i, 8), 2);
            }

            return bin;
        }
    }
}

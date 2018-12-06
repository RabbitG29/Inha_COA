using System;
using Assembler.Core;

namespace Assembler
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                MPUAssembler assembler = new MPUAssembler(@"..\..\Resource\test.mau");
                assembler.saveMachineCode(@"..\..\Resource\test.mexe");
            }
            catch (MPUException e)
            {
                Console.WriteLine(e);
            }
        }

    }
}

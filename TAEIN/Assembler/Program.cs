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
                MPUAssembler assembler = new MPUAssembler(@"test.mpu");
                assembler.SaveMachineCode(@"test.mexe");
                System.Console.ReadKey();
            }
            catch (MPUException e)
            {
                Console.WriteLine(e);
            }
            catch (Exception e)
            {
                Console.WriteLine("!!Unhandled exception");
                Console.WriteLine(e);
            }
        }

    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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

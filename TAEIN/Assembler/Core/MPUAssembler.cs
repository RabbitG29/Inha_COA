using System;
using System.Collections.Generic;
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
        void ReadCode(List<string> list)
        {
            try
            {
                System.IO.StreamReader file =
                    new System.IO.StreamReader(@"..\..\Resource\test.mau");

                string line;
                while ((line = file.ReadLine()) != null)
                {
                    System.Console.WriteLine(line);
                    list.Add(line);
                }

                file.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
        }
    }
}

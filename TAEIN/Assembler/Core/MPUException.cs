using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler.Core
{
    public class MPUException : Exception
    {
        public MPUException(string message) : base(message)
        {
        }
    }
}

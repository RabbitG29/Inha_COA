using System;

namespace Assembler.Core
{
    public class MPUException : Exception
    {
        public MPUException(string message) : base(message)
        {
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo_CSDL
{
    public class Item
    {
        private int key;
        private string value;

        public int Key { get => key; set => key = value; }
        public string Value { get => value; set => this.value = value; }

        public Item(int key, string value)
        {
            this.key = key;
            this.value = value;
        }
    }
}

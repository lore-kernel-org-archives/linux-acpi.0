From: "Tommy Ch." <tommy-c-hi6Y0CQ0nG0@public.gmane.org>
Subject: New insights about video module! Need help,please.
Date: Mon, 28 Feb 2005 19:17:27 +0100
Message-ID: <42236037.1010102@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I'm still trying to get tv-out and crt working on my Toshiba M30 not
using TwinView. It's a long time ago when John Belmonte told me to
experiment with the toshiba_acpi driver (?) like this:

------snip---------

Other than that, you can experiment with the driver as follows.  This
was given to me by one Jonny Robertson.

     write_acpi_int("\\_SB_.PCI0.PCI1.VGA_.LCD_._DSS", 0x1);
     write_acpi_int("\\_SB_.PCI0.PCI1.VGA_.CRT_._DSS", 0x0);
     write_acpi_int("\\_SB_.PCI0.PCI1.VGA_.TV__._DSS", 0x80000001L);

The path to the _DSS methods might be different on your machine.  In
this example, we enable the LCD and TV.  The 0x80000000 bit causes
pending changes to be executed, so that all outputs can be set
simultaneously.

------snipend-----------


I tried to modify toshiba_acpi.c at line 377 and made these changes:

-------snip------

if (new_video_out != video_out)
     // original line
     // write_acpi_int(METHOD_VIDEO_OUT, new_video_out);

     // new:
     write_acpi_int("\\_SB_.PCI0.PCI1.VGA_.LCD_._DSS", 0x1);
         write_acpi_int("\\_SB_.PCI0.PCI1.VGA_.CRT_._DSS", 0x0);
         write_acpi_int("\\_SB_.PCI0.PCI1.VGA_.TV__._DSS", 0x80000001L);

------snipend-----------

Is this correct? If yes, a
echo "tv_out:1" > /proc/acpi/toshiba/video
had no effect.

Of course I also tried the new video module in kernel 2.6.10. I tried to 
set TVout like this
echo 0x80000000 > /proc/acpi/video/VGA/TV/state
and also like this:
echo "state:0x0f" > /proc/acpi/video/VGA/TV/state

with no effect. But I just made discovery that might be important!
When running the modified toshiba_acpi and using
echo "tv_out:1" > /proc/acpi/toshiba/video
suddenly I get

cat /proc/acpi/video/VGA/TV/state
state:     0x0d
query:     0x01

"query" is 0x01 instead of 0x00. I don't know if this is important or 
helps you to help me to get the stuff working.

If it helps you, my dsdt is located at 
http://www.uni-koblenz.de/~tenshi/toshm30dsdt.tar.gz

Any help is greatly appreciated!

Bye,
  Tommy


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

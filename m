From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: New insights about video module! Need help,please.
Date: Tue, 1 Mar 2005 19:37:33 +0100
Message-ID: <20050301183733.GF17731@poupinou.org>
References: <42236037.1010102@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42236037.1010102-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Tommy Ch." <tommy-c-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 28, 2005 at 07:17:27PM +0100, Tommy Ch. wrote:
> Hi,
> 
> I'm still trying to get tv-out and crt working on my Toshiba M30 not
> using TwinView. It's a long time ago when John Belmonte told me to
> experiment with the toshiba_acpi driver (?) like this:
> 
> ------snip---------
> 
> Other than that, you can experiment with the driver as follows.  This
> was given to me by one Jonny Robertson.
> 
>     write_acpi_int("\\_SB_.PCI0.PCI1.VGA_.LCD_._DSS", 0x1);
>     write_acpi_int("\\_SB_.PCI0.PCI1.VGA_.CRT_._DSS", 0x0);
>     write_acpi_int("\\_SB_.PCI0.PCI1.VGA_.TV__._DSS", 0x80000001L);
> 
> The path to the _DSS methods might be different on your machine.  In
> this example, we enable the LCD and TV.  The 0x80000000 bit causes
> pending changes to be executed, so that all outputs can be set
> simultaneously.
> 

There are _PS0, _PS3 and _PCS methods.  I'm not sure if those methods are
supported under linux-2.6.10 (or any other version of Linux, btw).

I think you should try to call the \_SB_.PCI0.PCI1.VGA_._PS0 method
somewhere.

Add a line like this one:
	acpi_evaluate_object(NULL, "\\_SB_.PCI0.PCI1.VGA_._PS0", NULL, NULL);

in function acpi_video_bus_add()

Something like this:

before:
        if (!device)
		return_VALUE(-EINVAL);

	video = kmalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);

after:
        if (!device)
		return_VALUE(-EINVAL);

	acpi_evaluate_object(NULL, "\\_SB_.PCI0.PCI1.VGA_._PS0", NULL, NULL);
	video = kmalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);

Of course, its ugly, but its only to test if _PS0 is supported or not by
linux.

Hope this help,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

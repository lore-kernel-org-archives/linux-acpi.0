From: "Tommy Ch." <tommy-c-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: New insights about video module! Need help,please.
Date: Fri, 04 Mar 2005 14:42:23 +0100
Message-ID: <422865BF.6090509@gmx.net>
References: <42236037.1010102@gmx.net> <20050301183733.GF17731@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050301183733.GF17731-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Bruno Ducrot wrote:
> There are _PS0, _PS3 and _PCS methods.  I'm not sure if those methods are
> supported under linux-2.6.10 (or any other version of Linux, btw).
> 
> I think you should try to call the \_SB_.PCI0.PCI1.VGA_._PS0 method
> somewhere.
> 
> Add a line like this one:
> 	acpi_evaluate_object(NULL, "\\_SB_.PCI0.PCI1.VGA_._PS0", NULL, NULL);
> 
> in function acpi_video_bus_add()
> 
> Something like this:
> 
> before:
>         if (!device)
> 		return_VALUE(-EINVAL);
> 
> 	video = kmalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
> 
> after:
>         if (!device)
> 		return_VALUE(-EINVAL);
> 
> 	acpi_evaluate_object(NULL, "\\_SB_.PCI0.PCI1.VGA_._PS0", NULL, NULL);
> 	video = kmalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
> 
> Of course, its ugly, but its only to test if _PS0 is supported or not by
> linux.

OK, it compiled cleanly. After loading the module dmesg said:
ACPI: Video Device [VGA] (multi-head: yes  rom: yes  post: no)

Nothing else I could observe. Should I do any other tests?

Bye



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

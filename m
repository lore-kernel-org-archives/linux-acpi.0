From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: IDE failure on ACPI resume
Date: Sun, 13 Mar 2005 20:53:59 -0800
Message-ID: <423518E7.3030300@root.org>
References: <1110741241.8136.46.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110741241.8136.46.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On resume, an HP nc6220 fails during resuming of the IDE devices. In
> this section of code from ide-iops.c:
> 
>                 stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
>                 if ((stat & BUSY_STAT) == 0)
>                         return 0;
>                 /*
>                  * Assume a value of 0xff means nothing is connected to
>                  * the interface and it doesn't implement the pull-down
>                  * resistor on D7.
>                  */
>                 if (stat == 0xff)
>                         return -ENODEV;
> 
> 0xff is read and ENODEV returned. This results in

Sounds like PCI not being completely restored.  We had to work around 
some weird ATA issues in FreeBSD with the status register being invalid 
for quite a while after resume.  A retry loop was the solution.

-- 
Nate


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

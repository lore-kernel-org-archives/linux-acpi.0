From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: [RFC, PATCH] sysdev suspend/resume order?
Date: Mon, 16 Aug 2004 16:47:53 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41211D79.9080407@optonline.net>
References: <88056F38E9E48644A0F562A38C64FB60029C6914@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60029C6914-exJ48ZlmiLpQxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Pallipadi, Venkatesh wrote:

> I think the basic resume ordering should be 
> - APIC (if enabled)

You mean Local APIC?

> - IOAPIC (or PIC)

We still use the i8259 in APIC mode for some things. (Some motherboards 
  don't connect certain IOAPIC pins, like IRQ0... I think there may be 
other uses) Does that need to be before or after the local apic? Before 
or after the IO-APIC?

> - Link device
> - All drivers

Makes sense

But where does PIT fit into the order? It has its own sys_device, and 
was, I think, specifically reported by one user to be causing a problem. 
If the following message in the archives is accurate, it might help, but 
it's a little short on details of how he tracked this down: 
http://marc.theaimsgroup.com/?l=acpi4linux&m=109180681500139&w=2

Matthew, care to weigh in? I'm fuzzy on the details of what patches 
broke what, on your system. (That is to say, who did what to who.)

> 
> I somehow feel doing it in a single driver may increase the complexity
> of this whole thing. Especially with various APIC/IOAPIC configs and 
> boot time parameters.

You may be right. Part of the problem is that some of the affected code 
lives in arch/... and some of it lives in drivers/acpi/... That 
certainly makes cleaning up require a little more forethought.

Nathan

> 
> Thanks,
> Venki
> 
> 



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285

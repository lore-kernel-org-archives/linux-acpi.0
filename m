From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [BK PATCH] ACPI updates
Date: Fri, 22 Nov 2002 13:28:20 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A53C@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Linus Torvalds' <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Linus Torvalds [mailto:torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org] 
> Andrew,
>  did you see the attached report?

> Basically, it appears that the ACPI irq routing returns 
> entries that are 
> bigger than NR_IRQS, which is a no-no.
> 
> Admittedly the IDE layer is also doing bad things (it 
> shouldn't disable 
> irq's that it hasn'e registered yet, and it would have failed 
> to register 
> a bad irq number), but it looks like (a) there are bad ACPI 
> tables around 
> (big surprise, not!) and (b) Linux acpi doesn't sanity-test 
> the values 
> properly.

Here is the dmesg:

> > ACPI: No IRQ known for interrupt pin A of device 00:10.0 - using IRQ 255
> > PCI: Using ACPI for IRQ routing

ACPI cannot find any irq so it's using whatever the pci_dev's irq value was
set at. I still am not sure if the fact we can't resolve the IRQ is a BIOS
problem, or a problem in the code.

In any case, yes, we should be checking for this case. Shanley says any
value higher than 0xF in the Interrupt Line register means it's not safe to
use that value.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

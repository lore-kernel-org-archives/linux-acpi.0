From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: Invalid PBLK length
Date: Wed, 18 Dec 2002 14:00:19 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021218140019.H9994@parcelfarce.linux.theplanet.co.uk>
References: <200212181326.gBIDQ5D08026@ikffws2.ikff.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200212181326.gBIDQ5D08026-sBhUd1W9t4xfrO0PeCDDO4ECbGbo6+O1OOFObY0sJ7w@public.gmane.org>; from haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org on Wed, Dec 18, 2002 at 02:26:05PM +0100
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 18, 2002 at 02:26:05PM +0100, Jens Haug wrote:
> I'm trying to find out why C2/C3 and throttling is not supported 
> on my Asus L2000D (aka Medion 9688).
> 
> In dmesg, acpi tells me about an invalid PBLK length of 5 and
> an unsupoprted address space of 127.

That's two ...
http://sourceforge.net/mailarchive/message.php?msg_id=2138093
OK, the other one's an ASUS too, but seems to be a different model (S1300A).

> BTW, how can I make my FADT human readable? It isn't shown by 
> acpidmp, and I'd like to be able to check some values myself.

Use the iasl compiler/decompiler.

BTW, Andy, any chance the precompiled one could be compiled against glibc
2.2 instead of 2.3?  Not everybody likes to be quite so bleeding-edge ;-)

> I also see in dmesg that there's an unsupported address space
> of 127 in acpi_processor_get_performance_control because
> reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO. But I don't know
> enough C to understand where this comes from. Could somebody
> please give me a hint?

ACPI tells you which address space a given address is in:

#define ACPI_ADR_SPACE_SYSTEM_MEMORY    (ACPI_ADR_SPACE_TYPE) 0
#define ACPI_ADR_SPACE_SYSTEM_IO        (ACPI_ADR_SPACE_TYPE) 1
#define ACPI_ADR_SPACE_PCI_CONFIG       (ACPI_ADR_SPACE_TYPE) 2
#define ACPI_ADR_SPACE_EC               (ACPI_ADR_SPACE_TYPE) 3
#define ACPI_ADR_SPACE_SMBUS            (ACPI_ADR_SPACE_TYPE) 4
#define ACPI_ADR_SPACE_CMOS             (ACPI_ADR_SPACE_TYPE) 5
#define ACPI_ADR_SPACE_PCI_BAR_TARGET   (ACPI_ADR_SPACE_TYPE) 6
#define ACPI_ADR_SPACE_DATA_TABLE       (ACPI_ADR_SPACE_TYPE) 7

processor.c is telling you it only handles ioport (inb/outb) address
spaces.  But 127 is not a valid address space value, so you're going
to have to get an updated BIOS from your vendor.  There's really no
reasonable way to fix this.

On the other hand, I do think it's worth incorporating my suggestion
to fill in C2 if we have it.  Maybe under the CONFIG_ACPI_BROKEN_AML or
whatever it was going to be called.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

From: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Subject: Re: Invalid PBLK length
Date: Thu, 19 Dec 2002 00:17:40 +0900 (JST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4e353e0091944930a0$NiftyInterway@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org
Cc: haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I didn't check code, but if that said address space type 127 does mean "Functi
onal Fixed Hardware (0x7F)", then your processor expects that OS processor dri
ver knows the specific address to control voltage scaling state transition. Us
ually it's done by accessing MSRs. This has been true for AMD PowerNow! and Tr
ansmeta LongRun, and Intel's new Geyserville I/F which will be unveiled on Ban
ias in the near future. These are mostly under NDA, therefore I can't be speci
fic, however there're several public documents which explain this stuff a bit 
more.

So if my guess is correct, your BIOS is not bad. To enable processor performan
ce control on your machine, Linux needs inputs from CPU vendors. 

> 
> > I also see in dmesg that there's an unsupported address space
> > of 127 in acpi_processor_get_performance_control because
> > reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO. But I don't know
> > enough C to understand where this comes from. Could somebody
> > please give me a hint?
> 
> ACPI tells you which address space a given address is in:
> 
> #define ACPI_ADR_SPACE_SYSTEM_MEMORY    (ACPI_ADR_SPACE_TYPE) 0
> #define ACPI_ADR_SPACE_SYSTEM_IO        (ACPI_ADR_SPACE_TYPE) 1
> #define ACPI_ADR_SPACE_PCI_CONFIG       (ACPI_ADR_SPACE_TYPE) 2
> #define ACPI_ADR_SPACE_EC               (ACPI_ADR_SPACE_TYPE) 3
> #define ACPI_ADR_SPACE_SMBUS            (ACPI_ADR_SPACE_TYPE) 4
> #define ACPI_ADR_SPACE_CMOS             (ACPI_ADR_SPACE_TYPE) 5
> #define ACPI_ADR_SPACE_PCI_BAR_TARGET   (ACPI_ADR_SPACE_TYPE) 6
> #define ACPI_ADR_SPACE_DATA_TABLE       (ACPI_ADR_SPACE_TYPE) 7
> 
> processor.c is telling you it only handles ioport (inb/outb) address
> spaces.  But 127 is not a valid address space value, so you're going
> to have to get an updated BIOS from your vendor.  There's really no
> reasonable way to fix this.
> 


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

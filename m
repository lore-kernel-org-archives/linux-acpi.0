From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: Invalid PBLK length
Date: Wed, 18 Dec 2002 15:29:06 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021218152906.J9994@parcelfarce.linux.theplanet.co.uk>
References: <4e353e0091944930a0$NiftyInterway@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4e353e0091944930a0$NiftyInterway-fFkzxiWP14B3+QwDJ9on6Q@public.gmane.org>; from aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org on Thu, Dec 19, 2002 at 12:17:40AM +0900
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Cc: willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 19, 2002 at 12:17:40AM +0900, Adachi, Kenichi wrote:
> I didn't check code, but if that said address space type 127 does mean "Functi
> onal Fixed Hardware (0x7F)", then your processor expects that OS processor dri
> ver knows the specific address to control voltage scaling state transition. Us
> ually it's done by accessing MSRs. This has been true for AMD PowerNow! and Tr
> ansmeta LongRun, and Intel's new Geyserville I/F which will be unveiled on Ban
> ias in the near future. These are mostly under NDA, therefore I can't be speci
> fic, however there're several public documents which explain this stuff a bit 
> more.

you're right.  Andy, could we add something like this?

diff -u -p -r1.6 actypes.h
--- drivers/acpi/include/actypes.h      10 Dec 2002 22:02:09 -0000      1.6
+++ drivers/acpi/include/actypes.h      18 Dec 2002 15:28:47 -0000
@@ -579,6 +579,7 @@ typedef u8                              
 #define ACPI_ADR_SPACE_CMOS             (ACPI_ADR_SPACE_TYPE) 5
 #define ACPI_ADR_SPACE_PCI_BAR_TARGET   (ACPI_ADR_SPACE_TYPE) 6
 #define ACPI_ADR_SPACE_DATA_TABLE       (ACPI_ADR_SPACE_TYPE) 7
+#define ACPI_ADR_SPACE_FIXED_HARDWARE  (ACPI_ADR_SPACE_TYPE) 127
 
 
 /*


-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

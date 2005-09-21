From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fw: ACPI, pm timer and ASUS a8v
Date: Wed, 21 Sep 2005 16:44:54 +0800
Message-ID: <1127292294.3948.1.camel@linux-hp.sh.intel.com>
References: <59D45D057E9702469E5775CBB56411F1784EB5@pdsmsx406>
	 <20050921013019.74b5059e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050921013019.74b5059e.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: jonas-fAbYwIrWRvUAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2005-09-21 at 01:30 -0700, Andrew Morton wrote:
> "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> >
> > >> How about add something like this:
> > >> if (fadt->revision >= FADT2_REVISION_ID) {
> > >> 		/* FADT rev. 2 */
> > >> 		if (fadt->xpm_tmr_blk.address_space_id !=
> > >> ACPI_ADR_SPACE_SYSTEM_IO)
> > >> 			return 0;
> > >>
> > >> 		pmtmr_ioport = fadt->xpm_tmr_blk.address;
> > >> +		if (!pmtmr_ioport)
> > >> +			pmtmr_ioport = fadt->V1_pm_tmr_blk;
> > >> 	} else {
> > >> 		/* FADT rev. 1 */
> > >> 		pmtmr_ioport = fadt->V1_pm_tmr_blk;
> > >> 	}
> > >
> > >this works
> > Great.
> > 
> > >
> > >ps.
> > >	I opened as andrew suggested a bug report:
> > >http://bugzilla.kernel.org/show_bug.cgi?id=5283
> > >ds.
> > Ok, I'll attach a formal patch into bugzilla.
> 
> Please email a copy?  I fear that patches which go into bugzilla never come
> out again ;)
> 
> At least, not sufficiently promptly.  We need to get fixups like this into
> mainline quickly.
Sure.
Handling FADT 2.0 xpmtmr address 0 case. The patch makes the pmtmr ioport
detecting align with ACPICA (the comments are copied from ACPICA code).

Signed-off-by: Shaohua Li<shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

 linux-2.6.14-rc1-root/arch/i386/kernel/acpi/boot.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN arch/i386/kernel/acpi/boot.c~pm-tmr arch/i386/kernel/acpi/boot.c
--- linux-2.6.14-rc1/arch/i386/kernel/acpi/boot.c~pm-tmr	2005-09-21 16:17:23.000000000 +0800
+++ linux-2.6.14-rc1-root/arch/i386/kernel/acpi/boot.c	2005-09-21 16:20:05.000000000 +0800
@@ -642,6 +642,13 @@ static int __init acpi_parse_fadt(unsign
 			return 0;
 
 		pmtmr_ioport = fadt->xpm_tmr_blk.address;
+		/*
+		 * "X" fields are optional extensions to the original V1.0
+		 * fields, so we must selectively expand V1.0 fields if the
+		 * corresponding X field is zero.
+	 	 */
+		if (!pmtmr_ioport)
+			pmtmr_ioport = fadt->V1_pm_tmr_blk;
 	} else {
 		/* FADT rev. 1 */
 		pmtmr_ioport = fadt->V1_pm_tmr_blk;
_




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

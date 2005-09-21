From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: Fw: ACPI, pm timer and ASUS a8v
Date: Wed, 21 Sep 2005 01:30:19 -0700
Message-ID: <20050921013019.74b5059e.akpm@osdl.org>
References: <59D45D057E9702469E5775CBB56411F1784EB5@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <59D45D057E9702469E5775CBB56411F1784EB5@pdsmsx406>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: jonas-fAbYwIrWRvUAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

"Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
> >> How about add something like this:
> >> if (fadt->revision >= FADT2_REVISION_ID) {
> >> 		/* FADT rev. 2 */
> >> 		if (fadt->xpm_tmr_blk.address_space_id !=
> >> ACPI_ADR_SPACE_SYSTEM_IO)
> >> 			return 0;
> >>
> >> 		pmtmr_ioport = fadt->xpm_tmr_blk.address;
> >> +		if (!pmtmr_ioport)
> >> +			pmtmr_ioport = fadt->V1_pm_tmr_blk;
> >> 	} else {
> >> 		/* FADT rev. 1 */
> >> 		pmtmr_ioport = fadt->V1_pm_tmr_blk;
> >> 	}
> >
> >this works
> Great.
> 
> >
> >ps.
> >	I opened as andrew suggested a bug report:
> >http://bugzilla.kernel.org/show_bug.cgi?id=5283
> >ds.
> Ok, I'll attach a formal patch into bugzilla.

Please email a copy?  I fear that patches which go into bugzilla never come
out again ;)

At least, not sufficiently promptly.  We need to get fixups like this into
mainline quickly.



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

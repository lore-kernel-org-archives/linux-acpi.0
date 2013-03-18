From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2] Xen/ACPI: support sleep state entering on hardware
 reduced systems
Date: Mon, 18 Mar 2013 01:46:07 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88015C4C91@SHSMSX101.ccr.corp.intel.com>
References: <513DB68E02000078000C4864@nat28.tlf.novell.com>
 <20130311135322.GA25036@phenom.dumpdata.com>
 <513DF30B02000078000C49EB@nat28.tlf.novell.com>
 <2127236.DctbS7jp3r@vostro.rjw.lan>
 <1AE640813FDE7649BE1B193DEA596E88C1A230@SHSMSX101.ccr.corp.intel.com>
 <513EEE0302000078000C4C5F@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23107 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389Ab3CRBqM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Mar 2013 21:46:12 -0400
In-Reply-To: <513EEE0302000078000C4C5F@nat28.tlf.novell.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Wei, Gang" <gang.wei@intel.com>, "Maliszewski, Richard L" <richard.l.maliszewski@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Wang, Shane" <shane.wang@intel.com>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xen.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Sorry for delayed reply.

> >>> On 12.03.13 at 01:59, "Zheng, Lv" <lv.zheng@intel.com> wrote:
> >> > +#include <linux/acpi.h>
> >
> > This line shouldn't appear in ACPICA codes (drivers/acpi/acpica).
> > Please try to declare OSL interfaces via include/acpi/platform/aclinux.h.
> 
> I'm sorry, but why am I not permitted to follow code that's already there:
> - hwsleep.c already includes linux/acpi.h
> - acpi_os_set_prepare_sleep() and acpi_os_prepare_sleep() are
>   both declared/stubbed out in linux/acpi.h
> 
> I'm particularly not intending to do cleanup work on ACPICA just so that I can
> subsequently fix incomplete code.
> 
> Rafael, with that in mind, your request to submit the ACPICA changes
> separately is impossible: The hook functions just can't have a declaration in the
> non-Linux ACPI headers (or else they wouldn't currently live in linux/acpi.h).
> Hence breaking up the patch in the way you asked me to will not even compile
> without first cleaning up the existing code. And again - I'm sorry, no, that's not
> something I was looking forward to do.

Yes, you can try to use codes already there, but you still can find a way not introducing a new inclusion of <linux/acpi.h> in an ACPICA file.
Sorry for the inconvenience.

> >> > +	status = acpi_os_prepare_sleep(sleep_state, acpi_gbl_sleep_type_a,
> >> > +				       acpi_gbl_sleep_type_b, true);
> >
> > bool is not used in ACPICA, please try u8 instead.
> 
> Can do, but again - why am I not permitted to follow what's already there?
> acglobal.h has
> 
> bool ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);

ACPICA is a portable ACPI implementation, where there might be users using compilers not compatible with c99.

This difference is there for another reason:
It is exported as a sysfs entry, it could not be converted back to u8 without introducing new warnings during the current kernel compilation process.
At least for now, it is a committed difference.

Or you could wait until the "bool" portable layer to be implemented in the ACPICA.

> The more that the declaration, as pointed out above, lives in linux/acpi.h (and
> did so even _before_ this patch), i.e. isn't an ACPICA one.
> 
> >> >  	status = acpi_os_prepare_sleep(sleep_state, pm1a_control,
> >> > -				       pm1b_control);
> >> > +				       pm1b_control, false);
> >
> > Likewise.
> >
> >> > -acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 pm1a_control,
> >> > -				  u32 pm1b_control)
> >> > +acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 val_a, u32 val_b,
> >> > +				  bool extended)
> >
> > Is this an ACPICA OSL interface? Then it should not include bool parameter.
> 
> Returning the question: Given the current placement of declarations, it isn't.
> But if the current layout is wrong, than that needs fixing first. Which in turn
> likely means that the inconsistency will continue to persist for the next (or the
> next few) kernel version(s).

Yes, we may fix this ASAP.

Thanks
-Lv

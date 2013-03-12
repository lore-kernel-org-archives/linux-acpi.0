From: "Jan Beulich" <JBeulich@suse.com>
Subject: RE: [PATCH v2] Xen/ACPI: support sleep state entering on
 hardware reduced systems
Date: Tue, 12 Mar 2013 07:57:38 +0000
Message-ID: <513EEE0302000078000C4C5F@nat28.tlf.novell.com>
References: <513DB68E02000078000C4864@nat28.tlf.novell.com>
 <20130311135322.GA25036@phenom.dumpdata.com>
 <513DF30B02000078000C49EB@nat28.tlf.novell.com>
 <2127236.DctbS7jp3r@vostro.rjw.lan>
 <1AE640813FDE7649BE1B193DEA596E88C1A230@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:36773 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061Ab3CLH5o convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:6:1>);
	Tue, 12 Mar 2013 03:57:44 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88C1A230@SHSMSX101.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Gang Wei <gang.wei@intel.com>, Richard L Maliszewski <richard.l.maliszewski@intel.com>, Robert Moore <robert.moore@intel.com>, Shane Wang <shane.wang@intel.com>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xen.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

>>> On 12.03.13 at 01:59, "Zheng, Lv" <lv.zheng@intel.com> wrote:
>> > +#include <linux/acpi.h>
> 
> This line shouldn't appear in ACPICA codes (drivers/acpi/acpica).
> Please try to declare OSL interfaces via include/acpi/platform/aclinux.h.

I'm sorry, but why am I not permitted to follow code that's
already there:
- hwsleep.c already includes linux/acpi.h
- acpi_os_set_prepare_sleep() and acpi_os_prepare_sleep() are
  both declared/stubbed out in linux/acpi.h

I'm particularly not intending to do cleanup work on ACPICA just
so that I can subsequently fix incomplete code.

Rafael, with that in mind, your request to submit the ACPICA
changes separately is impossible: The hook functions just can't
have a declaration in the non-Linux ACPI headers (or else they
wouldn't currently live in linux/acpi.h). Hence breaking up the
patch in the way you asked me to will not even compile without
first cleaning up the existing code. And again - I'm sorry, no,
that's not something I was looking forward to do.

>> >
>> > +	status = acpi_os_prepare_sleep(sleep_state, acpi_gbl_sleep_type_a,
>> > +				       acpi_gbl_sleep_type_b, true);
> 
> bool is not used in ACPICA, please try u8 instead.

Can do, but again - why am I not permitted to follow what's
already there? acglobal.h has

bool ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);

The more that the declaration, as pointed out above, lives in
linux/acpi.h (and did so even _before_ this patch), i.e. isn't an
ACPICA one.

>> >  	status = acpi_os_prepare_sleep(sleep_state, pm1a_control,
>> > -				       pm1b_control);
>> > +				       pm1b_control, false);
> 
> Likewise.
> 
>> > -acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 pm1a_control,
>> > -				  u32 pm1b_control)
>> > +acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 val_a, u32 val_b,
>> > +				  bool extended)
> 
> Is this an ACPICA OSL interface? Then it should not include bool parameter.

Returning the question: Given the current placement of
declarations, it isn't. But if the current layout is wrong, than that
needs fixing first. Which in turn likely means that the inconsistency
will continue to persist for the next (or the next few) kernel
version(s).

Jan


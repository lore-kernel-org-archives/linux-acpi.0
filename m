From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] RE: [PATCH 5/7] xen/acpi: Domain0 acpi parser
 related platform hypercall
Date: Wed, 21 Sep 2011 15:29:00 -0400
Message-ID: <20110921192859.GA2606@phenom.oracle.com>
References: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
 <1314815484-4668-6-git-send-email-konrad.wilk@oracle.com>
 <9F57BF860713DF4BA3EFA4F8C6DFEDAC16F3F665@ORSMSX101.amr.corp.intel.com>
 <4E67A9E7.2020802@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:54302 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab1IUTa1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2011 15:30:27 -0400
Content-Disposition: inline
In-Reply-To: <4E67A9E7.2020802@goop.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Cihula, Joseph" <joseph.cihula@intel.com>, "Brown, Len" <len.brown@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "keir@xen.org" <keir@xen.org>, Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "Wang, Shane" <shane.wang@intel.com>, "x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, "liang.tang@oracle.com" <liang.tang@oracle.com>, "Yu, Ke" <ke.yu@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>

On Wed, Sep 07, 2011 at 10:29:11AM -0700, Jeremy Fitzhardinge wrote:
> On 09/06/2011 10:50 PM, Cihula, Joseph wrote:
> >> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> >> Sent: Wednesday, August 31, 2011 11:31 AM
> >>
> >> From: Yu Ke <ke.yu@intel.com>
> >>
> >> This patches implements the xen_platform_op hypercall, to pass the parsed ACPI info to hypervisor.
> >>
> >> Signed-off-by: Yu Ke <ke.yu@intel.com>
> >> Signed-off-by: Tian Kevin <kevin.tian@intel.com>
> >> Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
> >> [v1: Added DEFINE_GUEST.. in appropiate headers]
> >> [v2: Ripped out typedefs]
> >> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> >> ---
> >>  arch/ia64/include/asm/xen/interface.h |    1 +
> >>  arch/x86/include/asm/xen/interface.h  |    1 +
> >>  include/xen/interface/platform.h      |  320 +++++++++++++++++++++++++++++++++
> >>  include/xen/interface/xen.h           |    1 +
> >>  4 files changed, 323 insertions(+), 0 deletions(-)  create mode 100644
> >> include/xen/interface/platform.h
> >>
> >> diff --git a/arch/ia64/include/asm/xen/interface.h b/arch/ia64/include/asm/xen/interface.h
> >> index e951e74..1d2427d 100644
> >> --- a/arch/ia64/include/asm/xen/interface.h
> >> +++ b/arch/ia64/include/asm/xen/interface.h
> >> @@ -76,6 +76,7 @@ DEFINE_GUEST_HANDLE(char);  DEFINE_GUEST_HANDLE(int);
> >> DEFINE_GUEST_HANDLE(long);  DEFINE_GUEST_HANDLE(void);
> >> +DEFINE_GUEST_HANDLE(uint64_t);
> >>
> >>  typedef unsigned long xen_pfn_t;
> >>  DEFINE_GUEST_HANDLE(xen_pfn_t);
> >> diff --git a/arch/x86/include/asm/xen/interface.h b/arch/x86/include/asm/xen/interface.h
> >> index 5d4922a..a1f2db5 100644
> >> --- a/arch/x86/include/asm/xen/interface.h
> >> +++ b/arch/x86/include/asm/xen/interface.h
> >> @@ -55,6 +55,7 @@ DEFINE_GUEST_HANDLE(char);  DEFINE_GUEST_HANDLE(int);
> >> DEFINE_GUEST_HANDLE(long);  DEFINE_GUEST_HANDLE(void);
> >> +DEFINE_GUEST_HANDLE(uint64_t);
> >>  #endif
> >>
> >>  #ifndef HYPERVISOR_VIRT_START
> >> diff --git a/include/xen/interface/platform.h b/include/xen/interface/platform.h
> >> new file mode 100644
> >> index 0000000..c168468
> >> --- /dev/null
> >> +++ b/include/xen/interface/platform.h
> > Why are you adding so many new hypercalls that aren't being used in this patchset?
> 
> May as well bring in all the platform-related hypercall definitions at
> once rather than be piecemeal.

Actually, I think making it piecemeal might be easier. As in
 1). Not all of the hypercalls are going to be upstreamed.
 2). It gives a nice history/idea of what is actually implemented when
     seaching the code.
 3). git annotate can give precise git commits for when an functionality was
     added.

But maybe I am just overthinking it.

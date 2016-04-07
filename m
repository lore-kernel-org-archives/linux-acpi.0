From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [Xen-devel] [PATCH v4 11/14] pnpbios: replace paravirt_enabled()
 check with legacy device check
Date: Thu, 7 Apr 2016 23:42:16 +0200
Message-ID: <20160407214216.GH1990@wotan.suse.de>
References: <1459987594-5434-1-git-send-email-mcgrof@kernel.org>
 <1459987594-5434-12-git-send-email-mcgrof@kernel.org>
 <57062C63.2010609@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34766 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757532AbcDGVmT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Apr 2016 17:42:19 -0400
Content-Disposition: inline
In-Reply-To: <57062C63.2010609@citrix.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au, xen-devel@lists.xensource.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, jlee@suse.com, lguest@lists.ozlabs.org, glin@suse.com, boris.ostrovsky@oracle.com, andriy.shevchenko@linux.intel.com, Josh Triplett <josh@joshtriplett.org>, robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, tiwai@suse.de

On Thu, Apr 07, 2016 at 10:46:11AM +0100, David Vrabel wrote:
> On 07/04/16 01:06, Luis R. Rodriguez wrote:
> > Since we are removing paravirt_enabled() replace it with a
> > logical equivalent. Even though PNPBIOS is x86 specific we
> > add an arch-specific type call, which can be implemented by
> > any architecture to show how other legacy attribute devices
> > can later be also checked for with other ACPI legacy attribute
> > flags.
> > 
> > This implicates the first ACPI 5.2.9.3 IA-PC Boot Architecture
> > ACPI_FADT_LEGACY_DEVICES flag device, and shows how to add more.
> [...]
> > +struct x86_legacy_devices {
> > +	int pnpbios;
> > +};
> 
> It's not clear why pnpbios needs a new structure

I'm glad you asked. Dealing with placing pnpbios quirk in a more useful generic
fashion was perhaps the most difficult challenge in this series.  As I reviewed
possibilities to remove paravirt_enabled() the best prospect I found was to see
if Xen could instead use ACPI 5.2.9.3 IA-PC Boot Architecture flags to annotate
some quirks. It turns out that it is possible, but there are only so many flags,
and also, we didn't want to have a solution that incurred respective upstream
Xen hypervisor change, that would be silly.

To make this quirk more useful then this folds the pnpbios quirk as a sub
quirk under the more borad ACPI_FADT_LEGACY_DEVICES ACPI flag. What this
does, as can be seen by also looking at the next patch, "x86, ACPI: parse
ACPI_FADT_LEGACY_DEVICES" is it explicitly folds pnpbios as one of the
ACPI_FADT_LEGACY_DEVICES devices, but also paves the way for further known
main legacy components to added to the list.

> and why this structure of devices does not have the bit for the rtc device.

That's because ACPI has its own dedicated flag for it, so there already
is a one-to-one mapping available. All we needed to do to replace the
RTC hack was to provide a mechanism to unify both the paravirt RTC hack
with the ACPI RTC flag.

  Luis

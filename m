From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v1 0/2] x86/init: extend quirk use
Date: Wed, 13 Apr 2016 00:30:12 +0200
Message-ID: <20160412223012.GO1990@wotan.suse.de>
References: <1460161361-13635-1-git-send-email-mcgrof@kernel.org>
 <570B52EA.60300@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38055 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933163AbcDLWaQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Apr 2016 18:30:16 -0400
Content-Disposition: inline
In-Reply-To: <570B52EA.60300@linutronix.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, George Dunlap <george.dunlap@citrix.com>, Julien Grall <julien.grall@linaro.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de, sathyanarayanan.kuppuswamy@linux.intel.com, alan@linux.intel.com, rui.zhang@intel.com, mbizon@freebox.fr, ffainelli@freebox.fr

On Mon, Apr 11, 2016 at 09:31:54AM +0200, Sebastian Andrzej Siewior wrote:
> On 04/09/2016 02:22 AM, Luis R. Rodriguez wrote:
> > What seems a bit odd is CE4100 leaves RTC enabled, can someone
> > confirm if indeed it really needs it, or can it also disable it
> > as with Xen, lguest, and Intel MID ?
> 
> So what you do with "x86_platform.legacy.rtc" is to skip
> add_rtc_cmos().

Yeap.

> For ce4100 I added of_have_populated_dt() to skip the probe.

Ah look at that.. x86 using device tree. Wasn't aware.

> If you plan to add this to CE4100 you could remove the
> "of_have_populated_dt()". It was meant to skip the RTC probe on all OF
> platforms but as of now, CE4100 is the only.

Indeed, this would clean up the add_rtc_cmos() path more and make
the semantics required for this a platform specific quirk which can
instead more easily be set by the platform on the generic:

	x86_early_init_platform_quirks()

Will go a head and remove this hack as part of the CE4100 patch, and
also add CE4100 to the list of subarchs that need the RTC quirk.

  Luis

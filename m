From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [Xen-devel] [PATCH v5 04/14] x86/rtc: replace paravirt rtc check
 with platform legacy quirk
Date: Thu, 14 Apr 2016 00:49:48 +0200
Message-ID: <20160413224948.GI1990@wotan.suse.de>
References: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
 <1460158825-13117-5-git-send-email-mcgrof@kernel.org>
 <570B492B.80608@suse.com>
 <20160412205056.GJ1990@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52755 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752614AbcDMWtx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Apr 2016 18:49:53 -0400
Content-Disposition: inline
In-Reply-To: <20160412205056.GJ1990@wotan.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au, kozerkov@parallels.com, matt@codeblueprint.co.uk, lv.zheng@intel.com, xen-devel@lists.xensource.com, joro@8bytes.org, x86@kernel.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, glin@suse.com, lenb@kernel.org, josh@joshtriplett.org, jlee@suse.com, lguest@lists.ozlabs.org, boris.ostrovsky@oracle.com, andriy.shevchenko@linux.intel.com, toshi.kani@hp.com, andrew.cooper3@citrix.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, luto@amacapital.net, david.vrabel@citrix.com, tiwai@suse.de

On Tue, Apr 12, 2016 at 10:50:56PM +0200, Luis R. Rodriguez wrote:
> On Mon, Apr 11, 2016 at 08:50:19AM +0200, Juergen Gross wrote:
> > On 09/04/16 01:40, Luis R. Rodriguez wrote:
> > > TOTAL   TEXT   init.text    x86_early_init_platform_quirks()
> > > +70     +62    +62          +43
> > > 
> > > Only 8 bytes overhead total, as the main increase in size is
> > > all removed via __init.
> > 
> > I think this could be even less 

> > > +static void xen_dom0_set_legacy_features(void)
> > 
> > Can't you make this __init ?
> 
> Indeed, will change.

0-day tests indicates no size gains, that might be a build cache
issue not sure. Either way, will fold the __init change into
a v6.

  Luis

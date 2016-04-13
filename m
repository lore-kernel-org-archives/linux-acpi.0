From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 07/14] tools/lguest: force disable tboot and apm
Date: Wed, 13 Apr 2016 17:45:24 +0200
Message-ID: <20160413154524.GU1990@wotan.suse.de>
References: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
 <1460159886-13344-1-git-send-email-mcgrof@kernel.org>
 <20160413084446.GA21471@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43530 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575AbcDMPp1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Apr 2016 11:45:27 -0400
Content-Disposition: inline
In-Reply-To: <20160413084446.GA21471@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de

On Wed, Apr 13, 2016 at 10:44:46AM +0200, Ingo Molnar wrote:
> 
> * Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> 
> > The paravirt_enabled() check is going away, the area tossed to
> > the kernel on lguest is not zerored out, so ensure lguest force
> > disables tboot and apm just in case the kernel file being read might
> > have this set for whatever reason.
> > 
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > ---
> >  tools/lguest/lguest.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> Yeah, so the v4 patch was acked by Rusty:
> 
>   Acked-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> ... but you didn't add his ack to the v5 patch :-(

Sorry about that. Added.

> Please don't do this! Also please double check all past replies to make sure no 
> acks got lost. I noticed this one, but there might be more.

I thought I had only left out the Acks for patches I later modified
significantly. Sorry. Will revise.

  Luis

From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 18 Sep 2006 18:52:40 +0100
Message-ID: <1158601960.2414.0.camel@hughsie-laptop.localdomain>
References: <CFF307C98FEABE47A452B27C06B85BB601614F5A@hdsmsx411.amr.corp.intel.com>
	 <200608302253.43784.dtor@insightbb.com>
	 <200608302303.38458.len.brown@intel.com>
	 <200608302307.58511.dtor@insightbb.com>
	 <1158566150.2332.14.camel@hughsie-laptop.localdomain>
	 <d120d5000609180817h32e8dafavd5657f69a7d7a725@mail.gmail.com>
Reply-To: richard@hughsie.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:10141 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751865AbWIRRxp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Sep 2006 13:53:45 -0400
Received: by ug-out-1314.google.com with SMTP id o38so386691ugd
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2006 10:53:44 -0700 (PDT)
In-Reply-To: <d120d5000609180817h32e8dafavd5657f69a7d7a725@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: richard@hughsie.com, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, gnome-power-manager-list@gnome.org, hal@lists.freedesktop.org, desktop_portables@lists.osdl.org, "Yu, Luming" <luming.yu@intel.com>

On Mon, 2006-09-18 at 11:17 -0400, Dmitry Torokhov wrote:
> On 9/18/06, Richard Hughes <hughsient@gmail.com> wrote:
> > On Wed, 2006-08-30 at 23:07 -0400, Dmitry Torokhov wrote:
> > > On Wednesday 30 August 2006 23:03, Len Brown wrote:
> > > > On Wednesday 30 August 2006 22:53, Dmitry Torokhov wrote:
> > > >
> > > > > So... do you want me to make it work with !CONFIG_INPUT or shoudl I just
> > > > > add a dependency on INPUT in Kconfig for button driver?
> > > >
> > > > If virtually everybody uses INPUT, then I'm fine with the ACPI button driver simply depending
> > > > on CONFIG_INPUT.
> > > >
> > > > If nobody uses ACPI on a system without INPUT, then I don't see why we should
> > > > muck up the code to suport a case that nobody will test or use.
> > > >
> > >
> > > INPUT is not used on s390 but I suppose that's ok ;) You need to work
> > > really hard to disable input (embedded, no VTs or anything, etc).
> >
> > Is there any feedback on this solution? Also, what's the timescale for
> > conversion to the input layer - are we talking blue sky or a few months?
> > I want to make sure userspace is in a position for this change.
> >
> 
> I sent the updated patch to Yu Luming, the copy is in the list archives:
> 
> http://marc.theaimsgroup.com/?l=linux-acpi&m=115751976924048&w=2
> 
> so unless there are objections to the thing I'd like to have it
> applied to ACPI tree.

Brilliant, thanks Dmitry.

Richard.



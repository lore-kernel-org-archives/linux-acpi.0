From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] toshiba-acpi: Support TOS1900-type devices
Date: Wed, 1 Apr 2009 18:07:08 +0100
Message-ID: <20090401170708.GA14167@srcf.ucam.org>
References: <20090331214501.GC29489@srcf.ucam.org> <20090331214749.GD29489@srcf.ucam.org> <74962ea30903311506m41306659td0cd70c5736f6660@mail.gmail.com> <20090331221107.GA30383@srcf.ucam.org> <74962ea30903311519s2fb6087fxfe8859e3c570ac99@mail.gmail.com> <20090331230217.GA31599@srcf.ucam.org> <74962ea30904010950u31fbdca3w51eafb9b7ec1ca73@mail.gmail.com> <20090401165345.GA13939@srcf.ucam.org> <74962ea30904011003o354e8780ya5e9ac1a6a579084@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44057 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758686AbZDARHM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2009 13:07:12 -0400
Content-Disposition: inline
In-Reply-To: <74962ea30904011003o354e8780ya5e9ac1a6a579084@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Azael Avalos <coproscefalo@gmail.com>
Cc: linux-acpi@vger.kernel.org, dsilvers@simtec.co.uk, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org

On Thu, Apr 02, 2009 at 10:03:05AM +1700, Azael Avalos wrote:
> On Thu, Apr 2, 2009 at 9:53 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > Yes, you shouldn't be reading directly from TOHK at any point. It seems
> > to be a purely internal variable - I'm fairly sure that the INFO method
> > is the only one that should be called on event generation.
> 
> Well, on the patches sent to the omnibook module I was polling TOHK directly,
> it is until now that I realized that I can poll the events via INFO
> method, that is,
> if I enable TECF first via method \\_SB.PCI0.LPCB.EC0.NTFY

Mm. None of the TOS1900 DSDTs I have here have TECF or NTFY methods, so 
again that doesn't sound like the right way of driving them. Does the 
ENAB method not do this?

> >
> >> On the patches I sent to the omnibook module I'm able to get events but they
> >> seem to get repeated 3 times, or perhaps I'm polling to often.
> >
> > Hm. I don't have test hardware right now, I'm afraid. I'll look at some
> > DSDTs a bit more and see if anything springs to mind.
> 
> Well, I brought my laptop to work (I'm a sysadmin so I got plenty of time :-P)
> and I can test if that helps

I'll dig some more and let you know. Thanks!

-- 
Matthew Garrett | mjg59@srcf.ucam.org

From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and getkeycode key table.
Date: Wed, 18 Jul 2007 17:56:37 +0100
Message-ID: <20070718165636.GA23578@srcf.ucam.org>
References: <20070715211128.GA6291@srcf.ucam.org> <1184605565.2228.57.camel@work> <20070716180928.GA21211@srcf.ucam.org> <1184668653.2443.2.camel@work> <20070718114518.GB21658@inferi.kami.home> <20070718142800.GA20607@srcf.ucam.org> <d120d5000707180805u31099be0i2d827b10228d2608@mail.gmail.com> <1184771822.14062.2.camel@work> <20070718162510.GA22975@srcf.ucam.org> <1184777059.2496.10.camel@work>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:33164 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761AbXGRQ4q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 12:56:46 -0400
Content-Disposition: inline
In-Reply-To: <1184777059.2496.10.camel@work>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>

On Wed, Jul 18, 2007 at 05:44:19PM +0100, Richard Hughes wrote:
> On Wed, 2007-07-18 at 17:25 +0100, Matthew Garrett wrote:
> > This isn't an either/or situation. If you have a hal keymap then the 
> > system will still work. The question is what to do in the absence of 
> > hal. The kernel can either provide sane defaults (that might be wrong
> > in a couple of cases) or it can provide keys that are pretty much 
> > guaranteed to do nothing. I think doing our best to make things work 
> > even if hal isn't there is sensible - if hal /is/ there, we've lost 
> > nothing. 
> 
> The only reason we set the keys to KEY_UNKNOWN is so we still emit acpi
> events (and not change the interface) if we are using an old HAL to not
> break stuff like acpid and tpd.

I was thinking more of the ones that are just flagged as KEY_FN_F1 at 
the moment.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

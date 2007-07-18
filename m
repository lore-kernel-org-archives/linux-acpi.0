From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and getkeycode key table.
Date: Wed, 18 Jul 2007 17:25:11 +0100
Message-ID: <20070718162510.GA22975@srcf.ucam.org>
References: <11845208794064-git-send-email-malattia@linux.it> <11845208791511-git-send-email-malattia@linux.it> <20070715211128.GA6291@srcf.ucam.org> <1184605565.2228.57.camel@work> <20070716180928.GA21211@srcf.ucam.org> <1184668653.2443.2.camel@work> <20070718114518.GB21658@inferi.kami.home> <20070718142800.GA20607@srcf.ucam.org> <d120d5000707180805u31099be0i2d827b10228d2608@mail.gmail.com> <1184771822.14062.2.camel@work>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:43916 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508AbXGRQZk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 12:25:40 -0400
Content-Disposition: inline
In-Reply-To: <1184771822.14062.2.camel@work>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>

On Wed, Jul 18, 2007 at 04:17:02PM +0100, Richard Hughes wrote:
> On Wed, 2007-07-18 at 11:05 -0400, Dmitry Torokhov wrote:
> > 
> > I think we should continue adding keymaps to kernel until everyone is
> > using HAL's facilities to load keymaps and then stop. Does this make
> > sense? 
> 
> I don't think so. The whole idea of hal-info is that we can update a 14k
> noarch package every week if needed, that will work on pretty much any
> hal version.
> 
> I'm not sure people running FC3 systems are going to be running git
> kernels for new keymaps.

This isn't an either/or situation. If you have a hal keymap then the 
system will still work. The question is what to do in the absence of 
hal. The kernel can either provide sane defaults (that might be wrong in 
a couple of cases) or it can provide keys that are pretty much 
guaranteed to do nothing. I think doing our best to make things work 
even if hal isn't there is sensible - if hal /is/ there, we've lost 
nothing.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

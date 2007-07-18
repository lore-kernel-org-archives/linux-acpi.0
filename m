From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and
	getkeycode key table.
Date: Wed, 18 Jul 2007 20:45:19 +0900
Message-ID: <20070718114518.GB21658@inferi.kami.home>
References: <1184520879452-git-send-email-malattia@linux.it> <1184520879991-git-send-email-malattia@linux.it> <11845208793336-git-send-email-malattia@linux.it> <11845208793678-git-send-email-malattia@linux.it> <11845208794064-git-send-email-malattia@linux.it> <11845208791511-git-send-email-malattia@linux.it> <20070715211128.GA6291@srcf.ucam.org> <1184605565.2228.57.camel@work> <20070716180928.GA21211@srcf.ucam.org> <1184668653.2443.2.camel@work>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:43580 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758333AbXGRLp2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 07:45:28 -0400
Content-Disposition: inline
In-Reply-To: <1184668653.2443.2.camel@work>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, Jul 17, 2007 at 11:37:33AM +0100, Richard Hughes wrote:
> On Mon, 2007-07-16 at 19:09 +0100, Matthew Garrett wrote:
> > 
> > That's fine, we have information that lets us distinguish between 
> > models. 

Well, I don't think we have all, at least I don't and anyway it's nice
to have some way to add new models that doesn't require waiting for a new
kernel to be available.

> Yes, but the consensus I seemed to get from previous mails was that the
> matching quirks should be done in userspace where possible. The current
> FDI thing lets a user edit a simple text xml file and stuff just works.
> I'm not sure asking user to compile custom kernel modules to test out
> new keymaps is feasible, at least for the majority of linux users.

Yep, I agree.

-- 
mattia
:wq!

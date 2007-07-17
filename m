From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and getkeycode key table.
Date: Tue, 17 Jul 2007 11:46:16 +0100
Message-ID: <20070717104616.GB32486@srcf.ucam.org>
References: <1184520879452-git-send-email-malattia@linux.it> <1184520879991-git-send-email-malattia@linux.it> <11845208793336-git-send-email-malattia@linux.it> <11845208793678-git-send-email-malattia@linux.it> <11845208794064-git-send-email-malattia@linux.it> <11845208791511-git-send-email-malattia@linux.it> <20070715211128.GA6291@srcf.ucam.org> <1184605565.2228.57.camel@work> <20070716180928.GA21211@srcf.ucam.org> <1184668653.2443.2.camel@work>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:40795 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704AbXGQKqb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 06:46:31 -0400
Content-Disposition: inline
In-Reply-To: <1184668653.2443.2.camel@work>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, Jul 17, 2007 at 11:37:33AM +0100, Richard Hughes wrote:
> On Mon, 2007-07-16 at 19:09 +0100, Matthew Garrett wrote:
> > 
> > That's fine, we have information that lets us distinguish between 
> > models. 
> 
> Yes, but the consensus I seemed to get from previous mails was that the
> matching quirks should be done in userspace where possible. The current
> FDI thing lets a user edit a simple text xml file and stuff just works.
> I'm not sure asking user to compile custom kernel modules to test out
> new keymaps is feasible, at least for the majority of linux users.

That doesn't match what the kernel currently does. It's still possible 
to send the custom scancode (unless I'm entirely misreading this) and 
remap if the user genuinely does have a weird keymap, so all you're 
doing is moving small tables from one part of disk to the other - 
they'll be flagged __initdata, so there's no runtime overhead. On the 
other hand, you get the advantage that the keys just work.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

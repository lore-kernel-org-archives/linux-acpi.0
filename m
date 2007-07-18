From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and getkeycode key table.
Date: Wed, 18 Jul 2007 15:28:01 +0100
Message-ID: <20070718142800.GA20607@srcf.ucam.org>
References: <1184520879991-git-send-email-malattia@linux.it> <11845208793336-git-send-email-malattia@linux.it> <11845208793678-git-send-email-malattia@linux.it> <11845208794064-git-send-email-malattia@linux.it> <11845208791511-git-send-email-malattia@linux.it> <20070715211128.GA6291@srcf.ucam.org> <1184605565.2228.57.camel@work> <20070716180928.GA21211@srcf.ucam.org> <1184668653.2443.2.camel@work> <20070718114518.GB21658@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:53636 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbXGRO2Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 10:28:16 -0400
Content-Disposition: inline
In-Reply-To: <20070718114518.GB21658@inferi.kami.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Richard Hughes <hughsient@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, Jul 18, 2007 at 08:45:19PM +0900, Mattia Dongili wrote:
> On Tue, Jul 17, 2007 at 11:37:33AM +0100, Richard Hughes wrote:
> > On Mon, 2007-07-16 at 19:09 +0100, Matthew Garrett wrote:
> > > 
> > > That's fine, we have information that lets us distinguish between 
> > > models. 
> 
> Well, I don't think we have all, at least I don't and anyway it's nice
> to have some way to add new models that doesn't require waiting for a new
> kernel to be available.

They can still be overridden in exactly the same way - it's just a 
question of sending useful defaults on most machines. If a user finds 
that the defaults don't work they can still be remapped via hal, but the 
aim should be for that to be unnecessary where possible.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [RFH,Status] Sony Vaio VGN-Z11 support
Date: Fri, 14 Nov 2008 22:25:57 +0100
Message-ID: <20081114222557.04025d36@mjolnir.drzeus.cx>
References: <20081025214602.GB27030@gamma.logic.tuwien.ac.at>
	<20081108213414.579e178d@mjolnir.drzeus.cx>
	<20081108233337.GA21200@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server.drzeus.cx ([85.8.24.28]:56207 "EHLO smtp.drzeus.cx"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750936AbYKNV0A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Nov 2008 16:26:00 -0500
In-Reply-To: <20081108233337.GA21200@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-acpi@vger.kernel.org

On Sun, 9 Nov 2008 00:33:37 +0100
Norbert Preining <preining@logic.at> wrote:

> Hi Pierre,
> 
> On Sa, 08 Nov 2008, Pierre Ossman wrote:
> > The reader worked once you had a card in there in those cases. Could
> > you enable MMC_DEBUG in the kernel config and see what you get in dmesg
> > when you insert a card.
> 
> I have inserted a card and did a reboot into the kernel with MMC_DEBUG
> enabled and got that (irrelevant lines removed):
> 

The hardware is properly reporting that the card is present at least.
But everything else seems completely broken.

I'm afraid there's not much I can do at this point. We need to either
squeeze something useful out of Ricoh, or do some reverse engineering
on their Windows driver to figure out what kind of magic this chip
needs.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

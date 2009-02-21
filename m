From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [RFH,Status] Sony Vaio VGN-Z11 support
Date: Sat, 21 Feb 2009 13:48:21 +0100
Message-ID: <20090221134821.7540c39d@mjolnir.ossman.eu>
References: <20081025214602.GB27030@gamma.logic.tuwien.ac.at>
	<20081108213414.579e178d@mjolnir.drzeus.cx>
	<20081108233337.GA21200@gamma.logic.tuwien.ac.at>
	<20081114222557.04025d36@mjolnir.drzeus.cx>
	<20081025214602.GB27030@gamma.logic.tuwien.ac.at>
	<20081108213414.579e178d@mjolnir.drzeus.cx>
	<20081108233337.GA21200@gamma.logic.tuwien.ac.at>
	<20090127004840.GA7246@gamma.logic.tuwien.ac.at>
	<20090202204027.006bb2e2@mjolnir.drzeus.cx>
	<20090202235754.GA13222@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:60099 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbZBUMsY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Feb 2009 07:48:24 -0500
In-Reply-To: <20090202235754.GA13222@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-acpi@vger.kernel.org

On Tue, 3 Feb 2009 00:57:54 +0100
Norbert Preining <preining@logic.at> wrote:

> 
> Ok, here are my test. I was wrong in the previous email. The card does
> not have to be in the slot:
> 
> Tests, all with kernel 2.6.29-rc3
> 
> - normal boot without card in the slot -> not detected
>   . suspending with OR without card in the slot makes it work!!!!
>     (that is new, I thought that the card has to be in the slot!)
>   . re-ejecting and re-inserting always make the card show up
>     One sequence of eject/re-insert's syslog output is attached.
> 
> - normal boot WITH card in the slot -> detected!!!
> 
> All tests were made with and without ricoh_mmc built into the kernel. It
> does not change anything, so ricoh_mmc does not do anything at all here,
> can be disabled.
> 

This is extremely odd. I'd normally guess that this is because of a
race with ricoh_mmc, but since you've removed that from the equation...

> Hmm, isn't there a way to read the pci settings and see the difference?
> Could it make *the* difference?

Most likely. You can dump the PCI config using lspci -xxx. Compare the
data for everything on the Ricoh device (not just the MMC interface)
and see if you can see a difference before and after suspend.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

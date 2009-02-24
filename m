From: Norbert Preining <preining@logic.at>
Subject: Re: [RFH,Status] Sony Vaio VGN-Z11 support
Date: Wed, 25 Feb 2009 00:44:14 +0100
Message-ID: <20090224234414.GC19062@gamma.logic.tuwien.ac.at>
References: <20081108213414.579e178d@mjolnir.drzeus.cx> <20081108233337.GA21200@gamma.logic.tuwien.ac.at> <20081114222557.04025d36@mjolnir.drzeus.cx> <20081025214602.GB27030@gamma.logic.tuwien.ac.at> <20081108213414.579e178d@mjolnir.drzeus.cx> <20081108233337.GA21200@gamma.logic.tuwien.ac.at> <20090127004840.GA7246@gamma.logic.tuwien.ac.at> <20090202204027.006bb2e2@mjolnir.drzeus.cx> <20090202235754.GA13222@gamma.logic.tuwien.ac.at> <20090221134821.7540c39d@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:56552 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbZBXXo1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Feb 2009 18:44:27 -0500
Content-Disposition: inline
In-Reply-To: <20090221134821.7540c39d@mjolnir.ossman.eu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc: linux-acpi@vger.kernel.org

On Sa, 21 Feb 2009, Pierre Ossman wrote:
> > Tests, all with kernel 2.6.29-rc3

and -rc5

> > - normal boot without card in the slot -> not detected
> >   . suspending with OR without card in the slot makes it work!!!!
> >     (that is new, I thought that the card has to be in the slot!)
> >   . re-ejecting and re-inserting always make the card show up
> >     One sequence of eject/re-insert's syslog output is attached.
> > 
> > - normal boot WITH card in the slot -> detected!!!
> > 
> > All tests were made with and without ricoh_mmc built into the kernel. It
> > does not change anything, so ricoh_mmc does not do anything at all here,
> > can be disabled.
> > 
> 
> This is extremely odd. I'd normally guess that this is because of a
> race with ricoh_mmc, but since you've removed that from the equation...
> 
> > Hmm, isn't there a way to read the pci settings and see the difference?
> > Could it make *the* difference?
> 
> Most likely. You can dump the PCI config using lspci -xxx. Compare the
> data for everything on the Ricoh device (not just the MMC interface)
> and see if you can see a difference before and after suspend.

No difference, unfortunately. Absolutely no difference. The normal lspci
shows me:
...
0b:04.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ba)
0b:04.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 IEEE 1394 Controller (rev 04)
0b:04.2 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 21)
0b:04.4 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host Adapter (rev 11)

So I called
	lspci -xxx -s 0b:04
before and after suspend (before and after working state) and there is
no difference at all.

Anything else one can dump/do?

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
CURRY MALLET (n.)
A large wooden or rubber cub which poachers use to despatch cats or
other game which they can only sell to Indian resturants. For
particulary small cats the price obtainable is not worth the cost of
expending ammunition.
			--- Douglas Adams, The Meaning of Liff

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Switching controller mode in software?
Date: Thu, 26 Jul 2007 09:21:07 -0300
Message-ID: <20070726122107.GA25236@khazad-dum.debian.net>
References: <1184659806.15435.4.camel@pancake> <Pine.LNX.4.64.0707250911450.21897@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53872 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752974AbXGZMVP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2007 08:21:15 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707250911450.21897@butterbrot.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-acpi@vger.kernel.org

On Thu, 26 Jul 2007, Florian Echtler wrote:
>> I have a notebook (Acer Aspire 5550) with the Intel ICH7 chipset (see 
>> attached lspci output). Unfortunately, the SATA controller is stuck in 
>> non-AHCI mode and the braindead BIOS doesn't allow me to change that. Is 
>> it possible to change the controller to AHCI mode in software, e.g. 
>> through ACPI?
> Unfortunately, nobody on linux-ide seemed to have an answer for this so 
> far. Therefore, I am hoping that some of you ACPI guys can probably help me 
> out..

ACPI guys don't, this has nothing to do with ACPI, but thinkpad guys can.
There is a patch out there to do just that (force-enable AHCI).  Try
googling for force AHCI or force-enable AHCI, etc.  Sorry, I don't have the
patch around.

And be aware that it is your problem if this croaks something should your
BIOS try to talk to the disks at poweroff/suspend/etc.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

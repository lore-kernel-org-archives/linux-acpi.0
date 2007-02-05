From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Bad libata resume behaviour due to ACPICA change (in acpi-test)
Date: Mon, 5 Feb 2007 21:59:04 -0200
Message-ID: <20070205235904.GA18392@khazad-dum.debian.net>
References: <20070203004140.GB619@khazad-dum.debian.net> <B41635854730A14CA71C92B36EC22AAC803F9D@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:47694 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933089AbXBEX7O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Feb 2007 18:59:14 -0500
Content-Disposition: inline
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC803F9D@mssmsx411>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

On Mon, 05 Feb 2007, Starikovskiy, Alexey Y wrote:
> I cannot reproduce your problem with T43 here on linux-acpi-test with
> defconfig (relevant ACPI modules were tried both dynamic and static).
> Resume time is about 4-6 seconds, not 20-40 as you mention.

Never tried a thinkpad in defconfig mode.  Will do.

> Could you please send your .config and try defconfig on your machine?
> 
> BTW, my T43 use AHCI mode of SATA controller, if it matters...

Mine is stuck in legacy mode, so we are using different drivers (ata_piix in
my case).  Which BIOS and firmware you got?  What is your machine type?  I
am very interested in a way to get my T43 into AHCI mode...

Mine is a ThinkPad T43 2687-DDU, BIOS is 1.29, EC firmware is 1.06.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

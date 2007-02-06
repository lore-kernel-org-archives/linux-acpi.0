From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: T43 BIOS and AHCI
Date: Tue, 6 Feb 2007 11:39:14 -0200
Message-ID: <20070206133914.GC18392@khazad-dum.debian.net>
References: <20070205235904.GA18392@khazad-dum.debian.net> <B41635854730A14CA71C92B36EC22AAC804186@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:46780 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752153AbXBFNjX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Feb 2007 08:39:23 -0500
Content-Disposition: inline
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC804186@mssmsx411>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>
Cc: linux-acpi@vger.kernel.org

On Tue, 06 Feb 2007, Starikovskiy, Alexey Y wrote:
> T43 2668-NG2 BIOS 1.23 EC 1.03

We use the same BIOS (TP-1Y), but you are using a very old version.  A lot
might have changed since then, including AHCI support going away.  I don't
think I ever run a 1.23 bios on my machine...

And I know for a fact that the ACPI DSDT tables *did* change since 1.23, as
I have been looking at the DSDT changes in later versions of the BIOS as I
upgrade them.

Anyway, do you have anything in the BIOS that allows you to select AHCI
mode, or did Linux just load AHCI and skipped merrily along?  Here, AHCI
won't load with an error (supposedly because the ICH is already set to
non-AHCI mode).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

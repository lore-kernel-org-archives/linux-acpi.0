From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [Bugfix v3] PCI, ACPI: Fix regressions caused by resource_size_t
 overflow with 32-bit kernel
Date: Wed, 24 Jun 2015 12:18:43 +0200
Message-ID: <20150624101843.GA8924@gmail.com>
References: <20150624094916.GA5696@gmail.com>
 <1435141065-28536-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36235 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbFXKSt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jun 2015 06:18:49 -0400
Content-Disposition: inline
In-Reply-To: <1435141065-28536-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Boszormenyi Zoltan <zboszor@pr.hu>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>


* Jiang Liu <jiang.liu@linux.intel.com> wrote:

> A regression report from Boszormenyi Zoltan <zboszor@pr.hu>:
> There's a Realtek RTL8111/8168/8411 (PCI ID 10ec:8168, Subsystem ID 1565:230e)
> network chip on the mainboard. After the r8169 driver loaded, the IRQs in
> the machine went berserk. Keyboard keypressed arrived with considerable
> latency and duplicated, so no real work was possible. The machine responded
> to the power button but didn't actually power down. It just stuck at the
> powering down message. I had to press the power button for 4 seconds to power
> it down.
> 
> The computer is a POS machine with a big battery inside. Because of this,
> either ACPI or the Realtek chip kept the bad state and after rebooting, the
> network chip didn't even show up in lspci. Not even the PXE ROM announced
> itself during boot. I had to disconnect the battery to beat some sense back
> to the computer.
> 
> The regression happens with 4.0.5, 4.1.0-rc8 and 4.1.0-final. 3.18.16 was
> good.

So please put this into quotes, like:

===============
Zoltan Boszormenyi reported this regression:

  "There's a Realtek RTL8111/8168/8411 (PCI ID 10ec:8168, Subsystem ID 1565:230e)
   network chip on the mainboard. After the r8169 driver loaded, the IRQs in
   the machine went berserk. Keyboard keypressed arrived with considerable
   latency and duplicated, so no real work was possible. The machine responded
   to the power button but didn't actually power down. It just stuck at the
   powering down message. I had to press the power button for 4 seconds to power
   it down.
 
   The computer is a POS machine with a big battery inside. Because of this,
   either ACPI or the Realtek chip kept the bad state and after rebooting, the
   network chip didn't even show up in lspci. Not even the PXE ROM announced
   itself during boot. I had to disconnect the battery to beat some sense back
   to the computer.
 
   The regression happens with 4.0.5, 4.1.0-rc8 and 4.1.0-final. 3.18.16 was
   good."

...
===============

Also note the indentation, that helps readability.

Thanks,

	Ingo

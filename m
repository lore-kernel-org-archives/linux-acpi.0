From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [RFH,Status] Sony Vaio VGN-Z11 support
Date: Sat, 8 Nov 2008 21:34:14 +0100
Message-ID: <20081108213414.579e178d@mjolnir.drzeus.cx>
References: <20081025214602.GB27030@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server.drzeus.cx ([85.8.24.28]:50754 "EHLO smtp.drzeus.cx"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752047AbYKHUeZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Nov 2008 15:34:25 -0500
In-Reply-To: <20081025214602.GB27030@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org

On Sat, 25 Oct 2008 23:46:02 +0200
Norbert Preining <preining@logic.at> wrote:

> Card reader
> ===========
> 
> SD/MMC card reader
>   PCI: 0b:04.2 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 21)
> MemoryStick card reader
>   PCI: 0b:04.4 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus
> Host Adapter (rev 11)
>   
>   When I introduce the a SD card nothing works, but the kernel log shows
>   me:
>   mmc0: Reset 0x1 never completed.

It is possible to wire the Ricoh chips in some odd way that makes them
misbehave whenever the slot is empty. This has only been observed on
Samsung laptops so far though.

The reader worked once you had a card in there in those cases. Could
you enable MMC_DEBUG in the kernel config and see what you get in dmesg
when you insert a card.

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

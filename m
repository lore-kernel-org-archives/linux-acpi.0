From: Lars Noschinski <lars@public.noschinski.de>
Subject: dock, warning messages (Samsung X20)
Date: Sun, 23 Jul 2006 20:20:24 +0200
Message-ID: <20060723182024.GA9087@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:31152 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751155AbWGWSUY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Jul 2006 14:20:24 -0400
Received: from unknown (HELO vertikal.home.noschinski.de) (336680@[87.78.68.6])
          (envelope-sender <lars@public.noschinski.de>)
          by smtprelay03.ispgateway.de (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-acpi@vger.kernel.org>; 23 Jul 2006 18:20:21 -0000
Received: from lars by vertikal.home.noschinski.de with local (Exim 4.62)
	(envelope-from <lars@public.noschinski.de>)
	id 1G4iYy-0004Cl-SV
	for linux-acpi@vger.kernel.org; Sun, 23 Jul 2006 20:20:24 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello!

I'm using the acpi dock module on a Samsung X20 1730 V and it seems to
work, as far as I tested it (2.6.18-rc2). However, on docking / undocking I get some
warning messages.

I don't know if these are important, as the system seems to work
nevertheless. For debugging purposes, I put lsmod, lspci -vv, dmesg and
acpidump output for docked/undocked boot on

http://avalon.hoffentlich.net/~cebewee/dock

Let me know, if you need additional infos.

Greetings,
    Lars

Docking:
----------------------------------------------------------------------------------------
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dd400] [20060707]
ACPI: docking
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dde14] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17db734] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da914] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17daf54] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dae8c] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dadb0] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dacd4] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dd400] [20060707]
usb 1-6: new high speed USB device using ehci_hcd and address 5
usb 1-6: configuration #1 chosen from 1 choice
hub 1-6:1.0: USB hub found
hub 1-6:1.0: 4 ports detected

Undocking:
----------------------------------------------------------------------------------------
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dde00] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dddec] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dddd8] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17db720] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17db70c] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da900] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da8ec] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da8d8] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da8c4] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da8b0] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da89c] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da888] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da874] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da860] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da84c] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da838] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da824] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da810] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da7fc] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da7e8] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da7d4] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da7c0] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da7ac] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da784] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da770] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dafe0] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dafcc] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dafb8] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dafa4] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17daf90] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17daf7c] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17daf68] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17daf54] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dae8c] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dadb0] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dacd4] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17d8734] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17d8720] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17d870c] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17d86f8] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17d86e4] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17d86d0] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17d86bc] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17d86a8] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17d8694] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17d8680] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17da798] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17daf54] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dae8c] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dadb0] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dacd4] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17d8748] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dd3ec] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dd3d8] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dd3c4] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dd3b0] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dd39c] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dd388] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dd374] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dd360] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dd34c] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dd338] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dd324] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dd310] [20060707]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c17dd2fc] [20060707]
ACPI: undocking
usb 1-6: USB disconnect, address 4

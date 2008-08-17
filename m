From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Question about acpi_pci_irq_disable()
Date: Sun, 17 Aug 2008 20:01:23 +0200
Message-ID: <200808172001.24313.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40903 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbYHQR6H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Aug 2008 13:58:07 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@virtuousgeek.org>

Hi,

Recently I have been looking at acpi_pci_irq_disable() and it seems to me
that on x86 it actually doesn't do anything useful.

Namely, it may trigger acpi_pci_link_free_irq(), but that only does error
checking because of the '#ifdef FUTURE_USE'.  Then, it may call
acpi_unregister_gsi(), but on x86 that is a NOP.

So, is my observation (that acpi_pci_irq_disable() doesn't do anything useful
on x86) correct?

Rafael

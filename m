From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] PCI PM: Rework pci_set_power_state
Date: Tue, 17 Jun 2008 02:06:26 +0200
Message-ID: <200806170206.26616.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60616 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240AbYFQAQp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Jun 2008 20:16:45 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>

Hi,

I've recently discovered that pci_set_power_state() calls the platform
callback intended for changing the state of the device after it has done
that using the native PCI mechanism.  In my opinion this is not correct,
because, for example, if the device is being put into D0 from a low power
state, it may require some platform-controlled power resources to be turned
on before that (in theory).

The following series of patches changes this function so that the platform
callback is performed first and then the native mechanism is used.
Additionally, however, it checks if the devices is power manageable by the
platform and only in that case the platform callback is invoked.  For this
purpose, I needed to add an ACPI function allowing PCI to check the power
manageability of given device.

Comments welcome.

Thanks,
Rafael


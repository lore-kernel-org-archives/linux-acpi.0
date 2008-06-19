From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/9] PCI PM: Rework PCI device PM
Date: Fri, 20 Jun 2008 01:45:32 +0200
Message-ID: <200806200145.33053.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52490 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754317AbYFSX55 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jun 2008 19:57:57 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

Hi,

The following series of patches is intended to rework PCI device power
management to join it with the related ACPI bits more tightly and to clean up
disabling/enabling the system wake-up capability of PCI devices.  In
particular, after these patches the PCI devices that are capable of waking
up the system should have their /sys/devices/.../power/wakup files set up
as appropriate.

The last patch introduces two helper function intended to be used by PCI
drivers implementing the new suspend/hibernation callbacks that do not take
the second pm_message_t argument.

Comments welcome.

Thanks,
Rafael


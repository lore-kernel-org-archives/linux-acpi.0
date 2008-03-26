From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] PM: Rework suspend and hibernation code for devices (rev. 2)
Date: Wed, 26 Mar 2008 23:53:29 +0100
Message-ID: <200803262353.30566.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41703 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753242AbYCZXKI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Mar 2008 19:10:08 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Oliver Neukum <oliver@neukum.org>

Hi,

The following three patches are intended to start the redesign of the suspend
and hibernation framework for devices.

The first one is the 4th revision of the patch introducing new callbacks for
suspend and hibernation.

The other two patches implement the new suspend and hibernation callbacks
for the platform and PCI bus types.

Please review.

Thanks,
Rafael


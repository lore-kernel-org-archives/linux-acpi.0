From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] PM: Suspend and hibernate error paths fixes
Date: Thu, 1 Jul 2010 23:56:44 +0200
Message-ID: <201007012356.44690.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42604 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758918Ab0GAWCQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jul 2010 18:02:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>

Hi,

The following three patches are intended to fix a few bugs spotted recently
in the suspend/hibernation core code.

Since they are located in error paths, hopefully they have no chance to trigger
to often. ;-)

Rafael


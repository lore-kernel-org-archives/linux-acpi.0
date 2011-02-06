From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] ACPI / PM: Fix suspend regression related to button GPEs
Date: Sun, 6 Feb 2011 14:18:55 +0100
Message-ID: <201102061418.56202.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47709 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397Ab1BFNVq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Feb 2011 08:21:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Ferenc =?utf-8?q?W=C3=A1gner?= <wferi@niif.hu>

Hi,

The first of the following patches fixes the suspend regression tracked in
References: https://bugzilla.kernel.org/show_bug.cgi?id=27372
and the second one corrects a small ugliness in the button driver.

Please apply!

Thanks,
Rafael


From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/2] PM: Update system power off code
Date: Sun, 1 Jul 2007 20:51:47 +0200
Message-ID: <200707012051.48338.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38150 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755371AbXGASr3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Jul 2007 14:47:29 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

Hi,

The following two patches update the system power off code.  They:
* remove the (unnecessary) call to acpi_sleep_prepare(ACPI_STATE_S4) from
  acpi_shutdown()
* remove acpi_sysclass and device_acpi that are only defined to register the
  ACPI power off preparation callback in acpi_shutdown() and introduce more
  general mechanism instead
The details are in the changelogs.

Comments welcome.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth


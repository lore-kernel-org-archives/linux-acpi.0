From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] PM: Improve ACPI handling during suspend and hibernation
Date: Sun, 26 Aug 2007 15:09:39 +0200
Message-ID: <200708261509.40118.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40538 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbXHZNGZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Aug 2007 09:06:25 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>, Thomas Renninger <trenn@suse.de>

Hi,

The next three patches are intended to improve the handling of the ACPI
platform during suspend and hibernation.

The do the following:
* make hibernation_platform_enter() consistent with the sleep state entering
  code in kernel/power/main.c
* introduce global platform callbacks allowing us to handle ACPI in a more fine
  grained way during suspend and hibernation
* improve the handling of the system status indicator during suspend and
  hibernation.
Details are in the changelogs.

Comments welcome.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth


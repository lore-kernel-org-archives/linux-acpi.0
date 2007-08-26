From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] PM: Improve ACPI handling during suspend and hibernation (rev. 2)
Date: Mon, 27 Aug 2007 01:49:51 +0200
Message-ID: <200708270149.52585.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42139 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304AbXHZXpY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Aug 2007 19:45:24 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>, Thomas Renninger <trenn@suse.de>

Hi,

This is the second revision of the patches intended to improve the hand=
ling of
the ACPI platform during suspend and hibernation.

They do the following things:
* make hibernation_platform_enter() consistent with the sleep state ent=
ering
=A0 code in kernel/power/main.c
* introduce global platform callbacks allowing us to handle ACPI in a m=
ore fine
=A0 grained way during suspend and hibernation
* improve the handling of the system status indicator during suspend an=
d
=A0 hibernation.
Details are in the changelogs.

Comments welcome.

Greetings,
Rafael

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

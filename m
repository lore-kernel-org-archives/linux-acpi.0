From: Mikhail Gusarov <dottedmag@dottedmag.net>
Subject: Asus M6N: no battery information in > 2.6.20
Date: Sun, 10 Jun 2007 14:54:43 +0700
Message-ID: <87zm38gs70.fsf@vertex.dottedmag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dottedmag.net ([85.118.226.199]:51151 "EHLO dottedmag.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762562AbXFJI0R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Jun 2007 04:26:17 -0400
Received: from vertex.dottedmag.net (unknown [10.10.31.3])
	by dottedmag.net (Postfix) with ESMTP id EB07E1BE45
	for <linux-acpi@vger.kernel.org>; Sun, 10 Jun 2007 14:54:44 +0700 (NOVST)
Received: from vertex.dottedmag.net (localhost [127.0.0.1])
	by vertex.dottedmag.net (Postfix) with ESMTP id 1127913BF5
	for <linux-acpi@vger.kernel.org>; Sun, 10 Jun 2007 14:54:44 +0700 (NOVST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I've encountered a regression: 2.6.20 kernel correctly obtained battery level
information on Asus M6N notebook, while 2.6.22-rc3 (and rc4) no longer do this.

All relevant information and files are posted in
http://bugzilla.kernel.org/show_bug.cgi?id=8598. Copying from the bug
description:

Most recent kernel where this bug did *NOT* occur: 2.6.20
Distribution: Debian
Hardware Environment: Asus M6N notebook
Problem Description:

Main battery status/information is not reported: in 2.6.20 there were two
directories in /proc/acpi/battery: BAT0 and BAT1 (second properly reported as
missing, seems to be slot for extension battery), in 2.6.22-rc3 and rc4 there is
only BAT1.

PS: please CC me, I'm not in list.

-- 
JID: dottedmag@jabber.dottedmag.net

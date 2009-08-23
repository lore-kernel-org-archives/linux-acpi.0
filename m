From: Tomas Davidek <Tomas.Davidek@cern.ch>
Subject: battery alarm unsupported
Date: Sun, 23 Aug 2009 09:21:23 +0000 (UTC)
Message-ID: <loom.20090823T111106-926@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:60869 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755926AbZHWJZE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Aug 2009 05:25:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mf9Jv-0004jC-QK
	for linux-acpi@vger.kernel.org; Sun, 23 Aug 2009 11:25:04 +0200
Received: from nat.pe3ny.net ([nat.pe3ny.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sun, 23 Aug 2009 11:25:03 +0200
Received: from Tomas.Davidek by nat.pe3ny.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sun, 23 Aug 2009 11:25:03 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,
  I've a new laptop Dell Latitude E6500 running Debian with newest stable kernel
2.6.30. ACPI works well except that the "battery critical" events are not
generated (whereas on my previous Dell it was the case). I believe it is because:
[ipnp-n19] ~ > cat /proc/acpi/battery/BAT0/alarm     
alarm:                   unsupported
[ipnp-n19] ~ > cat /sys/class/power_supply/BAT0/alarm
0

First I thought that this is due to Bios problem (would not be so surprised with
Dell) that could be eventually fixed by compiling my own DSDT. However, an
expert (B. Zeimets, who is a Debian developer) told me that this is rather a
kernel acpi issue, that why I am posting the message here
Please let me know what info is needed to figure out what's going on, eventually
what info is needed for a fix in kernel acpi.

Thanks a lot in advance,

best regards
                Tomas


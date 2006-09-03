From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: 2.6.18-rc5 -rc5-mm1: kacpid continuously generating 4% CPU load on HPC nx6325 w/ SUSE 10.1
Date: Sun, 3 Sep 2006 11:23:02 +0200
Message-ID: <200609031123.02237.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57828 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751045AbWICJUK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Sep 2006 05:20:10 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Stefan Seyfried <seife@suse.de>

Hi,

I'm having a strange issue with the 2.6.18-rc5 and -rc5-mm1 kernels and
SUSE 10.1 on HPC nx6325 that kacpid is generating 4% of CPU load (on one core)
in a continuous manner.

It sometimes helps if powersaved is restarted, but only for a short time.
However, after restarting powersaved the kacpid-generated load sometimes jumps
to 100% (on one core) and stays on this level.

At the same time the battery is never reported to be 100% full (it stops at
~98% full and loading) and when I tried to unload the battery module, rmmod
ended up in the D state.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

-- 
VGER BF report: U 0.5

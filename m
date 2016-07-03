From: =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: external monitor of a docked ThinkPad needs "chvt1; chvt7" after
 s2ram
Date: Sun, 3 Jul 2016 21:10:16 +0200
Message-ID: <57796318.3010805@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:58342 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835AbcGCTKX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Jul 2016 15:10:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>

otherwise the monitor is just black, although the docked ThinkPad T440s wakes up fine iand is up and running.
(system: i5, i915, current kernel and older kernel versions of a 64 bit hardened Gentoo linux).

Just to help to improve the kernel (if it is a kernel issue).

-- 
Toralf
PGP: C4EACDDE 0076E94E, OTR: 420E74C8 30246EE7

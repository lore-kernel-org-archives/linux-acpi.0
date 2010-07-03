From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: trouble to bisect current acpi-pm regression
Date: Sat, 03 Jul 2010 22:47:09 +0200
Message-ID: <1278190029.5209.26.camel@zwerg>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:53599 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754447Ab0GCUrL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 Jul 2010 16:47:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, kernel-testers@vger.kernel.org

Hallo all,
i have regression in current master HEAD wich i can't properly bisect,
so i need your help. Please point me if i make some mistake or you have
some other ideas.

Regression: Standby do not working with newest linus/master.git .
To reproduce i use plain: "echo mem > /sys/power/state"
After this, standby initiated, but will freeze with black screen and
cursors on the left top corner. Nothing other is working, power button
will not return it to normals state. So i need to hard reset it.

For bisect i used two points: v2.6.35-rc2 - good; and HEAD - bad.
A result i get:
commit 7c8d20d40f29e7c08332d406d7a65678dece4627
Merge: 63a07cb 9a40ac8
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Jun 10 07:35:41 2010 -0700

    Merge master.kernel.org:/home/rmk/linux-2.6-arm
    
    * master.kernel.org:/home/rmk/linux-2.6-arm:
      ARM: 6164/1: Add kto and kfrom to input operands list.
      ARM: 6166/1: Proper prefetch abort handling on pre-ARMv6
      ARM: 6165/1: trap overflows on highmem pages from kmap_atomic when
debuggi
      ARM: 6152/1: ux500 make it possible to disable localtimers
      [ARM] pxa/spitz: Correctly register WM8750
      [ARM] pxa/palmtc: storage class should be before const qualifier
      ARM: 6146/1: sa1111: Prevent deadlock in resume path
      ARM: 6145/1: ux500 MTU clockrate correction
      ARM: 6144/1: TCM memory bug freeing bug
      ARM: VFP: Fix vfp_put_double() for d16-d31

what can't be true. I double checked it and steel get same result. This
commit, is currently first commit, where i can reproduce this
regression.

Is it possible git bisect miss some branch? Any tips to find real patch?

Regards,
Alexey


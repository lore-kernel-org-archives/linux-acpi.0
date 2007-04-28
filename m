From: malattia@linux.it
Subject: [patch 0/9 v2] sony drivers: finish rewriting sonypi and updates
Date: Sat, 28 Apr 2007 23:15:57 +0900
Message-ID: <20070428141557.GA4764@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi15.ns.itscom.net ([219.110.2.185]:44909 "EHLO
	mtoichi15.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbXD1ORs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Apr 2007 10:17:48 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>

[It seems vger doesn't like my batch mailings... so retrying also with
an updated patchset]

Hi Len,

first of all a thought about pushing all the latest sony-laptop stuff
for 2.6.22: many recent vaios are not supported anymore by sonypi wrt
its functionalities while they all seem to work with the acpi based
implementation present in sony-laptop in acpi-test. Thus I'd suggest
pushing all of it to Linus when the 2.6.22 window opens.
Agree?

Then a small explanation about this batch, patch description is in the
patch itself:

1. a fix for the motion eye camera support in old c1ve/c1vn series, the
   camera support is still incomplete in sony-laptop at this point but
   this change is needed to avoid bad things with the current code, and
   support will be complete with patch #6

2. add mutex locking to the ioport access in sony-laptop

3. add power on/off a new device present in some SZ laptops
   (edge/gprs modem)

4. suggest using sony-laptop to sonypi users both to try to have more
   feedback and to start moving away from it.

5. try to detect sony-laptop usage in sonypi by looking at the known
   ioports usage

6. complete motion eye camera support in sony-laptop

7. add sony-laptop.h header for meye usage

8. make meye use sony-laptop instead of sonypi

9. remove camera controls from the platform attributes and let the meye
   module do it based on real pci_ids.

The patches are based on acpi-test, please apply.
---
 drivers/char/sonypi.c       |   35 ++++
 drivers/media/video/meye.c  |   62 ++++----
 drivers/media/video/meye.h  |    4 
 drivers/misc/sony-laptop.c  |  314 +++++++++++++++++++++++++++++---------------
 include/linux/sony-laptop.h |   34 ++++
 5 files changed, 308 insertions(+), 141 deletions(-)
-- 
mattia
:wq!

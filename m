From: malattia@linux.it
Subject: [patch 0/9] [RFC] sonypi ACPI reimplementation (resend 3)
Date: Mon, 9 Apr 2007 19:15:04 +0200
Message-ID: <20070409171504.GA10646@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:45017 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbXDIRQk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Apr 2007 13:16:40 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, stelian@popies.net

[Resend 3: hopefully this time it will make to the list and the intended
recipients]

The following patch series is the state of the art of my work toward
reimplementing sonypi into sony-laptop. Most patches are mostly cosmetic
to try to obtain a decent namespace separation between the used
subsystems and the drivers driving the two sony devices (SNC and SPIC).
If suitable it would be nice to start applying to acpi-test so that akpm
gets them in -mm (update: it's already in .21-rc6-mm1).

Len, if you prefer a big large patch or a different series, just ask.
The most interesting patches are probably 0004, 0006 and 0009.
Andrew, the 9th patch is now really against acpi-test (I think the Kconfig hunk
didn't apply correclty).

0001-Remove-ACPI-references-from-variable-and-function-names.patch
0002-prepare-pfdriver-for-multiple-users.patch
0003-introduce-debug-macros.patch
0004-add-sny6001-device-handling-from-sonypi.patch
0005-unify-input-subsystem-event-fwd.patch
0006-add-SNY6001-platform-attributes.patch
0007-sanitize-printk-logs.patch
0008-update-documentation.patch
0009-add-sonypi-compat-code.patch
---
 Documentation/sony-laptop.txt |   25 
 drivers/misc/Kconfig          |   15 
 drivers/misc/sony-laptop.c    | 2019 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 1842 insertions(+), 217 deletions(-)

-- 
mattia
:wq!

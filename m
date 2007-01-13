From: malattia@linux.it
Subject: [PATCH 0/11] sony_acpi: prepare for prime time (resend)
Date: Sat, 13 Jan 2007 23:04:30 +0100
Message-ID: <11687258812893-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:59806 "EHLO
	aa014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbXAMWGH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jan 2007 17:06:07 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Hello again,

as said the following patchset starts to take care of sony_acpi:
1 to 7	are currently in -mm
8 to 10	are my local changes to make sony_acpi make some more interesting
	things on recent vaios
11	initializes the real brightness value in the backlight props (should
	this go in the backlight class itself?) and fixes the error exit path
	for the backlight_device registration

will follow shortly with a patch that makes sony_acpi a platform device driver.

-- 
mattia
:wq

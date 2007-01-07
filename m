From: malattia@linux.it
Subject: [PATCH 0/11] sony_acpi: getting in shape for prime time
Date: Sun,  7 Jan 2007 18:54:32 +0100
Message-ID: <1168192483500-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:46681 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932622AbXAGRzT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jan 2007 12:55:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Hello Len,

I'm sending this first batch of patches for review:

- 1 to 7 are currently present in -mm
- 8 to 10 are my local changes to have sony_acpi do something more
  interesting in recent vaios
- 11 initializes the real brightness value in the backlight props (should this
  go in the backlight class itself?).

I'll start turning /proc to platform_device in the next days.

So, let's go! Comments are very welcome. :)
-- 
mattia
:wq

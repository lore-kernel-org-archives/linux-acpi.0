From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [patch 0/8] ACPI Video various cleanups & fixes
Date: Mon, 05 Nov 2007 11:43:28 -0500
Message-ID: <20071105164328.982283020@anvil.corenet.prv>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:36139 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbXKEQwa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Nov 2007 11:52:30 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2045458wah
        for <linux-acpi@vger.kernel.org>; Mon, 05 Nov 2007 08:52:29 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rui Zhang <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi Len, Rui,

Here is a group of cleanups and patches to the acpi video driver.
Originally I just wanted to fix sysfs placement of input devices
created by the driver, but then I saw some more potential issues.

The patches are against Linus's tree, please let me know if you
want them redone against something else.

Thanks.

-- 
Dmitry


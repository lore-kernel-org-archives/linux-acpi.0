From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/4] Fix a few opses and cleanup video driver
Date: Sat, 08 Aug 2009 00:26:14 -0700
Message-ID: <20090808075626.18C39526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:39399 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbZHHH0S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Aug 2009 03:26:18 -0400
Received: by rv-out-0506.google.com with SMTP id k40so317590rvb.5
        for <linux-acpi@vger.kernel.org>; Sat, 08 Aug 2009 00:26:19 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

Len,

Please consider applying the following 4 patches. 2 of them are
very somple and fix oopses (the one involving backlight can be
triggered on any alptop that does not export backlight controls
in DSDT, the other one can only be triggered if cooling device
registration fails) and I think should be merged in 2.6.31.

The other 2 more of a cleanups (although the 4th one fixes another
potential oops at unloading) and can wait till later.

Thanks!

---

Dmitry Torokhov (4):
      ACPI: video - cleanup video device registration
      ACPI: video - rename cdev to cooling_device
      ACPI: video - fix potential crash when unloading
      ACPI: video - fix oops when unloading module


 drivers/acpi/video.c |  440 ++++++++++++++++++++++++++++----------------------
 1 files changed, 245 insertions(+), 195 deletions(-)

-- 
Dmitry

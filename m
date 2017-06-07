From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 0/2] ACPI: button: Fix button.lid_init_state=method mode
Date: Wed,  7 Jun 2017 17:43:28 +0800
Message-ID: <cover.1496828498.git.lv.zheng@intel.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49701 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbdFGJni (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Jun 2017 05:43:38 -0400
In-Reply-To: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, systemd-devel@lists.freedesktop.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>

The following approach fixes button.lid_init_state=method mode for
systemd 233:
 https://patchwork.kernel.org/patch/9756457/
 https://patchwork.kernel.org/patch/9756467/
But it is not working well with old systemd 229. This solution tries to
make a more comfortable approach for systemd 229.

There are platform variations implementing ACPI lid device in different
way:
1. Some platforms send "open" events to OS and the events arrive before
   button driver is resumed;
2. Some platforms send "open" events to OS, but the events arrive after
   button driver is resumed, ex., Samsung N210+;
3. Some platforms never send "open" events to OS, but send "open" events to
   update the cached _LID return value, and the update events arrive before
   button driver is resumed;
4. Some platforms never send "open" events to OS, but send "open" events to
   update the cached _LID return value, but the update events arrive after
   button driver is resumed, ex., Surface Pro 3;
5. Some platforms never send "open" events, _LID returns value sticks to
   "close", ex., Surface Pro 1.

[PATCH 1] tries to fix case 2,4, making them working with any systemd.
[PATCH 2] tries to fix case 5, making it working with systemd 233.
          This is also a replacement of the following solution:
           https://patchwork.kernel.org/patch/9760867/
          It seems adding/removing input node and requesting systemd to
          change again is unnecessary for such platforms, so this patch
          simply converts "lid_unreliable" into
          "button.lid_init_state=ignore".

This material is just sent to demonstrate solutions and issues, the
final solution is not determined yet. So marking them as RFC.

Lv Zheng (2):
  ACPI: button: Fix issue that button notify cannot report stateful
    SW_LID state
  ACPI: button: Add a quirk mode for Surface Pro 1 like laptop

 drivers/acpi/button.c | 188 ++++++++++++++++++++++++--------------------------
 1 file changed, 89 insertions(+), 99 deletions(-)

-- 
2.7.4


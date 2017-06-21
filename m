From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v6 0/5] ACPI: button: Fix button.lid_init_state=method mode
Date: Wed, 21 Jun 2017 16:54:57 +0800
Message-ID: <cover.1498034513.git.lv.zheng@intel.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

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

This series tries to provide solutions to fix all cases for old userspace
programs. These solutions include:
1. Fix order issue in case 2,4. Enabled by default.
2. Fix event missing issue in case 3,4. As newer systemd doesn't require
   this fix, and this fix is not power friendly, it is not enabled by
   default, but can be enabled by:
   2.1. button.lid_periodic_update=1: periodically sends _LID value to
        the input layer.
3. Fix persistate close issue in case 5, as newer systemd doesn't require
   this fix, it is not enabled by default, but can be enabled in 2 means:
   3.1. button.lid_init_state=ignore: only adds complement open events.
   3.2. lid_unreliable=1: dymamically adds/removes input node.

Benjamin Tissoires (2):
  ACPI: button: extract input creation/destruction helpers
  ACPI: button: Add an optional workaround to fix a persistent close
    issue for old userspace

Lv Zheng (3):
  ACPI: button: Add a workaround to fix an order issue for old userspace
  ACPI: button: Add an optional workaround to fix an event missing issue
    for old userspace
  ACPI: button: Rework lid_init_state=ignore mode

 drivers/acpi/button.c | 302 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 186 insertions(+), 116 deletions(-)

-- 
2.7.4

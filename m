From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/6] ACPI/EC: Cleanups of command flushing and event polling.
Date: Mon,  3 Nov 2014 13:16:07 +0800
Message-ID: <cover.1414988981.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patchset contains 2 cleanups related to the EC driver:
1. Command flushing
   This patchset flushes EC commands before suspending/resuming, so that
   there won't be timeout for the incomplete commands after resuming.
2. Event polling thread
   It is not proper to send QR_EC command using the same work queue as
   the _Qxx/_Lxx/_Exx evaluations. This patchset moves the QR_EC issuing to
   a seperate thread. This also allows us to extend the EC driver in the
   future to be aware of the events even when SCI_EVT is failed to be set
   by the firmware.

This patchset is split from an EC GPE storming prevention enhancement
series. The original discussion can be found at:
  http://www.spinics.net/lists/linux-acpi/msg51698.html

Lv Zheng (6):
  ACPI/EC: Introduce STARTED/STOPPED flags to replace BLOCKED flag.
  ACPI/EC: Enhance the checks to apply to QR_EC transactions.
  ACPI/EC: Add reference counting for query handlers.
  ACPI/EC: Add command flushing support.
  ACPI/EC: Cleanup QR_SC command processing by adding a kernel thread
    to poll EC events.
  ACPI/EC: Add GPE reference counting debugging messages.

 drivers/acpi/ec.c       |  379 ++++++++++++++++++++++++++++++++++++++---------
 drivers/acpi/internal.h |    2 +
 2 files changed, 313 insertions(+), 68 deletions(-)

-- 
1.7.10

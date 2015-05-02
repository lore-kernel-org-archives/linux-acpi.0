From: Marian Marinov <mm-l@yuhu.biz>
Subject: Patch breaks suspend
Date: Sat, 02 May 2015 23:27:32 +0300
Message-ID: <55453334.9030002@yuhu.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net
List-Id: linux-acpi@vger.kernel.org

Hi guys,
I have Lenovo T520 with one SSD and one SATA drive.

I tried to upgrade to Linux 4.0 and found that after suspend and resume I can't access the second (SATA) drive.
Both drives have bios encryption enabled.

I did a bisect and found that the following patch causes the issue:
commit 5d5132059a1f652de9dc2d62a8ff15561e648d11
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Sat Feb 22 00:48:31 2014 +0100

    ACPI / ATA: Add hotplug contexts to ACPI companions of SATA devices
   
    Modify the SATA subsystem to add hotplug contexts to ACPI companions
    of SATA devices and ports instead of registering special ACPI dock
    operations using register_hotplug_dock_device().
   
    That change will allow the entire code handling those special ACPI
    dock operations to be dropped in the next commit.
   
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Reviewed-by: Aaron Lu <aaron.lu@intel.com>
    Acked-by: Tejun Heo <tj@kernel.org>

Unfortunately I do not understand this part of the code and have no idea what I can do.
Any pointers would be very appreciated.

Best regards,
Marian

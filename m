From: Li Shaohua <shaohua.li@intel.com>
Subject: [PATCH/RFC 0/4]Bind physical devices with ACPI devices
Date: Mon, 08 Nov 2004 12:11:06 +0800
Message-ID: <1099887066.1750.241.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261747AbUKHERR@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Greg <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
ACPI provides many functionalities for physical devices. Such as for
suspend/resume, ACPI can tell us correct devices D-state for S3. There
are tons of devices enhancement for both realtime and boot time from
ACPI. To utilize ACPI, physical devices like PCI devices must know its
partner. The patches try to do this. After this is done, we can enhance
many features, such as improve suspend/resume.
These patches are against 2.6.10-rc1, please give your comments.

Thanks,
Shaohua

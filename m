From: Li Shaohua <shaohua.li@intel.com>
Subject: [PATCH 0/4]Bind physical devices with ACPI devices - take 2
Date: Wed, 05 Jan 2005 10:50:45 +0800
Message-ID: <1104893444.5550.127.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262220AbVAECvj@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Greg <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-acpi@vger.kernel.org

Hi,
The series of patches implement binding physical devices with ACPI
devices. With it, device drivers can utilize methods provided by
firmware (ACPI). These patches are against 2.6.10, please give your
comments.

Thanks,
Shaohua

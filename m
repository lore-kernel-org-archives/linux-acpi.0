From: Aishwarya Pant <aishpant@gmail.com>
Subject: [PATCH v2 1/2] acpi/dptf: document sysfs atttributes
Date: Sat, 10 Feb 2018 14:27:19 +0530
Message-ID: <1ed759fffa55e45a92a69867e8cb35ff3d3978ed.1518252138.git.aishpant@gmail.com>
References: <cover.1518252138.git.aishpant@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34314 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeBJI50 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Feb 2018 03:57:26 -0500
Content-Disposition: inline
In-Reply-To: <cover.1518252138.git.aishpant@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>

The descriptions have been collected from git commit logs and reading
through code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
Changes in v2:
- Split up attribute definitions

 Documentation/ABI/testing/sysfs-platform-dptf | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf

diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
new file mode 100644
index 000000000000..325dc0667dbb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-dptf
@@ -0,0 +1,40 @@
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/charger_type
+Date:		Jul, 2016
+KernelVersion:	v4.10
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) The charger type - Traditional, Hybrid or NVDC.
+
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/adapter_rating_mw
+Date:		Jul, 2016
+KernelVersion:	v4.10
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Adapter rating in milliwatts (the maximum Adapter power).
+		Must be 0 if no AC Adaptor is plugged in.
+
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/max_platform_power_mw
+Date:		Jul, 2016
+KernelVersion:	v4.10
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Maximum platform power that can be supported by the battery
+		in milliwatts.
+
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/platform_power_source
+Date:		Jul, 2016
+KernelVersion:	v4.10
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Display the platform power source
+		0x00 = DC
+		0x01 = AC
+		0x02 = USB
+		0x03 = Wireless Charger
+
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/battery_steady_power
+Date:		Jul, 2016
+KernelVersion:	v4.10
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) The maximum sustained power for battery in milliwatts.
-- 
2.16.1


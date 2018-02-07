From: Aishwarya Pant <aishpant@gmail.com>
Subject: [PATCH 1/2] acpi/dptf: document sysfs atttributes
Date: Wed, 7 Feb 2018 18:48:00 +0530
Message-ID: <01eb929d8dbfa3e2041d33619a7d30a6b0f4748c.1518009225.git.aishpant@gmail.com>
References: <cover.1518009225.git.aishpant@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:37340 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753643AbeBGNSI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2018 08:18:08 -0500
Content-Disposition: inline
In-Reply-To: <cover.1518009225.git.aishpant@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>

The descriptions have been collected from git commit logs and reading
through code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/testing/sysfs-platform-dptf | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf

diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
new file mode 100644
index 000000000000..e8168e5198d7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-dptf
@@ -0,0 +1,30 @@
+sysfs interface for ACPI DPTF platform power driver
+---------------------------------------------------
+
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/charger_type
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/adapter_rating_mw
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/max_platform_power_mw
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/platform_power_source
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/battery_steady_power
+Date:		Jul, 2016
+KernelVersion:	v4.10
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		charger_type:		(RO) The charger type- Traditional,
+					Hybrid or NVDC.
+
+		adapter_rating_mw:	(RO) Adapter rating in milliwatts (the
+					maximum Adapter power). Must be 0 if no
+					AC Adaptor is plugged in.
+
+		max_platform_power_mw:	(RO) Maximum platform power that can be
+					supported by the battery in milliwatts.
+
+		platform_power_source:	(RO) Display the platform power source
+					0x00 = DC
+					0x01 = AC
+					0x02 = USB
+					0x03 = Wireless Charger
+
+		battery_steady_power_mw:(RO) The maximum sustained power for
+					battery in milliwatts.
-- 
2.16.1


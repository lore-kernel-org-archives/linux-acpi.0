From: Aishwarya Pant <aishpant@gmail.com>
Subject: [PATCH v2 2/2] acpi/dock: document sysfs interface
Date: Sat, 10 Feb 2018 14:27:38 +0530
Message-ID: <4766f754e929cf4888ebe4da8d406d29bf07436c.1518252138.git.aishpant@gmail.com>
References: <cover.1518252138.git.aishpant@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1518252138.git.aishpant@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-acpi@vger.kernel.org

Description has been collected from git commit history and reading
through code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
Changes in v2:
- Split up attribute definitions

 .../ABI/testing/sysfs-devices-platform-dock        | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-dock

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-dock b/Documentation/ABI/testing/sysfs-devices-platform-dock
new file mode 100644
index 000000000000..1d8c18f905c7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-dock
@@ -0,0 +1,39 @@
+What:		/sys/devices/platform/dock.N/docked
+Date:		Dec, 2006
+KernelVersion:	2.6.19
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Value 1 or 0 indicates whether the software believes the
+		laptop is docked in a docking station.
+
+What:		/sys/devices/platform/dock.N/undock
+Date:		Dec, 2006
+KernelVersion:	2.6.19
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(WO) Writing to this file causes the software to initiate an
+		undock request to the firmware.
+
+What:		/sys/devices/platform/dock.N/uid
+Date:		Feb, 2007
+KernelVersion:	v2.6.21
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Displays the docking station the laptop is docked to.
+
+What:		/sys/devices/platform/dock.N/flags
+Date:		May, 2007
+KernelVersion:	v2.6.21
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Show dock station flags, useful for checking if undock
+		request has been made by the user (from the immediate_undock
+		option).
+
+What:		/sys/devices/platform/dock.N/type
+Date:		Aug, 2008
+KernelVersion:	v2.6.27
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Display the dock station type- dock_station, ata_bay or
+		battery_bay.
-- 
2.16.1

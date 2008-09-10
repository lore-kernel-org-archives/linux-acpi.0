From: Pavel Machek <pavel@suse.cz>
Subject: catch calls of acpi_driver_data on pointer of wrong type
Date: Wed, 10 Sep 2008 16:11:51 +0200
Message-ID: <20080910141151.GA13669@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755197AbYIJWXV@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, ACPI mailing list <linux-acpi@vger.kernel.org>
Cc: ak@linux.intel.com, hare@suse.de
List-Id: linux-acpi@vger.kernel.org


Catch attempts to use of acpi_driver_data on pointers of wrong type.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Cc: Hannes Reinecke <hare@suse.de>

---
commit 76c9074075cd9208cf386f37ebd932a00557643a
tree 02589a15c23f430c7728560e4ba51077d41a6eff
parent d4a51ebfa2ffc3320d7eab269dc1ca84e86719f5
author Pavel <pavel@amd.ucw.cz> Wed, 10 Sep 2008 16:10:28 +0200
committer Pavel <pavel@amd.ucw.cz> Wed, 10 Sep 2008 16:10:28 +0200

 include/acpi/acpi_bus.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a5ac0bc..641656e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -300,7 +300,7 @@ struct acpi_device {
 	enum acpi_bus_removal_type removal_type;	/* indicate for different removal type */
 };
 
-#define acpi_driver_data(d)	((d)->driver_data)
+#define acpi_driver_data(d)	((void) (d == (struct acpi_device *) 0), d)->driver_data
 #define to_acpi_device(d)	container_of(d, struct acpi_device, dev)
 #define to_acpi_driver(d)	container_of(d, struct acpi_driver, drv)
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

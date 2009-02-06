From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] ACPI: dock: Don't eval _STA on every show_docked sysfs
 read
Date: Fri, 06 Feb 2009 17:47:56 +0100
Message-ID: <1233938876.12590.4.camel@homac.suse.de>
References: <1232450304.5286.4.camel@homac.suse.de>
	 <20090127130455.2c1b0cd4.akpm@linux-foundation.org>
Reply-To: hmacht@suse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-BS20JcaEHnzBbJejXpBQ"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:53908 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbZBFQsM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Feb 2009 11:48:12 -0500
In-Reply-To: <20090127130455.2c1b0cd4.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, stable@kernel.org, lenb@kernel.org, Li@suse.de, shaohua.li@intel.com, marvin@mydatex.cz


--=-BS20JcaEHnzBbJejXpBQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

sorry for the delay...

On Tue, 2009-01-27 at 13:04 -0800, Andrew Morton wrote:
> On Tue, 20 Jan 2009 12:18:24 +0100
> Holger Macht <hmacht@suse.de> wrote:
> 
> > Cc: stable@kernel.org
> 
> The patch applied OK to 2.6.28 but not to any earlier kernel.  If we
> decide that it should be backported to 2.6.27 or earlier, a new patch
> might be needed for that.

Patch that applies to stable kernel from today is attached.

Thanks,
	Holger

--=-BS20JcaEHnzBbJejXpBQ
Content-Disposition: attachment; filename="acpi-dock-dont-eval-STA-on-every-show-docked-sysfs-read.patch"
Content-Type: text/x-patch; name="acpi-dock-dont-eval-STA-on-every-show-docked-sysfs-read.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Some devices trigger a DEVICE_CHECK on every evalutation of _STA. This
can also be seen in commit 8b59560a3baf2e7c24e0fb92ea5d09eca92805db
(acpi: dock: avoid check _STA method).  If an undock is processed, the
dock driver sends a uevent and userspace might read the show_docked
property in sysfs. This causes an evaluation of _STA of the particular
device which causes the dock driver to immediately dock again.

In any case, evaluation of _STA (show_docked) does not necessarily mean
that we are docked, so check with the internal device structure.

http://bugzilla.kernel.org/show_bug.cgi?id=12360

Signed-off-by: Holger Macht <hmacht@suse.de>
---

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 25d2161..7290e54 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -691,8 +691,14 @@ fdd_out:
 static ssize_t show_docked(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", dock_present(dock_station));
+	struct acpi_device *tmp;
+
+	struct dock_station *dock_station = *((struct dock_station **)
+		dev->platform_data);
 
+	if (ACPI_SUCCESS(acpi_bus_get_device(dock_station->handle, &tmp)))
+		return snprintf(buf, PAGE_SIZE, "1\n");
+	return snprintf(buf, PAGE_SIZE, "0\n");
 }
 static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
 

--=-BS20JcaEHnzBbJejXpBQ--


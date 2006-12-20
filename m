From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 18/19] ACPI: make code static
Date: Wed, 20 Dec 2006 17:20:37 -0500
Message-ID: <200612201720.37216.lenb@kernel.org>
References: <200612192056.kBJKuOEJ010065@shell0.pdx.osdl.net> <200612201702.46156.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56876 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030398AbWLTW1e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Dec 2006 17:27:34 -0500
In-Reply-To: <200612201702.46156.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, bunk@stusta.de

On Wednesday 20 December 2006 17:02, Len Brown wrote:
> Applied.

Wups, had to NAK the acpi_pci_bind part...

drivers/acpi/pci_root.c: In function =E2=80=98acpi_pci_root_add=E2=80=99=
:
drivers/acpi/pci_root.c:181: error: =E2=80=98acpi_pci_bind=E2=80=99 und=
eclared (first use in this function)
drivers/acpi/pci_root.c:181: error: (Each undeclared identifier is repo=
rted only once
drivers/acpi/pci_root.c:181: error: for each function it appears in.)
make[2]: *** [drivers/acpi/pci_root.o] Error 1
make[2]: *** Waiting for unfinished jobs....
  LD      drivers/pnp/pnpacpi/built-in.o
  LD      drivers/pnp/built-in.o
drivers/acpi/pci_bind.c: In function =E2=80=98acpi_pci_bind=E2=80=99:
drivers/acpi/pci_bind.c:225: error: =E2=80=98acpi_pci_unbind=E2=80=99 u=
ndeclared (first use in this function)
drivers/acpi/pci_bind.c:225: error: (Each undeclared identifier is repo=
rted only once
drivers/acpi/pci_bind.c:225: error: for each function it appears in.)
make[2]: *** [drivers/acpi/pci_bind.o] Error 1

Leaving that below.

thanks,
-Len

commit 9e0ed41e9aff61648e2261ab334fb5eea3d5aeb3
Author: Adrian Bunk <bunk@stusta.de>
Date:   Tue Dec 19 12:56:24 2006 -0800

    ACPI: make code static
   =20
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 279c4ba..555bf00 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -728,7 +728,7 @@ static int __init acpi_bus_init(void)
 	return -ENODEV;
 }
=20
-decl_subsys(acpi, NULL, NULL);
+static decl_subsys(acpi, NULL, NULL);
=20
 static int __init acpi_init(void)
 {
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 90990a4..a66b4c7 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -641,7 +641,7 @@ static ssize_t show_docked(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", dock_present(dock_station));
=20
 }
-DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
+static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
=20
 /*
  * write_undock - write method for "undock" file in sysfs
@@ -657,7 +657,7 @@ static ssize_t write_undock(struct device *dev, str=
uct device_attribute *attr,
 	ret =3D handle_eject_request(dock_station, ACPI_NOTIFY_EJECT_REQUEST)=
;
 	return ret ? ret: count;
 }
-DEVICE_ATTR(undock, S_IWUSR, NULL, write_undock);
+static DEVICE_ATTR(undock, S_IWUSR, NULL, write_undock);
=20
 /**
  * dock_add - add a new dock station
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index fdd1095..cefe952 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -315,8 +315,6 @@ struct acpi_bus_event {
 	u32 data;
 };
=20
-extern struct subsystem acpi_subsys;
-
 /*
  * External Functions
  */
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

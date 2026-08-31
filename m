Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595E3839A0;
	Mon, 31 Aug 2026 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206836; cv=none; b=bBLOclQW5JzGi/a5YcsqM4z8UkRDHyOSBfJ+/ERe/jB6idBcQkwvx4IGvBy/ov9VWhiLvkR2Fdg2SDnGJZZiu4WLua62tZ8hazzegHg5XXMojy+bSNmPeDzMVcYDwZ9PiqMJCynNsYKNVOts3qs6GcUtLb0rf74prBJPSnhAYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206836; c=relaxed/simple;
	bh=E1j7Sdfnpyfm0oFvVlaZ0kmjFpMXExSNpoRgtan/4OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OZv/eEFxZzlLyicbRkI3eJWM1BbfSsKnicrIhnxcF62vz5vkjr+0LB6leP4PEwpvVAM/jQm1ITrqAUqw//5RAJnA1TI9o1DjTHaHgJfU8RbRpKcASIdvXDEErBaTVjk9jPcNFWcpAY5w7za/2AtjRFRUlOQceBQ+thQMd/ochDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqSHiqQS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqSHiqQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AB01F000E9;
	Mon, 31 Aug 2026 20:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788206834;
	bh=UqP6iE36qE2v5zs2vu7b45gepQqfDGbgB7LdmkYot78=;
	h=From:To:Cc:Subject:Date;
	b=XqSHiqQSXZJPiO8C17BPThmj6csk98jzri1M7ycoOEsDOFmjJH8Ghk0sE/rRRETAV
	 ojSOkyoDCSsr8Ewa5PyQSEok0RosRcKwQx1YlvDSiZPI7vYKLg8NQEeYOoGRD4u65w
	 Sd/QjtGlGUIHw9TFxiicjrenh4arLghSNDhOtJXudF0zDN2qr3sa2zve9VIMXsPbGs
	 pQ3Kvw+9EakBBVxKn7VPKs/a5Zo5EGZob8ZIhZn9KuwcRCUD8I3liX4i1fO+/sKa2d
	 SwUtFgFHrmyyFhXaxAFKDFxOWOz5egBTXztA3fj4wzSVQCvOjBWUCgwX1cVuHg0Lab
	 mYLit8A4zKe1A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ACPI: bus: Drop two fields from struct acpi_device_pnp
Date: Mon, 31 Aug 2026 22:07:10 +0200
Message-ID: <6314925.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

There are two fields in struct acpi_device_pnp, device_name and
device_class, that were supposed to be populated and used by device
drivers, but they have never been used consistently and now they
are only set for the bus object in acpi_set_pnp_ids() (and never
read afterward).

Drop them along with all of the associated symbols except for
MAX_ACPI_CLASS_NAME_LEN and the acpi_device_class typedef that
are used by the ACPI netlink messaging code.  Move those two
definitions closer to the struct acpi_bus_event that refers to
the acpi_device_class type.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c     |    4 ----
 include/acpi/acpi_bus.h |   11 +++--------
 2 files changed, 3 insertions(+), 12 deletions(-)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -28,9 +28,7 @@
 #include "internal.h"
 #include "sleep.h"
 
-#define ACPI_BUS_CLASS			"system_bus"
 #define ACPI_BUS_HID			"LNXSYBUS"
-#define ACPI_BUS_DEVICE_NAME		"System Bus"
 
 #define INVALID_ACPI_HANDLE	((acpi_handle)ZERO_PAGE(0))
 
@@ -1446,8 +1444,6 @@ static void acpi_set_pnp_ids(acpi_handle
 			 acpi_object_is_system_bus(handle)) {
 			/* \_SB, \_TZ, LNXSYBUS */
 			acpi_add_id(pnp, ACPI_BUS_HID);
-			strscpy(pnp->device_name, ACPI_BUS_DEVICE_NAME);
-			strscpy(pnp->device_class, ACPI_BUS_CLASS);
 		}
 
 		break;
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -206,12 +206,8 @@ struct acpi_device_dir {
 
 /* Plug and Play */
 
-#define MAX_ACPI_DEVICE_NAME_LEN	40
-#define MAX_ACPI_CLASS_NAME_LEN		20
 typedef char acpi_bus_id[8];
 typedef u64 acpi_bus_address;
-typedef char acpi_device_name[MAX_ACPI_DEVICE_NAME_LEN];
-typedef char acpi_device_class[MAX_ACPI_CLASS_NAME_LEN];
 
 struct acpi_hardware_id {
 	struct list_head list;
@@ -233,16 +229,12 @@ struct acpi_device_pnp {
 	acpi_bus_address bus_address;	/* _ADR */
 	char *unique_id;		/* _UID */
 	struct list_head ids;		/* _HID and _CIDs */
-	acpi_device_name device_name;	/* Driver-determined */
-	acpi_device_class device_class;	/*        "          */
 };
 
 #define acpi_device_bid(d)	((d)->pnp.bus_id)
 #define acpi_device_adr(d)	((d)->pnp.bus_address)
 const char *acpi_device_hid(struct acpi_device *device);
 #define acpi_device_uid(d)	((d)->pnp.unique_id)
-#define acpi_device_name(d)	((d)->pnp.device_name)
-#define acpi_device_class(d)	((d)->pnp.device_class)
 
 /* Power Management */
 
@@ -582,6 +574,9 @@ int acpi_dev_for_each_child_reverse(stru
  * ------
  */
 
+#define MAX_ACPI_CLASS_NAME_LEN		20
+typedef char acpi_device_class[MAX_ACPI_CLASS_NAME_LEN];
+
 struct acpi_bus_event {
 	struct list_head node;
 	acpi_device_class device_class;




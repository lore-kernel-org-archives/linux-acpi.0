Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E537A496;
	Thu, 16 Apr 2026 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324996; cv=none; b=LIagy7FKXVQPY2zaNFScpkvuybkdH8i46Vs5l80U81+6bMZToteb3TimYHdaUdnAYOARiiuJmZCEYKdjjVnL9vA4HwbFa7fJPRV5/1DV0I9M/Wsb1RH4BOV4fzc+UUt+kdmeQYhgVW4TLgJJJo7HPtB7sERBYRIKdiAGzGeGSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324996; c=relaxed/simple;
	bh=6VevYWrs8NqWN2y3Eq38+J1jFjlWELnxkvsZaY351vU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N3GmKDezgejp34lzFVmfgTWmK9RNtzY4GeCwyvp45N07dtg8W8qa5uhQJgk6+kimI23xqWMSAxpRv07hdFIpYoxAzjzmOAmj0+pqIv701KAjnA/7xgZ4J/2gfVDC5M4icmZB9+pbVPfu488M6eGeZxZQOVFDSNGjgozX8naKbAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=UwtS7tZy; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="UwtS7tZy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1776324995; x=1807860995;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=P1H8FkBnSqxqtSxdd4aW+R2l9i7ipYi67lARmUWjnnk=;
  b=UwtS7tZyr4DQDRmffwGhMJXBS/WCADwUrf5XsJOKlBaLf6JjLEnT02ZJ
   kBKR6j7I2H2++jYx2znd3Lb/E9EJcILijT8xHPNK7snds/vVKh/vYKw9M
   6yeK+O1UvMWIBrTqGgOw8SUZPqe8Ua6uh/uGKwvWuCxEoY7rAgf+ERjqq
   UyIpWYrT7lV4+uhfn36pO4o4uvjEo8yO1tR0iei+JiE47GgKbiXcXss39
   L1nth/Azh2kR9dzLmxTjuQbCr6GB/92dzI//eDQDaOhjmKIxSQ06i4Ocm
   sCxgtK3+eOyKA356zzDlC9B0AYZzfxF53BlDYwpu+emm3TtHBgfG129IJ
   A==;
X-CSE-ConnectionGUID: 7fEw4vjRSseXNUva9NjwHg==
X-CSE-MsgGUID: 0Kd3jk+/Rt+bn4VLQyb3DA==
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 16:26:22 +0900
X-CSE-ConnectionGUID: Gap9FMZIR4yR+/UsOrelaQ==
X-CSE-MsgGUID: RCj85djZSR6e3ZBDGeVJRw==
X-IronPort-AV: E=Sophos;i="6.23,181,1770562800"; 
   d="scan'208";a="61013883"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 16 Apr 2026 16:26:21 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Thu, 16 Apr 2026 16:26:16 +0900
Subject: [PATCH] ACPI: bus: set mod_name in driver registration
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-acpi_mod_name-v1-1-1a4d96fd86c9@sony.com>
References: <20260416-acpi_mod_name-v1-0-1a4d96fd86c9@sony.com>
In-Reply-To: <20260416-acpi_mod_name-v1-0-1a4d96fd86c9@sony.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
 Saket Dumbre <saket.dumbre@intel.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, driver-core@lists.linux.dev, 
 Shashank Balaji <shashank.mahadasyam@sony.com>, 
 Rahul Bukte <rahul.bukte@sony.com>, Daniel Palmer <daniel.palmer@sony.com>, 
 Tim Bird <tim.bird@sony.com>
X-Mailer: b4 0.16-dev-3bfbc
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=6VevYWrs8NqWN2y3Eq38+J1jFjlWELnxkvsZaY351vU=;
 b=owGbwMvMwCU2bX1+URVTXyjjabUkhswH/TJmz98cUmR78+XYBZeCI67+RYUTTn18fKF0f/3WZ
 2fcEsTqOkpZGMS4GGTFFFlKlap/7V0RtKTnzGtFmDmsTCBDGLg4BWAiga6MDO99rufu3LzWdvU1
 jlChG1x1jSEe4j+3TfOesaJa7OqXzm6G/65dsyz1uUq9un73l6lWd/lcdFuX3Vyuelgy+XiCwpk
 UTgA=
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=75227BFABDA852A48CCCEB2196AF6F727A028E55

Pass KBUILD_MODNAME through the driver registration macro so that
the driver core can create the module symlink in sysfs for built-in
drivers.

Fixes: 48b9c4862bd3 ("ACPI: store owner from modules with acpi_bus_register_driver()")
Assisted-by: Claude:claude-4.6-opus
Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 drivers/acpi/bus.c      | 5 ++++-
 include/acpi/acpi_bus.h | 5 +++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 2ec095e2009e..152ef49e5970 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1062,18 +1062,21 @@ EXPORT_SYMBOL_GPL(acpi_driver_match_device);
  * __acpi_bus_register_driver - register a driver with the ACPI bus
  * @driver: driver being registered
  * @owner: owning module/driver
+ * @mod_name: module name string
  *
  * Registers a driver with the ACPI bus.  Searches the namespace for all
  * devices that match the driver's criteria and binds.  Returns zero for
  * success or a negative error status for failure.
  */
-int __acpi_bus_register_driver(struct acpi_driver *driver, struct module *owner)
+int __acpi_bus_register_driver(struct acpi_driver *driver, struct module *owner,
+			       const char *mod_name)
 {
 	if (acpi_disabled)
 		return -ENODEV;
 	driver->drv.name = driver->name;
 	driver->drv.bus = &acpi_bus_type;
 	driver->drv.owner = owner;
+	driver->drv.mod_name = mod_name;
 
 	return driver_register(&driver->drv);
 }
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b701b5f972cb..53952ec544e6 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -672,8 +672,9 @@ int acpi_scan_add_handler(struct acpi_scan_handler *handler);
  * use a macro to avoid include chaining to get THIS_MODULE
  */
 #define acpi_bus_register_driver(drv) \
-	__acpi_bus_register_driver(drv, THIS_MODULE)
-int __acpi_bus_register_driver(struct acpi_driver *driver, struct module *owner);
+	__acpi_bus_register_driver(drv, THIS_MODULE, KBUILD_MODNAME)
+int __acpi_bus_register_driver(struct acpi_driver *driver, struct module *owner,
+			       const char *mod_name);
 void acpi_bus_unregister_driver(struct acpi_driver *driver);
 int acpi_bus_scan(acpi_handle handle);
 void acpi_bus_trim(struct acpi_device *start);

-- 
2.43.0


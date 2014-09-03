From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: [PATCH] acpi : not caching sun value in acpi_device_pnp
Date: Wed, 3 Sep 2014 13:39:13 +0900
Message-ID: <54069B71.30404@jp.fujitsu.com>
References: <54052305.9060308@jp.fujitsu.com> <1936799.NYvsvtc9DH@vostro.rjw.lan> <5406796A.30303@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:57587 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbaICEkD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 00:40:03 -0400
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [10.0.237.134])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 46A013EE0C1
	for <linux-acpi@vger.kernel.org>; Wed,  3 Sep 2014 13:40:01 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id EC7E3AC0669
	for <linux-acpi@vger.kernel.org>; Wed,  3 Sep 2014 13:39:59 +0900 (JST)
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8CDA61DB8046
	for <linux-acpi@vger.kernel.org>; Wed,  3 Sep 2014 13:39:59 +0900 (JST)
In-Reply-To: <5406796A.30303@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com, rafael@kernel.org, linux-acpi@vger.kernel.org

By this commit, "202317a : ACPI / scan: Add acpi_device objects for all
device nodes in the namespace", all device nodes in the namespace are
shown under /sys/bus/acpi/devices directory even if the devices are not
present and not functional. And if a device node has _SUN method, it is
decoded and the sun value is cached to acpi_device_pnp->sun.

But when device is not present and not functional, some firmware returns
wrong sun value. And the wrong value is cached to acpi_device_pnp->sun.

Therefore, even if a device is hot added and firmware returns correct
sun value of the device, the value is not reflected to
acpi_device_pnp->sun. So user cannot know correct sun value of the
device.

By not caching sun value, the patch fixes the issue.

Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
  drivers/acpi/scan.c     | 15 ++++++++-------
  include/acpi/acpi_bus.h |  1 -
  2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9a92989..3bf7764 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -667,8 +667,14 @@ static ssize_t
  acpi_device_sun_show(struct device *dev, struct device_attribute *attr,
  		     char *buf) {
  	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	acpi_status status;
+	unsigned long long sun;
+
+	status = acpi_evaluate_integer(acpi_dev->handle, "_SUN", NULL, &sun);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;

-	return sprintf(buf, "%lu\n", acpi_dev->pnp.sun);
+	return sprintf(buf, "%llu\n", sun);
  }
  static DEVICE_ATTR(sun, 0444, acpi_device_sun_show, NULL);

@@ -690,7 +696,6 @@ static int acpi_device_setup_files(struct acpi_device *dev)
  {
  	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
  	acpi_status status;
-	unsigned long long sun;
  	int result = 0;

  	/*
@@ -731,14 +736,10 @@ static int acpi_device_setup_files(struct acpi_device *dev)
  	if (dev->pnp.unique_id)
  		result = device_create_file(&dev->dev, &dev_attr_uid);

-	status = acpi_evaluate_integer(dev->handle, "_SUN", NULL, &sun);
-	if (ACPI_SUCCESS(status)) {
-		dev->pnp.sun = (unsigned long)sun;
+	if (acpi_has_method(dev->handle, "_SUN")) {
  		result = device_create_file(&dev->dev, &dev_attr_sun);
  		if (result)
  			goto end;
-	} else {
-		dev->pnp.sun = (unsigned long)-1;
  	}

  	if (acpi_has_method(dev->handle, "_STA")) {
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index bcfd808..c1c9de1 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -246,7 +246,6 @@ struct acpi_device_pnp {
  	acpi_device_name device_name;	/* Driver-determined */
  	acpi_device_class device_class;	/*        "          */
  	union acpi_object *str_obj;	/* unicode string for _STR method */
-	unsigned long sun;		/* _SUN */
  };

  #define acpi_device_bid(d)	((d)->pnp.bus_id)



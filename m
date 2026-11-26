Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795662339;
	b=ifE3th3Fp+XFRA8uY2ljht8NzB/uYfMoVQOBo42HNaSG89Bu0pCu/Hi0tMAPekzqjdxv
	 yyXGP12CrAR+0g7qlSw73J5rNSvX1e7njNhflr4S+fh4UyTSm+xr3bgG7mnwEfZr6NGRU
	 TKoXePNmHoTgJLTMgmoVKiICeygGOE+/2aFzeW9Ci0y/H15p0/N98j+4HpoNZ4t+PpKjs
	 1ZDXRFDyZHiy7D9HCKBDiIbjj4uqldLwpfGdfOmqkmH+jpe4BmVlnfae6T5AIDwfWAuqj
	 0cztOyZBTAZuhrcMd6yq2+Lz5Epr2hWk6oLjWRV66ged/KCSAxjvp1ogjxKCpDWt4RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662339;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=89QTT1HrwEFq+jLZFOj97z86nlVa/c992xyKucriWiQ=;
	b=m9GB0FlXZd805tSNhHRUpVmcpC3+53DvEKIi+MpKUlEySmz6ydkS7Q5HiSiFA8kt74LU
	 tq6+pgoiM/3LPuVommBl3fXQaU2aVmAd0/dofw25RX5Mjt1d2o0t2fQbyd+fOSjDVbDWE
	 iEylPN6Tz8XlBRNpBtNXG2/1Y2Cq1hVShA6S5CAwzwSOUOaQ8PEJnna2HN6sigyEz0jzi
	 PztysSGVV/K3q5ioeBccQ39gHK2HWoWZaWdjAsXNff9xfl+qJiLdUE4nKq3PxolYOpSPA
	 0JewODdN26N6YXxpz3A+CfpkccU3vCYzI3B59x7h3pQugDjJXtsS8jFRQQtZ7pOL5Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=q3Xyqs4c;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1CE606A321;
	Thu, 26 Nov 2026 03:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED1CE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=q3Xyqs4c
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=89QTT1HrwEFq+jLZFOj97z86nlVa/c992xyKucriWiQ=;
	b=q3Xyqs4cWcUIr1RvjptYUqCH3VLIi2cxLnNzlWr4Oi/0HsOaXRRV9GnN9ODyRbl9WeT9PRlGi
	TwPGizrsEaIjeAFfN9BwR3Dgn2MZxkEo752wyvLTcgn/g3xgYEkl+n1VAP+05iezb3v9g+c1m5Y
	+4P0f0bWcdezp+fF+dSQLNg=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jZhGY1Z6dzcZyd;
	Thu, 26 Nov 2026 11:04:21 +0800 (CST)
Received: from kwepemo100017.china.huawei.com (unknown [7.202.195.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 05BB84057F;
	Thu, 26 Nov 2026 11:05:28 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo100017.china.huawei.com (7.202.195.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 26 Nov 2026 11:05:27 +0800
From: Bowen Yu <yubowen8@huawei.com>
To: <gregkh@linuxfoundation.org>
CC: Bowen Yu <yubowen8@huawei.com>, <rafael@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] driver core: platform: use reg-names for named memory resource lookup
Date: Thu, 26 Nov 2026 11:05:26 +0800
Message-ID: <20261126030526.3911143-1-yubowen8@huawei.com>
X-Mailer: git-send-email 2.33.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo100017.china.huawei.com (7.202.195.215)

Not only platform devices described by OF have named memory resources;
devices described by ACPI, in particular those enumerated through the
PRP0001 DT namespace link, may provide the same "reg-names" property in
_DSD, following the respective Device Tree binding.  However, resources
created from _CRS carry no names, so platform_get_resource_byname()
always fails for them, which prevents drivers shared between Device
Tree and ACPI from using by-name lookups on ACPI.

Teach platform_get_resource_byname() to resolve the "reg-names" device
property into an index onto the memory resources, in the same manner
as __platform_get_irq_byname() uses fwnode_irq_get_byname() for IRQs:
the i-th string of "reg-names" names the i-th memory resource of the
device, counting memory resources only ("reg" order on DT, _CRS order
on ACPI).

No agreement between the length of "reg-names" and the number of
memory resources is required: an index past the last memory resource
makes platform_get_resource() return NULL, and the existing
named-resource walk is kept as a fallback, so DT behavior is
unchanged and a mis-sized "reg-names" simply yields "resource not
found" for the names it cannot resolve instead of a wrong mapping.

This allows drivers shared between Device Tree and ACPI, e.g. the
Bosch M_CAN controller driver whose DT binding requires "reg-names",
to use platform_get_resource_byname() and
devm_platform_ioremap_resource_byname() unchanged on PRP0001 devices.

Signed-off-by: Bowen Yu <yubowen8@huawei.com>
---
 .../firmware-guide/acpi/dsd/reg-names.rst          | 68 ++++++++++++++++++++++
 Documentation/firmware-guide/acpi/index.rst        |  1 +
 drivers/base/platform.c                            | 17 ++++++
 3 files changed, 86 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/dsd/reg-names.rst b/Documentation/firmware-guide/acpi/dsd/reg-names.rst
new file mode 100644
index 000000000000..76c6363b8d57
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/dsd/reg-names.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+_DSD "reg-names" property
+==========================
+
+"reg-names" is a Device Tree binding property that assigns names to the
+memory regions listed in "reg", allowing drivers to look up resources by
+name with platform_get_resource_byname().
+
+The kernel resolves the same property for platform devices regardless of
+the firmware interface: the i-th string of a "reg-names" string array
+names the i-th memory resource of the device, in "reg" order on Device
+Tree and in _CRS order on ACPI.  Only memory resources count toward
+the index; descriptors of other types in _CRS, e.g. interrupts, are
+skipped.  platform_get_resource_byname() and
+devm_platform_ioremap_resource_byname() consult the property when a
+named memory resource is requested, and fall back to the named-resource
+lookup, so drivers shared between Device Tree and ACPI work unchanged
+on both.
+
+For ACPI devices the property is provided in the Device Properties UUID
+package of _DSD.  This is the natural thing to do for devices described
+by a Device Tree binding, i.e. those enumerated through the PRP0001 DT
+namespace link: firmware following such a binding provides the binding's
+properties in _DSD.  Resources created from _CRS carry no names, so
+without the property by-name lookups fail on ACPI.
+
+Note that IRQ resources are handled analogously through
+fwnode_irq_get_byname() (see "Named Interrupts" in
+Documentation/firmware-guide/acpi/enumeration.rst).
+
+Example - a PRP0001 device for a Bosch M_CAN controller, following
+Documentation/devicetree/bindings/net/can/bosch,m_can.yaml::
+
+	Device (CAN0)
+	{
+		Name (_HID, "PRP0001")
+		Name (_DSD, Package () {
+			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+			Package () {
+				Package () { "compatible", "bosch,m_can" },
+				Package () { "reg-names", Package () {
+					"m_can", "message_ram"
+				} },
+			}
+		})
+		Method (_CRS, 0, Serialized)
+		{
+			Name (RBUF, ResourceTemplate ()
+			{
+				QWordMemory (ResourceConsumer, PosDecode,
+					     MinFixed, MaxFixed, NonCacheable,
+					     ReadWrite,
+					     0x0, 0xF0000000, 0xF0000FFF,
+					     0x0, 0x1000)
+				QWordMemory (ResourceConsumer, PosDecode,
+					     MinFixed, MaxFixed, NonCacheable,
+					     ReadWrite,
+					     0x0, 0xF0001000, 0xF0001FFF,
+					     0x0, 0x1000)
+			})
+			Return (RBUF)
+		}
+	}
+
+Here "m_can" names the first and "message_ram" the second MEM resource
+in _CRS.
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index db9eb7229948..a6db8f327b7f 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -13,6 +13,7 @@ ACPI Support
    dsd/leds
    dsd/motorcomm-yt8xxx-phy
    dsd/phy
+   dsd/reg-names
    enumeration
    osi
    method-tracing
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 66f9ec73d47e..e697316b33c2 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -457,6 +457,10 @@ EXPORT_SYMBOL_GPL(devm_platform_get_irqs_affinity);
  * @dev: platform device
  * @type: resource type
  * @name: resource name
+ *
+ * For memory resources, the name may also be resolved through the
+ * "reg-names" firmware device property, where the i-th string names the
+ * i-th memory resource of the device.
  */
 struct resource *platform_get_resource_byname(struct platform_device *dev,
 					      unsigned int type,
@@ -464,6 +468,19 @@ struct resource *platform_get_resource_byname(struct platform_device *dev,
 {
 	u32 i;
 
+	if (type == IORESOURCE_MEM) {
+		int index = device_property_match_string(&dev->dev,
+							 "reg-names", name);
+
+		if (index >= 0) {
+			struct resource *r = platform_get_resource(dev, type,
+								   index);
+
+			if (r)
+				return r;
+		}
+	}
+
 	for (i = 0; i < dev->num_resources; i++) {
 		struct resource *r = &dev->resource[i];
 

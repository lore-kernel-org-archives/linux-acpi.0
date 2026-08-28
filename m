Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585233E022C;
	Fri, 28 Aug 2026 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906621; cv=none; b=UNGcZfUKhRuxc9nEnphRG6uMfJ9BvOnBkwt/l0pURaw8DODZYDFv3CBRflqpM6m5Y9Sjf91kQrx3TJO/I8Ce+DOcPtfKnfxoNTLefAC6XhTjlIM94DY/xPS9SLsiQuB5DDiOC71ZW/dF4zAzR8lC3zeQacWJRCrlUoi91yhGIBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906621; c=relaxed/simple;
	bh=iug86VlGvn/dyd2+mCxn/G8qYraRPPe6XrCBLwaY6mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2ekE9b0zpLm5zLYk1kUBb/06b9PF+j/hL72iM5vpyvx1Hhl1piwSOdbRknHlTJS+FJkwV9p9DXJqGoCjiHyZ8JEzLhkdEyFEXIHob22z6jLceUpWr5sl+vraryX1gIXRrwYajgM7D/XHmIO+ZX5Td7+vXaMm0PCY0W8AyQIaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AP1cIzMd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AP1cIzMd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787906618; x=1819442618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iug86VlGvn/dyd2+mCxn/G8qYraRPPe6XrCBLwaY6mM=;
  b=AP1cIzMdlclCEAAezyhHM2ITA45zgRui/xVvC11GiD5ldLT6S47xOHDI
   NRu/YPyrF0vg9PlrGXd58XjZJubr6cB6y31rSo6e/FVRpRLSyUl+wWZgN
   WbpnHkwtHmPV9urE4nFWAEKxHqlYNFm1tv9QRdO3VwwpH+TD7vaJzCiAL
   cNfBThYorJbHm3icXghX0wxWdbXma2eoDSkDXohWmk6saoLv0cGtVs9YW
   idJGIo4jVenH6vQLbsESA0thoNANUE7QXXcEKJ9coWzCC5OSPz20Ema1I
   Ui482NkEUbNW79jb0tkCPQUuqLA8cafyFexwb6yKL5VdQb9jUMhPZPElI
   Q==;
X-CSE-ConnectionGUID: PcrLtoNTRXy3q2q9kQ4alQ==
X-CSE-MsgGUID: nJ4b5wH9QjyNgHAeM9myvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="75955876"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="75955876"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 01:43:34 -0700
X-CSE-ConnectionGUID: vdoZ8FpqQqq8V4ji8Sisew==
X-CSE-MsgGUID: K6AzssgDRvuC7GALEVFb1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="261952408"
Received: from rvuia-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.92])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 01:43:33 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id D9B9B11F817;
	Fri, 28 Aug 2026 11:43:28 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1wzsBM-0000000152p-3Dp2;
	Fri, 28 Aug 2026 11:43:28 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-media@vger.kernel.org
Cc: linux-acpi@vger.kernel.org,
	rafael@kernel.org
Subject: [PATCH 1/3] media: ipu-bridge: Drop redundant ACPI_PTR() usage
Date: Fri, 28 Aug 2026 11:43:26 +0300
Message-ID: <20260828084328.257703-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828084328.257703-1-sakari.ailus@linux.intel.com>
References: <20260828084328.257703-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ipu-bridge depends on CONFIG_ACPI, therefore ACPI_PTR(ptr) always
yields ptr. Drop all use of ACPI_PTR() in the ipu-bridge.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/pci/intel/ipu-bridge.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index f9efa501e8cf..cdd654efd1dd 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -17,7 +17,7 @@
 #include <media/ipu-bridge.h>
 #include <media/v4l2-fwnode.h>
 
-#define ADEV_DEV(adev) ACPI_PTR(&((adev)->dev))
+#define ADEV_DEV(adev) &(adev)->dev
 
 /*
  * 92335fcf-3203-4472-af93-7b4453ac29da
@@ -239,12 +239,12 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
 	for (i = 0; i < ARRAY_SIZE(ivsc_acpi_ids); i++) {
 		const struct acpi_device_id *acpi_id = &ivsc_acpi_ids[i];
 		struct acpi_device *consumer, *ivsc_adev;
-		acpi_handle handle = acpi_device_handle(ACPI_PTR(adev));
+		acpi_handle handle = acpi_device_handle(adev);
 
 		for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
 			/* camera sensor depends on IVSC in DSDT if exist */
 			for_each_acpi_consumer_dev(ivsc_adev, consumer)
-				if (ACPI_PTR(consumer->handle) == handle) {
+				if (consumer->handle == handle) {
 					acpi_dev_put(consumer);
 					return ivsc_adev;
 				}
@@ -322,8 +322,7 @@ static int ipu_bridge_read_acpi_buffer(struct acpi_device *adev, char *id,
 	acpi_status status;
 	int ret = 0;
 
-	status = acpi_evaluate_object(ACPI_PTR(adev->handle),
-				      id, NULL, &buffer);
+	status = acpi_evaluate_object(adev->handle, id, NULL, &buffer);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -379,7 +378,7 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
 	enum v4l2_fwnode_orientation orientation;
 	struct acpi_pld_info *pld = NULL;
 
-	if (!acpi_get_physical_device_location(ACPI_PTR(adev->handle), &pld)) {
+	if (!acpi_get_physical_device_location(adev->handle, &pld)) {
 		dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
 		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
 	}
@@ -785,7 +784,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 	int ret;
 
 	for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
-		if (!ACPI_PTR(adev->status.enabled))
+		if (!adev->status.enabled)
 			continue;
 
 		if (bridge->n_sensors >= IPU_MAX_PORTS) {
@@ -821,7 +820,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 			goto err_free_swnodes;
 		}
 
-		sensor->adev = ACPI_PTR(acpi_dev_get(adev));
+		sensor->adev = acpi_dev_get(adev);
 
 		primary = acpi_fwnode_handle(adev);
 		primary->secondary = fwnode;
@@ -881,7 +880,7 @@ static int ipu_bridge_ivsc_is_ready(void)
 			&ipu_supported_sensors[i];
 
 		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
-			if (!ACPI_PTR(sensor_adev->status.enabled))
+			if (!sensor_adev->status.enabled)
 				continue;
 
 			adev = ipu_bridge_get_ivsc_acpi_dev(sensor_adev);
-- 
2.47.3


Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29132C25B0E
	for <linux-acpi@archiver.kernel.org>; Tue, 16 Aug 2022 11:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiHPLJK (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 16 Aug 2022 07:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiHPLIk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Aug 2022 07:08:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752DBD398E;
        Tue, 16 Aug 2022 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660644997; x=1692180997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EtlYtiwteZxWDMzq7m+ATAtdiv2Skwb0e3zLFg2zc58=;
  b=bMo8Xr+kIfXW+5F6mupDnNVk8P8Wy2KWATOdiKWlvf9r+W+bgzwbtfeV
   SRDVfv62gmt8MiUPymnvvswcp+1B4eSnzLs4I26JbCrrLrP5n6/xM0k9O
   fIJyyXmwig+pWbsOdcqPsnvQDSQ2UHSQ08HdS9+01j22Je6XIv1YRCapT
   dtBZJlR7I9ilczx5aWzUcDzqOLAr9ZWPKSbC5ldAYwISi+7UAUGm5oAin
   3yJjVgjpHgAHcaODYTIh6Oc1Cppc9/dhF01AarbHDx/MM8fEUFSA0EV3J
   JbdKt484r6Lz475NFCgbLrKkgKbbRxaBazoSWYVBDeIVCirU1Jrd+9mNe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="279141302"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="279141302"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:16:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="749260795"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2022 03:16:31 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>, rajmohan.mani@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 6/6] usb: typec: intel_pmc_mux: Use the helper acpi_dev_get_memory_resources()
Date:   Tue, 16 Aug 2022 13:16:29 +0300
Message-Id: <20220816101629.69054-7-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816101629.69054-1-heikki.krogerus@linux.intel.com>
References: <20220816101629.69054-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It removes the need to check the resource data type
separately.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index a8e273fe204ab..e1f4df7238bf4 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -569,15 +569,6 @@ static int pmc_usb_register_port(struct pmc_usb *pmc, int index,
 	return ret;
 }
 
-static int is_memory(struct acpi_resource *res, void *data)
-{
-	struct resource_win win = {};
-	struct resource *r = &win.res;
-
-	return !(acpi_dev_resource_memory(res, r) ||
-		 acpi_dev_resource_address_space(res, &win));
-}
-
 /* IOM ACPI IDs and IOM_PORT_STATUS_OFFSET */
 static const struct acpi_device_id iom_acpi_ids[] = {
 	/* TigerLake */
@@ -611,7 +602,7 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
 		return -ENODEV;
 
 	INIT_LIST_HEAD(&resource_list);
-	ret = acpi_dev_get_resources(adev, &resource_list, is_memory, NULL);
+	ret = acpi_dev_get_memory_resources(adev, &resource_list);
 	if (ret < 0)
 		return ret;
 
-- 
2.35.1


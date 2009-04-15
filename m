From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/2]: the patch set to weaken the dependency between ACPI video driver and i915 driver
Date: Wed, 15 Apr 2009 21:56:56 +0100
Message-ID: <20090415205656.GA32509@srcf.ucam.org>
References: <1239678275.5564.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52468 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253AbZDOU5D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Apr 2009 16:57:03 -0400
Content-Disposition: inline
In-Reply-To: <1239678275.5564.66.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

How about we just replace these with the following?

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 3a22eb9..cf7e7c2 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -71,6 +71,7 @@ config DRM_I915
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB
+	select ACPI_VIDEO if ACPI
 	tristate "i915 driver"
 	help
 	  Choose this option if you have a system that has Intel 830M, 845G,

-- 
Matthew Garrett | mjg59@srcf.ucam.org

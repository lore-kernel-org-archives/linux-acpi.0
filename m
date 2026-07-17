Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7A7430782;
	Fri, 17 Jul 2026 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299970; cv=none; b=AiOWGQt1e+B3whLcMbB5hnxYqedhk3IzeYksQbXURR5I0p6dU94egXuOXCgC2K5cxXSe4TGObJMbKiVDnl651y2szPw60BJhUe1MZcvv1K4bTkdUt2g7c5fUwgNsnVz0cIGqM5ET++9MF9+u3C0TP67G/iWvwFy0si4duWWhG4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299970; c=relaxed/simple;
	bh=OxO9YZox2xY0l28T0lDdPXsGzGq0KBOie7DqqCOQF6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qI/WRW4kREF9qz3Wee3Iz7GGGaLHf1sFBgBT6Ysiy6Wb7jL1mOQapJn3ilGALDDrPPG53Si4q+7UaVPj+RVC4KP8deLBY78iAvaLpOFjNeHZLX/3uE0kBaHL13KS5Wpmw4X1OS0wGt2nElvyREkKY1XIA44Su9quFK1mgKPpGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XfjsmQV3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XfjsmQV3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 70BC71A1066;
	Fri, 17 Jul 2026 14:52:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 42CCB60361;
	Fri, 17 Jul 2026 14:52:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6617811BD0B36;
	Fri, 17 Jul 2026 16:52:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784299959; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=gs9+7I6YeUyBpDrzpUbMlNZVb5dXGmT+tHx+sTG/svY=;
	b=XfjsmQV3OGSQsSlhVz1KQ9GTAWwkFIICk+IbvxWLGWhjL32Enhldu+/Zysl2vT5fcL6tRw
	vmYp4hv0lD+scA2JMwDm7pLUwlbw9am3EF5YVLBesX8JA9R0wA/W/H/bfy86cpw34MAgNp
	zyRdy6ThJoJNXDFpjFLupivW9vh4+P+MCCAPoIzroarXan305FQbSaAsarx5ykFrDQgAW8
	Lm0BSWX0WiVpCo6TXsVvDwwDJBy3mgJ7H+NWSj2OzqqqVYwHQrB/BoxJyKveyY1NOM9ALR
	8uiUDsSD5FQWj7Mvq8GwGEo/iFEVRlwP+/EAhtW5sTDzFF31/8eV/aeAMH7+Kg==
From: Herve Codina <herve.codina@bootlin.com>
To: Richard Cheng <icheng@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Herve Codina <herve.codina@bootlin.com>
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v10 05/10] cxl/test: Use fw_devlink_set_device()
Date: Fri, 17 Jul 2026 16:51:40 +0200
Message-ID: <20260717145147.823749-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717145147.823749-1-herve.codina@bootlin.com>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The code set directly fwnode.dev field.

Use the dedicated fw_devlink_set_device() helper to perform this
operation.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 tools/testing/cxl/test/cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 69da0727362b..95e39dfc6ec9 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1529,7 +1529,7 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
 	device_initialize(&adev->dev);
 	fwnode_init(&adev->fwnode, NULL);
 	device_set_node(dev, &adev->fwnode);
-	adev->fwnode.dev = dev;
+	fw_devlink_set_device(&adev->fwnode, dev);
 }
 
 #ifndef SZ_64G
-- 
2.55.0


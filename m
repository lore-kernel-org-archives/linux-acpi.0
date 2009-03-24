From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH 2/5] sony-laptop: Enable EC on newer hardware
Date: Tue, 24 Mar 2009 00:48:17 +0000
Message-ID: <20090324004817.GB2252@srcf.ucam.org>
References: <20090324004741.GA2252@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49640 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbZCXAsY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 20:48:24 -0400
Content-Disposition: inline
In-Reply-To: <20090324004741.GA2252@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Norbert Preining <preining@logic.at>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

The latest Vaios can execute certain codepaths in two ways - either using
system management mode or using pure ACPI methods. The latter is only used
if the OS has called the ECON method. Ensure that this is done where the
method is available.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/platform/x86/sony-laptop.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index ebe7ea6..130f81a 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -947,6 +947,12 @@ static int sony_nc_resume(struct acpi_device *device)
 		}
 	}
 
+	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "ECON",
+					 &handle))) {
+		if (acpi_callsetfunc(sony_nc_acpi_handle, "ECON", 1, NULL))
+			dprintk("ECON Method failed\n");
+	}
+
 	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "SN00",
 					 &handle))) {
 		dprintk("Doing SNC setup\n");
@@ -1004,6 +1010,12 @@ static int sony_nc_add(struct acpi_device *device)
 			dprintk("_INI Method failed\n");
 	}
 
+	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "ECON",
+					 &handle))) {
+		if (acpi_callsetfunc(sony_nc_acpi_handle, "ECON", 1, NULL))
+			dprintk("ECON Method failed\n");
+	}
+
 	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "SN00",
 					 &handle))) {
 		dprintk("Doing SNC setup\n");
-- 
Matthew Garrett | mjg59@srcf.ucam.org

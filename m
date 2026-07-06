Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC143E3D8B;
	Mon,  6 Jul 2026 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341744; cv=none; b=ATDMS+EHmqoBZKopEs44IbWW5oQhboO9bSftXbiZKRlB+CvqossHXgcu4EwRu8JIy2pNXwsCTJ1yR/I8ZUKgoZBG+CipFPKMpoHeCymZcK98A2ixv/lbPYfQ4LNq8LyFcuQ7VH45yEG13+0i/pxaNrmJYoaWTSkqcwpT+xd14jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341744; c=relaxed/simple;
	bh=bCUO5iQ5J7Bqlqp09cX6fz4HI39XW06lYR9snsDRv+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mxf9bjECx/yUbj+mTgDfrxl8QyC8In0v7++VknNqMSQdsZnIwJBBKDxAKNuPtCuRVMPgXFSgaNLllbTszy67fGh0r/0Wd3DU85onQ5/dE8feK3h11gKx33xrinHKmlar9A7we4OCVOM3NP/uSACYGPyy/giuvjx3SKSwI5vgiG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP5ZBq5P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP5ZBq5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AA41F000E9;
	Mon,  6 Jul 2026 12:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783341743;
	bh=eNsH6h/MKtICpYhQVo4wxSZ5WBAnlaWZx2U4C1glMhI=;
	h=From:To:Cc:Subject:Date;
	b=kP5ZBq5PW3ueAtkhO7QPJ8lPNatVX4OmOi7DIWjqL83CxlrbW+BATiyueFcP9fGrv
	 vGJVn9DmM4/YvoYWlVBpdlPf8gsyWu2qMRAEEfX5jFXGMM9sLKPxclbjNsSMW8gAtR
	 ZnDJh4V6wNT+mV2qqpETtqLpAcj46uUwQHaWNPKSL7PfDtrKE3kRGd5hhxfcIfKWP7
	 N+63rVcLXauU+xqyuINzZMWT8MZyCfWLVByd4ZrhuuiiK+Z2MAJP0DBmCvNirvxxFA
	 kBU40xyKhvuPJb7CU+JtabAdOYO2lFwp/6/1H5iRKZ6w2IU1UYOZGEufQXwPZfjaQK
	 cTvms5Cy7Yujw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ACPI: PAD: xen: Stop setting acpi_device_name/class()
Date: Mon, 06 Jul 2026 14:42:20 +0200
Message-ID: <2384190.iZASKD2KPV@rafael.j.wysocki>
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

The driver sets acpi_device_name() and acpi_device_class() which are
never read afterward, so make it stop doing that and drop the symbols
defined specifically for this purpose.

No intentional functional impact.

This will facilitate the removal of device_name and device_class from
struct acpi_device_pnp in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/xen/xen-acpi-pad.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/xen/xen-acpi-pad.c b/drivers/xen/xen-acpi-pad.c
index 5b98e0e93807..2fa9c7d3581f 100644
--- a/drivers/xen/xen-acpi-pad.c
+++ b/drivers/xen/xen-acpi-pad.c
@@ -17,8 +17,6 @@
 #include <xen/xen-ops.h>
 #include <asm/xen/hypercall.h>
 
-#define ACPI_PROCESSOR_AGGREGATOR_CLASS	"acpi_pad"
-#define ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME "Processor Aggregator"
 #define ACPI_PROCESSOR_AGGREGATOR_NOTIFY 0x80
 static DEFINE_MUTEX(xen_cpu_lock);
 
@@ -117,9 +115,6 @@ static int acpi_pad_probe(struct platform_device *pdev)
 	if (!device)
 		return -ENODEV;
 
-	strcpy(acpi_device_name(device), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_PROCESSOR_AGGREGATOR_CLASS);
-
 	status = acpi_install_notify_handler(device->handle,
 		ACPI_DEVICE_NOTIFY, acpi_pad_notify, device);
 	if (ACPI_FAILURE(status))
-- 
2.51.0





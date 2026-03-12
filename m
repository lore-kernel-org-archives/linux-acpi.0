Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47739D6D6;
	Thu, 12 Mar 2026 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314103; cv=none; b=EQKkQDZEQwq0U31tPEq+DtAuCObKJ/cLbDOubg1h7psvwdjXs9crWU1z1uja5pz/w1Tksv8lxTS34T3Szb/lQg5mZOyqZKC+SqghxvyaP+6rS8oWDDPIONKL2zJIfQpiOIJa3DoPFG8xf0rhBXRZQsRZGyaBof6XmGmuTDtDXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314103; c=relaxed/simple;
	bh=0ocFQGzupR1Pt72yrHYv8EadpqNhrGEJprW3yrA5z7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITfIdJL9Rf6ofyoYG9ef5aebODsGDux2TbT5m/TuijGzPODxlcdRnfIgt4yGc2rje3sWlGBThMViRX7cU3z3O+Ub9TP3158S3bP+fLJomQJoHzR9SY5ABsuZYJupBTuCYJxmuq8lVektEcJNYhLd0gZB/SnIELy5eZBKxitC5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHDW8U7x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHDW8U7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C06DC4CEF7;
	Thu, 12 Mar 2026 11:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773314102;
	bh=0ocFQGzupR1Pt72yrHYv8EadpqNhrGEJprW3yrA5z7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iHDW8U7xf22C97c0hZms/YITkFs57bhXK1QxYRMWG91+ClBtNdCyMQ008cB5pdCVO
	 pZ5gLUfOVO+lNm6vMtxj8QwMLGzBBoSckMEkra1LaEMJ+AZuYU4yvxBxJw0XJ3PrD2
	 sfzCgvRZVmSheRsEZck5k5W5fWmGgULFwYnHqeXrAuncB70cZ1tE0ZcFFPC2OsOwHh
	 LIiXC2LJFoNEt6GzELLCkx9M6vVQERvuvSeNPiddmFpYcPMPB0mcO+qL4WnpGcQIcH
	 YOkjTukmwmFjO0+FF5fcwvV/G7Hbv264fSrL0wYQsw9IJyYiZvPYtMDT5whQRE1Kjw
	 zSml/N7WtDvnw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Matan Ziv-Av <matan@svgalib.org>
Subject:
 [PATCH v1 1/2] platform/x86: lg-laptop: Drop debug-only ACPI notify handler
Date: Thu, 12 Mar 2026 12:14:03 +0100
Message-ID: <3346280.5fSG56mABF@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3698311.iIbC2pHGDl@rafael.j.wysocki>
References: <3698311.iIbC2pHGDl@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to using struct
platform_driver instead of struct acpi_driver, drop the debug-only
notify handler method from the driver.

No intentional functional impact beyond debug.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/lg-laptop.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 61ef7a218a80..7122d96abf86 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -271,11 +271,6 @@ static void wmi_input_setup(void)
 	}
 }
 
-static void acpi_notify(struct acpi_device *device, u32 event)
-{
-	acpi_handle_debug(device->handle, "notify: %d\n", event);
-}
-
 static ssize_t fan_mode_store(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buffer, size_t count)
@@ -906,7 +901,6 @@ static struct acpi_driver acpi_driver = {
 	.ops = {
 		.add = acpi_add,
 		.remove = acpi_remove,
-		.notify = acpi_notify,
 		},
 };
 
-- 
2.51.0





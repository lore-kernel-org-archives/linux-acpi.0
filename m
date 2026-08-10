Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508D23C1F4B;
	Mon, 10 Aug 2026 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362038; cv=none; b=DS0hZeNu7KAUuwjm08v+Ruv2EoZsv51ir/11wa5Xdo0i8LfjJ9d0nT/gxwMK48v5kmdMxTKVuxbUTekeboN8m62hgUE5TfX5n2eujH73558NJnq8j2vH8LDzyFGE5dwttlP5JzTnCnPRlGTBk2JWrNo41E244YiPoICF0wqFi6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362038; c=relaxed/simple;
	bh=NMSDwi3wtBvS0TVgOZFlD0+odwRoN1wXtjnCXwYHwhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKq/3eYywZYsoYxDsvHo70nUsIIhSzAmi4KwsHfi8hUKP/WHhTWsnxpZPZQbR8zXqRSnyHIIcC5a9xmXyr5ouQE+YzUxxwic6LhCmOEwkReog2tZr7sHn6HOkhgSp356V04fGvvN16VuMzOfszGe9XODp1F0bTjkMevvbmKr6xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k293Y4bQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k293Y4bQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650BF1F000E9;
	Mon, 10 Aug 2026 11:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786362036;
	bh=PfEweG1BRuQH+PzHoCVKBSGMSkZyS8sDXG4iRu+oc6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k293Y4bQBrLA2Lv0NoKazUGjnIRvzIv8orLpeIQlIs2QvT78ZZAIl1/aV1f7U+m9c
	 Thc5z1a4LbqHdiELgpnJfVM9Wb49FeYBnJYqjt6KEtKRK/9CF7t6Tzld4eMU7v+dBl
	 CV//yzsLScVtxSCduWjRcIX6mlcibE0cuuYzGAYJCZH7+OMWAY0Xq39jH5vIeCRGj1
	 8KZQI+yZLoNLoPKUGC1GlA9O7SMW2v18YxOzV7nD1bGXSfdSuwOvcMZSIr8BTwAcEW
	 w3OeEccIaDzulQ16rrYrMcigiJYGQynkXkPMo05HZG8/r1ImAUYTuu1DnsdW2JFvgi
	 Ocvdal0GGM9fg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 2/3] ACPI: platform: Use acpi_bus_get_primary_device()
Date: Mon, 10 Aug 2026 13:38:08 +0200
Message-ID: <3436112.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <4764923.LvFx2qVVIh@rafael.j.wysocki>
References: <4764923.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The acpi_get_first_physical_node() usage in acpi_platform_fill_resource()
and acpi_create_platform_device() is generally unsafe because in theory
the device returned by it may be freed at any time [1].

It is also inefficient because acpi_get_first_physical_node() is called
multiple times for the same argument which can be avoided.

Address these issues by using acpi_bus_get_primary_device() instead of
acpi_get_first_physical_node() and adjusting the code to call it just
once at the beginning of and acpi_create_platform_device() and drop
the device reference acquired by it upon the return from that function.

Fixes: 3b95bd160547 ("ACPI: introduce a function to find the first physical device")
Fixes: a252d881c558 ("ACPI / platform: Pay attention to parent device's resources")
Link: https://sashiko.dev/#/patchset/12955541.O9o76ZdvQC%40rafael.j.wysocki [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_platform.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -102,18 +102,15 @@ static unsigned int acpi_platform_adjust
 	return count;
 }
 
-static void acpi_platform_fill_resource(struct acpi_device *adev,
-	const struct resource *src, struct resource *dest)
+static void acpi_platform_fill_resource(struct device *parent,
+					const struct resource *src,
+					struct resource *dest)
 {
-	struct device *parent;
-
 	*dest = *src;
-
 	/*
 	 * If the device has parent we need to take its resources into
 	 * account as well because this device might consume part of those.
 	 */
-	parent = acpi_get_first_physical_node(acpi_dev_parent(adev));
 	if (parent && dev_is_pci(parent))
 		dest->parent = pci_find_resource(to_pci_dev(parent), dest);
 }
@@ -141,7 +138,8 @@ static unsigned int acpi_platform_resour
 struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 						    const struct property_entry *properties)
 {
-	struct acpi_device *parent = acpi_dev_parent(adev);
+	struct acpi_device *p = acpi_dev_parent(adev);
+	struct device *parent __free(put_device) = acpi_bus_get_primary_device(p);
 	struct platform_device *pdev = NULL;
 	struct platform_device_info pdevinfo;
 	const struct acpi_device_id *match;
@@ -187,7 +185,7 @@ struct platform_device *acpi_create_plat
 								       rentry->res,
 								       resources,
 								       count);
-				acpi_platform_fill_resource(adev, rentry->res,
+				acpi_platform_fill_resource(parent, rentry->res,
 							    &resources[count++]);
 			}
 			acpi_dev_free_resource_list(&resource_list);
@@ -200,7 +198,7 @@ struct platform_device *acpi_create_plat
 	 * attached to it, that physical device should be the parent of the
 	 * platform device we are about to create.
 	 */
-	pdevinfo.parent = parent ? acpi_get_first_physical_node(parent) : NULL;
+	pdevinfo.parent = parent;
 	pdevinfo.name = dev_name(&adev->dev);
 	pdevinfo.id = PLATFORM_DEVID_NONE;
 	pdevinfo.res = resources;




Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA4201278;
	Thu, 11 Jun 2026 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196049; cv=none; b=eEJfHg0K7Hga96imZgwM5eQCdRA7ex5/79LfVTfJCeoKhj1km5zPWIr6m+cWl8gSKpIDEaNVCpj4kj18Qj4umulAmCQ+KO/BsG5eGWoVxUplVIXpT0PfHzYaAWJkCujtn0NtVVkheS1WXr1plH9QqUBS7jxGiOmn9LXLpsfvx0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196049; c=relaxed/simple;
	bh=ZVCyuT+4i4Q5+f/DyUNAbzmxgr8v+Ww0vy2hgQbrZiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g+q2iW1mqBbSsRmEvy4QfnO0H/JBvUJVFn9vHVRvgHiyUTLFqbcKJn6mzd6MYYOvFJYt57NJAtM+kmUHGXRVYPcAuc0yKOvVlHvGMhHXfFoP7hnpiQD+dczhKo5OvkeDrfPquyGLof/FvzQlrEnQJ/BxGituHbTwEkDU/9MZOuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lht.dlh.de; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lht.dlh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from albans-vm.. (unknown [213.61.137.106])
	(Authenticated sender: albeu@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id D5367780395;
	Thu, 11 Jun 2026 18:40:28 +0200 (CEST)
From: Alban Bedel <alban.bedel@lht.dlh.de>
To: driver-core@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org,
	Alban Bedel <alban.bedel@lht.dlh.de>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] software node: Fix software_node_get_reference_args() with index -1
Date: Thu, 11 Jun 2026 18:40:05 +0200
Message-Id: <20260611164005.2930205-1-alban.bedel@lht.dlh.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bounds check for the index passed to
software_node_get_reference_args() was failing when passed UINT_MAX,
this in turn would lead to an out of bound access in the property
array. Fix the bound check to also cover the UINT_MAX case.

Fixes: 31e4e12e0e960 ("software node: Correct a OOB check in software_node_get_reference_args()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-devicetree/20260611103904.7CB131F00893@smtp.kernel.org/
Signed-off-by: Alban Bedel <alban.bedel@lht.dlh.de>
---
 drivers/base/swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index a19f8f722bc8e..e76f7c36f19e6 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -529,7 +529,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	if (prop->is_inline)
 		return -EINVAL;
 
-	if ((index + 1) * sizeof(*ref) > prop->length)
+	if (index >= prop->length / sizeof(*ref))
 		return -ENOENT;
 
 	ref_array = prop->pointer;
-- 
2.39.5


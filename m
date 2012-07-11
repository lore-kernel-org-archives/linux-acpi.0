From: Wen Congyang <wency@cn.fujitsu.com>
Subject: [PATCH 3/7 v2] remove memory info from list before freeing it
Date: Wed, 11 Jul 2012 15:48:21 +0800
Message-ID: <4FFD2FC5.2090701@cn.fujitsu.com>
References: <4FFD2F1E.10006@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:53046 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756540Ab2GKHnv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Jul 2012 03:43:51 -0400
In-Reply-To: <4FFD2F1E.10006@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

We free info, but we forget to remove it from the list. It will cause
unexpected problem when we access the list next time.

Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
---
 drivers/acpi/acpi_memhotplug.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 260a9c4..1f6196a 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -328,6 +328,7 @@ static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
 			if (result)
 				return result;
 		}
+		list_del(&info->list);
 		kfree(info);
 	}
 
-- 
1.7.1


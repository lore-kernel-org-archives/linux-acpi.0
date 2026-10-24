Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792839447;
	b=rk6dj7+MaEMQwuzhyIRUPHFPjXbqIYPIt9uWf01V2nHW4gii/4eoJYWKeS/M4n6TRjV0
	 ChhhD/5K3uyRLUtDoJXqA8hpbCmDAWktY5eFtA9UDo69RC5Ztww3QcxGE+cU1XuAaWD1V
	 4LzX8ZdZvsny0wo+/+BRnBh96Aj8V/y70P3eiMWWvZQNgQQKpXu1ZD/ECDVz7UUfvjg//
	 K5mJ0aNE1zKQGdTp0L6bH9+WNdjgXl3L6FCTWiIiTtJWLqY2OPYYSKx+CSUn8+vcfY/g1
	 o/kSCE0f+xqb1IOkqZ3JX8hZNWQmilfxDA6x7M+RYcB6jjJe7VoG8H9oHwj7JGxsdAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792839447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7CvZjphlLYyviRYRDAzTkF165UvtFroVZsLD8Snn5uo=;
	b=dmk+gvAHqpYATUDBnka3XHZ5hMEJFIkueFZx+OCo183A6YDpt3lTH6CyyCqJ5JYgzgrz
	 epzXHwPqKV12WzcDod0KpOgo7JmEfGvdFRvx+vQHP90XVTG7nWIcsj5m2ZaSrbWfTkfjz
	 5gER0tkk1VM7dDi6dXs9DULIPPyGK+FJt74TUvqjHqREYpouogi3WajGn08bLf3y4l06A
	 VgpWHRFYq+PzI4swjJ0QOqm7m8jJKw8SP3EjOFntAb8jh9LhzPi4pG24+Lp113TnHAjb7
	 GolcaMX7ufMyIuPgW1yPceAq/rd7wXdM5xj/UPWASpusEWnWTdOFWMXD8woNv74Jx5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iAqxQnp3;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350FB606A31B
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 10:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 350FB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iAqxQnp3
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso933827a91.3
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 03:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792839447; x=1793444247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7CvZjphlLYyviRYRDAzTkF165UvtFroVZsLD8Snn5uo=;
        b=iAqxQnp3AQBKM1cGnvIzCGVwNnsmGET6EuG8ExmkDqmq47YbAMrsWNY16I6KlZ6jw+
         iQ6C14TlApJAsDeoBOFfsG1FoHW6/esAZcLJX9dd+YQ8o8MaYpDbJ4jukHj34vyJV6+y
         gcdwJe3yDze+D1oKSVgvPya23KgVj3VlfbLd1VTAoaLbV8jhDYsRPdxSqsc8WdMEVowq
         ve4Gxa1QP50MChxu/m1KIhADJ4Xi/BFK80Z3AKv453nDFkd+paU3X3CzYx+MW4+0kyIv
         KtE2xV+SCSimCpOB4Y1GR7LVOYyCyMLjUQNwWZwvceoriVPAC8KYBv9+tEyvRe10h81u
         9eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792839447; x=1793444247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7CvZjphlLYyviRYRDAzTkF165UvtFroVZsLD8Snn5uo=;
        b=xcUZbaRSigt+7Yby8Dt3oUNTBInqihszHLxFLFMcVgdl0tmcWLPj+pu2oQn9xQZLjS
         fXbzXbbppWGAsrSOtcxJwhTOv5QTGPOji/ZmX9umPvdgdWBKWFCTDDr01qMYz8wELNWA
         +NFtDpz8TYwIMRwKd+PffFiGBsbWi/fgcfbaxS+lfyrWlilMEoEA3YgAyNQ5/dq/YTeB
         92HRcsUyRtRhWIdNHIcU0i1fQhTYo/zLMw7hadX0wXxPApcJ8s+19SnO6Vxb5fKEKAPA
         TqClUIHPi1bCXEHZRcFWdmIPF7F+T4ydulktMb+J5OqJH4vRw0ueFZ/0wLEL9KGJVwdP
         PZjA==
X-Forwarded-Encrypted: i=1; AKwUvBzwUO6yuWcadU5afxKvmSZdMFQ8CgjqX0xVW02MxUSmEv6uJmukAoxBvPXQpu6XD5CUiHTzHqpAzZ0z@vger.kernel.org
X-Gm-Message-State: AFq9FYIJAMJKw+0+eOABIWOyZ9mupxPY/0mxN/fFSRp8C/t00tEjg1aE
	fAeLtsOuCqtv6DA5bJvRB2a+qQrSp/0Ym5gG0NQGkCX5CXUj9/EWg+WT
X-Gm-Gg: AYBFou07j34F2v5iwCXXqYT49keCn7vy2ZypNFt0sFjs1RTIdUCh1X50of+xT00jeqr
	vYc9lgl/KXi2ws3oIwEbSSZXlF4e87Gx949M8tMuBNLMm4i4WkaDFgb5eo4Oxmcf2SCQWyhqiyU
	jtVW+zyFvI7NyYiQQkctvX+9+796tUtSR+WZf3aZsmKz/6zE75HslLnTDu7iHdoiHDA1mTtx6XE
	QYaPJqcULluPOyzRNwdGK9OT1dZbQmqBmuFQJeoTRS7kxty+ueq/rNDpQBk3O+ANbrvXV+mDKkc
	NQoIQ+3oL55w1aEl9r4hEdPJv2JXoEaJOhOv4O9AZi0vHxQ7B86n6W+Fsv+K53xGsjIRBECVgl+
	nSAcw38Gq+Op8bS7Hoye+FYnzfk6H3xOq2j6bqS8JqZaWWJgROUt0V9d2v2cb26cmrst3ADyIxh
	s3pOEokDJ5IBnsizmLYtY42aE8d3EEocVty96guoM3QIPvODzyayC2FRfOlYUPbnP7ADvzvYi6m
	kHX7Ee4atMMN1tHN1RiwWXrYD5JtfVQOXyL5L8Qefy94KJ0tz88V0m8pmN/TxKfbZPSmvAvlv4P
	aNTaTGQumiE3KL+2d/fu8+Deg0D3+x9UbDultmpX3ckSnyhlpc2ZGRzqcXdSpwN4Mr3IYBMbTN/
	jUdUsz+uZvsutY/AuwRBQJCMZYGlRXxtugrlnSJMCQyNfTpLL4JdCULJhZs7kX15MAWsBZzvnp9
	a6AKvVcT20eBlngxyFccOYu6IMOo1R/xfb5xrwAe/UfCQzLMBg2jYD/rxG
X-Received: by 2002:a17:90b:4ad0:b0:3ab:d26b:c2e9 with SMTP id 98e67ed59e1d1-3adead26b38mr1613976a91.33.1792839446604;
        Sat, 24 Oct 2026 03:57:26 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe6946dsm2565666a91.4.2026.10.24.03.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:57:26 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Frederic MARIE-JOSEPH <fredericmariejoseph@protonmail.com>,
	Wolfgang Walter <linux@stwm.de>,
	Bob Anderson <kernel@ametros.net>,
	Domenico Suppa <domenicosuppa@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org,
	regressions@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Julien <julien82453@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 6.18.y 2/3] ACPI: scan: Avoid registering platform devices with resource overlaps
Date: Sat, 24 Oct 2026 18:57:09 +0800
Message-ID: <20261024105710.593-3-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024105710.593-1-ue081723@gmail.com>
References: <2026102308-twisting-bazooka-12b5@gregkh>
 <20261024105710.593-1-ue081723@gmail.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

commit f234fdaae1cad8c39265e7ca0a14633076ec7154 upstream.

If acpi_dev_get_resources() returns overlapping I/O or memory resources,
the subsequent registration of a platform device will fail with -EBUSY
due to a resource conflict.  This is reported to happen on Acer Aspire
ES1-572 [1].

Avoid that by adjusting resources returned by acpi_dev_get_resources()
to eliminate partial overlaps between them.

This has not been regarded as necessary before because putting
overlapping resources into the _CRS of one device is really pointless,
but now that the issue has been reported to actually happen in the
field, it needs to be done.

Fixes: ab06eb920401 ("ACPI: scan: Register platform devices for fixed event buttons")
Fixes: 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platform one")
Reported-by: Julien <julien82453@gmail.com>
Tested-by: Julien <julien82453@gmail.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Closes: https://lore.kernel.org/linux-integrity/CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com/ [1]
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ rjw: Tweaked the new message ]
Link: https://patch.msgid.link/12955541.O9o76ZdvQC@rafael.j.wysocki
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
 drivers/acpi/acpi_platform.c | 39 ++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 52c8d602f..abdd8893e 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -12,6 +12,7 @@
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
@@ -71,6 +72,36 @@ static struct notifier_block acpi_platform_notifier = {
 	.notifier_call = acpi_platform_device_remove_notify,
 };
 
+static unsigned int acpi_platform_adjust_resources(struct acpi_device *adev,
+						   struct resource *new_res,
+						   struct resource *resources,
+						   unsigned int count)
+{
+	unsigned int i;
+
+	if (!(new_res->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+		return count;
+
+	for (i = 0; i < count; ) {
+		struct resource *res = &resources[i];
+
+		if (resource_type(new_res) != resource_type(res) ||
+		    !resource_union(new_res, res, new_res)) {
+			i++;
+			continue;
+		}
+
+		dev_info(&adev->dev, "%pR expanded due to overlap\n", new_res);
+		/*
+		 * Eliminate the previously processed resource that overlapped
+		 * with the new one because it is not necessary any more.
+		 */
+		memmove(res, res + 1, (--count - i) * sizeof(*res));
+	}
+
+	return count;
+}
+
 static void acpi_platform_fill_resource(struct acpi_device *adev,
 	const struct resource *src, struct resource *dest)
 {
@@ -151,10 +182,14 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 				return ERR_PTR(-ENOMEM);
 			}
 			count = 0;
-			list_for_each_entry(rentry, &resource_list, node)
+			list_for_each_entry(rentry, &resource_list, node) {
+				count = acpi_platform_adjust_resources(adev,
+								       rentry->res,
+								       resources,
+								       count);
 				acpi_platform_fill_resource(adev, rentry->res,
 							    &resources[count++]);
-
+			}
 			acpi_dev_free_resource_list(&resource_list);
 		}
 	}
-- 
2.53.0


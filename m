Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C861E3659E7
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312805; cv=none; b=OjqXuLqx6Z12Ck2IXnm8WDio5Xov0rkhyg3yORD8NasV6Mrcu8VzQmxjBLxTVcDBZb9L1IUu3Fr9J/T6oTLrFIgCOlK/nFjMRLt0O++I1Qy69S+piNku9dC62+S0saYSbz7IqpXMqGsghr33PWZKMb13tmuOuxPuCh0GBHQ1j38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312805; c=relaxed/simple;
	bh=Grx/pH7Whoel/08IPXs9sl4RENgf6azDLpfb9doS5b4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r4AQ0y3LrrHvMoibb+AW6IH9V0VMOVpOLLgNKQwFum29yrjONB0Jh0V2SWD26MdBbBcjMHAgdDkqjJ3OMiCOPtqkBbwb8a/9/9Gs1t1lflnH7HYVyElYxEDE5LPbsQ1jUKWGJe6+2mPEwIKl5DFuAKu8rhVzqfWgQle6LkZhQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QI1ypQya; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI1ypQya"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1279eced0b9so4821531c88.0
        for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 17:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774312803; x=1774917603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwlsItIufp55QkDByiWcscZ/zHchruIpUll+4+d6xMc=;
        b=QI1ypQyarsk/ooLHaFiBqaEXPdc4AY75LLLYDpDQDiFdx4tEWz7n8Vb0GajE5ChrPB
         FOmgKIL+NXDwYr+nYurFSYIJbvy9iycimXlRJUob7PDmoaShN72t697Phh8dO6QBcGet
         jr4CMbK+BnzEMeOYNZAcTxG/6NkJfLSRVrDfHfMKOxWVX/Cn4T5oiPu3QtUXse72h9xj
         AHBSNsTRdmZvUW+MTo7hTh6bTlRLkSReMNr76vTXmtz0G455h6wV2JqoemNabee/WDYg
         us+LgrIehfcSBsaggyoFcm9tFVbM5CNXMWJ+FFtiBZ8l3651HXtTkfNUILODqsHjMhYl
         HjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774312803; x=1774917603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hwlsItIufp55QkDByiWcscZ/zHchruIpUll+4+d6xMc=;
        b=blXdJY9jWdDLUhj42IR76pnKqWpGmf3xVnIMiIvW3W3NZMHGWrZvWocR8xEFfcEtyL
         xMckiYs5ulcJQ0OJOuRhkovsXa4Hk9mflGCPdN1WeLB+9o8hj8gbPRvc7RTaP2RPZfBC
         j69vAQz4t0BHNVFPtyZIdDMsAFdESNpDJJglgpZgZtZDeWeGp97RHqrALF0tmYgjdSL6
         ydfjzu6SibKy8DDzO17nAg3ZYnRsh8+Ovh4KThir98yyRSHJGgBALWHHo2wMyI1c/Lui
         aoMQqGuQTz2v+5i/aAZpe7SYHpVC0+cJ6ugoCTzDc7nrm85Xh+RZS0Wqv9gCWubgH7NT
         8t7A==
X-Forwarded-Encrypted: i=1; AJvYcCV34ZrIBQMvyGhHhm0R4qE4qdWB8xtFJqmKKIELyGoQw3mH05yjqHINI80JFHf2zM3nHece5J8XVQuV@vger.kernel.org
X-Gm-Message-State: AOJu0YyshN8mZGYIltweFNvHR66au7T17C7BFZuZMYKhbS3V79EFNYH1
	6IpinQP68EQdfCPI6tvRm7RPtm+g5hMHzI01CC2YEQp5O6K5VlbtX3N2
X-Gm-Gg: ATEYQzzh9dZgUOpta7W10Isx4TE07MTwLuRpm03wosYUwes8B0nFVLhLQjxYJ+0evYj
	htzJWvu9g/zGVrYG/+3iP5Sl3s9ntCIK/XUlU1c/vrtYGAbwZukhmQqIoOlJUGnXHtJheNL0U3c
	U537Up9wbAc+sJRsTFhoYEWIdq+MIXnxV1iPAuTZdGOjPbs05u2TZFS24TF/slvWC8YGOL1oGiF
	E+LtzAt4YF2/Lgcn0zhLbVSXaYLkwj+1TdSC+6YpZGo+++hAxrSeDxOKWDmNSgHMdzPcnmYEWbD
	m07dYTTRhAbs0J0UR866QBgmxWYOLNFWf2iobSSYzxDkRMylcAPpXo2bdlyO/c2Dxa3GsinBdsj
	4Ct0wNLpdGGW5tEmaWfPyjb9dXpQt4B2TN0ZqqSrvobqiOZtbyixeJaNxvslROYFGc+A6+0Eex2
	MYy/2kDnGlmQw8mgLoKtnn9CCiZRvr1ucwtOM34rEf64M30QXkchmBJLA2esLdmLR5mQ5lGj9U4
	lc0BD+A1lzOSSI=
X-Received: by 2002:a05:7022:4590:b0:128:cf5c:535a with SMTP id a92af1059eb24-12a7268c7dbmr6052354c88.11.1774312802827;
        Mon, 23 Mar 2026 17:40:02 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b90dsm17543148eec.10.2026.03.23.17.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:40:02 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 23 Mar 2026 17:39:39 -0700
Subject: [PATCH 3/4] software node: verify that property data is not on
 stack
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-property-gpio-fix-v1-3-9cb46e5fe7df@gmail.com>
References: <20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com>
In-Reply-To: <20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Hans de Goede <hansg@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 driver-core@lists.linux.dev
X-Mailer: b4 0.15-dev-a6826

When registering a software node, ensure that the property data is not
located on the stack, as it is expected to persist for the lifetime of
the node.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 51320837f3a9..45c319a08eb6 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -16,6 +16,7 @@
 #include <linux/kstrtox.h>
 #include <linux/list.h>
 #include <linux/property.h>
+#include <linux/sched/task_stack.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -917,6 +918,7 @@ EXPORT_SYMBOL_GPL(software_node_unregister_node_group);
 int software_node_register(const struct software_node *node)
 {
 	struct swnode *parent = software_node_to_swnode(node->parent);
+	const struct property_entry *prop;
 
 	if (software_node_to_swnode(node))
 		return -EEXIST;
@@ -924,6 +926,13 @@ int software_node_register(const struct software_node *node)
 	if (node->parent && !parent)
 		return -EINVAL;
 
+	for (prop = node->properties; prop && prop->name; prop++) {
+		if (!prop->is_inline && object_is_on_stack(prop->pointer)) {
+			pr_err("%s: property data can't be on stack\n", __func__);
+			return -EINVAL;
+		}
+	}
+
 	return PTR_ERR_OR_ZERO(swnode_register(node, parent, 0));
 }
 EXPORT_SYMBOL_GPL(software_node_register);

-- 
2.53.0.1018.g2bb0e51243-goog


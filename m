Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21034CFCF
	for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837683; cv=none; b=Xblv+ZdgwvS0olKRrzF4hntaqa2vOBkhdk+F1B0mIM8SRGg4+10SehKbTg5VVrdK2iOoC3vO4kRwLzmRZS6WFNI48eE22y/jvZvODpufQcHyeMYgwzB1IzqoBVhbZ05Svc7iap51HdIqQqC5OJXLTWCwTHtWQs2xBWNsCd4Bces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837683; c=relaxed/simple;
	bh=bFqZrxIa+wAz0ne9hpWyd8utebsvCUq3EVc4FZvgjF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yz+yCYMjXOuKq+dsDa8dZadjs9R2qn1HBj26jJDMshUFXAQLauVNUo1vobha3ozRYVnL9SuMqJ2rdWJGQaAnXeqPFJ3JHwYITfh7Z5mxoJNWrkvcXrETPi23GhonzLB8Km5cujqDkL4M9nlxfKRzUfGOS/mX3OSa6nRePYxsue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9Uk1jtU; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9Uk1jtU"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c156c4a9efso3734623eec.1
        for <linux-acpi@vger.kernel.org>; Sun, 29 Mar 2026 19:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774837681; x=1775442481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zqs1uUluer6Mf+lCXT25NfqzHgsGQt/gWHHebQbC4Q4=;
        b=W9Uk1jtUzfSwS+ApjDjt8P0n0Ww1/75z6hTaBql3scpt/hE1Bl6dqsb30zNPanLEaD
         Q58BZmuZ9rr4YvkFcx0c7M9iRh/lsyaWJYnbp4juvBTeQgmxGP/LniJHeGHuDwzD/6+y
         R8h8oc73Wxe2fCrO/3iS65sUCaTBDR6ODBl9l6joajSSjRUfECn1D80NNqEjy4zqImMv
         UMiIt0TUqY2w9oAO+7mGDVZAMU1Y3pE76q6t5K6qhxHw+Ppm7IpHNyMkZdRuHhSAXk3i
         UONFVUvYxGrqfLqmvezdu/Hi9qdOXmXve+K0vBlYDEHMSNzf4A5Z6HmV4YjEYO/w9a1A
         QvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774837681; x=1775442481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zqs1uUluer6Mf+lCXT25NfqzHgsGQt/gWHHebQbC4Q4=;
        b=osbovJvwXa744kzEsKJlXH/6a94Kd8nFTDm1QIadO5VRAkCcejrdR4bZXlT8sZ1wBA
         aH4xVpCT/FfzRaesilYoMHjiOoOwFxLZ78e8QAdGSnfpRsKZLgRTkv2WqhM+FEqknOOz
         DHLG+4R9tESL0J8JUmJKJBtbASB8nx4lg6HwSmSEeotnL9nBTbjjNP8zKfN/i3dlKV5U
         Ch3LzScQ5s4dKQxnwpu8vrVrobNYN3sUTvTi9k4hECMLq1k+pZHToW7So3VSebEVntVu
         YAovIV0+IrX3YySPKYcdOKz57ORfCzT2mNPuEud8CDmjPRDusYOK6msPsEiAinOHsTpJ
         p4WA==
X-Forwarded-Encrypted: i=1; AJvYcCX5Qyr0yDkw3XjpJp+3HZWNZi4zVTiKqPGAVsQg2lM0sJObvMDWmXX/4C5GwcPm8kb819h7Ej64YnHh@vger.kernel.org
X-Gm-Message-State: AOJu0YzFT/NC0l3fY4S8XP1zIa5dCu2faTc3vG2rnHhA6EzAK24g0UI0
	Xtz2ChtdU/02aGAn47S47X4bdr9h7jQLeE6x0CX3dqcROt0g8YSP8dB0
X-Gm-Gg: ATEYQzyJWHi4tgpf3va7cEhXa4GIcpuaQ17cPAaYAQAeCIkw0AjSXxKxWKY8JPDIcsZ
	43rXoq37v7rgqZFI2H0dBPwkyvXHf2cZmfRb2PLboK2nOcX1NFpi9Y21R1qTBL0REzbnL2ZVt3o
	PM2OIIy3WA9eYIE2kma/bAseB68i1nGjklSizE/zaephDnD4DrgtEupfDtzf+GectzQ/+8YqO6F
	YzEmf9IhfIGBcU9DDeBARK7aB87aRsjbjcEowo9mGAYIzBOswGth71+zs+1cV793g6m64ln8sh5
	Z4ea9rT/tXPwYa/cX9KB3wXa9Yps54h4IDXQEBBDTRNmals1GDaPyuPpYQLaLTJJpW+r7I3+7/S
	9htd9+cWGrwrRbADzeBra5rwrW7qnnRAqdiMEVf0ayLUL8nqbPVGXFPRfR+Xdwrq/2AitCHbL1E
	KjuA/AT7fOuFh7MKA5dezQjB5H6PDDU3mZB9rdmwDuBjBUww/IuC3363QwlkcrVc63mJXRzORC/
	mT+n1F9I7nQsWI=
X-Received: by 2002:a05:7300:b58a:b0:2c5:d833:a4f3 with SMTP id 5a478bee46e88-2c5d833c673mr1330554eec.18.1774837681020;
        Sun, 29 Mar 2026 19:28:01 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7265:773a:8e51:c62f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7971d97sm6250673eec.30.2026.03.29.19.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 19:28:00 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 29 Mar 2026 19:27:50 -0700
Subject: [PATCH v2 3/4] software node: verify that property data is not on
 stack
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-property-gpio-fix-v2-3-3cca5ba136d8@gmail.com>
References: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
In-Reply-To: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
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
 drivers/base/swnode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 51320837f3a9..286eab02e8fb 100644
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
@@ -924,6 +926,14 @@ int software_node_register(const struct software_node *node)
 	if (node->parent && !parent)
 		return -EINVAL;
 
+	for (prop = node->properties; prop && prop->name; prop++) {
+		if (!prop->is_inline && object_is_on_stack(prop->pointer)) {
+			pr_err("%s: property data can't be on stack ('%s')\n",
+			       __func__, prop->name);
+			return -EINVAL;
+		}
+	}
+
 	return PTR_ERR_OR_ZERO(swnode_register(node, parent, 0));
 }
 EXPORT_SYMBOL_GPL(software_node_register);

-- 
2.53.0.1018.g2bb0e51243-goog


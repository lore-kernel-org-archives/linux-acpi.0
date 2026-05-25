Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBC13D3CE3
	for <linux-acpi@vger.kernel.org>; Mon, 25 May 2026 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779695063; cv=none; b=UXQlRpFZGcCc+azgak2CIoT3pVYEY7mCiTQ1IT/UvcZk5yjW8Y2g/9Q67sRdP64YSHds1high1wpt8itNkcIbHug8RMFkiuXOFycM+YpConq/bQTlcOOhT/SnW0UVz92vXVw1mheHyuIA8WY8bLaEJLnZuvRnfqyzJ7GTUkLb1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779695063; c=relaxed/simple;
	bh=gZh0WXOkZ7TUV4i4k6DPQccuy1wCCMGgW3WktDwdS1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kCFSW5IDqG9hEE7Ugi6uv+CFUts7Toeg5hsrzg9vdlinA5qUfDDtiM7EpErZoit1zzN+PENcxnMVKDJY595Xqd7LOob+ZU07NGg9n5nyzcGTpz5rf69CCbAm+7Pnnn26UZkUw6b3FnpZiGuzrW9qS1zC6IsuHkWlnWp7ybUJv2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMczXFtr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMczXFtr"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2baef9f5ecdso76736635ad.1
        for <linux-acpi@vger.kernel.org>; Mon, 25 May 2026 00:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779695061; x=1780299861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg9TspPoq01uolM1ptMRklLuTF5lwXaabRXnRf1AltY=;
        b=pMczXFtrM4ROffJMXWLXsyAo6pNdTyleeEVdsH4sZDQH//tSc7H0MwWe4IQGYjpq0y
         Wxtw4LzhNVPnWIfKmE43VsdXqKOEw8ZkSEkX3IvKNuY2cYpPyWV54yDmRo4uG8iz7BH5
         exMxxog73DI5VGBofO0RLye6WaX/H73wUG6tDwHRYZKzPHvjeBoGLnEGKdsXaQvjn1eQ
         CubDs5EQ3SUnNivAG5WREgbMd60+EkRvkcim42cssR1a05bF59OC/12xYRYPItZxa6om
         D08SHLzUBZ3ZhHQewnUYgVoG+pVT0fUDz5eXhmyTLq+FdtSPTgSI+IpwrxN7cmSq2jUE
         Wy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779695061; x=1780299861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg9TspPoq01uolM1ptMRklLuTF5lwXaabRXnRf1AltY=;
        b=IFHFPKfzdiW5cd7SR8AWV6A4KFPnWSo16/WCcZdwbZ+aDuVBNYWRE0rLog1Wzz/2Fl
         i78ehzUFO0bzYIXweIN+W+z9zFgG3MPr83Wv4dfXrmmZvWfbhDuXHSAza3UcUOFCHxPK
         hSAP+uegWAGSkeu7SRoWLmJ9cPzxk3gNAICqX9YAZl1gEeg8t+0Jz0kYLJ148vGaWw28
         iGoqrI4yJFYelT9e+cKHTe589u6ueiKX5c+Nxdz9oQNfqcB1nMPBuqcZWammseUQ5siL
         Q8xe9HXBPO2FRout7vdKxSslWomtfrwKAuvgjmwUNy6+v+y9HEfwkaJF+vmhna1HceZg
         RhSw==
X-Forwarded-Encrypted: i=1; AFNElJ9crwk4xuGNPlrQJnzEFeqQcwNQxFxZK2qOzHa9FhFA3EAogM2RVF8hNVm8WaGEz0C6VDYrIkK/mdE4@vger.kernel.org
X-Gm-Message-State: AOJu0YyAGKfia1+wm4ksPyk9Pd2SpL37n8IxswxCerQjqENyIa/2aIrL
	/3oTXaoKCyhpR/2Uml++P4UVdkMK1drTt786NJ6srtQqikOcBiEmO3bz
X-Gm-Gg: Acq92OF0XXUoCP2tuvVr4RE6sOoFWQ6blE1+eS5gessiWXlDXcdpPsdztCiMPMkNzZS
	HH7cN2HNYCYH7ZnmAIQWgubuuZQiRMEHszEsZlA6lL0n3yOcLfudlyaUrcHcNLCd9nzA7bivu17
	pJ5P/fCBz3ZPS1HO+1KLq6dVtbnzqOJCDgUFtNtuLrIJVYdQSg42t7iNY38K/WSJouffGjEQvhM
	l9OpGZKOgMfGQvV5XJrgWCZX5NzTFaziRCa+LvTffKPy+iPA1OmKya03G+gqq9d0VVyQfRQdOl8
	QyP5RrIHueyenX2V1OzLGfOw3WnqbQJadSDCC8dQo6oUzcg3R7wgESqmbNRlBhXX6z60Ocf591V
	+DuLQuaaQRhZEOEdTn6xvN3sqwyplqDlso4nK60Rmf8NBKHZ/GnEYYenrx9fGh2q+iQdvlOTlmg
	lrzzfVA2MIYcexclzUCLSwVGk67HfNZahULxAgoEOFa11a8vBm
X-Received: by 2002:a17:903:234e:b0:2b4:5931:bc4c with SMTP id d9443c01a7336-2beb069806dmr133606145ad.15.1779695061379;
        Mon, 25 May 2026 00:44:21 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58dde5fsm88734325ad.70.2026.05.25.00.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 00:44:20 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Sunil V L <sunilvl@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] acpi/riscv: use a dedicated insertion point in riscv_acpi_register_ext_intc()
Date: Mon, 25 May 2026 15:44:15 +0800
Message-Id: <20260525074415.1533884-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

riscv_acpi_register_ext_intc() inserts into ext_intc_list, which
is sorted with the largest gsi_base first. It walks the list
until it finds the first entry with a smaller gsi_base, then
inserts the new entry before that entry. After the loop it also
caps the predecessor's nr_irqs if that predecessor was registered
as PENDING.

The current code uses the loop cursor for both jobs:

    list_for_each_entry(node, &ext_intc_list, list) {
            if (node->gsi_base < ext_intc_element->gsi_base)
                    break;
    }

    prev = list_prev_entry(node, list);
    if (!list_entry_is_head(prev, &ext_intc_list, list)) {
            ...
    }

    list_add_tail(&ext_intc_element->list, &node->list);

If the loop falls through (no entry has a smaller gsi_base),
node ends up past the end of the list. `&node->list` resolves
to `&ext_intc_list` via container_of() offset cancellation. So
list_prev_entry() lands on the last real entry, and
list_add_tail() inserts at the tail. The code works today.

It is fragile though. Any future change that reads another field
of node will hit memory before the ext_intc_list global.

Track the insertion point with a dedicated list_head pointer.
Initialise pos to `&ext_intc_list`. Set it to `&node->list` on
early break. Use pos->prev for the PENDING adjustment, and pos
for list_add_tail(). The cursor is no longer touched after the
loop. Behaviour is unchanged.

Same shape as the Koschel cleanups from 2022 (e.g. 99d8ae4ec8a
tracing, 2966a9918df clockevents, dc1acd5c946 dlm).

Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/acpi/riscv/irq.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index 9b88d0993e88..49582cf4f4e2 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -134,7 +134,8 @@ struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi)
 static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr_idcs,
 					       u32 id, u32 type)
 {
-	struct riscv_ext_intc_list *ext_intc_element, *node, *prev;
+	struct riscv_ext_intc_list *ext_intc_element, *node;
+	struct list_head *pos = &ext_intc_list;
 
 	ext_intc_element = kzalloc_obj(*ext_intc_element);
 	if (!ext_intc_element)
@@ -153,18 +154,22 @@ static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr
 	ext_intc_element->nr_idcs = nr_idcs;
 	ext_intc_element->id = id;
 	list_for_each_entry(node, &ext_intc_list, list) {
-		if (node->gsi_base < ext_intc_element->gsi_base)
+		if (node->gsi_base < ext_intc_element->gsi_base) {
+			pos = &node->list;
 			break;
+		}
 	}
 
 	/* Adjust the previous node's GSI range if that has pending registration */
-	prev = list_prev_entry(node, list);
-	if (!list_entry_is_head(prev, &ext_intc_list, list)) {
+	if (pos->prev != &ext_intc_list) {
+		struct riscv_ext_intc_list *prev =
+			list_entry(pos->prev, struct riscv_ext_intc_list, list);
+
 		if (prev->flag & RISCV_ACPI_INTC_FLAG_PENDING)
 			prev->nr_irqs = ext_intc_element->gsi_base - prev->gsi_base;
 	}
 
-	list_add_tail(&ext_intc_element->list, &node->list);
+	list_add_tail(&ext_intc_element->list, pos);
 	return 0;
 }
 
-- 
2.34.1


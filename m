Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795859760;
	b=y78lJw3zpgwRI39gMPnRLQTVZaq+lvQ1k3hPhm33AnI6jGdPojqU4b7WbbbodpH5Y1gv
	 6rW39rdyTqvPOXWp2nX8WpGfE1oeBzbBNjssMNpAwjwV13J++3s+xe6hERZZNKpSoYoNk
	 8LrenrTb8NOfOMont69y6hth0hgwgEpTCCtvWZVfv3BsCiTDldrRPmnjogeEpU7l6uqAJ
	 2eGBEsT6+LnUo3RvVDFcg1/b45VklQd45w5UPS7n0/HW6Ya/IhirtD7XL4wAi7oeDDafQ
	 s50J6Y+PyvWSvinvZKr8E0OmfM36fQft7ncxNyOYe06tqX+1FoDtqKUJ930pG4cn0Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795859760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PvlEG+ER8M2Vy2xbs4JceEuPCkBHgu2+F8E6dhnU3BQ=;
	b=ZJao8gKbQn+P4/3VgYkBBtoKyYG1//v8GX+F2rb8uoSn8KpZ0GVkOE1rpTFIv/2ZC2kc
	 /eyGZOxDCw+YzNSB2bx48TwNlFkzq5Jw/QQX49XNt3SSTZ39MTAjTQ6PMNOeRi/yQQjH+
	 drGWX5hA89LavDxpLOnD+2td67T/ipDWVHig3Mbcwd6uPSWBlvvsPXnTdxek/uVXovb6M
	 KBCOYvxNGY4GrLZglkVjlhSpeuxhaL+AOyByqN5C18734ihxLQa4HDpWAS/WXjzeNnOc1
	 Ne4OltYg5aNlvLTIVKLRHslArPFTv78vCSeMdyX5X1W02qpSQQwS6fXROGuZkDKH0/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZbJz1Nyz;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC22606A31F
	for <linux-acpi@vger.kernel.org>; Sat, 28 Nov 2026 09:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DC22606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZbJz1Nyz
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b54096b2d0so673028a91.1
        for <linux-acpi@vger.kernel.org>; Sat, 28 Nov 2026 01:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795859759; x=1796464559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PvlEG+ER8M2Vy2xbs4JceEuPCkBHgu2+F8E6dhnU3BQ=;
        b=ZbJz1Nyzfsy699ZCq1Nvvbd9tIXOvJPsqYRr1U/Mx4SsbxOBcL15Ddq+nFsCFmHSX6
         HpbKl6yqDVbQf+iVLQYaWc/CSdE2D1N2lZ3i/l1k5RmlNLnhSaJg/1iGRu/vUjzIQ2Rj
         0EFkB9pnlwO7xAnuW8uDNw7kfjLSODBXAtsY/zHGIbpj+Cq3YJ/L/S4O4ud81eOF47DF
         XLbkvL+FfgZaibN0+UUsfZeChV5HpbbCc74huY7Z0qf5q+zGxgyhdqHIlB/mIxS9GEzS
         /nEYt1CVMW3RmkavL4OIOCCF3BKhG9jayxnP0+i3vfJoLL/VCsE7zr/Q79yCLsh0WY/J
         zhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795859759; x=1796464559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PvlEG+ER8M2Vy2xbs4JceEuPCkBHgu2+F8E6dhnU3BQ=;
        b=Xkf8K+8916Y//v6tB3QlSLINZJy+vUltvuZnZaIvWe1f2D/W8+6LWKRNhaMU6kuQGM
         TKZbb4mPYchIi22Q5auMxSCOikTDtiwTl+mNS2JO9lnF8+Pi/FKTRQZClaJL1kzKhJ/J
         h8nfFUfGOHneoorTJDI4kCn36oay/xZXHAxGmEtW3UlFiakF4lCUVOzuiiwsq+9OQTa6
         mIwckR/NeuXTcQ5eS3N+HLxVmZrEzns+xvL+7WaeCkzDJqrW0bSDz1fApGPySQd9zaoP
         lSDeY9ubfcY+xWt++DE0ZgLfYT02AKyE+uwCQZEvylHzSbppddrgmiRSIILwI+BrUsaw
         lR7A==
X-Forwarded-Encrypted: i=1; AL+hErH2awXLHRCtnYcwklkA6gpH6f8+YrRTLtP6p1E8Y/2qbUTYrUWaAyVPbWmllgJTaXBqCrWOith8Bp+F@vger.kernel.org
X-Gm-Message-State: APuU4Z9FJV/IIyLkW/ECyPBwOAr7Byn3Y03qJpnLOJvFEwN0Tb3Ohvxk
	zfjUzcaJjTzvO+1erRUyi4FNkij90jF6zcwArZD4VE8VMzoW7PZeeLUA
X-Gm-Gg: AZFdTZfAQekAzGM1VdNCOyhwJBaHjP9jxsJeIYK6A1OO+7Lt5zADJLlStmvzD0WYjDW
	gRSLv2QfXr00yBXta1pn7vA0jK5kjVe3nBZEFDvVvqPRr/dbvOTozJL9xqzzjD5F75zwQ2u1TYb
	oUIzTlE6j1ww97N1qGbmHTrLyRsWZ3kDwfaNb2BoX5DnyybiAfddhsbHKO2AoWqncqd+g9XoF+t
	nZW5k6dpJzOrG2Ao1kdMRxy3fQBUeLGmzdaFu4vTABljLEmTDq3VCSQoeYP1w6fz1Vb1oiXhSgf
	oMv0na2u3GCjmd7W10exLu+HcgZuMgDgbhGPYJZCE6LsTg+VR3Vd6TrBhATj1tJQxavX1c02KhR
	/Xvc2YkSaAWY86pfFvwolmT58whjacvd8BrPzTjjWCyZniFcLeRUNDxt9x+sfefM/4zCf41GCFC
	M0gEwLyWNvUjZVZXvpOY3rZrpPCVvEhWcFIqWzi106tP7d+6SvEWQjqYjeivRfSFsFnFjD9zxlO
	txjcKcKb6/VXGXYj6zM6B+lFSp4Khz5CqRTBHZMTzGDXgNpnj81+k5GYhQlQm/jmgAg0cYtJo7p
	M/hDllqHmWbnw54b1Q7YFY2ztqgTWkAxXM4G3NpziL4hjP9kehKbQCHKNRD23MlrIEQb2v1pBxB
	tqo513bSxgWI3q0LYIb5wS4uxGV5nf6eSyXJMeG3V8jCSGQFcLfAATRxPdA4OnJSwznyC8Prom4
	cRTYfatby3qOjyqojroGmZBmQ7I9K4fNkk4kyD+ECL
X-Received: by 2002:a17:90b:258e:b0:3b4:fd89:5f99 with SMTP id 98e67ed59e1d1-3b4fd896a22mr11593107a91.17.1795859758798;
        Sat, 28 Nov 2026 01:55:58 -0800 (PST)
Received: from LAPTOP-3B99V33A (ec2-18-138-229-8.ap-southeast-1.compute.amazonaws.com. [18.138.229.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b8c2fcesm15732795a91.4.2026.11.28.01.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 01:55:57 -0800 (PST)
From: "Bin Luo (University of Electronic Science and Technology of China)" <luob87709@gmail.com>
To: rafael@kernel.org
Cc: tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: APEI: GHES: drain per-CPU estatus irq_work before freeing ghes
Date: Sat, 28 Nov 2026 17:55:46 +0800
Message-ID: <20261128095546.1364-1-luob87709@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
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

NMI, SEA, and SDEI handlers enqueue estatus nodes holding a raw
estatus_node->ghes pointer and schedule irq_work to run
ghes_proc_in_irq().

During ghes_remove(), ghes_nmi_remove(), ghes_sea_remove(), and
apei_sdei_unregister_ghes() stop further callbacks and synchronize RCU,
but do not wait for queued ghes_proc_in_irq() work before calling
ghes_fini() and kfree(ghes). In addition, ghes_in_nmi_spool_from_list()
calls irq_work_queue() after rcu_read_unlock(), leaving a window where
synchronize_rcu() can finish before the irq_work is queued.

Furthermore, a single global ghes_proc_irq_work and ghes_estatus_llist
cannot be safely synchronized across CPUs with irq_work_sync(): once
irq_work_single() clears IRQ_WORK_PENDING on one CPU, a notification on
another CPU can reclaim and complete the same irq_work first, clearing
IRQ_WORK_BUSY while the first CPU is still executing ghes_proc_in_irq()
or allowing another CPU to dequeue nodes from the shared llist after its
CPU has already been synced.

Convert the estatus llist and irq_work to a paired per-CPU
ghes_estatus_work structure (all callers hold a raw_spinlock, keeping
llist_add() and irq_work_queue() on the same CPU), move irq_work_queue()
inside the RCU read-side critical section in
ghes_in_nmi_spool_from_list(), and synchronize every possible CPU's
irq_work in the NMI, SEA, and SDEI removal paths before freeing ghes.

Found by static code audit.

Fixes: 21480547c8b8 ("ghes: add the needed hooks for EDAC error report")
Fixes: ee2eb3d4ee17 ("ACPI / APEI: Generalise the estatus queue's notify code")
Signed-off-by: Bin Luo (University of Electronic Science and Technology of China) <luob87709@gmail.com>
---
Changes in v2:
- Replace the single global ghes_estatus_llist and ghes_proc_irq_work
  with a paired per-CPU struct ghes_estatus_work and sync all possible
  CPUs via ghes_sync_irq_work(), eliminating the multi-CPU
  IRQ_WORK_BUSY / llist-stealing race flagged by Sashiko on v1.
- Update Fixes: tags to reference 21480547c8b8 and ee2eb3d4ee17.

Testing note:
Compile-tested on x86_64 with W=1 and KASAN (drivers/acpi/apei/ghes.o);
not runtime-tested on APEI/NMI/SEA/SDEI hardware.

 drivers/acpi/apei/ghes.c | 80 ++++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 5d888c8..bcd86a3 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -33,8 +33,10 @@
 #include <linux/mutex.h>
 #include <linux/ratelimit.h>
 #include <linux/vmalloc.h>
+#include <linux/cpumask.h>
 #include <linux/irq_work.h>
 #include <linux/llist.h>
+#include <linux/percpu.h>
 #include <linux/genalloc.h>
 #include <linux/kfifo.h>
 #include <linux/pci.h>
@@ -1339,18 +1341,25 @@ static struct notifier_block ghes_notifier_hed = {
  * Memory from the ghes_estatus_pool is also used with the ghes_estatus_cache
  * to suppress frequent messages.
  */
-static struct llist_head ghes_estatus_llist;
-static struct irq_work ghes_proc_irq_work;
+struct ghes_estatus_work {
+	struct llist_head llist;
+	struct irq_work irq_work;
+};
+
+static DEFINE_PER_CPU(struct ghes_estatus_work, ghes_estatus_work);
 
 static void ghes_proc_in_irq(struct irq_work *irq_work)
 {
+	struct ghes_estatus_work *ew = container_of(irq_work,
+						    struct ghes_estatus_work,
+						    irq_work);
 	struct llist_node *llnode, *next;
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic *generic;
 	struct acpi_hest_generic_status *estatus;
 	u32 len, node_len;
 
-	llnode = llist_del_all(&ghes_estatus_llist);
+	llnode = llist_del_all(&ew->llist);
 	/*
 	 * Because the time order of estatus in list is reversed,
 	 * revert it back to proper order.
@@ -1384,23 +1393,36 @@ static void ghes_print_queued_estatus(void)
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic *generic;
 	struct acpi_hest_generic_status *estatus;
+	int cpu;
 
-	llnode = llist_del_all(&ghes_estatus_llist);
-	/*
-	 * Because the time order of estatus in list is reversed,
-	 * revert it back to proper order.
-	 */
-	llnode = llist_reverse_order(llnode);
-	while (llnode) {
-		estatus_node = llist_entry(llnode, struct ghes_estatus_node,
-					   llnode);
-		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-		generic = estatus_node->generic;
-		ghes_print_estatus(NULL, generic, estatus);
-		llnode = llnode->next;
+	for_each_possible_cpu(cpu) {
+		llnode = llist_del_all(per_cpu_ptr(&ghes_estatus_work.llist,
+						   cpu));
+		/*
+		 * Because the time order of estatus in list is reversed,
+		 * revert it back to proper order.
+		 */
+		llnode = llist_reverse_order(llnode);
+		while (llnode) {
+			estatus_node = llist_entry(llnode,
+						   struct ghes_estatus_node,
+						   llnode);
+			estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
+			generic = estatus_node->generic;
+			ghes_print_estatus(NULL, generic, estatus);
+			llnode = llnode->next;
+		}
 	}
 }
 
+static void ghes_sync_irq_work(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		irq_work_sync(per_cpu_ptr(&ghes_estatus_work.irq_work, cpu));
+}
+
 static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 				       enum fixed_addresses fixmap_idx)
 {
@@ -1461,7 +1483,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 		goto no_work;
 	}
 
-	llist_add(&estatus_node->llnode, &ghes_estatus_llist);
+	llist_add(&estatus_node->llnode, this_cpu_ptr(&ghes_estatus_work.llist));
 
 	return rc;
 
@@ -1483,10 +1505,9 @@ static int __maybe_unused ghes_in_nmi_spool_from_list(struct list_head *rcu_list
 		if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx))
 			ret = 0;
 	}
-	rcu_read_unlock();
-
 	if (IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) && !ret)
-		irq_work_queue(&ghes_proc_irq_work);
+		irq_work_queue(this_cpu_ptr(&ghes_estatus_work.irq_work));
+	rcu_read_unlock();
 
 	return ret;
 }
@@ -1600,6 +1621,7 @@ static void ghes_sea_remove(struct ghes *ghes)
 	mutex_unlock(&ghes_list_mutex);
 	ghes_unmap_error_status(ghes);
 	synchronize_rcu();
+	ghes_sync_irq_work();
 }
 #else /* CONFIG_ACPI_APEI_SEA */
 static inline int ghes_sea_add(struct ghes *ghes) { return -EINVAL; }
@@ -1663,10 +1685,11 @@ static void ghes_nmi_remove(struct ghes *ghes)
 	ghes_unmap_error_status(ghes);
 
 	/*
-	 * To synchronize with NMI handler, ghes can only be
-	 * freed after NMI handler finishes.
+	 * To synchronize with NMI handler and any queued estatus work,
+	 * ghes can only be freed after both complete.
 	 */
 	synchronize_rcu();
+	ghes_sync_irq_work();
 }
 #else /* CONFIG_HAVE_ACPI_APEI_NMI */
 static inline int ghes_nmi_add(struct ghes *ghes) { return -EINVAL; }
@@ -1675,14 +1698,22 @@ static inline void ghes_nmi_remove(struct ghes *ghes) { }
 
 static void ghes_nmi_init_cxt(void)
 {
-	init_irq_work(&ghes_proc_irq_work, ghes_proc_in_irq);
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct ghes_estatus_work *ew =
+			per_cpu_ptr(&ghes_estatus_work, cpu);
+
+		init_llist_head(&ew->llist);
+		init_irq_work(&ew->irq_work, ghes_proc_in_irq);
+	}
 }
 
 static int __ghes_sdei_callback(struct ghes *ghes,
 				enum fixed_addresses fixmap_idx)
 {
 	if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx)) {
-		irq_work_queue(&ghes_proc_irq_work);
+		irq_work_queue(this_cpu_ptr(&ghes_estatus_work.irq_work));
 
 		return 0;
 	}
@@ -1921,6 +1952,7 @@ static void ghes_remove(struct platform_device *ghes_dev)
 				ERR_PTR(rc));
 			return;
 		}
+		ghes_sync_irq_work();
 		break;
 	default:
 		BUG();
-- 
2.51.0.windows.1


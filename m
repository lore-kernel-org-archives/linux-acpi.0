Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795673316;
	b=vfQTnCnA1Qxjk8XHd5BhWrg7S+LRCewqzINMnrUBsviE1OQd1yjX/Yn/baF2zWyPZWo0
	 829Oab8YzKvzcgD7I4r1eV6AraSC4L3Nn1r80cCB/JeEGL3dTG81lqCi1HdFfzZcSI5/h
	 g8OyDgurfrZdCxhQ5XjVToOBgIDr3aKSfdADaiv2CcBorWBF0TAogQ/yUao7S+aFPgz+0
	 xaWG2bMiNjJjrSe88C50Cpv78uCJpO+arD79rNh/heCy8mWSuMjsMndYuUpRHbPLNRVXY
	 QEj1gb1L6OyiA4ppuGuGDkXwFJ+BeVPksX6tvvUxPAX/zhMAzIQRMWknOg70E1tBd/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1KJK27VBvu4wl3DCI+QxhINQYQCh2tz3wSZqtMb9WEQ=;
	b=s1mxrCfsOPc//cwRq1IBXlhkGKaiA2YqjDF/+ymr6V4IC/6wYjSEqIeuiGO+K9MATtEi
	 RSm+m0z+AhlLbA/YmHF5HqdcQuhRUxLFjxykjbCMSjYTnnTRETwrEYEPzVVJsLOHF01p+
	 SiUGfmQBdJK6shQbyrHIKalE+v33r279/DJZDDNvjmMH96j0Wc+jU3/NuYSSsvrZoFbvm
	 u0Y99HKC+Rgr7+SfqmsGOA+oxv6yL3hExDjVGoUtlnXI8KaS9damv/Mi/+Mvb499q2yI1
	 LLCJQSUjdCDzdFJbJsx5A241sLgrdZdwu9QnZ9GyuY0PFXI6qCQONPzOPuFKwjfEcgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OBHMZoIs;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA0606A31E
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 06:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2FA0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OBHMZoIs
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b501791bb5so615250a91.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2026 22:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795673315; x=1796278115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1KJK27VBvu4wl3DCI+QxhINQYQCh2tz3wSZqtMb9WEQ=;
        b=OBHMZoIszhXVZhBFy0YvsVDqVYXnRw4ZCPO1xIt2c6/QYXBp/ynZHicl7x5IlOJM9P
         q7af7HLHehQq6jqdgdO4Co92EJghiR0WQ2IUIoS+0hYmoKSVIcAvgTRpAFxpgDxRBZQK
         fgcLdYH02O4JYH1BGjluM0IvlkI6MqU3ORXNjAoAIkMLs+PzWMGHKmq18gMp9tm/wQCO
         v7VagIBoZlVdXuAy1Eiji2sMZ4945e06/1yL3vUruTNTk2sJnOnlENz45LeqeO05d787
         z6usTsddaTSlo4d90xHpu0Ju7BLCFFUVI7RgIqlzGp4wLhIPU8ejEEtokX7CCrr2Pnsi
         DWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795673315; x=1796278115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1KJK27VBvu4wl3DCI+QxhINQYQCh2tz3wSZqtMb9WEQ=;
        b=WgQpeioGeRCRkWhUSLZOP+SK090dTVQ2WrcMRbrueFpQeJ0QkYXFMT7/9HNK1zSNgE
         LkX+3f3TXe5Cdi+RxIhdZeSDiB12sqPN10x4eYsSCz0vufgCxKifergAVsM1upPV57ou
         iC1DyKRGxULXAKNokxJHLtH3/aJvRlk1FhuoNIpBzeUPI9cUQptz3sGT1u+QwfpQOFdF
         oNuyyQc3sAmaWjJdygcBAmUGfy33J68fOI1pK8KHwGUmh/WRwUc+Q1VhnmdJDLygeEwA
         aOgFKBL9L9EfCJoDqKk1yTTDnhy97Fc7nRlYbQnyW7Z2+Tk8TOk4BAT4iOJ/sKIUs4YM
         FHsg==
X-Forwarded-Encrypted: i=1; AL+hErE3IdAXWVwKULIPzNxcsMbCBlrEVhbeAdNMNhmPGELJK6NWb4bydiAkwm4F476RbnLcw/UxH9uKlV1w@vger.kernel.org
X-Gm-Message-State: APuU4Z+A55AgxDRA6yhFsxjnMiPIwwir+r8JMMjMPGyUp98J8Z8Csdpb
	ONuHkpHDU+lT6Tr/J5yyHZNhHha5QwKNcBVfAj5tyyRweeqg5kYIF2NO
X-Gm-Gg: AZFdTZc8XboTwIyUpJ8aAFKO78HgwtQdEBUBA+bBvP5n7MjnVCBmC2Sawlkr2+tmdYL
	ySEtI/AAcmhYDX8CceSxo7BO8kxd0o6FBZl3qNuRt3I3mU/9LKwa3JOp1YAPMEh5rUiQ2Gf3UTg
	JfObxD1Cs+pHPE4FBk0LHV/OWamVSkAdAXzlkz452ESSGowG/AnJ5Dul4rn51nkbQc4pm9zACaL
	95/Gq8gO6fsn0Cvpbyqv3whWnbIPYt6WS5irWXbb7McaD9iKijmbuwfa9DepX+MCwaD1GC5Y4q2
	NKEPGpS7Wa03WIP2SYphbKzU1PWNBelORog+YPeOA8baUIZhkbft+NCeQGxvIunNiF3iNQOCpMm
	q9Lez5gUUlJUejRshcjfM36mli1+wF9VU2DGgQLLwcjIy/55Cs2+7cKp8xZoxh+XlYF3X5dpJIP
	Rttfywshg06iIqNvO0SAHyEoE1F/kLWNpJHUmh6qyQHo6uADWlnpQp20IhYeOJwihpmb9hgnYDa
	iY0NbXOTx2/vcAb/zav200Hp9OZXYrn1cn6PRarl5SdolO1wbONnhH9ELYZ4eEcDIV2N1Y9oD/s
	8F6icW6k7Mr/Viz6Cbr+DFNVNe7Vo1puwSBtl1GuqMu9i1bV9lOwdZ5Dt5Z+wcoycaso9C/bp7a
	fv14X90AdZbKJaem2h3enl19CHf5Yy9SbBe71TCDfnqZOiawHnoTxciG985k5eoA7Ge9hWzkduK
	fTQbOJ2qxbdVTez/LhlAal2V7YcooWZRetowztd1qWAtbrJzzqE7QHboOsWfobBw==
X-Received: by 2002:a17:90b:57c4:b0:3b0:9cc6:62ba with SMTP id 98e67ed59e1d1-3b41caead33mr17941240a91.38.1795673314993;
        Wed, 25 Nov 2026 22:08:34 -0800 (PST)
Received: from LAPTOP-3B99V33A (ec2-3-38-183-164.ap-northeast-2.compute.amazonaws.com. [3.38.183.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b6fe711sm13646238a91.1.2026.11.25.22.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:08:34 -0800 (PST)
From: "Bin Luo (University of Electronic Science and Technology of China)" <luob87709@gmail.com>
To: rafael@kernel.org
Cc: tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: APEI: GHES: sync ghes_proc_irq_work before freeing ghes
Date: Thu, 26 Nov 2026 14:08:25 +0800
Message-ID: <20261126060825.910-1-luob87709@gmail.com>
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
estatus_node->ghes pointer onto ghes_estatus_llist and schedule
ghes_proc_irq_work to run ghes_proc_in_irq().

During ghes_remove(), ghes_nmi_remove(), ghes_sea_remove(), and
apei_sdei_unregister_ghes() stop further callbacks and synchronize RCU,
but do not synchronize ghes_proc_irq_work before ghes_fini() and
kfree(ghes). In addition, ghes_in_nmi_spool_from_list() calls
irq_work_queue(&ghes_proc_irq_work) after rcu_read_unlock(), leaving a
window where synchronize_rcu() can finish before the irq_work is queued.

Move irq_work_queue(&ghes_proc_irq_work) inside the RCU read-side
critical section in ghes_in_nmi_spool_from_list(), and call
irq_work_sync(&ghes_proc_irq_work) in the NMI, SEA, and SDEI removal
paths so all queued estatus nodes for the removed source are drained
before ghes is freed.

Fixes: 67eb2e990767 ("ACPI, APEI, GHES, printk support for recoverable error via NMI")
Signed-off-by: Bin Luo (University of Electronic Science and Technology of China) <luob87709@gmail.com>
---
Found by code inspection. Compile-tested on x86_64 with W=1 and KASAN
(drivers/acpi/apei/ghes.o); not runtime-tested on APEI/NMI hardware.

 drivers/acpi/apei/ghes.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 5d888c8..75dd603 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1483,10 +1483,10 @@ static int __maybe_unused ghes_in_nmi_spool_from_list(struct list_head *rcu_list
 		if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx))
 			ret = 0;
 	}
-	rcu_read_unlock();
 
 	if (IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) && !ret)
 		irq_work_queue(&ghes_proc_irq_work);
+	rcu_read_unlock();
 
 	return ret;
 }
@@ -1600,6 +1600,7 @@ static void ghes_sea_remove(struct ghes *ghes)
 	mutex_unlock(&ghes_list_mutex);
 	ghes_unmap_error_status(ghes);
 	synchronize_rcu();
+	irq_work_sync(&ghes_proc_irq_work);
 }
 #else /* CONFIG_ACPI_APEI_SEA */
 static inline int ghes_sea_add(struct ghes *ghes) { return -EINVAL; }
@@ -1663,10 +1664,11 @@ static void ghes_nmi_remove(struct ghes *ghes)
 	ghes_unmap_error_status(ghes);
 
 	/*
-	 * To synchronize with NMI handler, ghes can only be
-	 * freed after NMI handler finishes.
+	 * To synchronize with NMI handler and any queued estatus work,
+	 * ghes can only be freed after both complete.
 	 */
 	synchronize_rcu();
+	irq_work_sync(&ghes_proc_irq_work);
 }
 #else /* CONFIG_HAVE_ACPI_APEI_NMI */
 static inline int ghes_nmi_add(struct ghes *ghes) { return -EINVAL; }
@@ -1921,6 +1923,7 @@ static void ghes_remove(struct platform_device *ghes_dev)
 				ERR_PTR(rc));
 			return;
 		}
+		irq_work_sync(&ghes_proc_irq_work);
 		break;
 	default:
 		BUG();
-- 
2.43.0


Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139ED379EF9;
	Tue,  2 Jun 2026 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384578; cv=none; b=szXftfCW8QPyp3a2lOjOQ1LylroZiMZwB3qXTq2kDTEByOeOQ8++lQRrwnpyPbTg1QDIIUBCS03FDhSe8JUrAcOzgc6j6MV4j5o5QgwcMiDlNDGhhOGDfSewN5+bVWhJmDDsFYBKq0ayMOyzGvqaQlVQAkLsTslvv6Y8VEHn2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384578; c=relaxed/simple;
	bh=osrAY3oSXcmFdhXfl5J9csnroBfPWQeryAd6I4CtGFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCW9pSjHb7DKA5IRKAlOY5Wh+gCAK6ljJK7nS3Q3rA1FpBTb+07Lkm9vgjDyEtYJemLdJhOnI5QHsFnEfoEHssLEBIbXtxjoM+S8fZyepyWu57M7kTSfEpofIP4nf3ebwxnKf/k6JF4VxHUGLUL34/4qWirV4PC/iiC/AYbiT4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jcy+GYjs; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jcy+GYjs"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780384572; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wKoXcf+SQackXHAfJqahD6MXuhSRg2crwRRaqTj4nF4=;
	b=Jcy+GYjs10Y8Lj6OjSEB4FzPA09B5dzTjv4QSUfLv72M/nenvRzCUBrE+r+J6t5i1hSgi+zakJRlUGFP7o/DOL4YuFR6EpEX0F4uIdyubdy376ZUGoYmwk92q8Yx7zEGhkzq8iJhbNdojhNfHxg+2e7JzRM59fz2phgIRys7JFY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X43R2fN_1780384569;
Received: from t50a05405.sqa.eu95.tbsite.net(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X43R2fN_1780384569 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 15:16:10 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	zhuo.song@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH v7 11/16] arm64: ras: Add RAS decode notifier chain
Date: Tue,  2 Jun 2026 15:15:34 +0800
Message-ID: <20260602071540.3711528-12-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
References: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a blocking notifier chain that allows external modules (e.g.,
EDAC drivers, vendor-specific decoders) to receive and further decode
RAS error events. Each error event is passed to all registered decoders
after being logged.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/ras/arm64/ras-core.c | 15 +++++++++++++++
 include/linux/ras.h          |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/ras/arm64/ras-core.c b/drivers/ras/arm64/ras-core.c
index 94514a5bb973..0b07b69545ad 100644
--- a/drivers/ras/arm64/ras-core.c
+++ b/drivers/ras/arm64/ras-core.c
@@ -139,11 +139,26 @@ static void ras_print(struct ras_record *record, struct ras_ext_regs *regs)
 	}
 }
 
+static ATOMIC_NOTIFIER_HEAD(ras_decoder_chain);
+
+void ras_register_decode_chain(struct notifier_block *nb)
+{
+	atomic_notifier_chain_register(&ras_decoder_chain, nb);
+}
+EXPORT_SYMBOL_GPL(ras_register_decode_chain);
+
+void ras_unregister_decode_chain(struct notifier_block *nb)
+{
+	atomic_notifier_chain_unregister(&ras_decoder_chain, nb);
+}
+EXPORT_SYMBOL_GPL(ras_unregister_decode_chain);
+
 static void ras_do_proc(struct ras_record *record, struct ras_ext_regs *regs)
 {
 	u64 status = regs->err_status, addr = regs->err_addr;
 
 	ras_print(record, regs);
+	atomic_notifier_call_chain(&ras_decoder_chain, 0, record);
 
 	if (status & ERR_STATUS_CE)
 		return;
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 468941bfe855..11663150612f 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -63,4 +63,12 @@ amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
 #define GET_LOGICAL_INDEX(mpidr) -EINVAL
 #endif /* CONFIG_ARM || CONFIG_ARM64 */
 
+#if IS_ENABLED(CONFIG_ARM64_RAS_DRIVER)
+void ras_register_decode_chain(struct notifier_block *nb);
+void ras_unregister_decode_chain(struct notifier_block *nb);
+#else
+static inline void ras_register_decode_chain(struct notifier_block *nb) {}
+static inline void ras_unregister_decode_chain(struct notifier_block *nb) {}
+#endif /* CONFIG_ARM64_RAS_DRIVER */
+
 #endif /* __RAS_H__ */
-- 
2.51.2.612.gdc70283dfc


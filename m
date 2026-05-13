Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278313E5A15
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661871; cv=none; b=TLdGnsLLnZRMR2LgRmytrWWXsK+KEMxvgtz5W7Z5JiSCefZMyYaxKVrQ0vxepFBU8T1ReIzNB7BGZGUAwfOjtFuFyoZJ1GTaTXVRuk+3KVtmTtqVsMEWdOdfvYbwEmCNy5ra5OQtcvXfpnhgKgSgMdYDSLWoOnkPzustb/C8ieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661871; c=relaxed/simple;
	bh=RbO1hZySTcpeqfT1OpALJtOaef3hmokwaW+RC72Ep7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epCdIUUw3V6bS6nynnxhughxH88nadsrXx0pIgAsfmS5kQ4jozVDye33trLTsBoCMdkaRzMGV7YP041j52WBTP4zdH416Xn1TBBIEoDXzC5mhYEzHr1LOzSiLileIpB+/4gVbaK0kX4rrRYKiySktvwoGnJMrEaet751z0fwgb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X4lVN1xq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QN3/jt4f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X4lVN1xq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QN3/jt4f"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4pMPL3595378
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ewmAIgvqude
	m6foGMLA49zaPAzwEB58f49bB7peXZKM=; b=X4lVN1xqk/XVZG6sjDtsXx+B7o3
	twyEsZHNiIcE7JF9szlfsVRR6JAi9PbmO8mWej86qGUuRhvWz24HdzbGYIxxZKhY
	QuJ9tJDQALJHlZZgI0srhIs++H/l6egzv5uMI7Kjtk+G7/xQtt8teZ+KFBEwPTEJ
	h5bpHetYGdEsOuW2CwP57c9//ICdHsTetDMObbP9wxU14EO+btpQEOuq/cJRFVhS
	fsIPQDr6fYjKz35ExXF4avNBSv4R3jmrFXYK4+oRn5uwod964E7NS8ZKoGZluGxF
	+6UUCxf/LxBQ/22TL4q2MN8DclT1Op3RoN04ULivBvq1NFOSHaDpU+uUnHw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e463dkkv7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2baf7748d0aso57950245ad.1
        for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661868; x=1779266668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewmAIgvqudem6foGMLA49zaPAzwEB58f49bB7peXZKM=;
        b=QN3/jt4fB1hQXnzUbFkIjzSIDwzxjUG5WCZMVLpe6cgrxt+q4Cb/Bm8T7rSqPgK8gG
         8tGyf1qb6VmXsBBSjMcKphEuhqm2QvSQNvc7zk+5MhjoDx25Nghi7ca5fRUl3+HSQXer
         YF02/VBWCmXQm4m3nZjJTWw/LerTyOWQoUvanAIwriP1gU28n/GatxaJjPmIUD9yqX4s
         oviG2/2RD5JDxF3QIZ3y5hBXDMERB/VdZPbtEjehU08aysyS/NKYdKAtCjonVlmSNYyr
         evHbzClu+16wPybaOa4Zqwv2Dj5OFtUL0+hNWBfy9lawG2Xfh3avozAZXzoBh4a1g7xJ
         k15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661868; x=1779266668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ewmAIgvqudem6foGMLA49zaPAzwEB58f49bB7peXZKM=;
        b=DsS8DoswSeSyAardSEObhZwHNTw+TbfDCnvJxz1H2+gyg7Qw8l2TWOZtBfISs1v42n
         85vUgSMNPyY8uJ8MTtPcQ70D5I0PKGK6g3zEJfaTdyrgoWL0G9TkDTQk8hg4/DpS2t+p
         C63YW0VG2GD7MgWq2jTRtPAyOyMJJdBB8PKQgj02aqDKBd+vrv3RD2HzXqZbrtEp0tzf
         xt2Snb+Ymc+XUHgIhqdruJpyvh0lZv45vBdPINDWAskRUZqid/mzi7VUv4X+NIeMA/p+
         mi05z01qTcVSqgh8huBg/VV3MMvfrz2H87YXnq8bHJAVGECPvp0eqY4Q7Q5I1bnJ+iqA
         3ICQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WzCBGnAbVCCNhD2RDpXgs9UvamatmXdK867B3r1hMQ8Td4TTMs3VLY6CcsWsWZFZiPmFxLSZq2S8o@vger.kernel.org
X-Gm-Message-State: AOJu0YzZKRD7kArsQf6gD+b9SwYW8fSuRV06VhsjSYn39MW0/1DkU/7P
	PFxfPZzSxCQjmhmRsfD2rZqrnVD83L1ohxZd6CuszQqH8dH6k9Io8VU7ZpUXj4rmrPZcGCBnvU0
	buwdFQ1p0JBGC+R7PmB+2l1sPyniLCH8Kow5uvQLMwpJ7Ml9xRqSc00A88mdw29jR
X-Gm-Gg: Acq92OH/tGmZ4b3GO/Wy6eFJBPO77TPOBpxLZY4aRNgML6iGLxGSMzkp2iVVEMI86nK
	9eK+lwZiQhzwD5HyVqWULIlmfDDiMp0tjiDhCm7i5aybuN0JB6YY2k59qpviSuyS6qy+CxoS6Jo
	9XrJqIis8TP5eD9mm+VhWrSbEw7qb00uTOBnTjNczGWIecTjYi5ZnXp0dwSEUSx25qIImAn6jHE
	JR90ne2iw3eVJ3y5JluPNXkZElQ/JeDIXZCYHODbQQIqQgeL5W+G6Wv5kEm1FqkJpeFf3ugC2aU
	W7+Px2Qing67Ljnl+FUbSndo7nr+Cx4ZlpLNmW3eMt+yzh8WmHU+haQJmN45ADXrBf1zpVwXEag
	42LY7SiPlWfh6TATMwniQHS0m4dFenPjJeqyzaY3ZEPn+++XVyEhjBV/Vh4YBM9+3bkjMvHjMC5
	jTxw/3AkVjOVHoAHQSplqFzJT6ukBL3zSi/UvsRPz2QxhDkQ==
X-Received: by 2002:a17:903:906:b0:2b2:4029:d77c with SMTP id d9443c01a7336-2bd27295b2amr28364215ad.23.1778661867644;
        Wed, 13 May 2026 01:44:27 -0700 (PDT)
X-Received: by 2002:a17:903:906:b0:2b2:4029:d77c with SMTP id d9443c01a7336-2bd27295b2amr28363715ad.23.1778661867179;
        Wed, 13 May 2026 01:44:27 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:44:26 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 08/10] riscv: Introduce HEST SSE notification handlers
Date: Wed, 13 May 2026 14:13:23 +0530
Message-ID: <20260513084325.2176952-9-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: r1ZoyiCaCl6o08xy4FHN5ulnDskS0o_M
X-Proofpoint-ORIG-GUID: r1ZoyiCaCl6o08xy4FHN5ulnDskS0o_M
X-Authority-Analysis: v=2.4 cv=aLTAb79m c=1 sm=1 tr=0 ts=6a0439ec cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=QyXUC8HyAAAA:8 a=Eu4eB5ymJzOrEwSPfFIA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfX6u21BlbOzMKD
 a+WjaRi2cFc66qEutDAHGPJEflE33EgF6dQhXmgJ0pk8S42ADl/S5xaC+agr+rZ00Ig4pcXG1ov
 unPpNGUjd8E2A6WeZO3a0GMPWOqXrYdavJrAlYB62KtUa0S1HB9+KBg2v+Ty7n/YA+ng2BHFkfq
 T+fkGj3KhHFLIgd+cZqTfTg1ocYB+nzpVen15fxDQUD7tKDZA4m+ylzql2Ey3JTWBlmHeG2opY6
 sHngUaZzHPEOf+K8XAKkzVLt47+mlPTJ4VutSRr5ohx46jiaXgeAnipAP89rKelQKlM7DsUgdDv
 Pfxm7+gt+SAvYVhn6g743JSX6eYoll0ENu5NwW8dvr1fsw+324chD8UXNq7p5JXzu2gspi2haMo
 0FX5ZIVDramaRbWXPrF4Gp00PkN4THPPkK0BpkuewxIjFmV4p53N4zJFsbeex7LiGmv383NPVMc
 BT3DbOWeqjGhqNoyjig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130089

Add config option to enable SSE in APEI. When it is enabled, functions
to register/unregister a ghes entry with SSE are avilable along with
low and high priority event handers. If a SSE notification type is
determined, a ghes common handler to handle an error event is registered.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 drivers/acpi/apei/Kconfig |  5 ++
 drivers/acpi/apei/ghes.c  | 99 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 93 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 428458c623f0..895a843d0e36 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -46,6 +46,11 @@ config ACPI_APEI_SEA
 	depends on ARM64 && ACPI_APEI_GHES
 	default y
 
+config ACPI_APEI_SSE
+	bool
+	depends on RISCV && RISCV_SBI_SSE && ACPI_APEI_GHES
+	default y
+
 config ACPI_APEI_MEMORY_FAILURE
 	bool "APEI memory error recovering support"
 	depends on ACPI_APEI && MEMORY_FAILURE
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8edc2c8db1bb..1baa8ddd10ea 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -17,6 +17,8 @@
  *   Author: Huang Ying <ying.huang@intel.com>
  */
 
+#include <linux/err.h>
+#include <linux/riscv_sbi_sse.h>
 #include <linux/arm_sdei.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
@@ -100,6 +102,11 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
+#ifndef CONFIG_RISCV_SBI_SSE
+#define FIX_APEI_GHES_SSE_LOW_PRIORITY	__end_of_fixed_addresses
+#define FIX_APEI_GHES_SSE_HIGH_PRIORITY	__end_of_fixed_addresses
+#endif
+
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
@@ -1662,6 +1669,63 @@ static int apei_sdei_unregister_ghes(struct ghes *ghes)
 	return sdei_unregister_ghes(ghes);
 }
 
+#if defined(CONFIG_ACPI_APEI_SSE)
+/* SSE Handlers */
+static int __ghes_sse_callback(struct ghes *ghes,
+			       enum fixed_addresses fixmap_idx)
+{
+	if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx)) {
+		irq_work_queue(&ghes_proc_irq_work);
+
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+/* Low priority */
+static int ghes_sse_lo_callback(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_lo);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sse_lo);
+	err = __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_LOW_PRIORITY);
+	raw_spin_unlock(&ghes_notify_lock_sse_lo);
+
+	return err;
+}
+
+/* High priority */
+static int ghes_sse_hi_callback(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_hi);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sse_hi);
+	err = __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_HIGH_PRIORITY);
+	raw_spin_unlock(&ghes_notify_lock_sse_hi);
+
+	return err;
+}
+
+static int apei_sse_register_ghes(struct ghes *ghes)
+{
+	return sse_register_ghes(ghes, ghes_sse_lo_callback,
+				 ghes_sse_hi_callback);
+}
+
+static int apei_sse_unregister_ghes(struct ghes *ghes)
+{
+	return sse_unregister_ghes(ghes);
+}
+#else /* CONFIG_ACPI_APEI_SSE */
+static int apei_sse_register_ghes(struct ghes *ghes) { return -EOPNOTSUPP; }
+static int apei_sse_unregister_ghes(struct ghes *ghes) { return -EOPNOTSUPP; }
+#endif
+
 static int ghes_probe(struct platform_device *ghes_dev)
 {
 	struct acpi_hest_generic *generic;
@@ -1708,6 +1772,14 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		pr_warn(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
 			generic->header.source_id);
 		goto err;
+	case ACPI_HEST_NOTIFY_SSE:
+		if (!IS_ENABLED(CONFIG_ACPI_APEI_SSE)) {
+			pr_warn(GHES_PFX "Generic hardware error source: %d notified via SSE is not supported\n",
+				generic->header.source_id);
+			rc = -EOPNOTSUPP;
+			goto err;
+		}
+		break;
 	default:
 		pr_warn(FW_WARN GHES_PFX "Unknown notification type: %u for generic hardware error source: %d\n",
 			generic->notify.type, generic->header.source_id);
@@ -1775,6 +1847,17 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		if (rc)
 			goto err;
 		break;
+
+	case ACPI_HEST_NOTIFY_SSE:
+		rc = apei_sse_register_ghes(ghes);
+		if (rc) {
+			pr_err(GHES_PFX "Failed to register for SSE notification on vector %d\n",
+			       generic->notify.vector);
+			goto err;
+		}
+		pr_err(GHES_PFX "Registered SSE notification on vector %d\n",
+		       generic->notify.vector);
+		break;
 	default:
 		BUG();
 	}
@@ -1804,7 +1887,6 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 static void ghes_remove(struct platform_device *ghes_dev)
 {
-	int rc;
 	struct ghes *ghes;
 	struct acpi_hest_generic *generic;
 
@@ -1838,16 +1920,11 @@ static void ghes_remove(struct platform_device *ghes_dev)
 		ghes_nmi_remove(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
-		rc = apei_sdei_unregister_ghes(ghes);
-		if (rc) {
-			/*
-			 * Returning early results in a resource leak, but we're
-			 * only here if stopping the hardware failed.
-			 */
-			dev_err(&ghes_dev->dev, "Failed to unregister ghes (%pe)\n",
-				ERR_PTR(rc));
-			return;
-		}
+		apei_sdei_unregister_ghes(ghes);
+		break;
+
+	case ACPI_HEST_NOTIFY_SSE:
+		apei_sse_unregister_ghes(ghes);
 		break;
 	default:
 		BUG();
-- 
2.43.0


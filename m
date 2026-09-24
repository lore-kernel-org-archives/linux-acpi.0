Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935C73E0C50
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235480; cv=none; b=onzgqEp96MZOs1GFBKVSNm/9WGlgPT7TJp6gpytm1GRPKB//eBXrGLDNr7GC9P3mUTjXUT7XliIT4DfZiirrSMSxt+7XZxPr6QLX+NN/5/eSZDqn5qne9yjYlJvFDb77uUAQTbexYx6NWbNlZ5W3MMQdJ8VD5gjBg61M39ohbV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235480; c=relaxed/simple;
	bh=5x3BDbWu2BTtoKw53/r4tXWCJd/ePptrxpNQUNLH2O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4M3m5LOHlfzXUNFYuNrSR72naTtSfUvpZdzl/l41RrQPn6tkrAAlH9T7WQHIMxALSlR+uvOl9Q+YsOq8YyF1DnxBOQux1n39zdVYOdF1zlJ3dVIqInR8QR6JLVTYJGueP+M2dy7Nz+icQAEpdDBpOIazRep8Nl6xRmjY9AHGhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B6IAFx/1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KQBwxa2N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6IAFx/1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KQBwxa2N"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5eEio2277211
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 07:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rdTF0U+iZv7
	FDTkpceF6pW19Gahev/fOfTV2XMSfzFM=; b=B6IAFx/1AqggKGQQG20qVPjR3Vl
	tz+UHmdzqasPjEUp0Q8EaLgxPKluZrS9VsMrXgpZvf++e3+a9KbIdhNqOKJmM6ZM
	aox0jnofcbdlR4gyBIbAOcJxPJmh/MWwGUK/ClZqDJN7SIGHqJZ6Ymuno1ytAG+L
	Fi9r8jqsiEWu90unQuuWe7mt7XWd7jHYsca68YQDikwOrEB3qk+0hZx9u+t2amfm
	wxSix3r1jdH7d91+14IVEmNSJhft7dMpiO6iRWKdymbp7HCFt/8b3ME1Qcjyk4dI
	5SrMU9X32C5WFoW3Tu5DhORS5VxLdguip4i9zuvyf+wuKS+NbWEtgK82I2g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjxuwyj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 07:37:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33713e5e6daso2358078eec.0
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 00:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790235477; x=1790840277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rdTF0U+iZv7FDTkpceF6pW19Gahev/fOfTV2XMSfzFM=;
        b=KQBwxa2NGLhCjLsQI/+3rBnSuOnx8xfAYMl1FcW/abllxXjRoUGEvYTzHBgnRXj3xT
         jFREEhSsZtZUO3gMLX52mUUDh30HLXqcLbIXZJZhacJ7kJjy+sz5bGSVkz6Hkp1pmZCD
         mt81PUCijnZ/yB173Kr76S4yLzwhr3Zrli0xeW/Tp95EMnas/nKY6cqtmykhnDGsfX0v
         gr0hamteOQvRWuJ1+aFrhd385cs8lZPILKlK7njwFZgLEFmGAYPEl7HhEipTo6DkScnV
         bSI0kZm7ltsHhCXB3oi13CHoOUCPsNmv7ua1hWm5BR9jweRp8K0BZYfTQ3q/Zd01Q9bw
         8TmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235477; x=1790840277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rdTF0U+iZv7FDTkpceF6pW19Gahev/fOfTV2XMSfzFM=;
        b=ykHnq3jxup3hADxMoOwOq24z8WQG/J+uDQFxJMiOeO8YWyWBQQ48ggcR1C1In8K5nB
         K+AZWuqSpXRAYe5a/aR1o8dyFhT6zmeah+2m8JiqTZS/OZmCl4z5FCjeMEy2PRJPwqXU
         DL9q9slqpj/doo4n/kkB30C9xSwuPLrlXFD1G9aBOQD0hwkyG+FEpepHTo7un+37Jx/y
         bpgS459UMh8g9JcNWS6sib9w2jZkNaY0Sffffm7FTShz3ipEjdBqb9IPd7/CdtxVNprt
         /bKGqusn3a9myAAKYYZ4v0RAjifRgzY+WP1OTDDNNnEe0FQBaZBPxYYJTCGir+SlrmCV
         jNuw==
X-Forwarded-Encrypted: i=1; AKwUvBxuHIqabYxuZb5jM12HZLNxPwIkzsAq+59nFvelt3sTPAf9h3/MFP0QJyDFY7QyatNDvIWNyzszqptq@vger.kernel.org
X-Gm-Message-State: AFuF++kYqv0cpOdn4RzgfjDUYTtALafhVgHqoaA8FN7ZboeuIxnqnhJw
	6FuPRa+9G+V1dV0AK39/5ZSCNjMgW8phS1DFHysf60lut3zwov0xc6pdRglqOcW4qMqooJ/PfRC
	S2DZCLUEREye8LZv2a9xC2yafLFLjnKUcKmm8SBgZo7dO/v3ewzOy1RFGQaUpCwQ/
X-Gm-Gg: AYBFou3U8dycYlQq6NEYhbl1WMpAb+sr0AqqgG3VNn1qlQU9dTnyaZeuuFiWQ4ZWxm4
	I4JEaSbLnuth0MVtA3oAeiL3V5HGMGE9pO5advUcJ71vjh+SeT/HFBtJHyo5yblj2eE2ROUUpXt
	I7caUhsAmWTX3eiq+Hm711PgEHSihKJwliaZ6XVFn/RL1c/F5zk/FbtCtumJNaM40c2f0xqSvsU
	cniMb7ifP+jJ1FpgN3qXVdlE8Keh1Yp8e8/IK6cyd3KyaGrh/sdJEDCzj5yTUKMAf5qbBdVfMgu
	mCergzbaG8dQc3Z/8ufeztgveEaH+Y9yrOQJTsv3drMeErJ1k7LcU1xvkCLiMCHOABPhy26UW16
	TyAmoUPwNOgbopYUnEcq749C6hlBr90rHydTqmvj9ecjY0fRsmAmY7CLURDvga+H62brkheGggZ
	jPJEXhItrPu4NrMOorcmjsF4Lc2OQLO39uVB4=
X-Received: by 2002:a05:7300:b181:b0:340:2133:5492 with SMTP id 5a478bee46e88-34021335760mr1299095eec.15.1790235477006;
        Thu, 24 Sep 2026 00:37:57 -0700 (PDT)
X-Received: by 2002:a05:7300:b181:b0:340:2133:5492 with SMTP id 5a478bee46e88-34021335760mr1299059eec.15.1790235476366;
        Thu, 24 Sep 2026 00:37:56 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm12120680eec.5.2026.09.24.00.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:37:55 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, anup.patel@oss.qualcomm.com, ardb@kernel.org,
        conor@kernel.org, james.morse@arm.com, lenb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robert.moore@intel.com,
        sunilvl@oss.qualcomm.com, tony.luck@intel.com,
        zhangzhanpeng.jasper@bytedance.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v5 5/9] riscv: Add functions to register ghes having SSE notification
Date: Thu, 24 Sep 2026 13:07:10 +0530
Message-ID: <20260924073714.1650588-6-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924073714.1650588-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260924073714.1650588-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VDYYLzALIslyqps6IHDKYGhY3v0_Eagy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfXw643VkQw28Ky
 KdkgAg+0UmNidicM8FpNxR6AhxCewVRlqc5y1PxzzelPW9AE9tnPnT89GJLoQTf/9g8/JSUJDCp
 JuIlFtpe2xiHVo6Eugp8xCvFjPwRiaTGk3F9p+M5UKrukE8TfsPYsXAd9u8qwv7zZ5YhENIQsc+
 OoRRLCc22VY4MJ5bAdd+RReAUhuDi01wz0+6idKwIc88yGJUXO9XDdpdkLqaM0DJUE3LIZJZ0Uj
 CoGIcaPxC9NIsyAo7QosCUVsnfURuG23v7Yy392NrfKpJKdt3lhKzKup7O+7WMxYlWbYq7wT7KK
 P15qIfcnhlZ5Tn+7PoarsBicumILWoVZqxWQ7rwyLZPcN2ew3sP+o/DQm5sNqTRPLlfwuQUcwRv
 J12m3U1vHAnNOUHIZ7LnxxXX3XesHzh0wj/XedLNbml/jyxlMzHxtGgDkgNTa7VhluqvNqNwltZ
 BeUW/TOgtfmIt8aGqXw==
X-Proofpoint-GUID: VDYYLzALIslyqps6IHDKYGhY3v0_Eagy
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ab4d355 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Ozu7XyEW6BlgmijDRVkA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfXw2f2BceLdfEX
 7OrZkqBriZ7TnBd1RR+q4aCGzK5pb/sZKW96YFjT/jNfKWmz7GVEsoaci92ADADsHSrDnHIGX4y
 9IPMMo1ijYNnQuJXXU2nSpoGjoDpv/w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240032

Add functions to register the ghes entries which have SSE as
notification type. The vector inside the ghes is the SSE event
ID that should be registered.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 drivers/firmware/riscv/riscv_sbi_sse.c | 146 +++++++++++++++++++++++++
 include/linux/riscv_sbi_sse.h          |  16 +++
 2 files changed, 162 insertions(+)

diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/riscv/riscv_sbi_sse.c
index 69ce98380331..d4a8691fdf8f 100644
--- a/drivers/firmware/riscv/riscv_sbi_sse.c
+++ b/drivers/firmware/riscv/riscv_sbi_sse.c
@@ -6,6 +6,8 @@
 #define pr_fmt(fmt) "sse: " fmt
 
 #include <linux/atomic.h>
+#include <acpi/ghes.h>
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
 #include <linux/cpu_pm.h>
@@ -1226,3 +1228,147 @@ static int __init sse_init(void)
 	return ret;
 }
 arch_initcall(sse_init);
+
+struct sse_ghes_callback {
+	struct list_head head;
+	struct ghes *ghes;
+	sse_event_handler_fn *callback;
+};
+
+struct sse_ghes_event_data {
+	struct list_head head;
+	u32 event_num;
+	struct list_head callback_list;
+	struct sse_event *event;
+};
+
+static DEFINE_SPINLOCK(sse_ghes_event_list_lock);
+static LIST_HEAD(sse_ghes_event_list);
+
+static int sse_ghes_handler(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	struct sse_ghes_event_data *ev_data = arg;
+	struct sse_ghes_callback *cb = NULL;
+
+	list_for_each_entry(cb, &ev_data->callback_list, head) {
+		if (cb && cb->ghes && cb->callback)
+			cb->callback(ev_data->event_num, cb->ghes, regs);
+	}
+
+	return 0;
+}
+
+int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
+		      sse_event_handler_fn *hi_cb)
+{
+	struct sse_ghes_event_data *ev_data, *evd;
+	struct sse_ghes_callback *cb;
+	u32 ev_num;
+	int err;
+
+	if (!sse_available)
+		return -EOPNOTSUPP;
+	if (!ghes || !lo_cb || !hi_cb)
+		return -EINVAL;
+
+	ev_num = ghes->generic->notify.vector;
+
+	ev_data = NULL;
+	spin_lock(&sse_ghes_event_list_lock);
+	list_for_each_entry(evd, &sse_ghes_event_list, head) {
+		if (evd->event_num == ev_num) {
+			ev_data = evd;
+			break;
+		}
+	}
+	spin_unlock(&sse_ghes_event_list_lock);
+
+	if (!ev_data) {
+		ev_data = kzalloc_obj(*ev_data, GFP_KERNEL);
+		if (!ev_data)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&ev_data->head);
+		ev_data->event_num = ev_num;
+
+		INIT_LIST_HEAD(&ev_data->callback_list);
+
+		ev_data->event = sse_event_register(ev_num, ev_num,
+						    sse_ghes_handler, ev_data);
+		if (IS_ERR(ev_data->event)) {
+			pr_err("%s: Couldn't register event 0x%x\n", __func__, ev_num);
+			kfree(ev_data);
+			return -ENOMEM;
+		}
+
+		err = sse_event_enable(ev_data->event);
+		if (err) {
+			pr_err("%s: Couldn't enable event 0x%x\n", __func__, ev_num);
+			sse_event_unregister(ev_data->event);
+			kfree(ev_data);
+			return err;
+		}
+
+		spin_lock(&sse_ghes_event_list_lock);
+		list_add_tail(&ev_data->head, &sse_ghes_event_list);
+		spin_unlock(&sse_ghes_event_list_lock);
+	}
+
+	list_for_each_entry(cb, &ev_data->callback_list, head) {
+		if (cb->ghes == ghes)
+			return -EALREADY;
+	}
+
+	cb = kzalloc_obj(*cb, GFP_KERNEL);
+	if (!cb)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&cb->head);
+	cb->ghes = ghes;
+	cb->callback = lo_cb;
+	list_add_tail(&cb->head, &ev_data->callback_list);
+
+	return 0;
+}
+
+int sse_unregister_ghes(struct ghes *ghes)
+{
+	struct sse_ghes_event_data *ev_data, *tmp;
+	struct sse_ghes_callback *cb;
+	int free_ev_data = 0;
+
+	if (!ghes)
+		return -EINVAL;
+
+	spin_lock(&sse_ghes_event_list_lock);
+
+	list_for_each_entry_safe(ev_data, tmp, &sse_ghes_event_list, head) {
+		list_for_each_entry(cb, &ev_data->callback_list, head) {
+			if (cb->ghes != ghes)
+				continue;
+
+			list_del(&cb->head);
+			kfree(cb);
+			break;
+		}
+
+		if (list_empty(&ev_data->callback_list))
+			free_ev_data = 1;
+
+		if (free_ev_data) {
+			spin_unlock(&sse_ghes_event_list_lock);
+
+			sse_event_disable(ev_data->event);
+			sse_event_unregister(ev_data->event);
+			ev_data->event = NULL;
+
+			spin_lock(&sse_ghes_event_list_lock);
+
+			list_del(&ev_data->head);
+			kfree(ev_data);
+		}
+	}
+
+	spin_unlock(&sse_ghes_event_list_lock);
+
+	return 0;
+}
diff --git a/include/linux/riscv_sbi_sse.h b/include/linux/riscv_sbi_sse.h
index f6b3881c8884..b470abd61b92 100644
--- a/include/linux/riscv_sbi_sse.h
+++ b/include/linux/riscv_sbi_sse.h
@@ -13,6 +13,7 @@
 
 struct sse_event;
 struct pt_regs;
+struct ghes;
 
 typedef int (sse_event_handler_fn)(u32 event_num, void *arg,
 				   struct pt_regs *regs);
@@ -37,6 +38,10 @@ void sse_event_cleanup(struct sse_event *evt);
 
 int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int cpu);
 
+int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
+		      sse_event_handler_fn *hi_cb);
+int sse_unregister_ghes(struct ghes *ghes);
+
 int sse_event_enable(struct sse_event *sse_evt);
 
 int sse_event_disable(struct sse_event *sse_evt);
@@ -67,6 +72,17 @@ static inline int sse_event_set_target_cpu(struct sse_event *sse_evt,
 	return -EOPNOTSUPP;
 }
 
+static inline int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
+				    sse_event_handler_fn *hi_cb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int sse_unregister_ghes(struct ghes *ghes)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int sse_event_enable(struct sse_event *sse_evt)
 {
 	return -EOPNOTSUPP;
-- 
2.43.0


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD463A6EE1
	for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485798; cv=none; b=faY8D2U4gA7ktOYB+B5Ce2jsECAi+kkEMUaYkyEU05OJIc86rjx5QHihn5e4Pq6jhq2lAj4k42wvcw4Ku5172T9U14IUaOY9AYkwz38oqihOWVSTyuKn8zKUHRihRTmlVIUIBWElnSZrjMHDX35azad5ReUX446VoPfFUofLLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485798; c=relaxed/simple;
	bh=dfcYwkyuDNYynj44TLY/xzDAGhF6slaoqu29/jCOjLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=plxxocwUG3APziTt1o9NhzeR/jWJreg0aJTLlg2PO8Atb0hdqq5wO7De7h/zmTHkZDZe8igjGZNkryXEZXgRaoFzd2CIUVcAhGHt4heXN8eR+Ehf67OB0/XQvS100a4ZkDIaj2riw/IcZrG2rXLnrc35tb3u/k7x24Ph5gQfqV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R84is9rq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KAq3i4lL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R84is9rq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KAq3i4lL"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B4GlM5018258
	for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 07:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zD0OZ3vl1Z6/q5f1uoJsnOx26bZdUEuAO+g
	pWzawFUc=; b=R84is9rqwSI5OH3TizEVkUFTdeHN+ftcMSJX/hfgCHCf+nfc0JC
	O0KRYqwiUFypzewXzD2GMob62VE+Ndg9lefuFwqwAxpbDC2j1dolRfUkzYcb7Yge
	L6f+TdG8GILv8mWAO7bYISRygcdFIhkOIzvafVewdzQPd3k+rkIeLo/ed+6xdj8N
	tl8oeTBgyByJUWZ3rVJsVzGHvnQJUoc8LAWUd5ayq2cUmlk+Tkhjs83EcXiPwLB9
	uYB5qOZvkMmLps9lmCl39l1t2wb50SZwHPsE9sa7FH9C9BFu95sdq6kzYOheHF5b
	/+zrYYmBg3w2cwXTa1w8HYxwfcjdsBwJEqA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xfrnuh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 07:49:32 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8b52bb3ff88so102929516d6.0
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 00:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778485771; x=1779090571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zD0OZ3vl1Z6/q5f1uoJsnOx26bZdUEuAO+gpWzawFUc=;
        b=KAq3i4lLtAwqckL+dOLezbhEoR42dOK3EPl2BdjWVY8CZV3LJEGqq+MmKDO9atlmwA
         U22hn8o9mI9RsIiSYjAYR4AfPI4WkMshDDsSMcoMffi9F9kZR5NzSSLlWw6AcQDzCaRj
         T8V4ICBaj3pnxKt6cxFFw7B3KMffxk4XMmZjfaK2zZ1y3NyCBZkgD1e/zu0g+rzd2kA3
         QcqGLRkirX6sUq1ZOd4JxTkWnJKqUjCQzHL+4b43LG6/fI2K2jcVHEYeYInxUV8kzhh7
         m5k2drZbt+sgc2MUHaP/y6+gRi4rv6PKsmwMF+DQDL0fLkrBB2UspcDnz2H34acMra48
         /qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485771; x=1779090571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD0OZ3vl1Z6/q5f1uoJsnOx26bZdUEuAO+gpWzawFUc=;
        b=h+lFYzxr02Q96cZLVPCuV4iWncfTmTdwVsIb/CfmRn3qnR02eLyRqfcM6BvsMDe6kx
         RSZp+ZdMovardb5GTZtH0VRqzB8fXg+necEXbAasv2E0Kkyz0tXg0h+K2np/2mDazYfO
         IJP0HwkdpJdTsH1htasJKC9gk68B/SNE0as1fDC/IFCaKADlts34DSrhwfE6aHhu9tkx
         g+0lG2hNMjpRkhSvpb6Kip4PwSkuAELlcKE4Q2P07fVSKco+HWdyah/35iFBs+ocHzgY
         YIoqM18IQdRfQkDO8ELHme/kQnwMIb5TAnh0xcgKuXA11ZzYrFlYXrZGmTejKYuGtyWb
         Hwpw==
X-Gm-Message-State: AOJu0YzFPUQww8yNIwFTXHE9Hlgn9q4oAO3O28aY//bRYpJPbxnJnKvq
	MqvdIJWTnrxE4RImTkVqrp0o1mGsdkZiicDBuUgChKZtUf6/8VXhGhTiLzRPGo+rP2gUe3EbMqH
	EhtVIWs420227vOYjJe2lB1wLvkU5jXuCdzMxN7N1R4O2ScV3ZHeyfdV8ImM5vAZA
X-Gm-Gg: Acq92OHK8Hm/MDoPGTzYzNGT6TdetxQKhhCuSs4fXqOC6iDpNdJX/EzqhP0apu4+43h
	gskpbe8tGcEhnabrTPhHAq3lYUyHbI8dOEaTVSMm8LKu/fhDWcloijx0w9nXyH8eWiKBlvyeYhZ
	P9WPU3avfVL6+YVP2WC2Ark8k9kyk0Tg6A545S/3on3RlPxugv9jqOlqI0w5VMYa9LsPl6SVgZu
	1QrmLlAxXrQwO6LygqqLAwgk3QbZx3HqhM0yMe6xOrm/kwlZEofV2TzGV3fdTRpcKjpUTx3WDHU
	zoVK1j5BKP1FV3ynZJUcSIUnhEshCF575ce4mvMeC+80yre7l9hHOByaSGi3E0rj99sfGzqKCvo
	pj4+gJ4Vssx9ENHwadlft8OAh0OnonOQbH1SYxHDw17bspMk6byQ46+3k3N90
X-Received: by 2002:a05:6214:2386:b0:89a:1c81:65a6 with SMTP id 6a1803df08f44-8bdb9b59b8emr211043316d6.17.1778485771477;
        Mon, 11 May 2026 00:49:31 -0700 (PDT)
X-Received: by 2002:a05:6214:2386:b0:89a:1c81:65a6 with SMTP id 6a1803df08f44-8bdb9b59b8emr211043146d6.17.1778485771059;
        Mon, 11 May 2026 00:49:31 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:63bd:c2f9:cedb:aa32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702ec51fsm147605045e9.12.2026.05.11.00.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:49:30 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Saravana Kannan <saravanak@kernel.org>, Rob Herring <robh@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] device property: initialize the remaining fields of fwnode_handle in fwnode_init()
Date: Mon, 11 May 2026 09:49:26 +0200
Message-ID: <20260511074927.9473-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqXWQjXh c=1 sm=1 tr=0 ts=6a018a0c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=VQTjnhxCuS3Q28dGhDUA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: zMQXEGIXVu70goFIZ9V7Z4B_Rmo3xxV1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4MyBTYWx0ZWRfX5NDbVE3IHiNd
 VO2du+2mVmK40G1O8dIjylvAzEgddOQS/BYPbbQZxmZxDvVcUBThiSWZXmKrSdEkkSubxbagdqZ
 yxJGDBWoYBM5OGWNPcipLBw8hxGJr4UynaFk75oGb1WV4OWs0s0qgDetOfWmbI8sxk7y6cuXkI7
 t/APpJyUC/AS6QoXWyNG13jkbtYQqDVlKYvrF01gwsvpNnfepIhSDs1hEvEeAZ829LycsIJbpFf
 vpmOl85UA87JCwGKinct9/oiYfmHtFZ/Uy3bofCxZH/JLxxjth5Woacu4vi5CvWjUiOR3+EiPP3
 CscbIVcpKIM7Cl8pUeF/vN9cwZcmF+GZTKBEWNmtIxGRaJJnGfHxOC7NlcRJqtQSCOrL55NejUz
 DDCKtebvHu5GTkgLvRE6udkCMCrxLE0/l5Y11+4S+yivqvcXvSWC9HaUgFPqZlUP4SbvXpaXtdZ
 Qfzj2tG8TSzHpDF6Aqg==
X-Proofpoint-ORIG-GUID: zMQXEGIXVu70goFIZ9V7Z4B_Rmo3xxV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110083

If a firmware node is allocated on the stack (for instance: temporary
software node whose life-time we control) or on the heap - but using a
non-zeroing allocation function - and initialized using fwnode_init(),
its secondary pointer will contain uninitalized memory which likely will
be neither NULL nor IS_ERR() and so may end up being dereferenced (for
example: in dev_to_swnode()). Set fwnode->secondary to NULL on
initialization. While at it: initialize the remaining fields of struct
fwnode_handle too just to be sure.

Cc: stable@vger.kernel.org
Fixes: 01bb86b380a3 ("driver core: Add fwnode_init()")
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- initialize all remaining fields in struct fwnode_handle too

 include/linux/fwnode.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 80b38fbf2121..c30a9baafc0d 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -208,9 +208,12 @@ struct fwnode_operations {
 static inline void fwnode_init(struct fwnode_handle *fwnode,
 			       const struct fwnode_operations *ops)
 {
+	fwnode->secondary = NULL;
 	fwnode->ops = ops;
+	fwnode->dev = NULL;
 	INIT_LIST_HEAD(&fwnode->consumers);
 	INIT_LIST_HEAD(&fwnode->suppliers);
+	fwnode->flags = 0;
 }
 
 static inline void fwnode_set_flag(struct fwnode_handle *fwnode,
-- 
2.47.3


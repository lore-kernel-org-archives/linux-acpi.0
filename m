Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A224314B6
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2026 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342480; cv=none; b=QgO1kPQiVtZbvO2ym8TH5ff7YzdoLXerFSsdE0eY0Hrcu61w5mG/6ohvSCEeMETkOdluZ2rfTQgGK1i6dXx1vTEtV/vxyck+wkGOb1uMAdhRudalib4iEgAdwifUgq1KvWA8/WJnGnOKvGoXfBpgOVM37lLEgPWyjCEgGzWk2PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342480; c=relaxed/simple;
	bh=lZbgNGsMr1suEXSQ3AyujBAwdJTKYOJyzKWDmgEJ74E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnDP0bMHOiZiymDnRZP0CFRFhZ6FsrL0r6CwcLmon2NV5q8fMdh9vQuizncU/h0/HpmrzTM0+RmtfTFAdaT/41q7HoRuJKVlWLyFo01G84B+IYCErXRFH8VVA40kmfb+5DdCALHp9qjx7TKPzcmRIvzr8cL4Zml3v4QwVpF6Cug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPNjzYmH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KSTIIPlp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPNjzYmH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KSTIIPlp"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666Ax8HS391051
	for <linux-acpi@vger.kernel.org>; Mon, 6 Jul 2026 12:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8JWLLs9BtcGkliFw968AXZYd7Z9KZJ1rY3dzFwNebIQ=; b=hPNjzYmHRvP8GXOL
	UU9uzk3GrAl0McMPmgMixslg3/IOuepI5QxDZEpZ7AONCkGfHEO362xtDTaJGNne
	A2pT6HN2HpCLyTXbb3U1R4iF0LzEzkaaA68QVsin2UpDaVg2t/TT5mVsHW3ry5Dr
	sqReMvXceWlNuB1ZVmtZr8JiOa2wkpqPrssc6dxLjcmDW71tBdWN0c2PI5C1Uf+d
	FmLIbsZhMUrDmSyV9S2rCYrOMx/GIoMjl++KunzOWJuVvEP1PIxFbJ4ZxLPbTP3x
	devIL00B+RnxaLVB1H4w1ukzDzDVBjc6ccca0+Wc4SNPRykCOcUTe/UI9GzVoXpI
	2WFg6w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgrss3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2026 12:54:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92d1cae5740so343814085a.0
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2026 05:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783342477; x=1783947277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JWLLs9BtcGkliFw968AXZYd7Z9KZJ1rY3dzFwNebIQ=;
        b=KSTIIPlppmf/6pitBkmSQ9CvHrULV0n+KetOAIdHkwLBEXHK6Xerf8tBHBVF/8jJn4
         yyla5Lse5r5e4fbWAjgLW6Knz2dZyPxFGm9iE9LXFL5egb0S5lxbYtoqI5sphQyiATUp
         nX0e/50q/4r2IWkcdWc0p6mzlnpUxXsbZ93m2rQhe3RHoznuU1g3qImPdNBDgeTFrlbr
         RCgC56K0YPHLc3mPooAM2hs2NyVR9sdcQafYocXwqgsSmqPh/6Bjd3tZnVQWgWvoJi3y
         PPh3mTSF1Lgvi9sgmjreGhQtxEss9E+1Sz9Umhbfc7uV1RrR3KwLsI4HxPwW9R/zamwG
         KUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783342477; x=1783947277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JWLLs9BtcGkliFw968AXZYd7Z9KZJ1rY3dzFwNebIQ=;
        b=gBeXc6DL2iEvgEf3VJw8TCLRnrMuK9DwtlOd90a9fulw2tqB+qgW2cZq/MUe8+CyO2
         RKpUB2BXY0scZNc/+Pj+i5yNvxRMMb55v3Ls+QH97JsRB84bVtlbiSmGtWQf/y1DgfoN
         Yzf7KxiCR/vaDYg4QxKY2D5i3eUuD0U+d6MVmdoN3IUHQ0z+7TZ4wCcC2M5SaLgSqK4v
         p9ulRNwgTXy/GJIN0e8p8qsdwT3MXF5TSm6F5uTSxYzGwVwFa87+8TAn4TQpe5txXS05
         2QsJaI7zwb4iw8DPUPWVyG7Aug1vkdnzhO6wu8ji2w4zlydK8knnFqxmaTLnpu80neOY
         9ffQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQLqKCAqckSpLmSDy4tQFY2pmlQKcJjydYjq/a6wjLJ7vZut6FSWApgqwmlZr515078y8ripvxMP2N@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5De4STh3OmsPnZ3S/FsAlCiogG51HY0BykPiXc29//5mi1Vx
	USlqqWfIw6R2IFU7NkfGdXUYp2kj+rxJVa4Z2KFbd7Xjn1h7T5EpUhnhNE4XpLsPmMleOOyxGP+
	9noMngdg4f1B+OshPUCZ/zCQON7ygXrNBdUfNBGeGya6PzqmmHbze50mvmIKH+w6n
X-Gm-Gg: AfdE7cnzd1JuBX0OEosBeRBn2X/yqa3rfTAOrMDKnFo+DL5i+yFsADtBU80AgbleiZh
	T4JWoocPyiVAzjjauHceRfpCFFX7E+Hihyo9c8F4Gt0yNrdpy8VezluIy7EJ9bR6GnFqJ109fDQ
	63PVY2fmmeodonYY5/YdHRQdMAoP4NiEGbs7sLvc09ZtAjZFAfpGYyXEzmJK3MR9GwPkJxd/YLA
	CpwIXN8i7oigxoRGDijrI5Fx8CgWU81ZmD18lIiTLbz947EJXHxqCcJxWICgei/rtPD63abcUyV
	T4G6XJYX3ljYhOVqWE7zPXT19Pm4QCFQP+RENtwjpskENzFHLwOSrrm89t6Grr0xEXn2BITIfhB
	Gs6EsNRyA0rr66ZwNGFrPuEIL4P8esd74kMTN0TSQ
X-Received: by 2002:a05:620a:19a0:b0:92b:67e6:8acb with SMTP id af79cd13be357-92ebb71f3f8mr49566285a.69.1783342476571;
        Mon, 06 Jul 2026 05:54:36 -0700 (PDT)
X-Received: by 2002:a05:620a:19a0:b0:92b:67e6:8acb with SMTP id af79cd13be357-92ebb71f3f8mr49561185a.69.1783342475992;
        Mon, 06 Jul 2026 05:54:35 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm26856931f8f.7.2026.07.06.05.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:54:35 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:54:08 +0200
Subject: [PATCH v2 1/5] kunit: provide a set of fwnode-oriented helpers
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-swnode-fw-devlink-v2-1-f39b09d50112@oss.qualcomm.com>
References: <20260706-swnode-fw-devlink-v2-0-f39b09d50112@oss.qualcomm.com>
In-Reply-To: <20260706-swnode-fw-devlink-v2-0-f39b09d50112@oss.qualcomm.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-acpi@vger.kernel.org,
        driver-core@lists.linux.dev, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5500;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=lZbgNGsMr1suEXSQ3AyujBAwdJTKYOJyzKWDmgEJ74E=;
 b=kA0DAAoBBZ0uy/82hMMByyZiAGpLpYKhUg9DWycVEmr+ujajTbc2FobBPKYZePvCNHEVm2tNU
 okCMwQAAQoAHRYhBJHlEy3ltUYde6Jl/AWdLsv/NoTDBQJqS6WCAAoJEAWdLsv/NoTDUTEP/iTA
 z+eBbvvyZlHRw7xIzJ59lxdmZl/wCSdCbzv/tfnBv2ljVdSifq5Vsj9CMAPdZxym/ZzKR/ghdOk
 jLshwlY+NMRilFWl6N8CE3F9RePjZMclTIfVLh3RkzIk7eFIpc+6YtPlaOrbb7+UQJAR2gFGrkM
 6f4jRM2gWyYO1umRDoI+aDscxqSFDtrEOeKr44sDtLQvsfow076JSvTXFHOeTz5GBdTtxKQ3+pM
 TSxlaykyGy1F6vUn7E5MDXyAXuhswAzWBDstAjYUmUK9tn/slfZql9TDQE7U+XSIus2eiQKGihI
 6vYPhe3moL36CL1Zr18ztxPZR+hV/qUvwyMCQkAfl/v9Ato4Esp28SiLOuzOwbpgWeB+l+dsaTw
 QhbSBc7LGdWhkskiA2s/ZncmKy43XaSSDtXmDwytUBXEDTFzDj0mbFg5Aezbx6OPpi/Olq9xhJj
 BrNJJ+Nj+FLu0h113zEP7WBtjGfxw4xVHjujjiLcCgCp6PK3INTWBwaet80rSR8Gk/ZTGUOMQ7c
 KksKwd4vpX1rD/oRyTSE81JNQXM7K3PTtDyViE9xoWyzjKmGoyWGeUog8rl0V7yxl+miNXPDfcr
 cESvm4SVT96taNwLgiCpnxkjKZawp/uH10Qebp5wJdRQq1rD3YYYrqCXIB0MyqRy2yW94b2iyE5
 J3/V0
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: zzQxVP0STWR8JfLSA0EtPbgz658DdTbw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzMCBTYWx0ZWRfX5WvreKu6A504
 rTjtAgL8PjM3isLNz7GBMT9pno0fQNNN7i0UYj12NaCWGpwDMzahhMCFRgo/kSb9okQjPc4SQUx
 Her1JXlmTap1dV2o33o6QTTiYmdvdF2u+wIfu4MfSlqBxBrt7t8mMjPNOKuCSs0FLSmEkEeuLzP
 Q8fHi8+4AmoZQ+p8s4/yIQBveFmnpGpsF8bFpAMHyH4s7gkU5XUO+TChs2hTZNoVuONqQtKIkVS
 HgHfgsNc31ofc37fCFt/D5/BM/SQH9g80I8AQbCbpGIdmNDWAsSFD9bNrmt7oA4shaG4ufIfB1u
 S7Uv3ZhZX6dh/Z+UbWzg9LydfM5kMl3HmXfRasL4oKGFUyNjrJ5NPjZiRd4ge/8uoyaamp2xrEr
 yFU5SJ5mAco9CRvokFDIU+bXPvJYkMjeePEOzormEUb/9Wx4oYrztb6kbKwZiRN3Vb8W2xbvT48
 rGP0ULxfKc4CEUeznpw==
X-Proofpoint-ORIG-GUID: zzQxVP0STWR8JfLSA0EtPbgz658DdTbw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzMCBTYWx0ZWRfX1cj2LPGhi7Cq
 wB5r/lJPDwnlz0qtjg+74OxnUdwGgC3eaLpoE9UZzC1HO4t48Po9O0FyzvZrKJWxipHIz4U1lRN
 D1HOE/piBHPenYXDDKH5F+pZAZ4e2TQ=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4ba58d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=VSMHv2xdrKP6GTymTuoA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060130

Provide three new kunit-managed helpers for test cases that need to
register/create dynamic software nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/kunit/fwnode.h |  26 +++++++++++
 lib/kunit/Makefile     |   1 +
 lib/kunit/fwnode.c     | 116 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)

diff --git a/include/kunit/fwnode.h b/include/kunit/fwnode.h
new file mode 100644
index 0000000000000000000000000000000000000000..239bc71eb5072ccead0beb51fc0882bab69c6877
--- /dev/null
+++ b/include/kunit/fwnode.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit resource management helpers for firmware nodes.
+ *
+ * Copyright (C) Qualcomm Technologies, Inc. and/or its subsidiaries
+ */
+
+#ifndef _KUNIT_FWNODE_H
+#define _KUNIT_FWNODE_H
+
+struct kunit;
+struct fwnode_handle;
+struct property_entry;
+struct software_node;
+
+struct fwnode_handle *
+kunit_fwnode_create_software_node(struct kunit *test,
+				  const struct property_entry *properties,
+				  const struct fwnode_handle *parent);
+struct fwnode_handle *
+kunit_software_node_register(struct kunit *test,
+			     const struct software_node *node);
+int kunit_software_node_register_node_group(struct kunit *test,
+					    const struct software_node *const *nodes);
+
+#endif /* _KUNIT_FWNODE_H */
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 2e8a6b71a2ab07a738964a7ef0f442fd53e085b1..204e02b10eba1030c6d511991fe2f6271de64603 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -11,6 +11,7 @@ kunit-objs +=				test.o \
 					attributes.o \
 					device.o \
 					platform.o \
+					fwnode.o \
 					bug.o
 
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
diff --git a/lib/kunit/fwnode.c b/lib/kunit/fwnode.c
new file mode 100644
index 0000000000000000000000000000000000000000..332490f07fae78e0fbf2930f9c80da0cc7dce028
--- /dev/null
+++ b/lib/kunit/fwnode.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Qualcomm Technologies, Inc. and/or its subsidiaries
+ */
+
+#include <kunit/fwnode.h>
+#include <kunit/test.h>
+
+#include <linux/fwnode.h>
+#include <linux/property.h>
+
+KUNIT_DEFINE_ACTION_WRAPPER(fwnode_remove_software_node_wrapper,
+			    fwnode_remove_software_node,
+			    struct fwnode_handle *);
+
+/**
+ * kunit_fwnode_create_software_node() - Create a kunit-managed software node
+ * @test: Test context
+ * @properties: Properties to use to create the new software node
+ * @parent: Parent of this software node
+ *
+ * Create a test-managed software node and return its firmware node handle.
+ * The software node is removed after the test case completes.
+ *
+ * Returns:
+ * Firmware node handle of the newly created software node or IS_ERR() on
+ * failure.
+ */
+struct fwnode_handle *
+kunit_fwnode_create_software_node(struct kunit *test,
+				  const struct property_entry *properties,
+				  const struct fwnode_handle *parent)
+{
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	fwnode = fwnode_create_software_node(properties, parent);
+	if (IS_ERR(fwnode))
+		return fwnode;
+
+	ret = kunit_add_action_or_reset(test, fwnode_remove_software_node_wrapper,
+					fwnode);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return fwnode;
+}
+EXPORT_SYMBOL_GPL(kunit_fwnode_create_software_node);
+
+KUNIT_DEFINE_ACTION_WRAPPER(software_node_unregister_wrapper,
+			    software_node_unregister,
+			    const struct software_node *);
+
+/**
+ * kunit_software_node_register() - Register a kunit-managed software node
+ * @test: Test context
+ * @swnode: Software node to register
+ *
+ * Register a test-managed software node and return its firmware node handle.
+ * The software node is unregistered after the test case completes.
+ *
+ * Returns:
+ * Firmware node handle of the registered software node or IS_ERR() on failure.
+ */
+struct fwnode_handle *
+kunit_software_node_register(struct kunit *test,
+			     const struct software_node *swnode)
+{
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	ret = software_node_register(swnode);
+	if (ret)
+		return ERR_PTR(ret);
+
+	fwnode = software_node_fwnode(swnode);
+	if (WARN_ON(!fwnode))
+		return ERR_PTR(-ENOENT);
+
+	ret = kunit_add_action_or_reset(test, software_node_unregister_wrapper,
+					(void *)swnode);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return fwnode;
+}
+EXPORT_SYMBOL_GPL(kunit_software_node_register);
+
+KUNIT_DEFINE_ACTION_WRAPPER(software_node_unregister_node_group_wrapper,
+			    software_node_unregister_node_group,
+			    const struct software_node *const *);
+
+/**
+ * kunit_software_node_register_node_group() - Register a kunit-managed software node group
+ * @test: Test context
+ * @nodes: Software node group to register
+ *
+ * Register a test-managed software node group. The nodes are unregistered
+ * after the test case completes.
+ *
+ * Returns:
+ * 0 on success, negative error number on failure.
+ */
+int kunit_software_node_register_node_group(struct kunit *test,
+					    const struct software_node *const *nodes)
+{
+	int ret;
+
+	ret = software_node_register_node_group(nodes);
+	if (ret)
+		return ret;
+
+	return kunit_add_action_or_reset(test, software_node_unregister_node_group_wrapper,
+					 (void *)nodes);
+}
+EXPORT_SYMBOL_GPL(kunit_software_node_register_node_group);

-- 
2.47.3


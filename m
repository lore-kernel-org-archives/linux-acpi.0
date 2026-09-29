Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D854E3EF6
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672159; cv=none; b=I3ViefJBdluk7NT/beWU6zovjLkhtD+0hNLGT0g1Xe9ASbrvDvzmiubj3JHt42Kq1/DKakTn3GwbUP+x8TqnaTLnaVFLcywyX0K/qP8J7cu4viDxaciq0rKCP9ZUWcBi77Htte8v2TmmZowwu/TNnGLdyH5b5RQwwYrBPdJipFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672159; c=relaxed/simple;
	bh=dEVdLDnbotYXBDXTQgCpJaXendQL9UIrbDdXDx0UiqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6+iuDyu+02d+6kRyEvul/WF5X6bQkQcvoLtNibw385+R1awVsZsAerYtxy58SRRct8A5rIbbDGk2cesIiWfsG30cQakRPtXFLh8wBlW51hEVX8nPoGu6pI/Ci7iHg1q46s2QKxC3IMDR/c/i5/ylyCa6r9un0yaDckE3goNig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SUfuzJt3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NGtqqc4L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SUfuzJt3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NGtqqc4L"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7Tobx3220592
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 08:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:sender:subject:to; s=qcppdkim1; bh=s4Dp
	Gg6gYN6rQ7jIzV1CefESyYzOIZ1FZ6SSXdL3274=; b=SUfuzJt3BkSW4cVoHqFD
	v/hmWy27vgsfcHBMZCQfBpBlIXpbLQKpGy1J1ZzvbWYg4IzH3dLt6xOB3l7AZcKA
	nRMpj/AOjhJecERm1vtFDtr7sACZyc84MY2qCU0ei/la8jOpshZb/Ba5QBu9BAyS
	vULx5ly+CCS+UVhsAgHyPo6ZUuFXKXHbmdwku1ZEjScgahLNnZFM24U4m2FNXS9l
	sfSyU54IlDT7vWLWOfxVWBc+yzpWfk5sXCFKkp6y5Jvnrg6iZiRviZhJBHObkMSC
	n+BEZ9P5/3sRsw/VqDILPhWfyK99CR3dorF5Ztgik2BEfZzknVfo+VA613REfqFS
	aw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvw23645-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 08:55:56 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso501611eec.1
        for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 01:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790672155; x=1791276955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4DpGg6gYN6rQ7jIzV1CefESyYzOIZ1FZ6SSXdL3274=;
        b=NGtqqc4LgsyYx67gJucKYLl8nJHo45G05yEeiTetcQj10RHzX11kW/UyYeQlLdggJ3
         M6AAOKvjFnBW/zD7LATEYiqA7Xdc6mUjANw3TVlUA1i4j0p0nFvqezwBuxE1m+a+DTiy
         f6sG5P9ppXj2e8f9fzJMeCIoW1RMNiz21HMVwzY91ogyZcUl9cJi2UM81QGLQx9wOlu9
         5GH2xgdiU2rbUQz5B8X2+0aUKjmJETS41k8lKa1KMasPk9g0kwkcxIpH3GftA6gYulo/
         G4MDYi5LR5RIPfgD8yWpJku4MZWy7mj8FF4WGdpf/tcCwXZPX/QwuKN/e2hI9kOptYS6
         /xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790672155; x=1791276955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s4DpGg6gYN6rQ7jIzV1CefESyYzOIZ1FZ6SSXdL3274=;
        b=Pl+vWoBcbPg1PLvmF15xKV0WMBaORJPGTuZFvxJ7RPonKUgtqm8m2K/gPZtlmNWICq
         /etm6JLB5h2RXo/iLaIMSezs8HkxXpvsPIK1WOgEfwXMlLLOyyCZ9APnnoZntHxz37Mq
         qvV5y+mZxDwY1wr4nJVBGIhRtvyJyLoA0Vuhm/mJyJCWS5CM9m0aPWlW4g/jfDG9/ezv
         evJO/F9p21bLTwsTIbmfGDk/OLtNHF7EDekO+ii/XxNdcAlVzPzMbmfeHn4/kHmfiAdO
         AWZW2IuvPkNT22vhap05TCllG2HbfDQmW7mnWVxRZ5UeU7pvqTg9kdXahJC88NZyZjCv
         qBuw==
X-Gm-Message-State: AFuF++lJkBDN3jo56kG/0dszRVB0a6nkTn7ymAkhY9GhHNLdf72cdosO
	21i+hQmC7UIukVhSpeawziaQ4supl99FbusAwH3DaIdHQTMwiW6ZA7WHIlSMK/p97xAA4A6f7WX
	gBJ4O6wumyiHGzWSd6q4EOJIJo170kuJ8NimnvIo558qAy2i2wz93nsl1+v+oBaiigOCy7w3T
X-Gm-Gg: AYBFou1+YoJvMjFHzYliNuyzuSyL+4x/UhMHUHqalrg1p8twP6qZQEPzDtXi6GIsWVf
	Ikm+PE+4s9/3cKjsayuRAEfSI30zmLekTlDa3HEfR9NHYoz5koNUTinjbyftbJHjaLcPc9SOpNf
	v7J64G6swtKCieWL4XuJbGiCyHIUh8W5gD6Wx3KSKIuQCwyCkbgYsCi90qub7CqhIfGLyzrIPvY
	EPc7HECfs4G/TKlsi2OVLwcRuuY+LiIyBD+xRTNn2ydCrNR/Tr2UvyppnMdMrq92kdVfCcI7VQk
	ulWVlxTBk+KSuz36o/ApgksRyFWYSo6XhSQ4oVPWyTPHm79i8EaVYvm5YmUPOK/CHgivKgtU6Yb
	AfDL+avI8RC49ouec931siSpRh8qSiCTVQchxEOEwLjXKlA51NB9XvDjv
X-Received: by 2002:a05:7301:b0f:b0:33b:96b8:3818 with SMTP id 5a478bee46e88-34272a44a3dmr11169846eec.32.1790672155202;
        Tue, 29 Sep 2026 01:55:55 -0700 (PDT)
X-Received: by 2002:a05:7301:b0f:b0:33b:96b8:3818 with SMTP id 5a478bee46e88-34272a44a3dmr11169824eec.32.1790672154533;
        Tue, 29 Sep 2026 01:55:54 -0700 (PDT)
Received: from hu-sunilvl-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144f4eb9esm34294467eec.19.2026.09.29.01.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:55:54 -0700 (PDT)
Sender: Sunil V L <sunil.laxminarasimha@oss.qualcomm.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
X-Google-Original-From: Sunil V L <sunilvl@oss.qualcomm.com
To: linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Mayuresh Chitale <mchitale@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
        Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [RFC PATCH 5/5] hwtracing: rvtrace: Add ACPI support
Date: Tue, 29 Sep 2026 14:25:24 +0530
Message-ID: <20260929085524.1554507-6-sunilvl@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929085524.1554507-1-sunilvl@oss.qualcomm.com>
References: <20260929085524.1554507-1-sunilvl@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=N6i8hG9B c=1 sm=1 tr=0 ts=6abb7d1c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=x5ONKeZPveTsSohF_q4A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: Xkg2nxAy3-ApKPBMAHjnXcNgs1jBF3Ld
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzNSBTYWx0ZWRfXy7APHTWuJsWH
 M5TYTJU2kkkgYwoO5J9flIa2+hGHYbRbvxNQs5k1aNahUZdtivy6Xerv4iiPhlaar/FPUZXUZJD
 xducb+9M7Wpu6Ne3Sh4pDPFApuK/bU68m5WNKYLHknpdDnNuSmQJJW4Qy5qn7cVXBrxqT9nq2Ed
 vVtooYPegY0b242Gn8mpLjhmicClDldxJj49t6TVYM6+dG4VAoaXqTJ0XVWG0OzvnIeQEQzUcPJ
 +anVDmQm3UH3gXgKYCa/vnjc11n3YqORlZ4V5tDVnxxwtRLYXexE+v0rSPx14DZnDOaTEyHy/x2
 mNCMr8nHFhBUzgPdKIiWD6NDtQO/prJrWRYE/d0S/d29/s6tcX+jAn2uLEJjsFlNoJM5AD1N7Bu
 jjS5jSwjqnfLgdDi/ox/WAKBcMREaKfw3llUD5eMGS5IP0BCB+dujio7ShJ/B9yeEOgTHsytQMU
 24i3jhGB9d3/5Kd4P8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzNSBTYWx0ZWRfXykE4z1WQ0Bz7
 tXLAbyG90wokDrj0J1MCaYud03loML5wKI4s3vjHWez6ePzbmSZxiQ1rRdPdCiKv3p5QDUii/A4
 DBfPz/mUSXaXkxhe/xrdrDPZEP8VNMY=
X-Proofpoint-GUID: Xkg2nxAy3-ApKPBMAHjnXcNgs1jBF3Ld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290035

From: Sunil V L <sunilvl@oss.qualcomm.com>

Add ACPI device IDs and ACPI-based CPU binding lookup for rvtrace
platform devices.

Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 drivers/hwtracing/gtrace/rvtrace-platform.c | 60 +++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/hwtracing/gtrace/rvtrace-platform.c b/drivers/hwtracing/gtrace/rvtrace-platform.c
index 12330d9dcddd..44422d429ccf 100644
--- a/drivers/hwtracing/gtrace/rvtrace-platform.c
+++ b/drivers/hwtracing/gtrace/rvtrace-platform.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2026 Qualcomm Technologies, Inc.
  */
 
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/gtrace.h>
 #include <linux/io.h>
@@ -174,6 +175,62 @@ static int rvtrace_parse_inconns(struct gtrace_platform_data *pdata)
 	return ret;
 }
 
+#ifdef CONFIG_ACPI
+#include <acpi/processor.h>
+
+static const struct acpi_device_id rvtrace_platform_acpi_match[] = {
+	{ "RSCV0007", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, rvtrace_platform_acpi_match);
+
+/*
+ * acpi_handle_to_logical_cpuid - Map a given acpi_handle to the
+ * logical CPU id of the corresponding CPU device.
+ *
+ * Returns the logical CPU id when found. Otherwise returns >= nr_cpus_id.
+ */
+static int acpi_handle_to_logical_cpuid(acpi_handle handle)
+{
+	struct acpi_processor *pr;
+	int i;
+
+	for_each_possible_cpu(i) {
+		pr = per_cpu(processors, i);
+		if (pr && pr->handle == handle)
+			break;
+	}
+
+	return i;
+}
+
+static int acpi_rvtrace_get_cpu(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	acpi_handle cpu_handle;
+	acpi_status status;
+	int cpu;
+
+	if (!adev)
+		return -1;
+
+	status = acpi_get_parent(adev->handle, &cpu_handle);
+	if (ACPI_FAILURE(status))
+		return -1;
+
+	cpu = acpi_handle_to_logical_cpuid(cpu_handle);
+	if (cpu >= nr_cpu_ids)
+		return -1;
+
+	return cpu;
+}
+#else
+static int acpi_rvtrace_get_cpu(struct device *dev)
+{
+	return -1;
+}
+#endif
+
 #ifdef CONFIG_OF
 static int of_rvtrace_get_cpu(struct device *dev)
 {
@@ -209,6 +266,8 @@ static int rvtrace_get_cpu(struct device *dev)
 {
 	if (is_of_node(dev_fwnode(dev)))
 		return of_rvtrace_get_cpu(dev);
+	else if (is_acpi_device_node(dev_fwnode(dev)))
+		return acpi_rvtrace_get_cpu(dev);
 
 	return -1;
 }
@@ -308,6 +367,7 @@ static struct platform_driver rvtrace_platform_driver = {
 	.driver = {
 		.name		= "rvtrace",
 		.of_match_table	= rvtrace_platform_match,
+		.acpi_match_table = ACPI_PTR(rvtrace_platform_acpi_match),
 	},
 	.probe = rvtrace_platform_probe,
 	.remove = rvtrace_platform_remove,
-- 
2.43.0


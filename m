Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D733659F9
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226358; cv=none; b=JORSdZACawqzyRTVszLSOchxFkm4WRP73CjwgR0o+0Zx4v4T/nfgEoA/RxI5Dg+I5QY+4OXAGc83t8OhLODPpV4LoLY8Mgz5eYBuDzMgM1cWDJAiT9pcRUISEeXeV1L9l3JzHQU5j4SDp9rtvkIiKmmcMKqk7RnglhmWbXc0w5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226358; c=relaxed/simple;
	bh=d3wRfKF28EPq+1ZOXUti8UPQystJWF5BefGu7E0Hn1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OT+vI5LIH/Fq1w/RiFN3G7JM/Rj1APAgLNw471/A9bFNlkeXUN4QZOAkg7NXmYoaTBKlj+BG/VBXtIMwQ9cCOVJaXrww5ostnv2QAMYYU36W/6d1wz/9BcImTxZBv4sWy4F0gzyhiYulhRDcHyqjmwhIjFG97Y6EoDDTQcH15co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DXZGyW9L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CZIvvC94; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DXZGyW9L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CZIvvC94"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBZgUG4052508
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=C1FY2EChGfq
	SXR78BU/386kT2GGSnyM0vTeoZn3970w=; b=DXZGyW9LGK4Bbq0ZYIXSXtGIeTV
	B1a93cX3A8EoZ48kiB2jGn3pwQkWsKZtiYncnYkbx6svY6FKgkAHGSsUaKf1sVGo
	jhvD7JeLrg63EOFGxFKqXY6SCfh77zPjx8wP26jEquWky51zimEZYP3lR3cVsoTf
	6lvMHnDreeC8SqDEWZ5iCNh3cHVWuUMGtAZIqjvoR25WXLlp7jBxXptb9hbhXldG
	Dg+ExgC3iK3aweBJgBWVi8lV2GPpE9aBgvmjN7lodOW9/j5OmFW7CnHDwWjQkw+S
	j9tIbu5nQlTOdUE6/dXeiCtyappMZxfO9jFzWKHp1MKpVcmOtysN/wRl0RQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr9ys394-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:36 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6cf37fe12faso3135462137.0
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 07:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782226355; x=1782831155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1FY2EChGfqSXR78BU/386kT2GGSnyM0vTeoZn3970w=;
        b=CZIvvC94X0gxzeDhskopWhJ9Jab82lDhuKFtfc1zrSu9qeI5ZheRGDeWxX+nuBkMgW
         P9OkG22Hs0cmXbRr1EO0Of+8pmfNKgBVuYZhO0slpOuZ4UDwCn7jxuLNB901LZ4/pRsh
         4PCEkGWOvUhD2PNYJ4AOTIBriSfNVQU9Rd+zf7SnvxoQI4wQtWLc4oSb9uABY+FDjTOI
         LN2V5fKg2BpLTv1230+7Z8UCrazCSuzXtGMmfDLK736YytB5wD1om3fV43dShAKEKPmD
         zj9YIXg29Sd/HA+2XrcOnljtxI6nSityYyNBnECESmBj0El7vBpPqv5Ko1wWkvJYVTqj
         aA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226355; x=1782831155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C1FY2EChGfqSXR78BU/386kT2GGSnyM0vTeoZn3970w=;
        b=k3pwjzBDeWLIPjnkqf39AqIgfI5YTd+FzrEAuPFyt27hbfIxIXwxONaDXf2bMp7Pqx
         +Ojcl0I2Gt4RrBlfwfPEOveB4Ip9QXFGuJh9pspElOXim0S3GpWp4AEAkdWjUAit43/4
         q3Zv212oVR+S7I3sk7ev9MTyhZVsSA8y2E+uJH5uQmImB47FfVuTs7OUzD8q23StkvFj
         2qZkNZagwbPwcs4tpOtAM0ETyU0wCtOo7T5W9dI7FBoLowCg7jWtHgF0TIp+KJI+URp0
         +SP2Y5wESyn7d2Wsgv7dN6JY9WXv8tJz8AlNtc3xUARqjinVMHClaOjyzB68KvM63WEV
         RwhQ==
X-Forwarded-Encrypted: i=1; AFNElJ9d/xhlRmv9J3PZeC6wdwKe468Epmk5cHAWgCf5WN6nEmaiMxxWpQNuTKrE8siPYKKM0K/OiDEhFSZ3@vger.kernel.org
X-Gm-Message-State: AOJu0YyBWph7cLTVYx+xZ7+AFVz9J1RvO3PRH8MZt5Pudb06L6fkN8QA
	CED0dW5Qzrc4v/tYgIwngDq7u8HLtGZhka8I1q64qHq4uwcRqqKAHHGpBUSHFP46dFmrOc6Yznj
	STlbC+EMeITMml6eXFNphctlPXE73dswCsy8b6hBF1p+mKMtLBpHBH/WAo5Acs9rj
X-Gm-Gg: AfdE7cl9faX7jCuDIW86Q8YBqN8Wyaa3F9xZ9a264RVE170pCd77dyO6ULpcnfeRXd4
	ORUWdROfGB/UzvCHP4K/fYyM9adRu7sGPDRWjZ25NXbeO+e+TyJDWHYfEmPeLgqAVTfQdEgwHuF
	lpd7JzS7+n6YF1yw3NgEbGSZHtv0AZACiGShlu2ATjtnYLp2VXDzMKqRxdGNMChCTIGAhg+JSkD
	/8BuLrxO7q8vtrb2Iu8Hqnmza+WmZziqdtCKuvPibQ9IQ1K3ThnPnAw4nte3zp+pTrYpAJ4082G
	+I1G/Mn4rNqhoixBMrNSmN+cv44I/L73EfdtdJKCRr38U3rJoFmxBrn527BPCa5H8Mu/DBhUOLx
	x4Bi/UQ/urTQcsxCYnmBzxf0OhbifIw9TobTMhesQnn5zKHkcseEnfoOWjVxdt909aV6+T5LROJ
	GVne8r56On1wRZsf/pph2KsbeJMQ==
X-Received: by 2002:a05:6102:3e09:b0:634:d42d:15e2 with SMTP id ada2fe7eead31-72ff7195e5amr1586003137.26.1782226355384;
        Tue, 23 Jun 2026 07:52:35 -0700 (PDT)
X-Received: by 2002:a05:6102:3e09:b0:634:d42d:15e2 with SMTP id ada2fe7eead31-72ff7195e5amr1585976137.26.1782226354952;
        Tue, 23 Jun 2026 07:52:34 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60aca46csm534042666b.36.2026.06.23.07.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:52:33 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [RFC 04/12] ACPI: Add helpers for dealing with ACPI fwnode as secondary fwnode
Date: Tue, 23 Jun 2026 16:52:17 +0200
Message-ID: <20260623145225.143218-5-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
References: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JYSMa0KV c=1 sm=1 tr=0 ts=6a3a9db4 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=9gDGnDraTdPISYb5DTAA:9
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: Njrtw3UAhPMigosdzjeXQ---SaB9BVmB
X-Proofpoint-ORIG-GUID: Njrtw3UAhPMigosdzjeXQ---SaB9BVmB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX8sRJUI1uxNkJ
 PFuef/b7cNXTvvOsBKACwAllttW8VModO0xTPs1SyxzTj9W/PCNYMjEbLMAg4CKFzDjlaudXjUx
 VHnKouuaHiS5m+JQgtiQUyt9pXyoYJIGIIZ0NC0MdT25leXoD3ql6wjBw2sElmIFts7Iau/eNKs
 f53zrswOTLhvV0ymWwjSXFQKaVIcjGpZuCbrQvsOSA2XMSF5+v+zLIHCR+ljpTIVAvQ9wFeKEad
 xQRAQMzpygK4YV5I2lEGJiq6bOP/AR3LpqjqkvoIOCLc7FhEzSEn574VeA6VozRUUSz0bOm+TXt
 1BoWR8t8ZshSTE8LOo7PpGyt9AeQgabWHZeeVpsKEUe9iQgowpU6Np8U+KVbyEdMhMEZRpmsyI5
 CnItyRzxYAyOp/gTKlG0CZyq0olm57cTlXngQewJjJguoqpS6r7ASjNo5x9ZVh9nfXQ0f8TRAjH
 ZwvQ+tYsJNgmmXNsUYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX8mXwy9sZLOio
 yuxo1/S8Fxhf/AuOvCU1mZAJF2SNIax2AtOzFYpBAghYGwLuutbpP5W27yza6yjQBVWYQ1m0YVT
 qoLxVciv+u8DnP+y9i6gkG86bkygicw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230122

In DT-ACPI hybrid mode in some cases code calling is_acpi_device_node() or
to_acpi_device_node() may also want the secondary fwnode to be used.

DT-ACPI hybrid mode is something which subsystems / drivers should opt-in
to, so it is undesirable to make existing helpers use the secondary fwnode.

Add new is_acpi_device_node_any() and to_acpi_device_node_any() helpers
which also use the secondary fwnode.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/acpi/property.c | 13 +++++++++++++
 include/acpi/acpi_bus.h | 16 ++++++++++++++++
 include/linux/acpi.h    | 10 ++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 8ee5a1f0eb48..fb555e50ce83 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1775,6 +1775,19 @@ bool is_acpi_device_node(const struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL(is_acpi_device_node);
 
+/* Like is_acpi_device_node() but also check the secondary fwnode */
+bool is_acpi_device_node_any(const struct fwnode_handle *fwnode)
+{
+	if (IS_ERR_OR_NULL(fwnode))
+		return false;
+
+	if (fwnode->ops == &acpi_device_fwnode_ops)
+		return true;
+
+	return is_acpi_device_node(fwnode->secondary);
+}
+EXPORT_SYMBOL(is_acpi_device_node_any);
+
 bool is_acpi_data_node(const struct fwnode_handle *fwnode)
 {
 	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &acpi_data_fwnode_ops;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c41d9a7565cf..bfc3883765f1 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -515,6 +515,7 @@ extern const struct fwnode_operations acpi_data_fwnode_ops;
 extern const struct fwnode_operations acpi_static_fwnode_ops;
 
 bool is_acpi_device_node(const struct fwnode_handle *fwnode);
+bool is_acpi_device_node_any(const struct fwnode_handle *fwnode);
 bool is_acpi_data_node(const struct fwnode_handle *fwnode);
 
 static inline bool is_acpi_node(const struct fwnode_handle *fwnode)
@@ -532,6 +533,21 @@ static inline bool is_acpi_node(const struct fwnode_handle *fwnode)
 			NULL;						\
 	})
 
+/* Like to_acpi_device_node() but also check the secondary fwnode */
+#define to_acpi_device_node_any(__fwnode)				\
+	({								\
+		typeof(__fwnode) __to_acpi_device_node_fwnode = __fwnode; \
+									\
+		IS_ERR_OR_NULL(__to_acpi_device_node_fwnode) ? NULL :	\
+		is_acpi_device_node(__to_acpi_device_node_fwnode) ?	\
+			container_of(__to_acpi_device_node_fwnode,	\
+				     struct acpi_device, fwnode) :	\
+		is_acpi_device_node(__to_acpi_device_node_fwnode->secondary) ? \
+			container_of(__to_acpi_device_node_fwnode->secondary, \
+				     struct acpi_device, fwnode) :	\
+			NULL;						\
+	})
+
 #define to_acpi_data_node(__fwnode)					\
 	({								\
 		typeof(__fwnode) __to_acpi_data_node_fwnode = __fwnode;	\
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 67effb91fa98..bb84774f61df 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -865,11 +865,21 @@ static inline bool is_acpi_device_node(const struct fwnode_handle *fwnode)
 	return false;
 }
 
+static inline bool is_acpi_device_node_any(const struct fwnode_handle *fwnode)
+{
+	return false;
+}
+
 static inline struct acpi_device *to_acpi_device_node(const struct fwnode_handle *fwnode)
 {
 	return NULL;
 }
 
+static inline struct acpi_device *to_acpi_device_node_any(const struct fwnode_handle *fwnode)
+{
+	return NULL;
+}
+
 static inline bool is_acpi_data_node(const struct fwnode_handle *fwnode)
 {
 	return false;
-- 
2.54.0


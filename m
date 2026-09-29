Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C664DA9C3
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672146; cv=none; b=IFFDK4z54y28hphKHqy8i1f2cv1/U2XduE+miDQBEm8NJagtNXUsVKORxQv5EKMQRIWLUiEl+ENb/+85Rvuk/wtCbpwnWfA0Xd9WKG20ezLZelKgFl8LDjq9Cr2VEBpWEzNecnb4K25Fkwp3z1guuB0tK01Sa/zec67ru7MZ5wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672146; c=relaxed/simple;
	bh=ZkLHIXs7+HW6LkpZ1T+1oegyTpFFA0Cf8FjTsH1b6tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNljhxNvbwoR0VKidqCmAbb/lbROm8bRhf0/XSt/RHczTfpO5FdB/M93vTIl53cczry4iZn3+GA73PmgrVrUT/Xo1yDlPB5X+wlBIY17UVfs2I/JdQkC+dXymMWAqDsUxmTEeNMP4jAarELnFRf8CJA+IO2O9bScZSev1MOebNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d+HCvsK8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a1uwL/wz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d+HCvsK8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a1uwL/wz"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7U3mj3127867
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 08:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:sender:subject:to; s=qcppdkim1; bh=D0fd
	WJiPI4zTrPZPiW/54gX7rmk7pvMm7nCasduv66A=; b=d+HCvsK8rkfRgbKlSJjz
	mF9Kp8cBsvtLgH6rtfrYXKyptCwLdfqHxfD4me04YjP9boM6gjfhOZdzoPIpW4K6
	FcVwRgrJBJ6oun3tAFMH1/d4cUoaodzHYX4o+5c5wirjEQaia1pBrofd9okGb/qo
	cqtShsdD75+3oxya1hvWtudUm+dZiyWS92Avy9+FqIndG6NR9VjWk6+iNW3oXhKu
	4NdctLqahlfSPQXbxGudX5Xpn3VQHo7Tzu/nMJJvo8Ci5P+MpzqFEtFh4nLuVJEC
	OfORIcpAEUI2snjhp67Ww6wtuyWuLZDRltpRPDm7h5TNC10bmq6PMRYvjx/e/Z8s
	5w==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mjhs9y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 08:55:42 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1438492fb40so567267c88.1
        for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 01:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790672142; x=1791276942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D0fdWJiPI4zTrPZPiW/54gX7rmk7pvMm7nCasduv66A=;
        b=a1uwL/wzYcM5sJ090qAuO4JGI6XLa1qnttzXDFJ4Zpkm4yzHDDAC3Yji6DnzuEXGsZ
         SYQjwV+IlWn0pB+bjUDk0cZmHg6MAZiIH+BpFyLdUpQF88VlC50UTbIWe5UrGfxyef+N
         DbB4W+mgOeMtLyTidu0tIPlLIHAPmtPwNMNVOe1aePzBKUqcx2lVgY8RESQLpfztjTCJ
         iuaXCZE/LTyOfvj3zhNsLTVUWJOEzB/Yf8fIbiQbEuWKpASuZGt/K5+Vf7STI8kgEdVQ
         5ZQYG7yy8uhGRVpwmOMNFKE8P/dlfQZme1CbLbWLOtPb+AsLYLHlFQ+9Ux1ldxaw7wx9
         U8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790672142; x=1791276942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D0fdWJiPI4zTrPZPiW/54gX7rmk7pvMm7nCasduv66A=;
        b=HeqI3eu185PAVxQVrOGcgBHr710zSAwxmYa23c+u9dNuPConQW0GJwuCpV9xhPpjvR
         rwRaTQ4QH5ZuxBGo/Z4+iv2KRZ7+47pqizqEXJTypXSxq/L0XPG/5Fd745ISfVQL+LtT
         zlzwyQ8aQ97S2tWs9JQPUfUIyM5nLFRe6M4v1AcWtzRgt9Cm+U1WJkxiJh8SzmRBd1ys
         tmcQBWIV+Th4M4zDEdpSv191Sugh/bT5Q5PQ8QTRLQ786HbBFnv6gabovAnl5y6a67Sp
         dAi+p5DxrWUQ5qfa73GC0uHpjUgrkTZ1gUfxKGjdjqaQxo2EkdAQi2KDp/pjBwpqi7gH
         mVhA==
X-Gm-Message-State: AFuF++lVFahpkQFKcELWXgjsuOnMbdGAMOzr3LSy5Wxbi14Kso0xmAkQ
	zKtZYixD3W4aaYCIAEI/xqaf+e9gGbIZ60WTgBV6jkMafyPZ9OebYhOJVUPGegWBTe4xZdOtgEd
	WGX8Zi17hCjfuhkDBcjHKO/kxMfHNLz6wwtFzQL96cU5fGLZNk0dF2jwoushaGUbHcDRWpcpM
X-Gm-Gg: AYBFou1HMZL1lqTJ87b9pJAOChPxOcQj++Bk0ab0ThXXd+xSDoyxXg4r+yKVknbwbBK
	foC6v0WPdkxmF2jCry7g1pdeUIH43XkS1v+XCfwpw/bjvvtULy2tZ0AT/QR0k4aUJpzzdj+HZPI
	Jss8PIq5q3SVTdi2RjKddFzF1tBbRyk1/t0A5qjf9rzPS21qRB1Q3Qe4/UE+rK8dv2rGyZY9bJ/
	nsPjuw0M1LoRjzQ7819YgnXysjCTQMRhQiLhLf0e1IEkoFrXNM8VL/AU8fPPnk7BlBEeis9X/00
	G2sGD8AqhVlnq5Dz+yJZFtarvOvxD+MEhgv43OZzyRANflU5iTTGPIjoPEscOhRDPzjwp6RyhOv
	ZPOQna4sEpSpoI0lYpF5bq0sNAGBm57d77Y4thBYmTehga2lvesNZ+L8u
X-Received: by 2002:a05:701b:4593:b0:14a:88ce:74fc with SMTP id a92af1059eb24-14a88ce7a2bmr4402870c88.41.1790672141686;
        Tue, 29 Sep 2026 01:55:41 -0700 (PDT)
X-Received: by 2002:a05:701b:4593:b0:14a:88ce:74fc with SMTP id a92af1059eb24-14a88ce7a2bmr4402845c88.41.1790672141119;
        Tue, 29 Sep 2026 01:55:41 -0700 (PDT)
Received: from hu-sunilvl-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144f4eb9esm34294467eec.19.2026.09.29.01.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:55:40 -0700 (PDT)
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
Subject: [RFC PATCH 2/5] ACPI: property: Add ports/in-ports/out-ports support to acpi_fwnode_get_parent()
Date: Tue, 29 Sep 2026 14:25:21 +0530
Message-ID: <20260929085524.1554507-3-sunilvl@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzNSBTYWx0ZWRfX/adTxchESPV8
 x/Ya5f2XWUUQ4bJdNznNomA8YB5x5XMwT2DuMge2ivK+s4M8z71YzCOYbVWLENco65HO0PVVqFh
 M0qqLjXAPmpZB1dO6pyXNc2DLFXam7fCn+yTAFx1yZ0avq3kYrAFvKzn/fSAlmZ2kte3kOgEWRi
 DeS4JR4+ScwulHSwaWtMzSvGBTMTq6SV6WrWjGzr2Bi++4bLS6mVgsJJ74r1v1y2xR4WLaML1xa
 hvg7jyoUHd0vvjnv4UyCHO9rGequiAijS6guaOgiV2Jv/PAb/R4pjSnRvopufkvvIYnIlidPPjB
 RabASPhoZ7cJaEWH2sqAenjOx0cHtfxVex/IT5xa6VwQFjV62QnHOzGXlMkhymiPG8xjq4d87sk
 0s0yq0nB9E3vaxQIPikgM7jmfZM8GhXlTFcUbBCIMcM52AuaC94fLfz7RMEHQ7s3sd4YfXbvMKH
 oEiuc+BrbLzUBw7HodA==
X-Authority-Analysis: v=2.4 cv=OdgNnRTY c=1 sm=1 tr=0 ts=6abb7d0e cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=UbLugLop3-FzA3s5YSgA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzNSBTYWx0ZWRfX4bpKLtgXxi9y
 i7DGWdMptIMPTwHqPDPVQfoDg3oRYhtpWqKu9dvOAnnXLCO5frx6IySb77MQvPJoI4GOlx6iXMm
 l6uLs4Au4S9e/rq311d9MfTW4vF96yM=
X-Proofpoint-ORIG-GUID: 3bcP-ucSTWH1xCGjBxjnyj-4Ba5MMiC9
X-Proofpoint-GUID: 3bcP-ucSTWH1xCGjBxjnyj-4Ba5MMiC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290035

From: Sunil V L <sunilvl@oss.qualcomm.com>

For collections of ports, the node name may be defined as "ports",
"in-ports", or "out-ports". Currently, acpi_fwnode_get_parent() does
not handle these container nodes, which can lead to incorrect parent
resolution when parsing remote-endpoints via common fwnode_* interfaces.

Extend acpi_fwnode_get_parent() to recognize "ports", "in-ports", and
"out-ports" as container nodes and ensure the correct parent node is
returned.

Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 drivers/acpi/property.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 8ee5a1f0eb48..78400620390b 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1422,7 +1422,7 @@ static struct fwnode_handle *
 acpi_node_get_parent(const struct fwnode_handle *fwnode)
 {
 	if (is_acpi_data_node(fwnode)) {
-		/* All data nodes have parent pointer so just return that */
+		/* Keep the structural parent for generic fwnode iteration. */
 		return to_acpi_data_node(fwnode)->parent;
 	}
 	if (is_acpi_device_node(fwnode)) {
@@ -1703,7 +1703,19 @@ acpi_fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
 static struct fwnode_handle *
 acpi_fwnode_get_parent(struct fwnode_handle *fwnode)
 {
-	return acpi_node_get_parent(fwnode);
+	struct fwnode_handle *parent;
+	const char *name;
+
+	parent = acpi_node_get_parent(fwnode);
+	if (!is_acpi_data_node(parent))
+		return parent;
+
+	name = to_acpi_data_node(parent)->name;
+	if (!strcmp(name, "ports") || !strcmp(name, "in-ports") ||
+	    !strcmp(name, "out-ports"))
+		return acpi_node_get_parent(parent);
+
+	return parent;
 }
 
 static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
-- 
2.43.0


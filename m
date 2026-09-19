Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDC8263F4A
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789821976; cv=none; b=oNQN+wtx21ZnPFL9vdLI+MH3OPfhYK/WFHymq4FbPz2X8BtyqANU1fYVdjI9R69xN5QAKRTFEpPJ5mmKATxz+66p7c0V7xiuhYTHDvnWZZPdRuww/3y6BtB5PDBQZ8/4gsdAV2z3q+W4YecUNSS0fbbijmrCfp7DzssNKfzOIjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789821976; c=relaxed/simple;
	bh=vgE0Mmesbv6tQUQOAfvzLiainwTS/qhj7cyY6kd2PQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcNFyNfZZVjjMv0bqrOuG5FhZPT6h1FnFqXGvQhmV5vvQ3D5K5cNjnbHlEHBmzWgfgolgkLZz07/4xHJ8HxrMJIoAO88coOsU0e3LfPxaPypSZ0gY1cilmzbqjBRS4Rh7e1TvmbBgVaT0RPkp2/+w5KXEPhhmHXFop81fs46gWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V9QxDIPY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KmbRHsbg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V9QxDIPY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KmbRHsbg"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J9tm0s3499744
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 12:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9nnTIvUKnCp
	FbJXrlORWfxfx9lzBK7RinirDRHI7T9I=; b=V9QxDIPYm+pZUpW3IK9VBSIz4uz
	cFcctLAA6hZGKMI8J5pYhjD5q4Rrh7JCFSmaxFayqrqDgpAoCDQMIt1o8qwRHsf+
	nVkrH1XX0/6SwVttxbIBVZSTne6+5TAZA100NMBYKinDVqjpqLhhqUBXz5E7u/X5
	5vh/KV2PAwHiZ7Yf/KatVa3HSIIYDPBF2YMItjoq+IPFVv6dqQtdkfy609+kiLqZ
	NsXIdQiXzxIO8hdyMCF2Z53r0LtCtMX2ARoV6A5K0RcUh8MkkDvu2ZVa+OEz085C
	MUEuoa88ZQ1g0bZgBETadrCWS8J9kTtJtfo62iJDz2rRMrwV0ubSIWSH1QQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsjm30w2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 12:46:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ae8e7e546so363335785a.1
        for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789821974; x=1790426774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9nnTIvUKnCpFbJXrlORWfxfx9lzBK7RinirDRHI7T9I=;
        b=KmbRHsbgwp7KXxDtnWnUfRfzq+Zw95a+R8nkafHi+OtuzEDzek9IejWt0x/l9CuzIn
         RNPpoLRoliIN1qCNSH9Vpso7hqFzpAW67jGpiiGp9vCx08eXC7DKvroK7JGRb5ErmIp4
         LqjMl2hYcgNyrVbiVk4vzEGFni7Uyh+Z4wwgI5xcNVi6IhVAZhCmkMb30nVXZdS9M0da
         jrwJ1Lm9cNdRs/+iHqWdLH7l0LSDfCSTCZnM87WX4yv2zk4jlC8N4TQRC9uewjaiQgUd
         YuZtmpXbNP8IgS8JS52/0o9NILK5Akfai6kTJx5KKlr0eOazdDaIun9C7mL22h7Jxl8B
         wsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789821974; x=1790426774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9nnTIvUKnCpFbJXrlORWfxfx9lzBK7RinirDRHI7T9I=;
        b=klVlU9fdPdoAyjXiuOMCO2p5Ah6/tQ7sd00e4rHvOLA1KEuRaxnv2QnaizkEHU45gj
         +GnuKj0eLgOcz2bAA2cGOionXW9mXQ42PLeuk6h8xkekdBOiNw3m+YdntIshTkdmwoIO
         4btAoqs+9L1AXMioeKI2zv47zpTtstvImAXniUR7aTEx0js23V6GqBeGqeNtjur0/wDe
         vjEsapU5hLSyAHZd2Qq+yQhurPTM2okr+GmQQ3XTGvHjjzQF1AZlvk2qiDeVhd+Qr4k7
         WhGJA/KEBTNKalejiNNOmSfu/xJ5J/oMxTx2mp1NwtrHdWu5x5NGadujIwNKpWH9F69w
         cHeQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9ujc+siSjrkI+uIxvTIpQ/yUwWwpfmmAu8I/YdcHU4G3hgu3N6XrnbrW274VVAzffCHIYfGGTPz0Y@vger.kernel.org
X-Gm-Message-State: AFuF++nCtB7gtNdf7FZp7NHjGIkmZqQUB2vNTSH3pKUjfgKQKLI0xZa7
	dqUrQ2kIAO7WPxQdCt47PLlB+zP/Sfg/0yj993XZQK0hX8bvp0/U0rWCTYd58RjdXXh/Mo1/WfT
	6BFR9TR9BE1YFzC4ptfxxDE0zUNPW7fGbzvGeieGMf8yiKJ2kJh+i0/suo1vC/Fln
X-Gm-Gg: AYBFou1zGCk8Zys3Lv0zv4//yqv0+qAB34MBkJ6iquif9FUtexSMJD4Af75DA/Gnff3
	aQXvin554FH0DNzQfNqdz9lGDCFy3GfgB+sl++j+AuWwj9aOjTGSiN5orgNkAJ1vpY9108mQEyu
	7HOYByxJ0Ypnd7LZTiObyffM08AeaU5rFl72NY4OPgO3w3QK6RCGFlIXIeEOWkHw2Yzl6rM2QWU
	cVsBAPd67xfWJ/fYLrNhPbdHI8i1emG7WLDobcLLPbci7LWKtg5feknM6At7F44JJERHpBUYYe4
	6Lw5l59CKP8kEKJbSoVJ9UJIUnAX3+AtJ1DD9UcBuF/ObW+6Oi0peQtXZx8upHKR7uwH3M7drfX
	IbYRMQJjZbwYQ5LytF30g5bmi9BiCH5HKgkqXYNlsz/+t1/qBLhf+1MVy5oVVs7J7TGXeyrVhjl
	8sFGbUs8qNBOdJJg==
X-Received: by 2002:a05:620a:2983:b0:939:fce2:d4b6 with SMTP id af79cd13be357-93bf5717a9fmr124985885a.38.1789821973594;
        Sat, 19 Sep 2026 05:46:13 -0700 (PDT)
X-Received: by 2002:a05:620a:2983:b0:939:fce2:d4b6 with SMTP id af79cd13be357-93bf5717a9fmr124983385a.38.1789821973194;
        Sat, 19 Sep 2026 05:46:13 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67dbaf0esm1332269a12.15.2026.09.19.05.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:46:12 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [RFC 2/2] ACPI: scan: Handle _DEP for thermal devices
Date: Sat, 19 Sep 2026 14:46:05 +0200
Message-ID: <20260919124605.12429-3-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919124605.12429-1-johannes.goede@oss.qualcomm.com>
References: <20260919124605.12429-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RiA6z0u37To7ceiOKlgTZ5fVsy9NRNCM
X-Proofpoint-GUID: RiA6z0u37To7ceiOKlgTZ5fVsy9NRNCM
X-Authority-Analysis: v=2.4 cv=DtfDa2/+ c=1 sm=1 tr=0 ts=6aae8416 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=zW5CBF21oHhVjbq58mIA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDE4NCBTYWx0ZWRfXwokwfmiE11xV
 jyuiFeh0akIMR58Q9Oh4uYpNmshEgewW7saI9awwsrKg9KNiBAHn0jUytyM0TVW0s6QCnQq5XYa
 GEQhcifcENBvuHxwNYmYGaJB6yP7+dLNRuHDom+tNKcadmEigwEpvlzQhBD479gbnE6zvuvpFbo
 zjdAhRgu8CkTkTYQu3kfZ6l12KubFuWsNX1/BLHzlZnd04EHevwTurVsM+rXQVLoYnjvI+9Lw7O
 +lb5c1uu8DtQwN/pU0tbfwc/p//aNZ1jBnkhXpHQZOdtkZGNrInK2/fZvbxXhldKpGlh5GKmDio
 /EcWb9uOwaLH06hia1XQ6zPlO08nEcSZCDW/tpY+VBBWGVKQdz7tAN9o51pTtngup6nz8ZpCiA9
 rIuEM9CpEqbC2yCHyQ4f/QIY2Jvaw7JQfwU+rCc5xrQIssxKo4VnuMtG1x+OKblRerYafUVvIzY
 jwHa9WkvzMu4Qo3zG9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDE4NCBTYWx0ZWRfX0V2aNgzYqcIg
 3uhHLXzsYoDUR7wMet6Xxp8TaMO2tlfvXGyea1aoeh1AmdPNOr93lNSUEh1JAaMQkp1oV4XB3jZ
 KPID9ThcH82XMbVPmmdkEeX5Jj7HD4k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190184

Add _DEP handling for thermal devices. Just like with normal devices this
will only delay enumeration for devices with dependencies on devices
which are in the acpi_honor_dep_ids[] list.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/acpi/scan.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 38ac6c470a9f..af2bd6cc51b8 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1874,7 +1874,7 @@ static int acpi_add_single_object(struct acpi_device **child,
 
 	acpi_init_device_object(device, handle, type, acpi_device_release);
 
-	if (type == ACPI_BUS_TYPE_DEVICE && dep_init) {
+	if ((type == ACPI_BUS_TYPE_DEVICE || type == ACPI_BUS_TYPE_THERMAL) && dep_init) {
 		mutex_lock(&acpi_dep_list_lock);
 		/*
 		 * Hold the lock until the acpi_tie_acpi_dev() call
@@ -2074,7 +2074,7 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
 
 u32 __weak arch_acpi_add_auto_dep(acpi_handle handle) { return 0; }
 
-static u32 acpi_scan_check_dep(acpi_handle handle)
+static u32 acpi_scan_check_dep(acpi_handle handle, acpi_object_type acpi_type)
 {
 	struct acpi_handle_list dep_devices;
 	u32 count = 0;
@@ -2094,7 +2094,8 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 	 * 2. ACPI nodes describing USB ports.
 	 * Still, checking for _HID catches more then just these cases ...
 	 */
-	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
+	if (!acpi_has_method(handle, "_DEP") ||
+	    (acpi_type == ACPI_TYPE_DEVICE && !acpi_has_method(handle, "_HID")))
 		return count;
 
 	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
@@ -2134,7 +2135,7 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool first_pass,
 			acpi_mipi_check_crs_csi2(handle);
 
 			/* Bail out if there are dependencies. */
-			if (acpi_scan_check_dep(handle) > 0) {
+			if (acpi_scan_check_dep(handle, acpi_type) > 0) {
 				/*
 				 * The entire CSI-2 connection graph needs to be
 				 * extracted before any drivers or scan handlers
@@ -2160,6 +2161,10 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool first_pass,
 		break;
 
 	case ACPI_TYPE_THERMAL:
+		/* Bail out if there are dependencies. */
+		if (first_pass && acpi_scan_check_dep(handle, acpi_type) > 0)
+			return AE_CTRL_DEPTH;
+
 		type = ACPI_BUS_TYPE_THERMAL;
 		break;
 
-- 
2.55.0


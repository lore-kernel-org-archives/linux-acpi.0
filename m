Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BDA432BF5
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235503; cv=none; b=PC5xVPeq/vi7j0ZJvBNB5urbp+XFE+CZJUNGNBQpGZa97GZlfqyCC030dt3nZO6g8HZGrHl1UhJp0QgCKAEqbLtPIdR4BDdPrLo6rN+u6qjvnZ4s56RdpD6WS27vwOayZ8MzVKLiy50TZiX4Geo9c7UZ/42A718xmh5Gm1pDBlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235503; c=relaxed/simple;
	bh=8XXN0JGE+aNQHVmkja0kyVPhb+92/XFFTPds/Qxn2ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ipv3OhLyFePi8ljxqgRDdH1yi+K5RWzQNIjWza5USt3xIpS80qGMEKi+MY18sNMw8yYs226eCpaD9tI9MZUDHQ0xhIl877Q8do64XbF/GfxXM72WW+R8haDLk05ZtbcMcb2IKZ/EpqJZJZUKL2Q0WDhDniYXjnj9kMYtlIyRMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YvApSJIg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ets1Npql; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YvApSJIg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ets1Npql"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O62OWe1475976
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 07:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LEuz0IYkO3v
	v3NkIV9hKvUGxpNw0DLo4XFrqlBEvznA=; b=YvApSJIg26yiUkCIqtY49o2Rn2S
	RQZLEU/0abNuxebWy1i691/5YtILrNLLRVrmrdr0Zs/dvgXDOj+HT1Mx7i7YvCwt
	VqSJ00sq6XIdnsMNrLa38U96SbH/QtvcrCz5HRZXMI+OWyOQb3tcIE5Se/zls/z9
	fH5r+OhALjcfF/bOM0BCBSouBgsqHyNKQGnx5ANzOTZi57NUdzqw1TbwZOetXhHP
	mUAuO9IzAK+kwKxdqvtlSAQ0RNPttMR6f8ilttFqK9QY/j1+4UCSTPnbPIMC/Xih
	DTcrRfL0m7D2nGcBTIifQyTDXcGFmkdVdj7UwWe+NdWfMzZI4uxzAc9WlcA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvx8agccj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 07:38:21 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso3003582eec.1
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 00:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790235501; x=1790840301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LEuz0IYkO3vv3NkIV9hKvUGxpNw0DLo4XFrqlBEvznA=;
        b=ets1NpqlscO1T3uA/0Alo9c2dhy4krM2SDudK5tv8DgPtV95p1PStGBwD9pKhJBqat
         cHppZSUgsPO4oKqiKf8r7MD/gqwFaY0g0xsBF2K95z8EREyGpUl2TC6ui6y37GGO7n7N
         K9HuLX/fawDDTB7FfglxdK2efGd1vcPmftjPMR4wgw9DmbYjiJ0AOJnOyaknoLZ8T5jr
         9S0kHNCM80r4xEWQZfjns13thRjcxGX9oOzwSP7Zq4uCYL6h4+E8Jh8RQpDD3nelg/Lc
         zkaRL++c5IJtQbtgNocDwlR2cgSoHjxFvz5puEGT1Sd+DyYiAJWVmEiLWZg9MTke8KLQ
         vadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235501; x=1790840301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LEuz0IYkO3vv3NkIV9hKvUGxpNw0DLo4XFrqlBEvznA=;
        b=Dq9vRWXjhZ+bFXO5pRnq5monO1kWpOWr75sCp7LWPbQ1x2MDGj2PSJft5ENVcGiXXR
         TbumbAuBP44guiwy8Ub46BmUBdctXRNHAHWsHbJV18LT7Vvqox5jpNQdPqlpUyNxZ0Hk
         djNH/8yTL8n1SnE+aD76PZb+8Be9ZJtilv2WYWqn6ylo8ozCXjzA2nMsadRfRsn6wF1O
         ryK5o6t9j5iReMXa+Q638kco/cl2o/nc1y0dw9h4X18YdJXAUOfsR+7dX0wFEER9LN9n
         UFZKAM86/gLfHHHJXZep6b6llIhMB1s1GLtnv59mqAE/qMCZG/0bLkl+tOiXjz1cfTxP
         yESg==
X-Forwarded-Encrypted: i=1; AKwUvByApdwohpeZNVNXK2ZVFKyjL+aXwMo39dkUKdJFwhQPSDF36DMmxkU5I0atsje7yH4TDMM/IAr/mZEh@vger.kernel.org
X-Gm-Message-State: AFuF++n92hCGC08+q4Dusx8Oa6PG6wfASHkeImNqyda3c2nUyFxzpuTr
	DtShI/CywPs6eCtRCJHVs1ioI51pOfVGTb88lXrFWFH4sJTUhvuuvrbA+xoZ3H3NAli2INGwrmw
	wnCwdL/WMVjhxbczjgGrs4EUk/TJa/MsLSFhDUVuBpAUcqHhyKYlHW6R9HyKxRZz6
X-Gm-Gg: AYBFou3xaL82ovR4I0eNDDhDwBz8sQIsRPoeEH1tjDV3bjnceDOkh1BmM2ssEpzbzE2
	lVN4UtCr0WZylaigApHOmOhxSV33ESuR8e6gA87/lKYfB1qpMxK1+16uDsPUsRMutVs5GAtc2OH
	+4XLzw3LUDZiU1v3siOS9RlIkmNnsU+IhiPNuyvCbYQoFjet47Y22LWIz5Z2RFTuCfPpsQvvUSS
	JrzI+xneGOA9kw6+L4Vzkcp3Lt7dBg5IY1EmDi4Ph9nT4M0OGDsV8EGqN6q2cfrbzUv/P21WHaC
	Wo64U9iXHtCqUabia73NxAcKoCuXQq1XUEOrtoWFRHPi4eexmE2fCNO9/yEXvVqoAaU0ZlFiftM
	kkZSbdRHd9Ogtsv8LrKhInqYjh9FLbLiUhQq1VqKV2EH+RscuOW971ySwd2WBdfrdDJkwrj9FJF
	cnMV9M+splFsSKL33xhZVesYcR
X-Received: by 2002:a05:7301:4441:b0:33c:1ff7:8681 with SMTP id 5a478bee46e88-33ffee597f0mr1649418eec.15.1790235500400;
        Thu, 24 Sep 2026 00:38:20 -0700 (PDT)
X-Received: by 2002:a05:7301:4441:b0:33c:1ff7:8681 with SMTP id 5a478bee46e88-33ffee597f0mr1649373eec.15.1790235499750;
        Thu, 24 Sep 2026 00:38:19 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm12120680eec.5.2026.09.24.00.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:38:19 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, anup.patel@oss.qualcomm.com, ardb@kernel.org,
        conor@kernel.org, james.morse@arm.com, lenb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robert.moore@intel.com,
        sunilvl@oss.qualcomm.com, tony.luck@intel.com,
        zhangzhanpeng.jasper@bytedance.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v5 9/9] riscv: Enable APEI GHES driver in defconfig
Date: Thu, 24 Sep 2026 13:07:14 +0530
Message-ID: <20260924073714.1650588-10-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX8q5AXqiVc4a9
 cnsOri/8NmFH3UxeJNo5buSIvTGw0T6xEry0y+Ui6udDCOSJmpvs7hEd6fM/eO3dCFaF2iuLcQD
 vFZPAEuu96o/n8zbEIlqZP5xqI3uqp4=
X-Proofpoint-ORIG-GUID: UgS-Si6ArPj6N5cp6gHrzydIjUZIivdW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX/z+qzqpv2XxI
 zbRhNn1rq6X42diumRhu4iPWyRZIGfadVsb7FfTUG8GvH1OT4YxM1CT9MEZ6uPtUgsOKidPsNoK
 MJI8UdbFI1Els2cWnrBBdt0p8rRo5oYftwiNTwBCKg9ekXqMPZY64+xf08zv15Ck4okXU7X6XC0
 jFyEigs+CtzRWPXN8+Ej4W7oTHjtaO41b/NYh1jnEKYYZXFAaG4eaKw/IbCqVLFLsPHlodapoJA
 KfHh2yYSt++TvaEZjrsVpRsW3RHsTCoYOgxUa6S/YCRiXz5s9ltruuyZ4Tk31+PmTwlp2aDD9Zn
 J7+ovsu4nKqH//zQsNgvgqt41A3fVlCWPGGViluhgqP6KLeqBo7FQXUmHowUz2vTbrpGcH3kN9U
 bPpgAaFa3OJsDRfSqaEc+tWoCAgYZY/MGoYrDiclOriev5DR5dhOlEiTo2WhNuW352U6MkCStic
 1hgGSiod8MhEJu2d/3Q==
X-Authority-Analysis: v=2.4 cv=a6SlZkSF c=1 sm=1 tr=0 ts=6ab4d36d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=xUlk1AThICIXWUt23vsA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: UgS-Si6ArPj6N5cp6gHrzydIjUZIivdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240032

The APEI GHES driver is very important for error handling on ACPI
based platforms so enable it in defconfig.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 04ae305d5511..66353b22298f 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -48,6 +48,9 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_ACPI=y
+CONFIG_ACPI_APEI=y
+CONFIG_ACPI_APEI_GHES=y
+CONFIG_ACPI_APEI_ERST_DEBUG=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-- 
2.43.0


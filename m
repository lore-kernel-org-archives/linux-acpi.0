Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D0432310
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235497; cv=none; b=dL0hmOGnqwA1tfhMvBCd0a/SchVIGlGVreq7wyvbSo1kg+rQdlLVmSTGbeOtdQrdjbR2tVNZx39pZnMv8gKW4gbfps1tdYZNklIGfFpA2+ucbaoDZv3VK4V/y4vjXmtqTFa63mp+69aq37p1vxv9CxHx7FuZ6fXMC64zuGjxdZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235497; c=relaxed/simple;
	bh=IPDczm67WB9cdss4DG7r4mgvBThj4nInB+DV/41f8tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERZEZodOnM0JJpSUAgMcaG18M9ou6g3R5anoF4jMToFMS86YST6b6jNcPv2HrFTDQFRkgxhBebe0Ysl2oY20U13G3bZY7I+y4i3QCB9AqW/Az23VgQw36KtB2cM+wDS45IlTA6wTNZLIM8NTZ80St1IqUwaV339SRamxH0pJIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZBLfErtj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PCJ4dnXs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZBLfErtj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PCJ4dnXs"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5e7iC772409
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 07:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=c4sUVCmmjjo
	/P0eMok8JUuO6sZJCdXw8PrIwaTMTfUA=; b=ZBLfErtjnHbpJBbL2C3TJnOe6dC
	rnrCo7Njc0NBxWlfBgH3egh5mSCMfCi72t6i+zCk+AEp711U7KE9VOV0nN9PzMY9
	HgMn4Drml+qLliqS3z5jQdWXo5MVVXhhS0Jg2sAgVWbnylsdfmUsGaL5n0jdEeWi
	wJYEJDAelI4PCLyCrbPjyk2b242HOqHdau7MfxrctdkRl5nNfAS49wyu+g9klAib
	88w7retfxiU0dHd6Zrywd6pZPGn2ZeQHbLj3qH/4Ip+S7vfekM6wcUfB0KgEjVxW
	TCChsOlO0SekmYqLNZjo4QS7M1DfHcTOUgT4hlivSPT/puQ7W7w46YDLmFA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvr909n3n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 07:38:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30f1b904861so2472446eec.0
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 00:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790235495; x=1790840295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c4sUVCmmjjo/P0eMok8JUuO6sZJCdXw8PrIwaTMTfUA=;
        b=PCJ4dnXsgqIKXoIVTPVpokOLAt2vgqTddPLg0HboYMqUyfsUohccjMTKvMriXc81FT
         eaVoOwwoCXayv8aICrIvSlxHaTKM2aZuAtw/m2Yk/S0i/ghBqNmpork2pQhrMOzYddVE
         1BnObrb4tRMpW2o4dnVi2a2FuyIYS3RtOz/RURYwJx8YCJpboOGsKj/uSUqfJzbTUAo5
         +6C+pJlY1AHAJeSwly1iOZidRmkDZqLSLSiWmaRb9zhMW6YiGFOaXb58qxi41ONw7y6u
         fOsYV4cYd9q/mN/QTxxgMXc4FLBFEBwDNReJsVW9hVfmtn+jWnuwp8Gu1cddXjxLq+4K
         30uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235495; x=1790840295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c4sUVCmmjjo/P0eMok8JUuO6sZJCdXw8PrIwaTMTfUA=;
        b=gi8369W8KQqJ46yZuo+WPwpVFlX+qHec/JOv3N55NF2WOm6oym7nlKyY+95nJ8bqeI
         PkNfeElMCaXdBmwSe4mF5eSsEXy1ixv+KxZ9CLM9dMdItRvDC1oqJUqRUKrfqOx6PQrJ
         iFXoS+O25DIFlijap68v2K7tW024x+bR7P+DGrrQ6SMs45KRujzfJhoqj5SM50KGNLps
         JEdxP7eYb6L6cTE3fbxqkpMxAWvhXlXjJptCIALb0Aqu9uNP+wwpCPbsFPpJm9zD6pU5
         NBKKRvbTAdSJzk/ZTlVV0E5MxhcbhU5HnEu2SpLypDoajeljMCjr/3BakeOuBNhudcKx
         UaVw==
X-Forwarded-Encrypted: i=1; AKwUvBylOMUpWnuiCmyTZCr6lezYcm+qWDa+43YVxsyAUK+hICZa/8Xo2/GKlhYdBPEjC+LKeLJnRbRrRJG8@vger.kernel.org
X-Gm-Message-State: AFuF++mJoU9IE3RXfyv3gd1ZEITZaNr9aEyK5WKU2aqt1QGL4+71iRJH
	TQ0MvVBtIDLANq+yMvhOoBmqhyzMatGukNjkm9HSLFL72F3jxytXK3PiTBzLFX/2AqLZIB3A80o
	nlb78JalwVL2GCgd0I12pnKjkGoHRHjmheCJmnKihPI4PGBRswmlT/uDjid63DKuq
X-Gm-Gg: AYBFou1CgQ8k1GVBGa72gDHSevT7RA2rZWCMLttQiUpGVt1i1k5AaA5DmyeIpmzC84K
	N2Qo16/orosfHeKV5S+p2erK5h24136sUGr4ud/vSIJCux4cvDIBHV4Jy2ICnP9P0/66AMRbML0
	DI9zjmtUQm+VY0A8ZXkNpJxLOnoYcHDPCZPsKs/yCVRv7e4jIK0P34/54QUZW8pfQ8hTYf505Xu
	ot+YyBwIA59TAx4YGZC/mx3KIGmF5KVDZXE8pdDu6ca28yh90+qozuooQxBU3LABnPbi8qwjGjf
	4YSvGOQWlMyVox+7sQ5okoWoORonTlvy0TZcpDgOP3oq0hYyCBexGVBY3ixI9ePJ7mImcF8+HO8
	Ypr5RpKuk9rmi99aMAVadAcaM/GttOvY12c6oLlc3W3o/JJtfnmYjV1JUxJvZ2SlL0z4G0AMqoo
	hqTiCEeHJxiLWogLLzRMfkfsOn
X-Received: by 2002:a05:693c:821a:b0:33e:699d:575d with SMTP id 5a478bee46e88-34003ca6caamr1230450eec.1.1790235494675;
        Thu, 24 Sep 2026 00:38:14 -0700 (PDT)
X-Received: by 2002:a05:693c:821a:b0:33e:699d:575d with SMTP id 5a478bee46e88-34003ca6caamr1230426eec.1.1790235493990;
        Thu, 24 Sep 2026 00:38:13 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm12120680eec.5.2026.09.24.00.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:38:13 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, anup.patel@oss.qualcomm.com, ardb@kernel.org,
        conor@kernel.org, james.morse@arm.com, lenb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robert.moore@intel.com,
        sunilvl@oss.qualcomm.com, tony.luck@intel.com,
        zhangzhanpeng.jasper@bytedance.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v5 8/9] riscv: Select HAVE_ACPI_APEI required for RAS
Date: Thu, 24 Sep 2026 13:07:13 +0530
Message-ID: <20260924073714.1650588-9-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX3uOjwY5kd6j6
 kKDq2vmWW3SOZ+dOJqD9CfxmwMWZhqQqvGJDUEgD6GI91Z1MfZYBc7ayJ0fAo/z7dksgvM007gI
 zsNqp8vTqlukqhaMcjwTO26wUhGJXzw=
X-Proofpoint-GUID: 4JcTbl8INjhfa4SO25rB69Bt01dfaOgb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX3TymDfOLz7+J
 7Me0v1cd8h1MjnpCG4QWT7Ym40pTyphOruxDc7XETm8Ecr3OAHiGj6bdGUCS2pIPLn+pbY8LmCl
 glH7gFXeNJZi6ScBg4uRit3lqUkvMHZnPf36I97snK84VsMMWjXchoz+2uMx59MjF/niwHNJ8xy
 KOw0StcfyWXyzBSTFW/wp+uHwyL5FybZNBNf8JGQrJO4JR0AJXz7C/vY/FTLj/BVbYEdJ+lvDG+
 9lcwQyL+Q8mURoSkzHgBT/UrZDwaxNxbXFr32/kJ8aZ4VEtd4gckAn2Nb11wPu6v5Hd6T/GblcF
 WfuEzwopxD7VXj6Y2eLprXl/vJi7tK9GtZXJ1XI5IAvJXHHQimBC97ehBBNBYdlRUmyf42soan8
 iSdTy4MWv2zJfrRzIP9tm+keierlwLz12yZE8LbRMPrxu6y+Vty9lposR28V1oUj3dxiP0lMa9r
 868MiF8sByRD6hGexVQ==
X-Proofpoint-ORIG-GUID: 4JcTbl8INjhfa4SO25rB69Bt01dfaOgb
X-Authority-Analysis: v=2.4 cv=fMusTpae c=1 sm=1 tr=0 ts=6ab4d367 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=ctgbmQax9_dbRqqonagA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240032

Select the HAVE_ACPI_APEI option so that APEI GHES config options
are visible.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d6c2dbf8455c..9608abe126a0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -191,6 +191,7 @@ config RISCV
 	select HAVE_MOVE_PUD
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
+	select HAVE_ACPI_APEI if ACPI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.43.0


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616173E0248
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661866; cv=none; b=p/Fv+4EmK+IC19oq7BaDNAwKUYNcj5og3/skInI37P8v9dKMwdhC6ekrxu3Pu/oleA+EjHbg4YFZdl02V0wjQedt29bTF0v2EhIP7MnSuqtnVOK8LDsNgmp6IccdJS2uM2n/e/nNVkUnw8viMXwRzXXCuu38rDJl8/HzLxKVVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661866; c=relaxed/simple;
	bh=nvHY3EcHTYRY9I9aMgWPVt8VieEY0jbt8ogsXLJbOJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrfUxYFQ8sNeyALRyPlyaVmqN2n+cfjI57OPrY2yiXaWZoxFmUDbrxfUQZancXvO1G/qYI4LZ9FqgyZF7TAglve2Av5fypoUa58fzpkSBEq871CAa0SyrUZiHhFTjt6cQxGm57Pgx4IjE5qdNgn3lEjZVvHISQXw77qEsmMexaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YRekJzfF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EpERTJXH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YRekJzfF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EpERTJXH"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D5JdwV1393180
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NUjop8bIgjc
	4kzn5Txli1zlGm+BpePPllAZ0mN/qO84=; b=YRekJzfFZ/MHDlciDtRpJz040hC
	BlbOFPswO1P456inpjHtRnZ9ouyRtT0MY0O4FkMSeLeSm1WNmh194NcDk1zClm1d
	LbNeJVxalCUmw4bhrKN4xCzQkcIyfPhdcmwfo+iLf/3WxeLsfCKiihuINxAYP+2m
	RcwuHFrhocW4/fVs4vP6a2UQLSAUhBMHI3m03Img7RZCX0gsjPivVnUPBVVXmUv1
	1Gro2I3fb6r5zZXpJgY62ZBZa7c7q38FbGCX2x2mcmro4L+rq1eISBTCY2JWHnXc
	ZTDAXySzbbSg2F99Xq1tIZkMB8xu0zPxhHMBXjHWKHn1bBdiWssE2BjcCLQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4k260sre-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-366122e01fcso7422639a91.2
        for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 01:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661862; x=1779266662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUjop8bIgjc4kzn5Txli1zlGm+BpePPllAZ0mN/qO84=;
        b=EpERTJXHTwBy8KXwHIHVghUcNPdhOn9OLMzokJtmu7YOt5w2tQPWK+4CT5zL7YppKu
         Qxrfq3dPwH4xr7Z4SKUsWN4Nxu+3BYTM4zFDJ9PCmaAAsjQgsK2mBddU+TsFAya/8fyJ
         4c4wxzZ+9AjfmTCUFPvzGno8K2hDL2Y4oYTliXVHJoFugMU4kflb2qFVQ3CGux+9JepG
         EnK3dcCMcwbDrCA/x4T9qBWBvrUoqhy6VRknYe7I+B1ksPyFFR0Mit0VHVQBYWtcBs2r
         Ca/K6bSdYDsT27wy5F7+DrHN4ET6CnTPolk2Gxh46VK8kaQX0sy9fWQlsiwOzUF3sxNL
         /9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661862; x=1779266662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NUjop8bIgjc4kzn5Txli1zlGm+BpePPllAZ0mN/qO84=;
        b=U+JFWfaZvdolU85ehiDGL0U53WRxU6h6IDZOxd+EeUoYfbDZTYb7iEL2yNgmABefnQ
         UsHt2m67tvqKv8qkPRNXkgKE3HcdOawhu9eyu38gNThI3DTV40sujCcnHpcxFz7e8qwJ
         xNzmw1SsmWrTLob79eiGAT1CZKdSpnkFqjbwwFJvU72RpDLM5e/jMFwLjGtBzU0Nvw9m
         /e7/Nryu0ScvzIr6HyiZ3/o1apYJfG+Dh7Sg+cMfD9AHT4xRkjKF+83bZFyy4NqouHQG
         CYyr9vyx/03f3ERzn38w2LWCdc9OUaHdkjzHoknDoOwB1y7zk2r5crAuXcuVkXv6Lblv
         D2jQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YXDFse4+TKnRlBBO8Ms1TW8rRb2qNRC7/Vet9hVYX3w3eRfUaOrsKNLR027mL+BclxJAdjplHt2+j@vger.kernel.org
X-Gm-Message-State: AOJu0YweljOL+Iz/Tlghq3VM3vu0x793X3pSk/ep79/2wBlCcN6V76Ed
	6BESa2+YXoDQochrJ+ZEXV5KUcEKF8YFL/UGGA4b0n2x2sWhpsjYVVrsjeWA/SystK6gasFOm9t
	U8Kr8sYN0zCQFlnnFvAeWnGR+IOWuDlsQyJEwuMrb3uQFCuSZVzCh9uN4P6s89ZJq
X-Gm-Gg: Acq92OEYoAsANTGkGNMkzFkHm2ueBfqzZzAFyRVwKShnab2dHdSTjBmEAiX6IIn4uac
	VI7TjbRZbrnJpQVTguKnSO5E1f5y5K+7SyCqhXsVQHI1HX/QQAIiaHIQ/LJvHAyBreGugiLQ/c4
	GKQ9vEalCnJYcJq9AocaP4ijKEHVMKaU+2lnF3gKJ7tIwaV3kBCDdmghvLdzf/Fg2FHxuoogjEH
	00sJnSJh/Y422NyiG1NBOZAMtMS4gfwjCFNHVmDp8df+uNjaJNZsvw0QLyjfZ8z6xadRVbA0tLn
	witnjVwkgfNY5/PvTeK506J7FroCutTggQ5oKKWu5gaWCD44nSkBmZEGabwNEDmjuwEM8PSzwkc
	qg8LxkBq3DsjF3yrv1JN7DOSuBqeolgvXPGIl2YEIHiyUVBhkVvHkRuIJHHNb1kUxLBVhqJEBvM
	JQF/GTXF3npadz7o1LW7AhA1KkqaD0RErC/tHPI3E/6bBxLQ==
X-Received: by 2002:a17:90b:3845:b0:368:1064:62f2 with SMTP id 98e67ed59e1d1-368f3bd83ecmr2662361a91.3.1778661862223;
        Wed, 13 May 2026 01:44:22 -0700 (PDT)
X-Received: by 2002:a17:90b:3845:b0:368:1064:62f2 with SMTP id 98e67ed59e1d1-368f3bd83ecmr2662325a91.3.1778661861767;
        Wed, 13 May 2026 01:44:21 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:44:21 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 07/10] riscv: Add RISC-V entries in processor type and ISA strings
Date: Wed, 13 May 2026 14:13:22 +0530
Message-ID: <20260513084325.2176952-8-himanshu.chauhan@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=M/l97Sws c=1 sm=1 tr=0 ts=6a0439e6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=osVkw33_48dge00NZUcA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfXxmrcN/kj/jGT
 Z+R3cDbVT6T24PgcigZI0RCd8Qd2w+mAMat+ze4tY1PWJpJTDwsBJem9b09MvwjWrcjICy55suh
 BrBQGb/mi1vrE8o46Dg0YcdNVTvd7srCvYWNu74QwMTGBqIecsKbK1AThEKhGvFvpZqjxk0M+7l
 DSULPaI1kCNYlohiW9PeHYGGv7NrPwfzVoxpIeqBHlAQmRvEdP6MbYjCGu8KZYPL8AV01Qxj8NF
 RTTCQTRo8SVOP/AZLvpiIxT9HGGdKvy2M3zvo3AKrOYTvM1E3hrEJnQvf0bWEG/Bm6HgtTIeAZn
 JD9xgzXVWdPv+wGJHFs30j/8aF9ZZrFYBQgVc8owHPLqu/pXWSBvrULsPxwbugoWOV3BxxEVuB8
 y9FcbHvAU9pjKsYhtAiPbEzppqUL1EXZo9u67zuNtNkfVFvQGWBX3vjehz2QNUi/WJ2mrVgyIHX
 Q9+NWhN+7h1bpI2MLwg==
X-Proofpoint-ORIG-GUID: 1qf6LX2HcDjbYHdSKQ4Qtv_u_va4xkrc
X-Proofpoint-GUID: 1qf6LX2HcDjbYHdSKQ4Qtv_u_va4xkrc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130089

Add RISCV and RISCV32/64 strings in the in processor type and ISA strings
respectively. These are defined for cper records.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 drivers/firmware/efi/cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 06b4fdb59917..1b1ab2f1355b 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -170,6 +170,7 @@ static const char * const proc_type_strs[] = {
 	"IA32/X64",
 	"IA64",
 	"ARM",
+	"RISC-V",
 };
 
 static const char * const proc_isa_strs[] = {
@@ -178,6 +179,8 @@ static const char * const proc_isa_strs[] = {
 	"X64",
 	"ARM A32/T32",
 	"ARM A64",
+	"RV32/RV32E",
+	"RV64",
 };
 
 const char * const cper_proc_error_type_strs[] = {
-- 
2.43.0


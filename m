Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4C3128D7
	for <linux-acpi@vger.kernel.org>; Tue,  5 May 2026 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983914; cv=none; b=CZkdDyE72p6D5xK+p09tlGteLt6EoVqG+9XvwNla7Z5vcQ3uoa0K+Y0u0X3QEwVPCPtLbHx2hyW12Yc1cS4d79R0JghREyxeM2uxIph0j/LHaFktsD/4k6U0Z8gnUM6CTFxJige9B266G50XLW2UD9KOOdLOP4rtv/zgqgeCYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983914; c=relaxed/simple;
	bh=2IM4lMSreVHLqyyOxDBhvYJWupnQlqLCRMuo/4Cjc8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dLb56BQvnefVGZu7rhRfbG07UYaDq1xGL6mH3SgE3ic53HmQt91ZBv378ZoN2DxzisHNGuJLs171RDKbKko1HYvGt4v+zjzHwgD2I/j5DrB2j0llV7Kgm7cBqERnCtCdAJ6oJD6w3FTHeCDRmed1tzVDP7R1f78bf+RGMde5hd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TdJ65q7Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UZBDTG4x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TdJ65q7Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UZBDTG4x"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645B6OYK3091455
	for <linux-acpi@vger.kernel.org>; Tue, 5 May 2026 12:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6n/YGblvIcxORdMx+6LxziMRaZ4/mcyw2o6YavI3itw=; b=TdJ65q7ZsmmM7A9s
	PBnNuQ/i0v4A8QPjn4V2POdg9kz/RCuU25m6xcXQN3WWok6aroZpw+rrldHYTAbZ
	5vmi1ETWcg43mtJQa3IAqFY5hg7tK9RcBniEEWKTdSS06luxc8Eczlt+X7+WJeNx
	L58cHgLKPuHNpiOZOtZ2EhMfaLHEcqX+Nn7QWtzGq9jAfltQVyF4h7cdzjSQXk5u
	OFLqy9roijDBrGdoGMOMzIv74cr3H1oXxHkL4yzhB2yeSmL/LwLoi31AWcK5Ut64
	7XRuZOKq3E5iUPMH3MtU9B3zbZv0T3EkwdhNm6yuqhBVPcjKMtSqvRbhH9q+Svkm
	uJTYKw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyfct07fg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 05 May 2026 12:25:12 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6e2a6ba6b6so425186a12.1
        for <linux-acpi@vger.kernel.org>; Tue, 05 May 2026 05:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777983911; x=1778588711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6n/YGblvIcxORdMx+6LxziMRaZ4/mcyw2o6YavI3itw=;
        b=UZBDTG4xeMM6nEoTRZaB8JQaL1A2aTwW0K+pVzIIzhX3U4IIMN1pK/pU6trVMNAEXf
         MGBUA/qgbcCjOUJywxz85LnaSnJ7Pwz8bYI6VQK9NW2xsMX8xwKk4NYhDX73BSLR7Sxy
         23Re81g8PuwW0SpTHPxklGsJOCD/W0/cjASlDpjukXhlrUyUNAqeHj2i1JBDPDB38AS6
         DxX9QvSRankKGIqnI+wy7enCnKQGFuW0S3TJHYl6x1DROf9hkn/aQU1jQhF3FZBAMCXV
         O4IS/JYU+/V4LKcz3wCDb7mI0avrSths27WSgXJBTBNIVh8ZQDuhdUHqO5y8YVGL7kYu
         WUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777983911; x=1778588711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6n/YGblvIcxORdMx+6LxziMRaZ4/mcyw2o6YavI3itw=;
        b=Oo8N4EYJoKW4cWNe5PmkLM/z7mUDm8dMulMmwIHl3dUkpUrw+R0etN6UJnZLlfzS+e
         8KU8U7NkK9+sO6ABlQ36BbqhQSDXK4S4wWcqu65BrB4LvQX+pfbJaZoVzJynUimfIYby
         q+9KKhsQvLMWKSvVrEbC3xv7iRLMoZUKoufCaVTCyzE+nq3OL2JkmAH6qJ38LMGJqAWs
         OtxVLh/uqNy/X9ykwshYAyv6v+DvIgzkCWfs2atc0A7GTH9AEQ6gBAtvplqY/TC2DGhA
         vgmGUIttJHpB9bwBUbt4ESsZqlrGfC9Jvb9P+u3psGufFavuZZwE3xb9BC4hKZXH8qwk
         1how==
X-Forwarded-Encrypted: i=1; AFNElJ9o1PN/NSPlXKmSnNC0EdsvKzTbzl2lo4huYGCSum1QYKOM5IEEVxovAuzIDvp9zR4cPv0dyOmD0Edd@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Us6NP/vb/zhnB5Ox7fXe+uZPyLo10Ne5/f5WIqzUIuVs1eVW
	CY2pc7x0AFt+GHbcuGkzJGVLaaOwm2lGU51a9ROIOIKcD+KzNoKcoMnfV/Ro1xcptzfR2G42Rlp
	fKZAijJytweaLuCzzXkVxcQCIA2sUVUJokSeFXFAtj0bfUfyBgqrVdkQR7yVEDe7Z
X-Gm-Gg: AeBDiesoe/EWOOU4SCMBYy2SFGawV0VKiC1LCGHesZOOwJDIBVJnks2dOQiBH1CDsBs
	JLxkzA2M55won2N0uSxYfFY96CJzjBC+zT6TjbtYZG4GoviO9khocniXtXXMqb/HDNJt1JzBVR+
	69aJ1MvpyDSiHcGgJaItYCt/VZxuQ6yRx0LxpXzflGvvIlJsj96xqgkZ2cdYlhD0kPDPeuPguM3
	g1u69qgWsLkpgr4lUqapqVPb5Chgk/pT3429kKFTv6ZPU0aUE2h7mrNk2yHU6PdjGHWsHqeEwDv
	uwAJHJfdxcY23Re6XfYpfTnosVNv4+CcixKTeNKqY8r7w0+wQ5/KhkkM+F7YCFDBMKjuYlLe/i5
	RfhdXN8JDejV4BKwKLIlPOiHXHnl9KVc41iKK3MbuBXKFkzCZmtP+vF8j0x8CJOQ=
X-Received: by 2002:a17:90b:4e85:b0:35f:ba08:35bf with SMTP id 98e67ed59e1d1-3650ce40d34mr7090697a91.5.1777983911504;
        Tue, 05 May 2026 05:25:11 -0700 (PDT)
X-Received: by 2002:a17:90b:4e85:b0:35f:ba08:35bf with SMTP id 98e67ed59e1d1-3650ce40d34mr7090668a91.5.1777983911014;
        Tue, 05 May 2026 05:25:11 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbbaac5bsm12597998a12.6.2026.05.05.05.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:25:10 -0700 (PDT)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
Date: Tue, 05 May 2026 17:53:47 +0530
Subject: [PATCH 3/8] ras: aest: Skip unimplemented records in debugfs
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-aest-devicetree-support-v1-3-d5d6ffacf0a5@oss.qualcomm.com>
References: <20260505-aest-devicetree-support-v1-0-d5d6ffacf0a5@oss.qualcomm.com>
In-Reply-To: <20260505-aest-devicetree-support-v1-0-d5d6ffacf0a5@oss.qualcomm.com>
To: Ruidong Tian <tianruidond@linux.alibaba.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, catalin.marinas@arm.com,
        will@kernel.org, lpieralisi@kernel.org, rafael@kernel.org,
        mark.rutland@arm.com, Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777983885; l=1700;
 i=umang.chheda@oss.qualcomm.com; s=20260328; h=from:subject:message-id;
 bh=2IM4lMSreVHLqyyOxDBhvYJWupnQlqLCRMuo/4Cjc8I=;
 b=fu5pDeP5xi3HER6UMYy15HGHWu0Q0X9dpDdi3I2AdC7VPoEVXMmPbTCAZ4BK67PM/lvDZoL4u
 HVgHnE+TPdgB2ZI4YYsNx0SlBhhGoi8hF8+KMHvtMao8NtxlePtZQ+7
X-Developer-Key: i=umang.chheda@oss.qualcomm.com; a=ed25519;
 pk=3+tjZ+PFFYphz0Vvu4B14pBQSzqcG0jZAQspTaDRQYA=
X-Proofpoint-GUID: jZq3_yuoEijaH2VMtPy8cXYpLD_XyBY0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDExNyBTYWx0ZWRfX/dLtwLODGpWH
 cNWfGSiLGZo3AXL4u+kAll1+v1A4ZlrcsJDHuoOv1RUVjWfJ995T/1hYzqt41LMtPGqnNssHIP/
 DN+aMVjO/+RhBb1Cc8NPEaFl3LVATUr8dyjnis2wdQ37HmKVofmG+h/bcFqtGL5Dlpb5wRCwdEl
 yix/+UFrqTlgQlTbSToRmUvaX0icOXxSUhoQS+nDaI9CBfFmG/IgOtZV+NWpDRZ07f479wnjV1o
 qOHrxa8c156YKHgfuQcGjwyS/LHn/dNNMJHmAhkyrRFIRkVcRCV/KV2iVVFwoxA1taYtSlOTvE4
 ekENRbFx5qa1zZp1xlHuE0jO2wp/Z4UYGH5uzGUfWkO9SpgjVU5Ufnrpo88jmMNEikGMB6B4B1j
 CblHpoHZyYDyOpw39+1SWE8gUtmOtw2D3wyfMOgsK95OsFO3A01tG4fJyOubZnjCW9+pF2xg4pH
 HrzbeGniZ5ABz/uPB1Q==
X-Proofpoint-ORIG-GUID: jZq3_yuoEijaH2VMtPy8cXYpLD_XyBY0
X-Authority-Analysis: v=2.4 cv=NtXhtcdJ c=1 sm=1 tr=0 ts=69f9e1a8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Q5xIpPglxa2DKV_CsKsA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050117

The record_implemented bitmap uses the same semantics as the rest of
the driver: a SET bit means the record is NOT implemented (skip it),
a CLEAR bit means the record IS implemented (process it).

aest_node_init_debugfs() and aest_node_err_count_show() were iterating
all record_count records unconditionally, creating debugfs entries and
accumulating error counts for unimplemented records too.

Fix both functions to skip records where the corresponding bit is set
in node->record_implemented, consistent with how aest_node_foreach_record()
handles the same bitmap.

Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
---
 drivers/ras/aest/aest-sysfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ras/aest/aest-sysfs.c b/drivers/ras/aest/aest-sysfs.c
index f710503e4d74..b36190bb3b3e 100644
--- a/drivers/ras/aest/aest-sysfs.c
+++ b/drivers/ras/aest/aest-sysfs.c
@@ -52,7 +52,8 @@ static int aest_node_err_count_show(struct seq_file *m, void *data)
 	int i;
 
 	for (i = 0; i < node->record_count; i++)
-		aest_error_count(&node->records[i], &count);
+		if (!test_bit(i, node->record_implemented))
+			aest_error_count(&node->records[i], &count);
 
 	seq_printf(m, "CE: %llu\n"
 				"DE: %llu\n"
@@ -174,8 +175,11 @@ aest_node_init_debugfs(struct aest_node *node)
 		record = &node->records[i];
 		if (!record->name)
 			continue;
+		/* Skip records not implemented on this node. */
+		if (test_bit(i, node->record_implemented))
+			continue;
 		record->debugfs = debugfs_create_dir(record->name,
-								node->debugfs);
+							node->debugfs);
 		aest_record_init_debugfs(record);
 	}
 }

-- 
2.34.1


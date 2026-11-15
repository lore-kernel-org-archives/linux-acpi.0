Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794732164;
	b=Xl8igeni+NHlVePG+OUa0jYbmuRpKfk/1BPFvt8umf3rbodI9BRyJyn5gsAtCCiw/5WT
	 y6sS1BAdd4UgmPu1TS2tFC8LgIxnWzLzy4PDHW+3DQcvFt7yd1799kztHdK9QGdwpjjWj
	 rPQyUqofGwLJAWprD6JDedJ/OUtnqXSMaI68KmMXb4vaTvZ3QJMQIf+lBVblT8NCKZBed
	 YO0rQtAzpWKf93dSkZp7DAuXZGDQK5eTpSXFhcg3m/9sj7QWmv94vP2NOBWRQlYNh3Gxh
	 VPSySZqafJher0LZiewxmebYW2bpNQW+N2jOYsXQOx2Fy2SM5G/xrnDwLfHY2twKZEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794732164;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=J0LNhcS3twbB9Ya/CltyDMpIsNPzAzolhCjKnYk9xMA=;
	b=vCrkhL/mvG6jDM3lYKjhTpRt/QNsr/zjziAG4FBJMwFMkyyGknAuxoHwCAiv+HFGCAt0
	 OsvfQ42lP6AWY9h1nuAJmmDjgUj26xLSPdJHjAxsmvGIHCcTWW3gHHBu5GN16l7fzOlEH
	 jgu8b/WvCpzz/9mcwmg3JswUb8V9ylIDRewvTUgp5UBykErNJ4pMj3XgAtN7+TOshmrXv
	 kSBhHbJsfB7P4YPDPvwlSNkG5bwkyi+d030Wge/zRE+dw+cLLoiPVBcY7iYuhiYesPIO9
	 wM8smcmT7UP8KreBz/Cs+6BH1dCZY2Z/zxE/tG+rgz1KfRzeQ+JRa8dCKUBgnZY8ZHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VjtatNVy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34253606A31F;
	Sun, 15 Nov 2026 08:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34253606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VjtatNVy
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AF7w6PT2139781;
	Sun, 15 Nov 2026 08:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=J0LNhcS3twbB9Ya/CltyDMpIsNPzAzolhCj
	KnYk9xMA=; b=VjtatNVyDZhHOVTCkPyatQe1NwohGti/dVNiwvXCuuTpXovgXVx
	sjHvP+JQfPeJOv5C6zM3OIhiWEB532o19ZG816kH+WhkTIo5xF9Orf9A1/bu5gZH
	GSuj0uxSW2HDjIIW1HVG7RUgU+zLZn4vQ4qG7lauftMcdxvBCOoTzypGZS+9S/+h
	pEFBnTbmOP4Nw/pG48t4qUTWpkHVqcbLxCwDK91/xzleNibdMbIbXUYdl1OYNCB7
	/eecTBg5fyP7bAjbf6O2soYJcrZMxBI2K5xj2WBW25pZO8kabRN4wEhBujVqoHfX
	jNY4S8pDjD5x+Qq4Qm+1hUgwQnDEgDLyTDw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjtqgh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 15 Nov 2026 08:42:23 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AF8gKFh2516207;
	Sun, 15 Nov 2026 08:42:20 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AF8gJBH2516198
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 15 Nov 2026 08:42:19 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 4DAE022C67; Sun, 15 Nov 2026 14:12:19 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Sunil V L <sunilvl@oss.qualcomm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Atish Patra <atish.patra@linux.dev>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>,
        Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@oss.qualcomm.com>
Subject: [PATCH v8 0/1] Common csr_read_num() and csr_write_num() for RISC-V
Date: Sun, 15 Nov 2026 14:12:17 +0530
Message-ID: <20261115084218.951411-1-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAzNCBTYWx0ZWRfX1oZ2TSV9Li3M
 kVNk1aarmZO+9PqanKNI7ranfeS73xZwwJiCpLovGlFxyczeLhd6SAW1+2hc0zHIzZkpSz4m+u1
 zMVQLE/oAEceWd6FcbGS985WmjgUM/75EHkLUoE7wRs6I3j9Tl2STlToP33zOVpMQX12mFUcWBw
 IVHyQaSdMjC4LsDJ1/4BThI9Hd9Kh1YhndBWW/C4WyhDhZ9vkZ/7Vz3QHCHrD46Tubijq74vZDl
 o4sxj86MTwsi8z9wF+n2ygrcUEtXJEuVKJCFt5L64YdufAjQ3Vv8dRNz2DEM782Mz2NXzXoYI2J
 HboapCfnX8I1AuBz1rs1ZrPovDO5FZm1PfBZOBkTKejnLKtmfNRLSqmcRfyny0WQs9aq46ajtis
 1gmsQTmyRIc2rRie3kY7Zfd0fktxgwI/Gxm+3Xgc7477nIHlWn8GzsP5YfsyYha/77AQGkb7Yzx
 /buYouWz+LzzpxkidfA==
X-Proofpoint-ORIG-GUID: CD2fYL8w91xyA3ycraO2rOy8cY8pqc4E
X-Proofpoint-GUID: CD2fYL8w91xyA3ycraO2rOy8cY8pqc4E
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAzNCBTYWx0ZWRfX5BfEk3q1S+D/
 GMFCpX3OOPm9McfSd4NvEWdCL0ciR/Y33uOZONNtE5CBDAdspD+C6wiD4JzMwMSZF4cNDhOQktE
 0GazZAaL41h7igcu6T7u4mbJSA+siJk=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6af9706f cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8 a=97VCTQuGHz7arqyciaAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150034

Some of the RISC-V drivers (such as RISC-V PMU and ACPI CPPC) need to
access CSR based on CSR number discovered from somewhere. Add common
RISC-V csr_read_num() and csr_write_num() functions under arch/riscv
for such drivers.

These patches can be found in the riscv_csr_read_num_v8 branch at:
https://github.com/avpatel/linux.git

Changes since v7:
 - Rebased on Linux-7.4-rc2
 - Preserve the CSR range check in riscv_pmu_ctr_read_csr().
 - Added #if CONFIG_32BIT for cycleH CSR in csr_read_num().

Changes since v6:
 - Rebased on Linux-7.4-rc1

Changes since v5:
 - Rebased on Linux-7.2-rc5

Changes since v4:
 - Rebased on Linux-6.19-rc6

Changes since v3:
 - Rebased on Linux-6.18-rc7
 - Updated commit decription of PATCH1 to reflect the fact that
   we are removing sanity checks on CSR number which are already
   taken care by csr_read_num() and csr_write_num().

Changes since v2:
 - Rebased on Linux-6.18-rc1
 - Added reviewed-by tags

Changes since v1:
 - Make "out_err" mandatory for csr_read_num() and csr_write_num()
   in PATCH2 as suggested by Sunil and Drew. This also helps further
   simplify csr_read_num() and csr_write_num().

Anup Patel (1):
  RISC-V: Add common csr_read_num() and csr_write_num() functions

 arch/riscv/include/asm/csr.h |   3 +
 arch/riscv/kernel/Makefile   |   1 +
 arch/riscv/kernel/csr.c      | 167 +++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/cppc.c    |  17 ++--
 drivers/perf/riscv_pmu.c     |  52 +++--------
 5 files changed, 188 insertions(+), 52 deletions(-)
 create mode 100644 arch/riscv/kernel/csr.c

-- 
2.43.0


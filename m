Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793808934;
	b=lviBiZvgl94eBSAEsHU+xPJL9d5DeLR3ccg9sjNX0uzU21hhBzzYytWUZ+Pelzhb7N0q
	 v1BFOYWYoGh9rMW4UfKQ1YYUoAWrzj1I9DmnIPhvD4KeDKqUmTVdDmja1Gga1L5DE/Wp7
	 YGX/ztV8LfdXO3qXZ56q6F6nAp2APNzPXlDIfJHD2fwAA3i6PJIu5IEJ3mPw2GFYXtQqD
	 UtCeYD85bsI5FhK+bA0hYBV+g02xKIo5PzEFka1jdcLRpwvuX3WHutWuOVz/W4HkFn6jR
	 PhnC7p8B860qoCvgFMHG9RnbFnlI7Vb9HoPpqvZCZDcM7YbEfoGjiyPMGtRZbJEbL9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808934;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jVH1WdWwc2cqdtMVBuZBwnu1HjvA+uxsgPvwECRUhpU=;
	b=qUnPlkIotc2yqjqmOiZfDvhUSeqccYV/8VqQXfZ9IcXCDb9GBvaO8z8Lrf3aTvWtNsDG
	 RvueWTS6kTjTHRAFsZ3Ev8MjlNEWQlnl9Aa1B+Psa+3H2dJd0mNFLOn9vX0lqhtB7ybc4
	 G4zACQNlYC+M1MwnDmZ6XxtQUy97euvrl7O7wJJxVPAGEU32fDywhrerKVs3sIeZteLP/
	 5ybLzFjC/jaXe4ocm0ZT0fOLHWyCIs9wrLwhC30uPQlepXyTw697MGOt7oyKF/iWY9PCt
	 /Hyb8gBu4uHLACNQ5CanmsA9e9+AwKQskffx491Gk+NbS2WGn0hPtwKVtqii3SUrBlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fnFXmXXM;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EDA606A326;
	Wed,  4 Nov 2026 16:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17EDA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fnFXmXXM
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Fip7C3272812;
	Wed, 4 Nov 2026 16:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jVH1WdWwc2cqdtMVBuZBwnu1HjvA+uxsgPv
	wECRUhpU=; b=fnFXmXXMdq3zSC4C1/z2hdl0xwlfzKa4NklsoNHi7Az+RTp+VaH
	SagXqyFTA+e6UnBA2oRA4WsiO/0OUvM1rlZbCAHnMw8m9Cizu4VzrTRyBJJ1Scjq
	jqTPmafJ2nKTQZiwr/B1r2+WbCUi1UsojmATfFgfVr3qAfOj313SZZm6xXgeQcwP
	gNmB5JP616J+H7wx+v3CXwwwQELzMbljV69Nv8ApRk6QrMmQdlo/9ZWJoTJiHnKH
	r4Tgt96ryftShLVbLKwB11gfyVVM6i8t+DiZX27NrPf7JzzYCDF3DM5qtq7hLObf
	yfTmfw+NEFs06/5CrVEB2mI5I8Kr1vlvYRA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bngeye-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 16:15:17 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4GFD7Q3122607;
	Wed, 4 Nov 2026 16:15:13 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6A4GFDi03122590
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 16:15:13 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 4760222944; Wed,  4 Nov 2026 21:45:13 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Sunil V L <sunilvl@oss.qualcomm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>,
        Atish Patra <atish.patra@linux.dev>, Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <anup.patel@oss.qualcomm.com>
Subject: [PATCH v7 0/1] Common csr_read_num() and csr_write_num() for RISC-V
Date: Wed,  4 Nov 2026 21:45:11 +0530
Message-ID: <20261104161512.883885-1-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NCBTYWx0ZWRfXwMYEfbYYzoib
 W+h30IjHo3dnZrnVT/XF9ew2yAkco9QR85L0BcNfw/N6JNedVcBMyye8b4NhWhRXDImfWSflRiv
 2zPiKwtid50WvqJSxLCXW/yDWpnjo+e7i5mb6j1op9YsDM5t0crobsXG+xRDPL62ln4zqU92jNM
 fol2mrT6pVfEwn+qAir9ChPheAMlPdCoDvIrkIjxFst33GyOfug7S2BcpxETH8dYCVGAPsM1cHX
 N7Ko+GhMMTY6cgmoAOppTeYqJq5x7a1PEdNEi0qxYhlfW+bNWcyrogPSDNXXqpLUkLEkvnjqMBE
 RNSxN1KgD2hpqgTCGcOfYV9anPnaSgEU2ioiMWyB1KIW9G6gSfTqeMRi6A5Pm7406xgW0wbzu4Z
 rSIqBy3Nei1L909fk3yj6s6johG1qVWNbHc1VS/BMXY4JBij4uGJbZ9AJkvdFtmUAWvgzgRc2+K
 8nJ9DV0wOjF49+fdfqw==
X-Authority-Analysis: v=2.4 cv=KLLPn1Fo c=1 sm=1 tr=0 ts=6aeb5a15 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8 a=97VCTQuGHz7arqyciaAA:9
X-Proofpoint-ORIG-GUID: JMzeAe4MiFqyn55hnuHbxmeVbb85bzpS
X-Proofpoint-GUID: JMzeAe4MiFqyn55hnuHbxmeVbb85bzpS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NCBTYWx0ZWRfXwIYoJ9rJs/kg
 D2DK2zbs1LT4A1R8BtQR1mgPwI1V/re/cYbFr3j2Tc8SeiU3oKZKF/MsOagfAdl7308NEAAgW+4
 7Hsosi0teXdwjWlEbLxT4E87sZHeC48=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1011 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040064

Some of the RISC-V drivers (such as RISC-V PMU and ACPI CPPC) need to
access CSR based on CSR number discovered from somewhere. Add common
RISC-V csr_read_num() and csr_write_num() functions under arch/riscv
for such drivers.

These patches can be found in the riscv_csr_read_num_v7 branch at:
https://github.com/avpatel/linux.git

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
 arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/cppc.c    |  17 ++--
 drivers/perf/riscv_pmu.c     |  54 ++----------
 5 files changed, 184 insertions(+), 56 deletions(-)
 create mode 100644 arch/riscv/kernel/csr.c

-- 
2.43.0


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763E52F7F00;
	Mon, 27 Jul 2026 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141565; cv=none; b=VyhWs+anwo/VLxeKCWnqTyzrKVqT20ZRwxiuQIGlZ8Tb8zmDLWs1KJtCAYz3q14XOFWK5OvCprvr3QSRLRz+EHp/YDnAkUBcjE8ow6YbdLGZN0ofU74K88AYEdAdtoujWc/BVD4K4WTIcWRh+gmmMFmNukqx/WYuL1Gp4+zRzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141565; c=relaxed/simple;
	bh=zjw6l4yVYZaWxphXMdFpJFW5/c1cnlClYoaLjBRYfgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HiX3+iBdbEuo3EyS23ymPCK938F1zblvYkQCaPZ210kdcwdhbm/uw3krkS6vsTcNcENlrnugeuOBezfGpF23DTNgJzrA1sgIb64gTZ3fUdlqz/vuu4GKJZMrD6Ki9+a/CeaV+k3+H+Iab9JoGa93/hsthbCsdgEHxUqAjewgRp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HvznNHuz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HvznNHuz"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R7SOGE2532964;
	Mon, 27 Jul 2026 08:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zFxcSkYghExSjtIuaCz+4VzVSTxmLksyKQk
	cfjg5tTY=; b=HvznNHuzAmd1AAUhN8cX0803T6qViU4itnhD+vTe/ok4FBoqJha
	bFdbZltpbVLd2sbBFADOwZeBKtn2Qsr8YRUHsTQ7Bw7ThcIDg0qNzzTxdEiIxmvu
	4YkwtyOPui6X9H8lDpOBFV9IG1O04IfEZWHKBjGr/5xfzcJqAQxy/8+kBbpVuFPh
	XsLCE5RjeXNkfYxZHnzqj49UqSULlLZfJhI7gD162WqAbd1z0paMiZvtVPfUbEZx
	81iFgVG+nNzru2Qwgl38bDTRR8wQ2E4uT+O/qUdyy3JF+0t8HqCvTODcgYe5xjQX
	Yc0G6Wn7owG62TcgdQNN+ab/VfiKnPIWGFQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmpajn5dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 08:39:10 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R8d7Si009456;
	Mon, 27 Jul 2026 08:39:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4fmp7j9ybd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 08:39:07 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66R8d6AJ009446;
	Mon, 27 Jul 2026 08:39:07 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 66R8d614009444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 08:39:06 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 221D82295E; Mon, 27 Jul 2026 14:09:06 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Sunil V L <sunilvl@oss.qualcomm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>,
        Atish Patra <atish.patra@linux.dev>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@oss.qualcomm.com>
Subject: [PATCH v6 0/1] Common csr_read_num() and csr_write_num() for RISC-V
Date: Mon, 27 Jul 2026 14:09:00 +0530
Message-ID: <20260727083901.1951188-1-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: F2fCzZV36YiDc1hvFF33K1izfDvUJb13
X-Authority-Analysis: v=2.4 cv=A8Bc+aWG c=1 sm=1 tr=0 ts=6a67192e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NEAV23lmAAAA:8 a=97VCTQuGHz7arqyciaAA:9
X-Proofpoint-GUID: F2fCzZV36YiDc1hvFF33K1izfDvUJb13
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA4NSBTYWx0ZWRfXzhpvFo6JC5Ig
 +VKxW9rsIDzEpz0ma1M+hPK5WzcGB8EytphaLufixd09eDyGRlKPjel20tLakdkimTJ6M0/Rnn/
 FXkTMijN3fIbjS2dVQ9SrCKNRMg9O8loaeNULxqTEtuY1BWUDETccb7Vgrq0WPb+ibAh7uU9Mrd
 IyMi5ySpJp0E+qipI0dYDSYurqSz+PaLEq+rC40Uj0ylAjbTZl4NGfoTp7GqqxhlImkiWAEWR34
 EEr+0jiuFD3vYPJhPBrqZRQ3igiAiU2IwVdc64dhrvsvXpSUoSY1sDZ4BzJJV/JLpf3sp/4e7q2
 IYFDjMwfSmHufGUNnmIdfJIXXwqfJX1vtm6wNoDlsID/HRMPRV8l7oAepgU0Ib0UxOBCZAgfJYh
 lC2kSW3vXxbKlFb58JovYkUXzuXZPVAtUtU6YSYFEfh59q8W3KtNQQzfMI44fuwqAZ51GRMgahk
 ZysFuWL4CX3ct6/UAhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA4NSBTYWx0ZWRfX/n4MbmEULrSM
 3MxUvcow5Ad4r34JmomdV4m4Zg2k7SyJdDFfO8PwQCYYboSAdiQY6fqQ7PJRAdbKydylvkf/6Ep
 i7cD6L14TrxQFoKP0uJWwCvfuM7HNTY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270085

Some of the RISC-V drivers (such as RISC-V PMU and ACPI CPPC) need to
access CSR based on CSR number discovered from somewhere. Add common
RISC-V csr_read_num() and csr_write_num() functions under arch/riscv
for such drivers.

These patches can be found in the riscv_csr_read_num_v6 branch at:
https://github.com/avpatel/linux.git

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


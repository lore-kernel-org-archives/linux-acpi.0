Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812933DE43F
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661877; cv=none; b=izVIA0tCD9aKhr01dlbKq0UmUI3sOPEOV7VqwtJ/w9zaoYDtKw8QPLe+87Vhn2E7uTRrGev0AicZ68ynMjq1OckdllhwNtQWDt4ND/iaBpd/SExslytNHnrfrOy7kdnCAsbg49nEq0Itn361UGjouQ0uoPB6XKHaFAIuBpfNTDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661877; c=relaxed/simple;
	bh=Z9H2IrGiWap4bBYZmAUQVqDaXWdawcf9g8slb/LeoRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCmMOG3/3sIatd55vGmwEiF/pYFQ2HHMzuc08yNr/yIyxti+9fSPLukUq6M1R2Da8CZGG7ZRFVw8AzcaVmYVgnLvVV18rB1YM6x9uWg6n5dNRNZJPWfDXpmwFChikY1jVRS9MrQk3h4LPOavqLGWQZyCpx6gJwbgGYGnppmmqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UmLLDQ0e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HIJ7meEq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UmLLDQ0e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HIJ7meEq"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4pPOB2321468
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=BpdgYqVS356
	+a0fEP+B5YTQRF4fTcXzt0S0SRfD6Nlc=; b=UmLLDQ0eXSzNMvpwnLG5/XnOyZN
	3Y8BRA1m+a4WyZcjb9sgMyCKUQ+NPMzjS84X2m6RKMGTWNoehW5uJYRVawYCpZuV
	Tbnomd29MYOIGQHX0OQgiB9yJWSKfVgJu06ejrnP+U5bmKH+GWLPkJb1yrAkWDsY
	oJbWG5cENFhsctGn8qCpK23+br2yfOw31dTRp9Hrc8vg17He39SpmTyuFgD3iZhh
	wjxDYdpLW0HsnJc6xnTcfF4hsU5vzG8v0szRlR1Dam/7j6LrjXQ9oBRKxHm6RpgI
	4QeY50BLqf8/+vSQQM7jgNWPN3QX25XADJ3vP0T6WrYl5kx7TePxCt0A9uQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hgu93ck-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2babbeff9e4so77896455ad.0
        for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 01:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661873; x=1779266673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpdgYqVS356+a0fEP+B5YTQRF4fTcXzt0S0SRfD6Nlc=;
        b=HIJ7meEqseWFuyvWVFgzKOxytYaLV52uE8e3JI1qR/CyuvMszczc3VslLghjUtC+PM
         C65KsbTFa9Sq3iIxxi5HXm9zCoSYELA4CUOPXU4ktM3QJY+zP3kTPV8Eum/z+9IUU45o
         IS1pKpqe40tqV299mg6NpVcYKGyyzqIueZYkBF5N3f4CfdRzzC5+cx77YLEtAgdekN7u
         Vb4YFkv64i7xGzEBbmNhv3PHURYmOGq3Gtw/ky3qiBuZ9c3B1qGy0YG4TogtYdSRVYk2
         PLi+0vcLQzaHRFXCFW/g97x4dWHVTYtwXMct2NPz56H1nBbvI2DKtovm0ZNnu/+jjEL6
         Xy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661873; x=1779266673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BpdgYqVS356+a0fEP+B5YTQRF4fTcXzt0S0SRfD6Nlc=;
        b=FP/gBGyNqcHyxtJl1T5zq6A8Pr4cQrhIu1U0xIYP1EUF86NR+akG62OdTW+GEoxvFD
         QPqHALryDupxm69yMcbyn0QGBC60q/FpRaXssWrRes/AfSwCRD6FnPQIyCqBuBcYFgGl
         h77IqRgA0IDoD33MNaZpoI0sPCgTARbSBE5Qes2p4RkvK1ZAAZHivngTF8YqLYLNxRV/
         CerTBglAxrW0C9v6SrHh3IciYgDGW+6R9E43zbfl8jtHcJBqe63Np9JIFl35sxbu9huS
         QYpBAl2krlxJR2VgWtwJPzEs6JvhQDXsOp0wmg3VzCcb4+aX8eWN8ihi1MxWvNHtHlcS
         jmAw==
X-Forwarded-Encrypted: i=1; AFNElJ80MSrbiAxCXOGVezJZlamYgwcKrv1AcSTXUpZOCjvAcoXtfea0APBWwP86EE7lLRcoV4C2eYqyvjY2@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZpGpMFFdtKr1hPqRcrNSYgxBiJCAxDdFExzoF1I0s7dNBr+F
	4fatyQh67XtRR213QLvzHvuW/CMPB8WsSyJM81aaeODOL+C+6Fip3ny3Bf0iwMaleZ/gj/nVut/
	q92g4ilA6p5O7mhBQ6KLsBZEhDIlHX6uJqNZE9qoYdHwxX91pzMAe7jqbiZ6bWrR8
X-Gm-Gg: Acq92OFWozs2QOtJOEyiUsOYgU4IoV6JXbmw0D36YK7hDolCMEQwBQIURbutQQVN+Wy
	p9JSMwlwitAK97Mg5xVs32TmtVz2FidZoy9jT5SfVvFHEFIekL4Pc1jaEK2Xk8Tkn6icD8Ul/Qi
	qH8DsZgkRMgEcNULQ8+/SUbkawTU63BB06za0UyLgFWDgPcdHu+cIkXPalJ/efx9F3Sax1yw+ti
	4/Sdi6Duza3UI2465UwiaFgPXf/EiaDVHpvL/CpwNxwBVwfiR/voCLU0/vTB10x+c9TYpSaYj9I
	FeLMhHf5+CrDexzxRZrzJRfEIfj3EuBJLezsp/BvgY+nAm/b9Ft+GWVawgDbwBcByGa6utIKRQK
	T22H3aUX0h9vHxnScAFuXNmbrYD8+wrO87/HWhV8sia+7CSeDtz4J6t7kqbh/I79DsPDA3pYlh2
	XJ1MfxWxQWJrsry/5+NK0JDznEb4phK9GxAY/O6mwHFYC7gg==
X-Received: by 2002:a17:902:aa8e:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2bcfd48a8bdmr42628695ad.20.1778661873032;
        Wed, 13 May 2026 01:44:33 -0700 (PDT)
X-Received: by 2002:a17:902:aa8e:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2bcfd48a8bdmr42628535ad.20.1778661872580;
        Wed, 13 May 2026 01:44:32 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:44:32 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 09/10] riscv: Select HAVE_ACPI_APEI required for RAS
Date: Wed, 13 May 2026 14:13:24 +0530
Message-ID: <20260513084325.2176952-10-himanshu.chauhan@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a0439f1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=cq_Hu0Mfxj2oTTqF29wA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 13UQyM88MoyTyRjIj1HnjNbLWratPOh3
X-Proofpoint-ORIG-GUID: 13UQyM88MoyTyRjIj1HnjNbLWratPOh3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfXwBhQ6JrhTR0c
 PhxxIIbATKmarOn0A+E8/lP0ZZVbyRsBa8RirVuJ07pEmaxSfBV/tJF5rVvn992CnnPhznC9OoD
 avblUpQgfkfIEjj0ptbhZw4dstON2CvDgiHUKnL31H7nNE0nnUIPYKYkAHXg/zu0w2XepfPE5Iw
 pefptpvrSPpGcT46xOcIKK/cI0ms+2snmC9PgQfIQ+Cw4vmjDlX9ZOnim4FUsRZLQC0nb5Ffjca
 0KWVFERiwJv+96MmG0LQMovzYB3uJwGYdLxGm5W91wyy3iDGM7o8ieV4SmscGPme0jeToRyfX9l
 zaGvKZJF6DqmsUz1698I51wiix0FlBXodig14GCO5cG50VUbDQcGlYsRNqAuFoKC83qNXeG2WSn
 jwbtE+B/ne84OsYBiL24nJ9QjFwlCQ4C1ilvgkfxd/ppgZJxqrWfkv+s0bXDhjFDzkk6IiQ3Bwi
 Qq9t3sQNFEEVAlJhU5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130089

Select the HAVE_ACPI_APEI option so that APEI GHES config options
are visible.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d235396c4514..b94b19fb4249 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -187,6 +187,7 @@ config RISCV
 	select HAVE_MOVE_PUD
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
+	select HAVE_ACPI_APEI if ACPI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.43.0


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17A3B7757
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288984; cv=none; b=IqxTqHrOiHt7BWCJL1dfjlvLkYMIB1pvVpUzCe/k8Y/biqbl57FJyV42cm0u54nmrZBatHtj1FleXaALXuZ9adAT6fkk/UhqBNTkMelhu2QJVZDYt8E+G+Rp9dbYLKgxabXDOTd/zhV4WDipRPaxhy6pPQ1sPBixxBTy1yRxTQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288984; c=relaxed/simple;
	bh=XgzHn885FWid3cTTZxGylf++YQN4FERwJEs8Jjsu50o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b42vwrUW2NQPI0KpYphp+LNN3BXdNNRj27rGcNF0J2xveMGnOYMrQs7WlpO+t+J8GChGA6ZU8A1myJAyj4Sh0LQhdBzUeJuO3V0It5mQEP3/UeFBgqYw/xB5Ap9993FN/HU1s9a2ZpedKioVoQi4sB8NxsqIFP9dMszknZbJktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D5DNrB+C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cRbcalc4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D5DNrB+C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cRbcalc4"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TGnL3682656
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 11:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=I0hy7Pqqez7D6hC5jhpZMX9oVReaOUnQN5f
	qbMLiLSw=; b=D5DNrB+CWpt0dN7GLAmqXDh5Z/L09GJ2m8lIHkFTjHxlgqIHM5p
	o8vuOdR/3N49MEUEkYC3yvaXPlyCy3E/qD0Uobk3QgzTKx3ufjiuAQ8Um0vFr8KU
	ElHM6+5rvD2plb1934/IzcYzOyaIub1nOpA7tEYpq1DKmQTSZ9UZp8MN3P/SZWku
	RJbZjO+rxPCiF9bT17uUY4r+IuYc91ebf8cKpOS13CyHnZf8kABT8xNA3LVwCl4s
	z7YdCKaefejvc9Nq5mXtJbFfj0G5iKKKsNJ0F+lYSUvIHx4CF+aSVxcv/iek4GX4
	bDXWvWUhzYDl6m5DIU0wXEz4hiiHsAGM3KQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnmr5udb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 11:23:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50ff0bef198so38097141cf.2
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 04:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777288982; x=1777893782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I0hy7Pqqez7D6hC5jhpZMX9oVReaOUnQN5fqbMLiLSw=;
        b=cRbcalc4t7Nx2vO4YesH36TBJFVd6D6ykBJEYA+i1sOASmazF8l9YWa6lly3B/jAbr
         1UNbK6Ag+TKCPH9jlXBS9VD/RVObv6jiQ8a96xvR8qIA+JuqSCCvUcR2zer29Fum1tWe
         GdmAUQnYkv5Wyz97NCUJQX4uPOfWUL6jHnx5kTmmRMP2CAwcm/0NSxKHHTRvuCTVD4x5
         y1zWn8J8UL1mKEXwSTK48s6Tfk5BiPwmyMv22vlHlAcddQ+5yZmN78qGYd3Mso2D4CLn
         Wtsh9XNUAyyQoe5AXKo2PXvKeW4/q6V0Vzbxhy7eShmht5r1ls+aZ/+jW7LPGl/DJU+E
         xS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777288982; x=1777893782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0hy7Pqqez7D6hC5jhpZMX9oVReaOUnQN5fqbMLiLSw=;
        b=dhCfcgAeIF5oevhkHFmVWTh+8KIfLMjStM7HscCxxbQiQiJtan5yKdeHG7a0H0rVrN
         H+809/Bobgoq5mbS+SGvFVw3iJEKRZnIS2Ry2QWMQMoWtXCkh46gWCnsSTY+s8pibqZg
         mrTNqx+tfzDeYzYyP5xTgUvZYq982tj9qJvOEm7Jk2lw49Uuj/Y9WM181nJh42rq2/eb
         aOhb0KGue4XYz74bfFhCHe6s6uLrq4O33o5OeLFNT6hPYJUQU8esj1sNHow/aCGVLjQl
         RwvwM9gVjn0JDyhzraT2eZiYGo9PxNWi03CuapZRLnYHMleSXx7Rq74lonHYpBVkOpgE
         aBmA==
X-Gm-Message-State: AOJu0YxlZ7mcxzOsqH8yNgYVAten4/gdZLiHW419U5hZhueazWxpTAyK
	Dogax6dxLkCjh9IozvzmVWUjPdyvT5n81Spjh1FIbCqXCBBwxDiM2D1vFRCaYuiB1ldxmyiDGBv
	rugGDX19zvrgPwUi+iDHRKxrInu/vfNjDa7bU4w8f+ION951vGl2yho/IlsJFE4U/
X-Gm-Gg: AeBDietwpsq7d8rb8oTN3a78g/8vAIkb8D/npY+Saryguuhu6xUsDOClEI6CON0+yRH
	qgbNrACBiqCtAfYtRU/qbb5wTZ6ZS0ocToaUz70UYNzQH/Sku4fBb9j8ZDZXxD2WbP65qR/vIsw
	U3eKjglmIFi+o7B8BkOO3nyaIx372F9pTCOhcUmRFG2CSOaXwpl1Hnc7UI7clo2NwubtR/1blFC
	toaR1ctNw231qtrh4HGc9gRX7HE4MrrpHsd/XdtFWWdaTv/ioanL4kmFcuZyRtxkflGlu1ePjJS
	NudrDyBpjxueTAapvmqEqbJODdnhESjlxa9Ahoj0hudJdVaeNNaGFHF5BRNgRjocOU6L74Zw30i
	nKXIZH8syesmJ82WrvOd1iumNg8Ciwt827z93UPywboYi+tzbGy18xEQ0gTwX
X-Received: by 2002:a05:622a:7103:b0:50e:5eba:caec with SMTP id d75a77b69052e-50e5ebad365mr322642221cf.54.1777288982014;
        Mon, 27 Apr 2026 04:23:02 -0700 (PDT)
X-Received: by 2002:a05:622a:7103:b0:50e:5eba:caec with SMTP id d75a77b69052e-50e5ebad365mr322641901cf.54.1777288981559;
        Mon, 27 Apr 2026 04:23:01 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:5062:ae86:23aa:702c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a525a0b1asm234825375e9.2.2026.04.27.04.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 04:23:00 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Saket Dumbre <saket.dumbre@intel.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH] ACPI: add missing forward declaration to acpi_bus.h
Date: Mon, 27 Apr 2026 13:22:38 +0200
Message-ID: <20260427112238.132419-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aqCCzyZV c=1 sm=1 tr=0 ts=69ef4716 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=IbMZajSweJTZi3pcCa0A:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 7RFfWxlL8aO9M5RE9VjcqAmukltKF6wS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyMCBTYWx0ZWRfXx0qk5SSJcjYq
 wjQey+lztP3CBUH2vy4Q8UZvii3pVlb6QibbHyXfseYYLvgGBTawkTd4srBKAwQITC8iVa7whJh
 erOgpogkow3Yll37sOkQkcxpICTWKRT4G3KNDt0kj/5eQOQb72bx2lQNS7pf8JEggvxUPaUdSfi
 vIHquFJY5Ka38fcbcYGJoyE5MVLTVNXmOauM4fKNe41VmJCubMLy1xMGdcPWUaH+SPbaTfhqaaG
 pPDyBtGutSsjRQvvU3Abc+6qIelTk3NKPvGVyRtciiJUM3RPEksK7asz+D4HE//XlOAHdCX2nV8
 jV1FmRzzX71+blgZRZc8gzU6xASCk9HLWkX9jLjrrKDGsDtzMnNxsHyeE5QmmzjE88PlplBm9Y1
 0QsT/jt7s1mIKMbIC1dUuXU0Gh0O927RAAlcsu3+64ZkHJ2VTjSW7oAe3oK6Ix/L9VqeNQqyvzh
 wphuqspWvWr7rDZKnEA==
X-Proofpoint-ORIG-GUID: 7RFfWxlL8aO9M5RE9VjcqAmukltKF6wS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270120

The header references struct notifier_block but neither includes
linux/notifier.h nor contains the relevant forward declaration. Add the
latter for correctness.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/acpi/acpi_bus.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b701b5f972cb..c41d9a7565cf 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -17,6 +17,8 @@
 #include <linux/property.h>
 #include <linux/types.h>
 
+struct notifier_block;
+
 struct acpi_handle_list {
 	u32 count;
 	acpi_handle *handles;
-- 
2.47.3


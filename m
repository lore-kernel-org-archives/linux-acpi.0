Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9728831328E;
	Wed, 15 Apr 2026 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237373; cv=none; b=WRyl5JgtCZ5UsV3dghVsN/gvCa88Y55T/XvoqEPaIFngjQnvQ9Omra0ZBq66XIijHHjxxNWnR1tvQSdENwipVz0ebX7d4eqfM20WxvudmwHMul+cYe+rV3ONHz3oz1l6rd9Zgmy3XT0BzBAp1Xfc+nwSEWPNBbcHDpau8yVQ4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237373; c=relaxed/simple;
	bh=TV6ijp30RZoZ2T35D9Bgw6ZhfZyJZPupiVsDKmuF148=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Ht/U10Irch/x2nF87ox+O0Ttki19Q2qg92PyhYvkNNNOI8pC/2wFZFquYlEYw4hfCmwTwDQ/z3G1tVw5d9EW32u+i4s6B7QvfcSWBJyAR/5bXdDNWsN/pMKbYnZJfHWJlWi8b2yyHzXUAJwCCY7+j2Y+YWEib0YMII9JWrnawcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=REJLY5aX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="REJLY5aX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F53PKB1833338;
	Wed, 15 Apr 2026 07:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=WEnknMO3dmzRnw4sY91a0cL5olEa
	5fZR/f5Yv8yWu9c=; b=REJLY5aXNEaJJz4iLG3lHMzpkSdUMoKCOkKlt4xVEBas
	c+ob+/Znb6QNIFhsn/ZIpW9b6cfJ/3xaK+u8wj9MaNsB/KknTEQRw/RsJWFfG9fk
	8Xhj2+pNjh2aiMa0Xbn9Duar6izUSSDRRL79/rMFOCiYQwrsaaQ8fF62VitWX9xd
	MWhF8+ovwNR8AbBOKl2z5l3c1MuoB2sAnb71CADUFUUkJT1I6bqNgxIIFbUtB9t0
	6VE53LWtOut8jRmbB5+ZEnITDt39PnVwTCk0+LFR7WnjOb9Po1VJoaTOgh6MuH4U
	inCfGovEQeaCEhPULzyKcAnwxIRz33Hw74vY/xC9Qw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89retwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 07:16:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F30Qkc003557;
	Wed, 15 Apr 2026 07:16:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnd5e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 07:16:05 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63F7G4tt38470212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 07:16:04 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21AC258063;
	Wed, 15 Apr 2026 07:16:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFC9358052;
	Wed, 15 Apr 2026 07:16:01 +0000 (GMT)
Received: from [9.123.12.79] (unknown [9.123.12.79])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 07:16:01 +0000 (GMT)
Message-ID: <ad624e0d-cfd7-4521-ae33-c5c3287b4204@linux.ibm.com>
Date: Wed, 15 Apr 2026 12:46:00 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        lenb@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        luiz.dentz@gmail.com, Ritesh Harjani <riteshh@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Build failure in linux-next: implicit declaration of acpi_has_method
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA2MSBTYWx0ZWRfX1UUu8xXGYa5V
 fgLkECborZ50+jxaB9pjvbX2JNxWMECCubznRv0sDw+3dJijBXV4AuU1tR0WnH/MekEI7b3/BY+
 0P76pQBTq0WggOXmh4amPbTeLTfRd3g/4mDAqVea5oZGZROKLrXGvaEqEolnGmLe10e33yfkE80
 HxIBrZuOmVAZfjwO2E785/oRudLd0l47Zye6XsmmTLJgzZzULQS+RKP9rsCtZUD8glmewUWTk57
 mAk5jXM8Mk2y7ScH7g7EN5Wp5W6010vcIpbTkh2UujLKMj6Hizuxbr+zAJ4UDOsOg2o0oxJGqRp
 jWoQUl/YklAfcGD3YOhOkPjRePCS0AkDesIbY1kyxmDMBR3gNEVkS7uVLXT9i9wG8iT2aHPFsMh
 9soiOurjVpfoQOad1jSmrHfH08XBAqlKp1IwidLF+8KsDi0T0sy9GG9VnzclbksZOnZaT45fyb4
 oBa8ldJCMsRiv99+vFQ==
X-Proofpoint-ORIG-GUID: l2g5Wlq6ff9ioS99kYhqdMzal-5eB1m6
X-Proofpoint-GUID: vEx32sqea_51C9GFnlDQe6hHndparATx
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69df3b37 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=hs2N7WNzdA4uTjTejakA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150061

Greetings!!!

IBM CI has reported a build failure on linux-next repo.

Failures:

drivers/bluetooth/btintel_pcie.c: In function 
‘btintel_pcie_acpi_reset_method’:
drivers/bluetooth/btintel_pcie.c:2309:14: error: implicit declaration of 
function ‘acpi_has_method’; did you mean ‘acpi_has_watchdog’? 
[-Werror=implicit-function-declaration]
  2309 |         if (!acpi_has_method(handle, "_PRR")) {
       |              ^~~~~~~~~~~~~~~
       |              acpi_has_watchdog


The function acpi_has_method() lacks a stub definition in 
include/linux/acpi.h
for the !CONFIG_ACPI case, unlike other ACPI utility functions.


Below diff fixes the build failure.


diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index bfacb9475aac..d3804f7f2610 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1100,6 +1100,11 @@ static inline const char 
*acpi_get_subsystem_id(acpi_handle handle)
         return ERR_PTR(-ENODEV);
  }

+static inline bool acpi_has_method(acpi_handle handle, char *name)
+{
+        return false;
+}
+
  static inline int acpi_register_wakeup_handler(int wake_irq,
         bool (*wakeup)(void *context), void *context)
  {


Please let me know, If this looks good, I can submit a formal patch.


Regards,

Venkat.


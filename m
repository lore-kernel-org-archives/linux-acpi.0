Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC9B471D03;
	Wed,  2 Sep 2026 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.133.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349768; cv=none; b=BnniWMMx33as+u5pvCLrbDxHXR3O/JKsrRvgyoiN1WOZg1CCP9BC8k22zFDehXzhaEYFaxvbXWo3mygdTj66b/34s86cz5Icq1n8uFabPEHBTo5Cdax2EJ5gHzHVp8kvQpBwaLTO1TVfp5vs0Rpr4a/6hSX6ptkYirXJL2PyAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349768; c=relaxed/simple;
	bh=r8bozCi9uh1JOKgd4eXVO5kQidR78n/zyBCPOqgHeB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBJTZRQ9VhbPI6fykjn1kPQudkPILad3j80fevt1/VcgltLfU6oEGXZVUCvVlkTtK2TibmeTlcSN343hz7f1pKHf5aLbQNPpnYqBHSD1QDA0iW7joupCH5r+UVibwtyqX1nQ4RxGfTCvZGK5EmOm1Z3hq2LO2vSq4TPxsYxj9Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=AabdiF5U; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=AVMyJ575; arc=none smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="AabdiF5U";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="AVMyJ575"
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829M748417200;
	Wed, 2 Sep 2026 07:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=smtpout1; bh=ZQrQfKrSOSMgwDlamBv2nnKeQLetsylZZkc8
	g60AoP0=; b=AabdiF5UJL6Yy8wFxFj4Ijz0Ai5Tn1VzxNT2cxkEu2ZlkPOBGAUU
	HnNBP6VnrUbw8LEKk/UiGLiUhNUkwzFwKejrYXVlGpQILGxD50XvA/yC3BRhTWUs
	ynMCa61LwVCC2hw+5gVPd9pJQMIvG5Dv8yXeVPhBJRPBDjsJpe4pLcN80pQ5nTtt
	VzFrQ9CBPCLCMr3g+mgmfVx8AY0bcWOiGgtkmXcr+uq5luau1LI5qA3mnsur8Aki
	e8P7EoezZC59upNwyiUA7vuOwdgnDhsxnmZlzWTXx7Qfe3wRguWMQn8SYepVxMOC
	VlF9OgMYnyarhZAtTKMsXe1OGiDaNSoYxA==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gbtrg98ga-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 07:49:18 -0400 (EDT)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682Ax2vK922456;
	Wed, 2 Sep 2026 07:49:17 -0400
Received: from esapsmtpat10.us.dell.com (esapsmtpat10.us.dell.com [143.166.211.153])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4gejhd8mrd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Wed, 02 Sep 2026 07:49:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788349758; x=1819885758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZQrQfKrSOSMgwDlamBv2nnKeQLetsylZZkc8g60AoP0=;
  b=AVMyJ5751BrLr9vbwlqRanJ+pgepFyn3658mUmlgFFJHHURqttNBMFTv
   ZWzZQmD8svoxQlIUXHRNhBfKDs6NEf09RJDKhfdq0IY0YB8giZXsZqZh0
   +53PTR9qzmQOG2zQRC58DK1uousD9Z0IvnAQrRR3ncBZ/6muYNf4dCK0p
   8nPBrAZenNLDlV+CF+lQW6bYiYvB4t9Ad4P9YrQ/RmYOAETVWCAPuNr7q
   KatYwKWyQXsVwYi8b1td9Mt1IGu51y6YT8HK6ezeL+slR+pOdVFHB0Hna
   4LOtHaWwfQ/2cF90FWsZQE5QVdB6TP/UvS0lVR9cAsRYgYW/KWDWOO84Z
   w==;
X-CSE-ConnectionGUID: TfZjxlnwRvijWguHmZABtQ==
X-CSE-MsgGUID: QONU9Ld3SK6bo5dJoqqiNQ==
X-LoopCount0: from 10.94.14.196
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.14.196])
  by esapsmtpat10.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Sep 2026 11:49:16 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Subject: [PATCH] Documentation: ACPI: EINJ: Update stale driver source reference
Date: Wed,  2 Sep 2026 11:49:12 +0000
Message-ID: <20260902114912.6690-1-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020105
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEwNCBTYWx0ZWRfX9rD5xp7nVHaz
 hsQi50oQJ/MeuquPwi8ySxW9gX9aKENWdvOTNPcH6VxpyxCBaBDN5EU5l9yCLsawyO2zBG/topg
 PrHEp+xPbD8oFVasSe7KqiclOTbZITL7uPgb7IpV9smMWbdpNDM7HEmM1SrSnjjWcKdTv4k5+16
 Teh0TWGvB1LCMcQHvAMzHuUKKyp1CW5I4GKdEhUItsq5Nh9se69Jxl218nOT9nrXNzrjZYEt7AA
 K8SITExfWkgu2SK7IGkrDejO2KFuHw6DSXiBGzgL92/lI6oG359x/RUOxOkQ+zOmKOPUT7MoIKe
 BD/ULYBRdPvFi5YGfY8Q/M+w5utR4kG4VoREuX4zK4+6NqDwpTLtpdpS9oyK7LoeKzTktjfDn4g
 VNnz5QHFU4isg8xbpEQ+q/iWImn3gpk4vbdi0iR1eerauvtLPfXb1X5G4I9Cm6zhU2szzDc/Djm
 EuFWjOX2A9HcXWrbE/w==
X-Authority-Analysis: v=2.4 cv=SeXHsPRu c=1 sm=1 tr=0 ts=6a980d3e cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=zctdXvwhg3EK6xEvKeLW8g==:17
 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=2Lpba0WeoN7BYVdwMO11:22 a=iLNU1ar6AAAA:8
 a=0cIJ9W-BkcCEToZRgK4A:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: AvVxTOOfOV8evQabP7pnKt864inRECXh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEwNCBTYWx0ZWRfX0XQ0X4CJLys7
 IIQAlKIhzHdF+X7rZXZpriUCj/tkjSKGgGK7egAfv3udyQXTqN5Y+DewWIFSDweM3FSMLDl9DSX
 3gNLPh1fLmNbAYGWiRuYmsz3EPc6d4U=
X-Proofpoint-ORIG-GUID: AvVxTOOfOV8evQabP7pnKt864inRECXh
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020104

The EINJ implementation was split when CXL protocol error injection
support landed: einj-core.c holds the core logic, einj-cxl.c the
CXL-specific part, and apei-internal.h the shared plumbing. The old
drivers/acpi/apei/einj.c does not exist anymore, so the documentation
points readers at a nonexistent file.

Point them at the actual files instead.

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 Documentation/firmware-guide/acpi/apei/einj.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index 7d8435d35..70fa59bd9 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -180,8 +180,10 @@ function are specified using param1::
 	| segment |   bus  | device | function | reserved |
 	+-------------------------------------------------+
 
-Anyway, you get the idea, if there's doubt just take a look at the code
-in drivers/acpi/apei/einj.c.
+Anyway, you get the idea, if there's doubt just take a look at the code:
+drivers/acpi/apei/einj-core.c holds the core logic, while CXL-specific
+handling lives in drivers/acpi/apei/einj-cxl.c and the shared plumbing
+in drivers/acpi/apei/apei-internal.h.
 
 An ACPI 5.0 BIOS may also allow vendor-specific errors to be injected.
 In this case a file named vendor will contain identifying information

base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
-- 
2.55.0


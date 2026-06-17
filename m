Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768F396D03
	for <linux-acpi@vger.kernel.org>; Wed, 17 Jun 2026 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676887; cv=none; b=qDdaLWAzS2wg8ZJfzzPgGESwmK4WOypz4eO/MsCjmmKVniY6nbRcJTH7+fn4LlDcs0CdW7bdrXdmSzIGHfHM460UvI1SHdlkIbshCHq4gO2TYseQTjloQsiJC0R9c3um4J15UekpJg2bdjvGOwd3Xj0Asq3xObo/IBX3oz7O6tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676887; c=relaxed/simple;
	bh=wKiMVLUAx19WyFwzzaZvSnwRtvMmSQM1NdB9qiCTAys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inNxakAx4YGak0Fgu4rmcaHBKACx+kUf3N99SCNKFvoSFScdAsb3ZAajVP6wbrtqiIwobljtZgf1gCAy7LrlhWh850oeLQEtxmhinbb4UjEvr0MAPZmFYzG0jNu/ihD7JOggIVHjcdupeSaJrXdJpSw9V+pohqrlsdVmAzU3d1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nkSGghOh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UNrqb72H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nkSGghOh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UNrqb72H"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H62jho1936002
	for <linux-acpi@vger.kernel.org>; Wed, 17 Jun 2026 06:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4nttNcpNb9A29dZe30v6JN5+MR96v4shqqFZOyAtYKY=; b=nkSGghOh7aTJnSbF
	fe6YNpt5XvI8RvTXZQVJ7/jxnt9Fl3hEfqtPdLsQqIlkl+l+Z/rmoWOsQo1YfE45
	0r4r0RExwLLKMx9xCh85hvgKiTssJWJTW0G054/ktsbTm92+xzgW85MdgEb7loN1
	qW1P9IWi1fz9iFY0MVl2ONC6QA7k5qftpIPxokucTTZyFTXp+eFQoKIEXSgRYVgB
	yHD52OIjZMf9KQxzBpEECtChEeo1fJ4a4xjb4V7smMbkyeT0+tvngMfHsH1zOcPi
	onfigCfdroCkLQ4PLbei86fvWRU7qZC7r4897sV3oCg3JxPTJe1F5w9ouEjVFIoV
	0hW8/w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef29r29-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 17 Jun 2026 06:14:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-915b3587972so505178285a.2
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jun 2026 23:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781676885; x=1782281685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nttNcpNb9A29dZe30v6JN5+MR96v4shqqFZOyAtYKY=;
        b=UNrqb72HOmAK4X8ssYcXEHYzOCGxfgu2aS6RiQhVV6BuD3uaj+8lrOVd6pu9EITLks
         9pbSBXTJ9v0TkEpm6i69DQ0OdZdW4YqxKci31KAnQ/b1BecGWf0rotnDlNKKBzWnZ16Q
         4egz00go9x6yn03UbO4Rd/+UeC+w1TIt/CFJda0RPAk9Ky+D8FdzZp2+X8198/2xAKLa
         YnhDdkedf3APhFAuHjTSrDa2hZeA7Vls9MFVb+07kdlQZGJdXSOoArOa6G7CKtSgovSP
         4Bqsf/cPG4u6Hc1UnblBozK5G2vhnGKoBcpsznKgCDDTcghfq7zPSs95AQetJ4zZH695
         iGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781676885; x=1782281685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4nttNcpNb9A29dZe30v6JN5+MR96v4shqqFZOyAtYKY=;
        b=N8s6KCBLQLn1+mT8/7Kbo+MFt7MIKFEBEcWE7t9syANf1+KFcpY4xryi/RBZzG7Vp6
         ZWxtnOcmR+kjWLriKXLtpdCjggCJX51TeoijYTmopgEu2dTMdSY02tQWWVCq8JV1HFwB
         V8nQvn7E2b5xrsiDIGw1EFT8cjPsyl/OPDYE+HmDlJGEI8so8vApY/Clwf4BKWvAS4jp
         OMqx+kCh7+JHkJOMN6ZB2wOLmFu9DmFHci6fVEZi+fwXFdKHudP7P4HvdtALJdQefziY
         cH8BzwZYXkTk/SWaRLGM4DY//LU+mZwe8iZQk4ROFEq89kyxONC4FtCcvWt7hQq7Wt44
         uzXw==
X-Forwarded-Encrypted: i=1; AFNElJ9AvTceZqb1XyV1vM2cdGXzbDLzvfbVwGWO7GJswX/JctH9Fx5FNMWhgFoAkLJEfVDR4O64oY/9DVph@vger.kernel.org
X-Gm-Message-State: AOJu0YxUE0promXVysaNzYvTWHCDRyYvFoQv/WeWGpq/8EgTyEDPjqXy
	Lu6An3hLdgGaWQ/ZKuUNXN9IXehKWLeseAjUnx6eP1mfo1V7q09cp3OPOFHr/Sq2rvkqa6lb097
	fi+BsoRNHpHpElT54iVTVNKnr4cMBoIH+LDFmBqTyl3wz77HLd4/FI8CWsLrirjSP
X-Gm-Gg: Acq92OFUbTHKs5FzmIM2ED/WFTrYRDiyeq1jrZ1RAGPEy5Z5TiAu8C7ZnPMMeKHFjQ7
	DOaDvXKsLRq50sgQ7el4aepKRWGxQPIMO/B0d90UOBfLZoUpaq1of6GWmMS9doEebmYAV2uPfSd
	W25+SCd87/TnB8P3+n5SVaFVFupPS/GC/SQpOnIXZiLo7J6MSWZJVz+4evoa8k1siiGqhYbwOwC
	Ci6hWewyVHeriO+BqBmL/nn8ZScuTDI1OJSV3aV7cc2PyqsSu1zoCJnbdBlXJzm+BmSlK+cL1Fg
	sIwpOpI0pfQ4Tv8FxuRkoHk+5iVWLlwslLZwskZcjj0iGAndR4zAGSlI6qUFNPz9teQZDXJ7zSZ
	/+Vp5rzwAohKwRbjtrInIcVozlUX2Bp8O+wEkEZM=
X-Received: by 2002:a05:620a:1a1d:b0:916:191f:5052 with SMTP id af79cd13be357-91d8e1a4e11mr483533685a.53.1781676884787;
        Tue, 16 Jun 2026 23:14:44 -0700 (PDT)
X-Received: by 2002:a05:620a:1a1d:b0:916:191f:5052 with SMTP id af79cd13be357-91d8e1a4e11mr483530985a.53.1781676884305;
        Tue, 16 Jun 2026 23:14:44 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:c856:25e5:e249:5e0f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0c10sm50411388f8f.21.2026.06.16.23.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 23:14:43 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Mika Westerberg <westeri@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marco Scardovi <scardracs@disroot.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] gpiolib: acpi: Add robust bounds-checking and safe address handling
Date: Wed, 17 Jun 2026 08:14:41 +0200
Message-ID: <178167687856.3656.4948917542366798856.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610154204.110379-1-scardracs@disroot.org>
References: <20260610154204.110379-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=F8hnsKhN c=1 sm=1 tr=0 ts=6a323b55 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=6ulFtW-IaP1gNaq5q34A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1NiBTYWx0ZWRfXyQAerNbb0sL9
 iEreYvPBDOvmyUyqYjK1ivFvpdG6LRNlyPZwkIllZYFzuFusV7fbLFtz4Y4wI5ZDDqFNv+Cc7rK
 d0SbCfllLxVpOsTXg0VU114BGbKXI9c=
X-Proofpoint-GUID: 1Yv-7EDNYSC6AcP2tm1zpdGpOjC5h6cJ
X-Proofpoint-ORIG-GUID: 1Yv-7EDNYSC6AcP2tm1zpdGpOjC5h6cJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1NiBTYWx0ZWRfXzQzrtAkRCwEY
 hLqCr2+QmXd2tr9is7HoiysQXJpgUAz3/kpRIRvEXQSMCft38VeRjlUeZxFszNV2MfL+85ae8L5
 vcFbyuoAWbG/ZRKL053EZiYFSTR0fg8II7ExLSf2efdGG/Ky3bnBFQRv4MHNDOXQchPzVvI/Xce
 JSEAVA6JQ2GD5NZVSK5t+cQVMI4t/HgTcqs9cGnZF0R97HqOIjinsAw9XF0yg+obvgV5xjK667J
 2kKmvLBinXREtJdCHu4bIUNvv6gygrhgsVDdblOtBS0GH44SsPSEFtBMlnPi7A/Fm5n5REA6MaQ
 UTfC293gsv0OLj10DWHjqcdq2X5n6QRX3ePXbAHC0BZo65OViwx9OCfmeZOhdS3HMQLiPDAEZVP
 D+frjgWSUaKYv4+oJVTNtobtxMJ7jh8/mMQN5DM+E9VUjU29f6glmumnfagHon72UmQ8mTZu+aC
 AWps/kQ+uh89jf5WSRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170056


On Wed, 10 Jun 2026 17:42:02 +0200, Marco Scardovi wrote:
> The series adds explicit bounds checking for GPIO pin accesses and
> ensures safe handling of ACPI addresses in OperationRegion handlers,
> without referring to truncation or wrap-around behavior, which does
> not apply.
> 
> Changes in v6:
> - Rebased onto next-20260609.
> - Corrected commit messages to describe bounds checking and
>   safe ACPI GPIO address handling.
> - Removed references to truncation or wrap-around behavior.
> - No code changes compared to v5.
> 
> [...]

Applied, thanks!

[1/2] gpiolib: acpi: Add robust bounds-checking for GPIO pin resources
      https://git.kernel.org/brgl/c/dece79032f529d2c9fdbf63a9f2fc32244722775
[2/2] gpiolib: acpi: Prevent out-of-bounds pin access in OperationRegion handler
      https://git.kernel.org/brgl/c/ae9f812df3149729643d27d2af488c112f62af9a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

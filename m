Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A190C450403
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289418; cv=none; b=Dq7EcTVHLfFrOXIXXhsXeAquXfanunPutyQ1bzjcCmHAKbPJVjT7EYgaGGMYfNiPnI1kSaU88EGaYj+8sGx196DRiStnF7h2ZzUzWzjNdWCdU164imjny9xz1QIT1eO62FPwQR2p/l/MX3V4Yh0/D4XzIuIlA3IPAfMhQ6Xumrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289418; c=relaxed/simple;
	bh=JknbI1AFX3JEWz9ZUQIuWwBQSt/x+hCytybGhyddOQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hmsa4/8uJ7ZkGZ7+F7CON2EvK87Riog1OjcdktzJsPSiLj+s4mbuhObtvOoIv4FScHqoKWddztB/XBPZAN7sNfK3jimf/tUBoBeAgyjikb6QGHJTLgCYTUheswufeP9NrhVZ86U0E5fZuzE3tI8UwhVovGzkJ57NcIVhEfbDdA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PlUatk1n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AwBQkGJZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PlUatk1n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AwBQkGJZ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OMOt4M2969485
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 22:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s/xSqJlOl7EjdT/3t/l47+j1hr0vJTFvoJBKOwjDyj8=; b=PlUatk1n41tAzO1B
	PX1tOR480nktBDvXyTUN3Mch0LXudLeEAIlNhVxDbhygxH86COstmPZ3gjNoEbJl
	EUR8R35n2Wz4q5Ai2bh+pgYArUFRrY9puwtnMFAZpo+1yNIySROsTD1g9RPUqP4j
	seGbeU09R6Y3y7FmKgw4j+VtFbLGaHMZGrMszydloTiV1WebcdRGicYs1DoIv/tg
	X3TltJWVj/O8cDRNua0YU8eRHIvyxDDkLP73/P5YKXd8HvuXudezBWx1B1fJgGKh
	WaOCODTUzYbTGjBuTX0q4BkQKY56op1Yp+B6uHqP1gatpGMHKO8IdL3EFd8ZFqoH
	ioIIGw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw68e1rub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 22:36:55 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1416f32fe11so802339c88.0
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 15:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790289415; x=1790894215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=s/xSqJlOl7EjdT/3t/l47+j1hr0vJTFvoJBKOwjDyj8=;
        b=AwBQkGJZhb12OOJhadWhzrm+G5WFMhlV5L7EyH7R4bztKG25+FM0vQHmgIrBRhTqm7
         m4+xUZYW6+GxFDzuIWtuWrRFIVliYDx8b6n99EJbJYrLs99SP8TkYGGAYnh+NrviCIOb
         faUscqFqb5VtHQYScdmkO2+wp4khvopCEAS1c3JL1QCFUVvdS9RPB4FjwgEmTLKls7qp
         baGio57yfOBlViV+I4nWSHcKN+dmyR94um1jU5bXFmToD4/0AJHgDhAZVqU/hqh1/9rd
         tisVdq09uC8QJU/OlVLAGTkR8BsmuzIgJwmeg+q3PCyZZ8N5CIfecQTWpkrnipZlMUKG
         9V5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289415; x=1790894215;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/xSqJlOl7EjdT/3t/l47+j1hr0vJTFvoJBKOwjDyj8=;
        b=rbX7Be9J63SXYKSmhEchUWyeYNjL/eEE8AbWGbDDB+QcMukatldEeClVSXykX4OEKV
         GORykQe1OUsK6sLysDy+5iM2ymiv8EhLXJvQH4ouD3cVThmAxC+vheL8lOimx2E77ZTp
         BqJF0tYRypvEE29gmZINw24ooXLJjUTMde83eMAjCazeycSZWXu5ApT5a8kOykoAgguw
         ySLU9taU3jLJUSMf8FS+yEVrg7P2m7/KGyEMCrNqE/aGKOGAhIKQSXeRgZRrcukc5Ml0
         oathHHZiUNuC7nk/ZG6JC0+vXg9e/y7/3PkSRnpIE/2EkqOAAGWB+Jy/QmpVPHBUwX3H
         WYLA==
X-Forwarded-Encrypted: i=1; AKwUvBz+tGeb4/AO7ryyzDCov3NrkXROps298xZyMpIg/payQF6NF6o2rC+8RJnmJ+6kBJieY7bDqp1DaVSW@vger.kernel.org
X-Gm-Message-State: AFuF++loR8aJCuAhDWqM5KUvYSxfRjOIF1R+NVSyoIOS4zJmNjmbuAW5
	sIBU2+5NrEixyqY8KCu0JIP4pfz6Xrra3HuMg13hZX21sM+U5ksjeX10r6ZC2EVxeJyPDp6H+xM
	wDb/+41FvCZW6dr6PmF9hiHk9RDgbExq4C97wRXMU6KDMMW4sITeXxIpF0C2buDmo
X-Gm-Gg: AYBFou3SOleTwwgxGzoPreSmD9YMsGjAkSoZ2UhihbenXoOzf15Z3eD1MZtY3yZdGcQ
	aywn7tLH26dA5z9DguBNZOkzf1XiWdiEJ64Rvk1sMwm63jA50TaJNj7TPC6+NsgKpaiaT+8aYqg
	HyOlVieCJgiZVbjU8XOMcc++ZpuWElGQklEWKWTc4bSp/AkeVrkgfcKbs9QzTY9EMYelKd+DAwT
	WAzDfLp5bOVFJm3ni4BsNx6XAaIm0HpJXG3XLw4R29wK6RfGPf2cxT+/ECIh4o7rtZd16/R4KLk
	MdsKTSkgvAT/vDBQ8jqDm7FmABohBryYmhqOxezfsvJENXdkU4YYPPji6U7hAQu8eAV3/a2BW7V
	alDKM2UqIhBdaNAqyLLwvC8z9moQKJ4pegVTBOSCCsqOOpzfjqSNCmA==
X-Received: by 2002:a05:7022:b042:20b0:128:d20a:2f40 with SMTP id a92af1059eb24-14503fc0c9emr3358107c88.8.1790289414045;
        Thu, 24 Sep 2026 15:36:54 -0700 (PDT)
X-Received: by 2002:a05:7022:b042:20b0:128:d20a:2f40 with SMTP id a92af1059eb24-14503fc0c9emr3358092c88.8.1790289413429;
        Thu, 24 Sep 2026 15:36:53 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ac67c505sm1379403c88.5.2026.09.24.15.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:36:53 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:36:49 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo
 <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Catalin
 Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse
 <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
        Reinette Chatre
 <reinette.chatre@intel.com>,
        Fenghua Yu <fenghuay@nvidia.com>, Jonathan
 Cameron <jic23@kernel.org>,
        Srivathsa L Rao
 <srivathsa.rao@oss.qualcomm.com>,
        Ganapatrao Kulkarni
 <ganapatrao.kulkarni@oss.qualcomm.com>,
        Trilok Soni <tsoni@quicinc.com>,
        Srinivas Ramana <sramana@qti.qualcomm.com>,
        Niyas Sait
 <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
        Ritwick Sharma
 <ritwick.sharma@arm.com>,
        Gavin Shan <gshan@redhat.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 12/13] arm_mpam: change MPAM-Fb error IRQ to use a
 threaded IRQ handler
Message-ID: <20260924153649.00001584@oss.qualcomm.com>
In-Reply-To: <20260924152739.2865510-13-andre.przywara@arm.com>
References: <20260924152739.2865510-1-andre.przywara@arm.com>
	<20260924152739.2865510-13-andre.przywara@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5MiBTYWx0ZWRfXxBIdhPw3xRfc
 lR312lNnX/KDsFn4xVpV/J0Ih8Ss+6Ck88xjOEK/HE9dGKGJNdOZRu8wuSOF5Jb+896awtlv4/T
 AT4k5Itt9moeCE55bsjLKf+aJRGJWIKzomcRE02xDy14thexPIEc8dA9T+TXNZTCj0g6ZAsxDPP
 0WBovUkbDXuj4+U8qLBFDxVF7IItbLfx1s46BTXiIe57NfblH0d8o68xu0YiZwvEq5l++PT1uj5
 nQnxWdXFnYhdMmQVlcG98Xr9uwYKRjPW8COHLvbWDEbfKhDbOsxDsMizpYC1ojHmRU3omWFsAly
 K3YaJdVxG7DnHaTdkH+K+K0vFEM38th8g9XgAukqQITPJCO7ZoznLjmzFqJBeuA7lCytj1zPITW
 c0gnX/y9s3PJDlZRqDleLwym0VGsrNprvLXEogNri+mfsoD7PCozDFAAXpSXEpdi4dx6hjD4gvM
 /qbceZ9gREha3aXy2AQ==
X-Proofpoint-GUID: Y9umLXwIfI06PXPDkLNkqbsDAzLpIr8X
X-Proofpoint-ORIG-GUID: Y9umLXwIfI06PXPDkLNkqbsDAzLpIr8X
X-Authority-Analysis: v=2.4 cv=XawcX455 c=1 sm=1 tr=0 ts=6ab5a607 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=kM4gzuUOBcDNVL6HCnIA:9
 a=CjuIK1q_8ugA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5MiBTYWx0ZWRfX/+e7//3fJ4b7
 3E2sKffuJx+zyEeue3dhK3iK9Q4YOEIEt4pxCSh9Cc0gdnD720HmIMKCgi03J1iVP7fthnVxTAa
 i6yCr4I/JLyUdf9w0LdVcnjaKuja1CE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240092

On Thu, 24 Sep 2026 17:27:38 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> When an MPAM MSC gets into an error condition, it can trigger an error
> IRQ. We cannot really do much about those errors, but we at least query
> and log the error, then disable MPAM functionality.
> 
> This error report relies on reading the MSC's error status register
> (ESR) in the current hard-IRQ handler, which is not possible for MPAM-Fb
> based MSC accesses, since they involve mailbox routines that might sleep.
> The same is true for clearing the interrupt at the source, which requires
> a (potentially sleeping) MSC access as well.
> 
> Change the error IRQ handler to be a threaded interrupt, but keep the
> handling in the hard-IRQ part for MMIO MSCs. This is needed since the
> CPU affinity check in the MSC accessors requires a non-preemptible
> context.
> When the MSC is using an MPAM-Fb based access, we push the work into the
> threaded part of the handler, where the accessors are allowed to sleep.
> Also forbid per-CPU interrupts (PPIs) for MPAM-Fb, as we cannot use a
> threaded IRQ here.
> 
> The actual IRQ handler learns how to deal with errors. We cannot really
> handle them, but we can try our best to disable the IRQ anyway.
> Should the level IRQ line deactivation fail on the device side, we mask
> the IRQ on the irqchip level, to prevent an interrupt storm.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>



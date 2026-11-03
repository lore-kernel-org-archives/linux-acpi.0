Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739746;
	b=ZH1usgekNka9AhYxuA5h1hFTR/sbZvzSOFPb7zPAQFl8hgQPN7Ocjy9cdv1n3tzGTkGy
	 pH2lj5zSCA3wLps8qx/UdWA7jikuCBlucdJSSND4lu/qyHdMzq7F9Qy0d66L0WNgXekDP
	 FKxHI9Ynp8heR+bmIHaFpKC0GZJX84ONTDGVXnloQpS2Qi97s3tLGbq5VkfEEoeC8KB0x
	 4n3UQT7NmP7HOJ4h55HfV5CAsQxi5+1lV4KT/prp9uRm+vOUGWxnjEbHLc9UyC1WnSiqy
	 DiY/9Yz3XHo8NhVuiAxb5WLTI0es3oNwvZThtSVKco02LOD2tTLyBpwwJxGgctcqsVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739746;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7L/kjnfMz9A0ktTU8C0Qq6Ox8RbkPb5fZACdQWXlPe0=;
	b=a4zUGulUwEElBsrFsLcIhpK08YphUKSAA8/6bictQmGKebAkRvpDPxwOlHB7kq2CPlOv
	 LobEsAcHysxHRIk9r8tndTGaKl+mpIQsEdn2b9vc4guOR0D4RU5Dne0B9r/gNB1m7kLyb
	 nIjZYw7sh/Fu5tmiAQ+ZNi+Qhx2JR+sWcJ7KeqEAMI1xNSvbteS2TkYS8bsMSx3vFr3Mf
	 sNsBTcfltYkKDwYNXCbDD0wINodzxPjxEvYrAZ4WviigAh3xKoAlVYXOqk/ADMCnFebVp
	 5nyu0qblMM5Dy4bpQ4pic4nViYsdORVt8BlUIhtjdLfsGBN9fSfbVUy24ht596B+aHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JPiOdnnW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UulFl8sP;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D6B606A328
	for <linux-acpi@vger.kernel.org>; Tue,  3 Nov 2026 21:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79D6B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JPiOdnnW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UulFl8sP
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3KeVG3768977
	for <linux-acpi@vger.kernel.org>; Tue, 3 Nov 2026 21:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7L/kjnfMz9A0ktTU8C0Qq6Ox8RbkPb5fZACdQWXlPe0=; b=JPiOdnnWfA+/xFyI
	p2nW9Dn4LDsEyt3BDwjrQ74Imw4QivpB7aKbeapzNwoDLT1rxw4hZSWvcpO4G/qF
	L7sHNxtHvRHpdjWixSxng+oz9IAB8A0nVsZo9Di62/gBEeuyBSsQHC2l3Kp/1qAy
	V7CmWUbAz4Z+7QL22LsTq5xQdlc7Bnmxujh9oGJJWlWc4pkhfddiJ1VoygyHNpuF
	E3GRBPcnnVY0z4E3889Mng3st8diHFzMIdGY156fyWcMZXT19U7pPWMiylP150p/
	lZ8IMzEXN7qujPBVHaZ8vHfqubNZC7GvahSpiXxoF1f32u1990e7pRm+6X6OL/yP
	miP+WA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqpuv82gv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 03 Nov 2026 21:02:24 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so9898492eec.1
        for <linux-acpi@vger.kernel.org>; Tue, 03 Nov 2026 13:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793739744; x=1794344544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7L/kjnfMz9A0ktTU8C0Qq6Ox8RbkPb5fZACdQWXlPe0=;
        b=UulFl8sPdK9zN/hp0PaOhh+OOznGX2woJsFn99fQ/0uu8tworRqHNH+uNvpLm/idyE
         1m0ObdazIlqsFIwAyyZDqE/nOBtLJa+DeFws89xJifRAiU0EdbuQ8PPYKRwWvoo/cTN7
         4gyty5zjAx/flI6ZcDLADkDlpf/G9RMmjpCekHclL0Y9wVWOHikLA9DlAoke90K3d738
         ZD6pR/MH0M9AN0DWdKC2zRTHQCleH8AO+gwfVyCP3xmkc23aNks8wAjzUImvXBSmc1re
         qkis2nGKkuAWL+2YdbAEX1U9tsekt36ar5sd4DWKAsXzHMSopRjmH3qkjpNNQy9A/Qg6
         IWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739744; x=1794344544;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7L/kjnfMz9A0ktTU8C0Qq6Ox8RbkPb5fZACdQWXlPe0=;
        b=F99/XjW4OB31FPabd2q3pB/1ym1MFgkX+3PFI+m34V6OvLly1q6VFTyyxGCLviAOPz
         TjYTm1U9hbk/buxHx8WCbKsNNpc/BZJFUlNJAyuN0Bn8cNME1eeXGr0Xk9x2/OTutnT+
         sXJWjjbnjZKGSTVprgWTL5iGGKU6Rm2u87BX28VmKdZv0zAVR2Ywvl66zzezZakjd9yp
         P+L5AfW4ar/MLukpYh1syLRh5I9YmcHTsTM8Q5sqLBuTg8urLbP5scADExTvdEYzm5Ch
         9Q7zioPaEwzJ12rh+aZcAovzmf2fWz6JRFpbtPx2dSj2vsJXDlfg3riGcnneRlgvdZRc
         UiSA==
X-Forwarded-Encrypted: i=1; AKwUvBwxxXyExMloIOIlJ254ovSXn90mfDCtHWMaob0ut68Y6sO82WrLwctR1mcZ3dW4CWrjwVM6K4o4g5nv@vger.kernel.org
X-Gm-Message-State: APuU4Z+KPG8zoRWJnqpoCK08Cy8sg15HK8/c3ycqQ83WHDIWmdKmx7KK
	5+zvD2rVtRlIhsDuAJit7X5whLxe16k6N2YI6MxMntiQ7U6skbO5x+rYVtJEMTxCNv332Z+y5o7
	iz1j7MZOMLIFIuLD/iuvRfT0WdnZcWTQOGOc3Bh9kik8RS9du1jSQFSFMxuz2Ly8P
X-Gm-Gg: AYBFou2jt9+IaLSGybjL9TldckdieXIlg6zLvqaaCEFCRFqwsFYlgrGeongr24wQMgQ
	A7Okc1EbBfoecjqhAtFbRvJke3iNqfUiz+qayV+OAGO01SBil8MapiSEeVEZyZ7IcpXpSlj1DVt
	cmpxQuZ1BQaxtlmX7GWthDhCWD6yH0YYjr9IafHozjDtF7OWh2EzgwMZq19TUoIvDPMkiTrEd/m
	EpKiKAIoOETMg9n2RNRXaeMMicC1J8BgTFfisVBSIB/aafpp6y1WOdEtkt8rnA5QKqn2O//fBhs
	Ylqa0Bnh8pZBvnBDU0+6TRO9r8a6HSPRDGwTZsKa57PujzMrfTjqoFI7k4sdnjRy565Ih0mNtKC
	QEM8kzAKmMuQwPwzGfpjEyBlvYA06dOLxfs3gqQsJSb+s0LdsHd1jSyOtAZ1ycDDjMxo7/mwvww
	M89cqjppy2joBEQzl5tHk3+np69w==
X-Received: by 2002:a05:701b:2094:20b0:187:efba:9ba2 with SMTP id a92af1059eb24-1ac5e8e1decmr22023740c88.44.1793739743648;
        Tue, 03 Nov 2026 13:02:23 -0800 (PST)
X-Received: by 2002:a05:701b:2094:20b0:187:efba:9ba2 with SMTP id a92af1059eb24-1ac5e8e1decmr22023667c88.44.1793739742820;
        Tue, 03 Nov 2026 13:02:22 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2de58sm1260017c88.12.2026.11.03.13.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:02:22 -0800 (PST)
Date: Tue, 3 Nov 2026 13:02:14 -0800
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
        Robin Murphy
 <robin.murphy@arm.com>, <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang
 <dave.jiang@intel.com>, Dan Williams <djbw@kernel.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1 2/5] PCI/CXL: Probe the underlying bus reset in
 cxl_reset_bus_function()
Message-ID: <20261103130214.00000b82@oss.qualcomm.com>
In-Reply-To: <auorjXgbVPXZNHZL@nvidia.com>
References: <cover.1793729707.git.nicolinc@nvidia.com>
	<6c09d2f78d4bb9db7f49fa14a6550f5176721121.1793729707.git.nicolinc@nvidia.com>
	<auorjXgbVPXZNHZL@nvidia.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=O6SsLx9W c=1 sm=1 tr=0 ts=6aea4be0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=Zdewuh5ThNVhPH2xqRoA:9
 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: AB89ky6W8wbV4ov_cnt4YLB9JJwlCEWt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MyBTYWx0ZWRfX7sOdfxswZlb6
 ugjJovdxjLIxMNsi/QWCcS4kN9AJMsdMHHCtAqKDMiDaU/tO91/Xmf7VexLflHKaaTe12Yf8uTl
 wh0DiUpf32EXra9vSqctaaYnw9dwISI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MyBTYWx0ZWRfX6P9Q7tn/fsb8
 Ize+CvlE8K9o7pvoLj2fHTfJb2ZBCJaOKr6SMboyw2yJAPam42ljXnIMQSVEME7kCsapj1FXTY3
 xRcgcVAGg6+yMPoWSf25C7fpu1x6iWVV7KIoYM0FR2GqSChEgrpzC7XxA90eC3PYe/WNxorxiVh
 IeLyzHJn97YmDgfn9B8VHn9xkAVpgBHjWwmXSBjQ4rgt/FEgoZsLnTmZSOeHfJdlbSzlvRIzuXH
 8+GrJOuvlkUI80qfrSv1uIOYCheH08Jo31CAnstQXmNf1wu62yKUeMhYahDMGNmUL17//r5NIbY
 uwtNneH2waa3tnjfzT1SEIvpk8GVS9LC6BwXybX/ATv/uMGNAdF6auBcOXxWs/7c9oBwH6363jQ
 zD4WVWa3oipHSnPeyaXw/iRjpoQISSQPY03d4f64eIkM+/dgjq7Dd2Rz6gRTBcFHay9qD56+xZp
 ceoEP+Eo3k/62h57F4A==
X-Proofpoint-GUID: AB89ky6W8wbV4ov_cnt4YLB9JJwlCEWt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030083

On Tue, 3 Nov 2026 10:44:29 -0800
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Tue, Nov 03, 2026 at 10:33:43AM -0800, Nicolin Chen wrote:
> > cxl_reset_bus_function() reports "supported" to a probe after checking only
> > that the upstream bridge carries a CXL port DVSEC. The underlying bus reset
> > can still be unavailable, e.g. on a bus shared with other devices, so both
> > the reset_methods[] array and the reset_method sysfs node end up listing a
> > "cxl_bus" that is guaranteed to fail with -ENOTTY when it is attempted.
> > 
> > Probe the underlying pci_dev_reset_slot_function() and then, if it is not
> > applicable, pci_parent_bus_reset(). These are the same two checks that the
> > actual reset runs, so a shared-bus CXL device no longer advertises a method
> > that can never succeed.
> > 
> > Probing via pci_reset_bus_function() would not work: its cxl_sbr_masked()
> > check rejects every CXL port with a masked SBR, while the do-reset path in
> > this function unmasks the SBR before resetting. Such a port would wrongly
> > probe as unsupported.
> > 
> > Move the port control register read above the probe branch as well, so that
> > probe runs the same checks. That read asserts no reset, and a failure means
> > the device cannot be reset this way, which is a probe-time answer.
> > 
> > Also pass an explicit PCI_RESET_DO_RESET at the do-reset call site, since
> > probe is always false at that point.
> > 
> > Fixes: 53c49b6e6dd2e ("PCI/CXL: Add 'cxl_bus' reset method for devices below CXL Ports")
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>  
> 
> Ah, I missed Jonathan's review tag during the split:
> https://lore.kernel.org/linux-iommu/20260926001311.7c4be583@jic23-hlaptop/
> 
> Jonathan, would you mind giving another review tag here? It's the
> exact same patch that you reviewed. Sorry for the inconvenience.
> 
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> Nicolin


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8548D4E9C1D
	for <linux-acpi@vger.kernel.org>; Mon, 28 Sep 2026 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635294; cv=none; b=amyE0lWEaL6vUm+J7d8QJuUm8QxilyTVeA3ulHDIE6A4oNTfwB1cxFSyZBtjnOINKwE08HKqXJmLBrcXUKPO3OiG/5narFILXAHy8rFVzGlNZASzV0qZ5auvB9qPxVOSNpz1YMAsmyX8NM0y1I0rqZq7hJ9rx5uUgiQKdfh3k4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635294; c=relaxed/simple;
	bh=dlibW/vQ+f9/VdkDSXY1CFVI/jcz3sV6AIMdfgpLZ+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fI3H19ZBhDSjyM5qsCyDpRzY6smP9hJN+XFkN1dQOb5XjrpKcEYbs9xb4vI1FDfahHv8qMXOZIXRSPZad3iGXYjFS3sZAdKqr4NLU4zpTU+KiO2EGVKkajnJA8Ppv9DgBUVD7HQFX9Hz5dtDg3JaNxez64fOuuSrGznQpfQ65xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fjfMX7DC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cOAZbSrU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fjfMX7DC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cOAZbSrU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SLV7Xp3204351
	for <linux-acpi@vger.kernel.org>; Mon, 28 Sep 2026 22:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2LbniYZ7fnuS8HEmKzDH2uTF
	6sC0/heSzXV6COCGwWA=; b=fjfMX7DCgOmRzT/SXFHOJcxZhAEzsF0iR1PEIrfP
	2PdEa/zcK13cRf9T1vNbL0Dg8hnERdJYitVwMvmb37m9I0krzX/UukT9vhI69UR6
	lqjvxKl7o0WKuEzRtia83YRly66FDBtlLzXVBaGcIArK15GzkI4+V7Jo3qKnHnNB
	WWUDb7rAFiT8n24DIErCVv0m+IweYpsJ+XJts7I5Bkj7v6LNsP5UPChyMg5YTwnl
	17gWs35BJN0fTOILqfqy4rlkyEq34pwWHwWd1yeiQZdc2JeUqsGdNEtYpt5jJydc
	cMqZhq9/NSp4oyuHDnXG5V7xrXjmrPUkuhFGqdQp+AYaAw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynb6k54h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 28 Sep 2026 22:41:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-34316295d86so5713676eec.0
        for <linux-acpi@vger.kernel.org>; Mon, 28 Sep 2026 15:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790635290; x=1791240090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2LbniYZ7fnuS8HEmKzDH2uTF6sC0/heSzXV6COCGwWA=;
        b=cOAZbSrUEy6ew/rqHEbmzsgU+NrxQIu7Fj7eIgZClMQ/Ts1buuTxGK95mFycOHD4nf
         y0LYftWpo8SBvIVD9XimZysPhDlR284xUP2h2SEbvdldmw0qhJAhFG8PI+qnO7UMmu8x
         IFo99494ELx+hXVpXDRE3c+mcuBp0hGUbja/+DOwIpI1Nn74QQIcC0b3ACR9u6XzOfM9
         CATr5zZHscKlEuwb3cfMQ+lG6Ui86rXxcvarJ1jdtFFt4Xt8Jcf+8gTxDzBqp2HNhxct
         2Xj3rWAA+f4A1CX+qrrEK1pqu20Hd4RXgikIe1bGaeZxRmci9cg+JgWJ6p59S0SumANh
         +GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790635290; x=1791240090;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2LbniYZ7fnuS8HEmKzDH2uTF6sC0/heSzXV6COCGwWA=;
        b=HTpKlTmjNqM0IBTVYS9m7NpBKoc2YF4YmT6xUgCFzH9JYMmt4RNS8IVe+0Nqdk1qSh
         ge5kOOCN/loGw5udnoGfoMC8Er78WlG4bPfFFYxqh9sxn6JP80VTRgb9caRlQmHsjsuj
         uveT0a5qfdPFdu26IGpQLINzlT5OUUl2+T8ik+6QtwhGQm75rXsJaRn4QIJTX8/du9eq
         KWwy0Ug1p8LM9HEC2TdP5QkcSfMNCdEX/l/ElD05BkXwzhW4vVIZy0M1hbz7o0RfK/Kk
         WQ7/D2aFbBvm/eHKK7kPTTPWPiOwRzCXi8wjDjWyPxqphUn3nq7c/Sxzvdhe9bZPrevt
         r4sQ==
X-Forwarded-Encrypted: i=1; AKwUvBymS/xAOAUZP6F/UNtr9BJSoeXsS/Ma769Bm8fa5vggftYhrsgFtMVBlZaoWZnAfyGZQiZ4TNpcYxmq@vger.kernel.org
X-Gm-Message-State: AFq9FYIfADKanStc9C9+5Um/H8Id2pdIVMZmm0aqiWhNhY+JsB2tl2sF
	McIAJNDtwkSC7pPXjthf/rMVKdTPXKSnRMkrHfPgaNQiFxZx2YDCHDwxp654njBm9SeP55p1v8s
	X7lRersHDBQcVLn+1sWyCxCF7kGprxqEqV+sG3so8wRPruyHFM1EAA0c4ss5fJ1DJ
X-Gm-Gg: AYBFou1s+pyeH5otCb+XMNVC4IfgPaKYCI4+X6DGELjUbbW5lDkOGsZLQ0Pae8fB2oL
	oO/pSsE/H2o1pMlebcogcvRKGI5khlOSDt1pQf3LthsLDEk30thQ44pZHP8QjTtC/sjJtD0yM7D
	WX4RglH2tIAZqaBsJtZ2YgFvEPKaqzmSx2rA7Xv//PokJoZ+xQQvXeQdNrXY6AfneM7aqhuu8yr
	mTaKZKs4dzobmmCSPM0bFUjeTg5mzcWBYC3O3Zvzcp6zcjHUkAMLuJhcAawUbh1Js8dj9Yr2dVZ
	lKIjAalPsZdFlHrNIu0HcO7ypW/9dogoJJF/wXR9/hNSxpM4hLfiFqWz79Qbbm3ciadi81lJvoN
	90vIEhGAbP7Ne0yRkNjrqFtxTKqZXJNiGvrs3WlexHC7Tx7bb
X-Received: by 2002:a05:7301:428a:b0:344:bf6:cd8f with SMTP id 5a478bee46e88-3440bf6d66amr7350718eec.31.1790635288871;
        Mon, 28 Sep 2026 15:41:28 -0700 (PDT)
X-Received: by 2002:a05:7301:428a:b0:344:bf6:cd8f with SMTP id 5a478bee46e88-3440bf6d66amr7350648eec.31.1790635287162;
        Mon, 28 Sep 2026 15:41:27 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34141a49febsm32699771eec.2.2026.09.28.15.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:41:26 -0700 (PDT)
Date: Mon, 28 Sep 2026 15:41:24 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, driver-core@lists.linux.dev,
        linux-watchdog@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>
Subject: Re: [PATCH RFC 10/11] iommu/arm-smmu-v3: Add IRQ mapping
 -EPROBE_DEFER handling
Message-ID: <arrtFFtK7KgQfr0z@hu-ashoraj-lv.qualcomm.com>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-10-2c62125d0085@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925-acpi-static-table-irq-probe-defer-v1-10-2c62125d0085@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA5MCBTYWx0ZWRfX5kyrqSP48OtH
 K7aNH0EgqpXRvZaiAmPWeCtU8tXU+DnTIc0n8itR/H9zRwYuCnWORjFrVljRXkCccFnslLwDDqe
 Hj07BOEsO5zbnpfLJYIt35S5/J605zsdfgp7tz9yfgaFMOW6H/V1ppmPG383l2gXUdFiDSUZtDI
 aMerRGz8x4BaIlhIoFVQRnBDmm8hf7gPOeNQnFgvPnVnLfQKAbiimww3Gm4568ZQY+IGtogHmKH
 3TB4rPLGRrOxeQVM+j7sw68WBrm5cQ41Uz/miiE4rsKs9PDCi4iw+NVYztkzrANFy54JKTMPS7T
 hnxJvTalzmx80pcziB0WKHGmXA5PyLURV4cm9v3HR5fTBwha3msqqj4/XzBS2kLJBMeiDsFfTLf
 KWkQQpBAh5cIcNGUzDBTNIBcSPFiVMraK8SJL9xyyjZV4S27NwnLKfHauQjzpJaw+6KORGfGXJw
 GK6+ktCVJblDngHsp9A==
X-Authority-Analysis: v=2.4 cv=K+e3jCWI c=1 sm=1 tr=0 ts=6abaed1b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=ZUgflM6HN2uMUVLQTkcA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA5MCBTYWx0ZWRfX+Yl/QAKmuOup
 Fq1RcbO4oaSkRuvuouKh1FnDzpMY4Bl0aaVH/nJpCMZiqUC3KvBFwpAeEF/mzKCguiOQF9owPnv
 fb+/JodlQQf9E7e98u+cpKTIEdw0+QA=
X-Proofpoint-ORIG-GUID: TkelGAeeVXc8Ktod2Q0nCPpxcDQw5-iV
X-Proofpoint-GUID: TkelGAeeVXc8Ktod2Q0nCPpxcDQw5-iV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280090

On Fri, Sep 25, 2026 at 09:48:09AM +0200, Lorenzo Pieralisi wrote:
> With the advent of GICv5, IRQs mapping can fail if the interrupt
> controller the wired SMMU interrupts are routed to has not probed
> yet when the SMMU driver probes.
> 
> Handle -EPROBE_DEFER gracefully for IRQ mappings failures.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 5732f3ba0122..1832389916a4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5562,18 +5562,26 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	/* Interrupt lines */
>  
>  	irq = platform_get_irq_byname_optional(pdev, "combined");
> +	if (irq == -EPROBE_DEFER)
> +		return dev_err_probe(dev, irq, "failed to get combined IRQ\n");
>  	if (irq > 0)
>  		smmu->combined_irq = irq;
>  	else {
>  		irq = platform_get_irq_byname_optional(pdev, "eventq");
> +		if (irq == -EPROBE_DEFER)
> +			return dev_err_probe(dev, irq, "failed to get eventq IRQ\n");
>  		if (irq > 0)
>  			smmu->evtq.q.irq = irq;
>  
>  		irq = platform_get_irq_byname_optional(pdev, "priq");
> +		if (irq == -EPROBE_DEFER)
> +			return dev_err_probe(dev, irq, "failed to get priq IRQ\n");
>  		if (irq > 0)
>  			smmu->priq.q.irq = irq;
>  
>  		irq = platform_get_irq_byname_optional(pdev, "gerror");
> +		if (irq == -EPROBE_DEFER)
> +			return dev_err_probe(dev, irq, "failed to get gerror IRQ\n");
>  		if (irq > 0)
>  			smmu->gerr_irq = irq;
>  	}

minor: 

Maybe consolidate the multiple if (irq == -EPROBE_DEFER) parts and
consolidate the return to one place?


-- 
/ashok.raj
ashok.raj@oss.qualcomm.com
Qualcomm Inc

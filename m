Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8583290D2
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439047; cv=none; b=pGu6VMdwRjgyzgY8EL7Pau9/eAh6EPxYD4koAxfclfsYSkz36p8TDAtf8Mh771R3PapHlLVdLHmqvLk82jJfD6t0yYNgzhLigsahsyop7MSzg7B5pUxnMjYYaBOXp1ouaC2203+na43bO2DB37r33Qxy3vhQLpAU6JWhayaOIg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439047; c=relaxed/simple;
	bh=vVYDeRhVpbRKAkNU9h+TDx1PARTZiGHjTEsk5vZv+dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xm7LUBGxXOTWJD69SY2zUumy8/Xg4eWLawpdgWEANV4FAaQPK9dVbYO4hloD2kJ/QGLQJAFeOxsO4aLyyS/fmixAkOi4BuYe/gHWSaOJuNvqDsK/C5j0zx8qazlWANcycG9uBgTuDwPdS1NyWgt/GGWbXM9kboUYIQp1WY408aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bTV+cDnX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BBoUWNDo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bTV+cDnX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BBoUWNDo"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UIQXiV1557986
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 19:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8fla+BUQURBo/7c21A3WNrfVtrC0xwyiRMNM1yGIXLQ=; b=bTV+cDnXEBaExVDh
	LrLd5GEvBQhwYn7tO6tLCTVkdxreycTniZ7QeXiWuT4F6Jp9pPCgNdK1HVE7jKaY
	quhXchMzeEC+gDGM58r2P+esS9ysFT/hAl4dCO6R2z6GbJOhTDLx3NUFWSbi6sgx
	VSPfpu7frI+RV2CI5L9aJHGiuQT4z6/DSn3C+cyAQWcYZJVFmNbr4bLofemp6o5L
	B89Bu/+NOgr+u9kTQwTV+wx1KMiV4x4nNLvXdA1TOkEmPaDpsQtBj7cEMIQk/r4l
	oTwT94NeQ2IaqnhV9rqIDJSyGzK7LqyiquEH4aJ0QUSbRY8gfuSfUBTSvindjgH1
	P6pCAA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frbw3g89q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 19:17:25 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-847a00bcbd0so321476b3a.0
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785439044; x=1786043844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8fla+BUQURBo/7c21A3WNrfVtrC0xwyiRMNM1yGIXLQ=;
        b=BBoUWNDo+RTKs+Hajt8IuEXhz61ObntPesjP03Mx6bwp4NlA4yuEYubBjKw4ZY705C
         SwWTJIFcshMTVrGTqRJTs3A/fDSkrZiZbF6PN0C/3kB2ICVAGNU15TpiG1lrT9hr1ASR
         +KgOtEIz+O3DtxfwAYCKc+i0iB8ZQVygp587mFRnLYmNUdwPu9TYo6ttJhHLrUW5d5+y
         4tgtooNycnvCgBHug8glxbQiabaxuFOc673mNIm6N2xB/joPb3i7VBptvWthovYAcAoK
         TVjJ2Iy0bYVW2Q5Zye/pVWfLnASRWLSQ+VVEDi8ZdtJ1H1FkroyB8mhw3eOnMezcJ0P9
         86XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785439044; x=1786043844;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8fla+BUQURBo/7c21A3WNrfVtrC0xwyiRMNM1yGIXLQ=;
        b=PY5G8QTVnegMCozTxLCEG08fHUkV0uEtB1Z4/vbolmnQnDXdXx62I7XIOYerGTyTaB
         WvkkzFlm2XR3njWE8r/6mWc1NwHKEO5xxoSTHQz3EXwFT4wb0By8edVQksLYVwD7e5de
         YxJfYnWOTjzUkD2ITyZ5jPChQtw2GB3r3CiEG5cTFLilmOVwi97PiIJR4krv1bTlyz1r
         Xf12jj6nR1EcFWgm9i8CBG2r4Hohr3VpfLkMQh4xIxAW5xXRe5D3MBsyW2CgIzBgr1zD
         +2xDXda6Vn3PkmXq+O2mzSfksJBe8zON8gl0jBXFlLDg2Gr7CeQ4IxSP1BnWpCXdxv9L
         MpmA==
X-Forwarded-Encrypted: i=1; AHgh+RoPiDYhDjC9dy2N37HM1HI+pULRJcCJVNGfwSnapnvMxasrjHTKnO9OLryZESld6t+DQrq7B206/kuy@vger.kernel.org
X-Gm-Message-State: AOJu0YzvgBkOvtbp6G/nNTVEt0OIfx9zaJjAo6sqboLKuZOoYyDmJILw
	oWHl4YdX0FCGp9UHjLks6ijtYsA1lN5KjgPoHQqxndC4Jyv971M9wIejg6h2NYRWhAkxF+mTOyk
	Q2jMNjuQ76cKQDXJSHwSFgA/40pF6iJrUNpQCUblbapPeyRAnYCRcvdkPqk9LPIgT
X-Gm-Gg: AR+sD11jm+c3Z/w/IQ+39IieYydrE8MxWUxgEug5aHeU76QiPmo8OSrJczHPFxxRavx
	4rPaKkeD1Xap8Jfq4iFzEt0tEitVg16Jk2cIuvlhakXlWgstONHTk0N7J7c1z7HBiJsV0kk9v2G
	ns+ZnY/CgDWuN2v23Lslg1vhiu39J6YqcC620OexsLpdOFJ3icFYs4WuRUhfQSD2aXn2TeCCMqp
	xGF3O272lO6b6iqgKNfmHHqY3bx3MMOz5UDL5LuXlNPrYaqCOMIadFisnI8knHpcFfAhaHNjm6W
	iwHRA0QZbmoRX/ILqn2luydY5JqCAs1aX2hU0gkDXxoxpFHqH+GfWNbOWLCRJk40awLg7uRHWVH
	2LJkLdWuD61raiZtk/Vn9lQ9Muw==
X-Received: by 2002:a05:6a21:3a87:b0:3b4:6cae:4a50 with SMTP id adf61e73a8af0-3c90075907fmr3944512637.20.1785439044551;
        Thu, 30 Jul 2026 12:17:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a87:b0:3b4:6cae:4a50 with SMTP id adf61e73a8af0-3c90075907fmr3944484637.20.1785439044150;
        Thu, 30 Jul 2026 12:17:24 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e72745b1bsm22343420c88.14.2026.07.30.12.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:17:23 -0700 (PDT)
Date: Thu, 30 Jul 2026 12:17:20 -0700
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
 <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/10] arm_mpam: detect and enable MPAM-Fb PCC
 support
Message-ID: <20260730121720.00002b55@oss.qualcomm.com>
In-Reply-To: <20260730152539.2712312-11-andre.przywara@arm.com>
References: <20260730152539.2712312-1-andre.przywara@arm.com>
	<20260730152539.2712312-11-andre.przywara@arm.com>
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
X-Authority-Analysis: v=2.4 cv=cbDiaHDM c=1 sm=1 tr=0 ts=6a6ba345 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=RV8cvHK6CGr8J9zzExgA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: pH0elVKI71d0s8AYINSWY4x-v7CdC04A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE0MSBTYWx0ZWRfX00ClsDAvBEuE
 jL0PjFuVktP6UCtEB5mDMQ+SEwAN+6bnr3mhfowMKeZpVuzyUpDbOoi0DEGPBHU7sXD/1vFkJGF
 9BTiPe/IZSrO+iBy6zm6L+5Iv3zfzPQ=
X-Proofpoint-ORIG-GUID: pH0elVKI71d0s8AYINSWY4x-v7CdC04A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE0MSBTYWx0ZWRfXzyZyVUNps8RH
 BIIHKS+ojbn5s2UPclvschbfsK79MLFeAq5NZbLx6hqS3jVTHWd96NEz4XdNA6eQa4VSSDapSck
 s9EVH1rm1U3dhVm+jznmwmo2KPe4b+1+nmr7Vr9nF4yIb30XRjnqEBaUaV6EaF07ghH+XRoYoBX
 3hD7meHqxoaKr+6IcOArw4FlgQ9KD2eAIAywCdMS6gb0F0fsggzNzvJ9dENnF0titE3zF5Tdec1
 Mb4puSKX+NzkNBZl7ZjijorWKQzAMBn1XAWcQXH/aHBYkg84iYxG1pxPm0il41EXfO0yoalg0Uk
 xfE9kniMM3+NdLAMDriPkaj/wq9Zfeu98L7cytN9aUJWceJ96DiS45PljipyFW9kAbo670mny2D
 47pZpsOjvO9gTsT719q+9kzepvLkYNve0dI+paawdX26bYmeaO4VXSs5iLEDETX/itGWUHY5wYN
 MsE7XUyVfOQhLapfkyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300141

On Thu, 30 Jul 2026 17:25:39 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> The Arm MPAM-Fb specification [1] describes a protocol to access MSC
> registers through a firmware interface. This requires a shared memory
> region to hold the message, and a mailbox to trigger the access.
> For ACPI this is wrapped as a PCC channel, described using existing
> ACPI abstractions.
> 
> Add code to parse those PCC table descriptions associated with an MSC,
> and store the parsed information in the MSC struct.
> There can be multiple PCC channels, and each channel can serve multiple
> MSCs, so we need to keep track of the channel usage, using a list and
> a refcount.
> 
> This will be used by the MPAM-Fb access wrapper code.
> 
> [1] https://developer.arm.com/documentation/den0144/latest
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Tested-by: Ritwick Sharma <ritwick.sharma@arm.com>

One trivial thing inline.  With that resolved
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/resctrl/mpam_devices.c  | 111 +++++++++++++++++++++++++++++++-
>  drivers/resctrl/mpam_fb.c       |  41 ++++++++++++
>  drivers/resctrl/mpam_internal.h |   2 +
>  3 files changed, 152 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 606ae4af2be9..8490034c7db9 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
..
> @@ -2232,7 +2317,7 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>  static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>  {
>  	int err;
> -	u32 tmp;
> +	u32 pcc_subspace_id;
>  	struct mpam_msc *msc;
>  	struct resource *msc_res;
>  	struct device *dev = &pdev->dev;
> @@ -2280,7 +2365,7 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>  	if (err)
>  		return ERR_PTR(err);
>  
> -	if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
> +	if (device_property_read_u32(dev, "pcc-channel", &pcc_subspace_id))
>  		msc->iface = MPAM_IFACE_MMIO;
>  	else
>  		msc->iface = MPAM_IFACE_PCC;
> @@ -2296,6 +2381,28 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>  		}
>  		msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
>  		msc->mapped_hwpage = io;
> +	} else if (msc->iface == MPAM_IFACE_PCC) {
> +		int ret;

Trivial but why not use already defined err?  


> +
> +		msc->pcc_chan = mpam_pcc_chan_get(dev, pcc_subspace_id);
> +		if (IS_ERR(msc->pcc_chan)) {
> +			pr_err("Failed to request MSC PCC channel\n");
> +			return ERR_CAST(msc->pcc_chan);
> +		}
> +
> +		ret = mpam_fb_check_shared_buffer_size(msc);
> +		if (ret) {
> +			mpam_pcc_chan_put(msc->pcc_chan);
> +
> +			return ERR_PTR(ret);
> +		}
> +
> +		ret = mpam_fb_check_protocol_version(msc);
> +		if (ret) {
> +			mpam_pcc_chan_put(msc->pcc_chan);
> +
> +			return ERR_PTR(ret);
> +		}
>  	} else {
>  		return ERR_PTR(-EINVAL);
>  	}


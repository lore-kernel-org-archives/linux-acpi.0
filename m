Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2813FBEC1
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405496; cv=none; b=HFYeSte7VGi9JVD2bCrXwnD2JuvdNzejZ/ToBVAXt/p5wJLBSgQmxfxuljKwh9l2iVZy+53MfTaHq94BsPqVD7uPLdKcvCYheUrn6Eh6WRqwuOu0c57TZD4wnq0KuNF3MMBmTEk6QaIbrJUUnqKEa1MqsxZ8QapS0j4Ty0pG/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405496; c=relaxed/simple;
	bh=LGe+2CZ85lyKB9CiXmE2NH5B65yfdKPyHuBUXnFSgNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ge07IoqrQZmQzcs4PXtWXJ1oTuITlFGxc18gxV+GLrJjavFdn2hz5XzCQwIdNSZy1c1P/DzII4cGGGKM6XPh/kfSYg4Co/ypbGC/G51onZEVMxQpi7tvCbTGQsasCIUaBZrOMfTT8d/rOKPqtOgHzG9J3ltB3O4iDLjhmL05EBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LubM9gnQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aSe58jAS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LubM9gnQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aSe58jAS"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U9HSom834669
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 09:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J98yx8lwTcA7+HAeL+xCCMseBkr+QOZ0wOi+JvvluAk=; b=LubM9gnQs9Dtp75P
	yc5F3KLeQtmljKIMZNSBtf+F4ugRXdyUpST21bWv7uhlZYVZ+MSoXcBIH5zsXDev
	EAPJvhqGcSrMYe7j3eJoAmT2m6o9j7JV0nm0RPwf1rENglbbrqRuwBw+3H9VdBt9
	iH7eoow3w1P5X518yYrQJ4sqsa++ya//cXtuUBaDl9Zz2vp8PaSKDn4/VFZuJ6ks
	vW7tBStHmLm9VQovLgxWztCF4mnjfE9Y4nKdvxYwGUj5e4s86z90YxJ5/1Ucjji5
	d4eOv9yJ290aVw7V4QgzSE3JCkD0UNgrhA4uuh+T2oBoJhP4rS3gmUa/+DPWtJAM
	eW/icA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr3uqr63k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 09:58:13 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8482b95574dso2431968b3a.1
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 02:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785405493; x=1786010293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J98yx8lwTcA7+HAeL+xCCMseBkr+QOZ0wOi+JvvluAk=;
        b=aSe58jAS9iXcpFxPRIaNBCrNq3tPGnmgmYqjPKkb1/juMAsTQ9lVgBX8lmtB6d7t+M
         3dVSWp9/xlA1GzMFs105X91ghQlrnMADzXagEt8e88dpeK/CpKhxvQiAOwAgKJKDpzx3
         dJl9v9QUSKHB3UJg8nvW21h96qJVuPiJmanu3vGjcWPAifluDVoQd0wo4xsTXtqPvcfu
         9jNGF6cupWa9/iCY6E7lz8D38DJWdmm+uieLHlrmaFngCkfYvKWDb35dwi/0JPjSntUe
         nxnm1TTWotB7so6ySkCYRdNCXBXXXz+hXkNtY0lnoLfFqqPE69GhwuoY0SDEPs9vbgp8
         9bkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785405493; x=1786010293;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J98yx8lwTcA7+HAeL+xCCMseBkr+QOZ0wOi+JvvluAk=;
        b=dy5ZT97IXLnri77wH9Nhkfn1eWxYoiNip1WNc6s5NYh8zJMoG5IoKyLrawHptPoXfX
         JYXZu6FlKL/YXkW6/Lg6R8/C5JJADf4QoFMCYK/qL+DFz3owpvLwon3JWN2+Mu1oqgML
         c5E8fPcep8bF0ahagbnfHB5sLRxkR7r+QrdYBg1ZXU6204j0vnfoH4X8fRRrpIPBzHV+
         EpB1R5RN4fnMwYug+4PyEDHMRcFE/yI/fj8ufA0dV7bN0rCSlX/YSkoADnEXuMqT6FyV
         S+On8cIPXD9DK1BlSkDhQunwP41ZXWsDVqiwDW/6U5AzBN98l/WgwTyg23YoYwxXi/jA
         Hk7w==
X-Forwarded-Encrypted: i=1; AHgh+RqrF6IY5treOc+naLgILzz6tmTFevkcH6NHE5IVkGnhlpDWjQDMnJdG3CLyKJmjxl3BjmxVKnCvre+I@vger.kernel.org
X-Gm-Message-State: AOJu0YziaURKJs3mriglxAUwtTVEEGykZP6XRHMzw2ckzKvDN/RlRS8A
	CeFwn0GJBZGz16HGrTVb6AUVXMrEiab6sYO1zYXzVJ+/LlGbT2uWd2HmOvBv6Hyhh61sWYtLG5K
	+u4xdenOrF2lrnOt5YPxFgRQErURyUTiUVLAV4s+y77BxyEBXiryMcnIHba/hYyxo
X-Gm-Gg: AR+sD11N6BXPZNEBnAQGgpP308JaVxBIFn8ey2f729OXhstYymqKX0EMbW4aDXwRy6K
	Uq2fyIw+52j0GTry6xlyO5AonI1up5zwfAUPgVFocyGb/8HMU6Rf8s0GaioFDlpms3apG7VT0PR
	0+EXjfCMmdxmk/fEFMSweaCjrT9jOJpuc0fTJ5c9S/ukNWcz9oOVrjyG+ROzgvgLdv/Ng/4qmd7
	Hr9JhWJeEVeFX6058RJPsyQGOn/a06iLyy53ETRVUzJvguZRX8uMmmvXjNHyYvg6zvigSUC5uVk
	62giwDzUQwUJd7IWQVQhouD+WHd530MVmuWALvKCBYZApd4vtGtC1pQQcAi1apVgiuIexsFqVUt
	/2qeXE24Z9e8KQ2MhetB/g/QbzYz6qkXe
X-Received: by 2002:a05:6a00:10c3:b0:848:40d0:1a57 with SMTP id d2e1a72fcca58-84ebc4154eemr1987012b3a.71.1785405492974;
        Thu, 30 Jul 2026 02:58:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:10c3:b0:848:40d0:1a57 with SMTP id d2e1a72fcca58-84ebc4154eemr1986996b3a.71.1785405492527;
        Thu, 30 Jul 2026 02:58:12 -0700 (PDT)
Received: from [192.168.1.106] ([106.51.199.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb824f077sm1876183a12.11.2026.07.30.02.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 02:58:11 -0700 (PDT)
Message-ID: <5722b21f-6406-44e8-9b55-7272cf6014e0@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 15:28:03 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] arm_mpam: detect and enable MPAM-Fb PCC support
To: Andre Przywara <andre.przywara@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo
 <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
        Trilok Soni <tsoni@quicinc.com>,
        Srinivas Ramana <sramana@qti.qualcomm.com>,
        Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260729134124.2506269-1-andre.przywara@arm.com>
 <20260729134124.2506269-11-andre.przywara@arm.com>
Content-Language: en-US
From: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
In-Reply-To: <20260729134124.2506269-11-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA3MyBTYWx0ZWRfX18yrxHezupKc
 8Crh6G/q0uAAvAP48Vf6JpGD7Pm8H63M3QrA3XKqQqVckEmPocayArx5HOqQrf1IUiu0u3Vsmor
 gbNjn+7N3fUf8RUWIOJw1hFAsNxwsNo=
X-Proofpoint-GUID: AGGzED5f3h-DlPMYIDfYTv_SaAGUeIT0
X-Authority-Analysis: v=2.4 cv=Do9mPm/+ c=1 sm=1 tr=0 ts=6a6b2035 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=PO1FP6gy+OYP9C5qPHjZag==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7CQSdrXTAAAA:8 a=Q_vOtp3auH0CpEMZiTYA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: AGGzED5f3h-DlPMYIDfYTv_SaAGUeIT0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA3MyBTYWx0ZWRfXwtqnX5aFkT8x
 kQFCAsTtoSex7QInHFEJl77DNakOfgCo9GXw9wQwI4Lkk7jEY1cdk5ol2jKX8VLCzcqaXPbGffD
 VtNWbISTdez63Xo3LpRznubweaYSBW5bm/B89Ih8iMzjd8vwicRnfV9KP8/XkvPAyyFH51SOVjs
 f26T9B5hAD/oNJw+kHlxfZoj9bFnHJSEWGBacJxPFfekOP4g0bJHIpZF09656Qhqjjvm0rUX8Hc
 xhQ9IoYx/UdgMl/9goq0A2lowA/uzuObpQ4chFBmrNv8Ne+96oLC3VAhElz2EWauxOkm7gtGeQc
 9LsuDH0rhKoUxN8xMofOXPPD+MePdLQZpFSmSyS8KwOrBuG9rbnLE1Eze5x19TLEnpRaj1cpu8C
 p3mq9j18fd5+YxbI8YmEyGLEEqo2g22+Ou7EHLsMv5R1bIlw2kwaXFQMyDSnt4o+fyIBYR5dH17
 D2i4s0iLrHFvAmP95Ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300073

Hi Andre ,

On 7/29/2026 7:11 PM, Andre Przywara wrote:
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
> ---
>   drivers/resctrl/mpam_devices.c  | 119 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_fb.c       |   4 +-
>   drivers/resctrl/mpam_internal.h |   6 +-
>   3 files changed, 124 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index e535603d2c7d..e360051f4aa7 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -19,14 +19,19 @@
>   #include <linux/irqdesc.h>
>   #include <linux/list.h>
>   #include <linux/lockdep.h>
> +#include <linux/mailbox_client.h>
>   #include <linux/mutex.h>
>   #include <linux/platform_device.h>
>   #include <linux/printk.h>
> +#include <linux/property.h>
>   #include <linux/srcu.h>
>   #include <linux/spinlock.h>
>   #include <linux/types.h>
>   #include <linux/workqueue.h>
>  
[...]

>   /*
>    * Number of MSCs that have been probed. Once all MSCs have been probed MPAM
>    * can be enabled.
> @@ -2221,6 +2304,8 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>   {
>   	struct mpam_msc *msc = platform_get_drvdata(pdev);
>   
> +	mpam_pcc_chan_put(msc->pcc_chan);
> +
>   	mutex_lock(&mpam_list_lock);
>   	mpam_msc_destroy(msc);
>   	mutex_unlock(&mpam_list_lock);
> @@ -2231,7 +2316,7 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>   static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>   {
>   	int err;
> -	u32 tmp;
> +	u32 pcc_subspace_id;
>   	struct mpam_msc *msc;
>   	struct resource *msc_res;
>   	struct device *dev = &pdev->dev;
> @@ -2279,7 +2364,7 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>   	if (err)
>   		return ERR_PTR(err);
>   
> -	if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
> +	if (device_property_read_u32(dev, "pcc-channel", &pcc_subspace_id))
>   		msc->iface = MPAM_IFACE_MMIO;
>   	else
>   		msc->iface = MPAM_IFACE_PCC;
> @@ -2295,6 +2380,36 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>   		}
>   		msc->mapped_hwpage_sz = msc_res->end - msc_res->start;

Ritwick pointed out in the v4 thread that mapped_hwpage_sz should use
resource_size() rather than open-coding (end - start).  That fix doesn't
appear to have made it into v5.

Also I did verify the resource_size() in my setup by adding prints, it 
did work well.>   		msc->mapped_hwpage = io;
> +	} else if (msc->iface == MPAM_IFACE_PCC) {
> +		int ret;
> +
> +		msc->pcc_chan = mpam_pcc_chan_get(dev, pcc_subspace_id);
> +		if (IS_ERR(msc->pcc_chan)) {
> +			pr_err("Failed to request MSC PCC channel\n");
> +			return ERR_CAST(msc->pcc_chan);
> +		}
> +
> +		if (msc->pcc_chan->pcc_chan->shmem_size < MPAM_FB_MAX_MSG_SIZE) {
> +			pr_err("MPAM-Fb PCC channel size too small.\n");
> +			mpam_pcc_chan_put(msc->pcc_chan);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +		ret = mpam_fb_get_protocol_version(msc);
> +		if (ret < 0) {
> +			pr_err("Cannot query MPAM-Fb protocol version.\n");
> +			mpam_pcc_chan_put(msc->pcc_chan);
> +
> +			/* ret is an MPAM-Fb error code, return a Linux one. */
> +			return ERR_PTR(-EIO);
> +		}
> +		if (FIELD_GET(MPAM_FB_VERSION_MAJOR_MASK, ret) != 1) {
> +			pr_err("Incompatible MPAM-Fb protocol version %ld.%ld\n",
> +			       FIELD_GET(MPAM_FB_VERSION_MAJOR_MASK, ret),
> +			       FIELD_GET(MPAM_FB_VERSION_MINOR_MASK, ret));
> +			mpam_pcc_chan_put(msc->pcc_chan);
> +
> +			return ERR_PTR(-EINVAL);
> +		}
>   	} else {
>   		return ERR_PTR(-EINVAL);
>   	}
> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
> index dbe984241b0d..55c4778a8379 100644
> --- a/drivers/resctrl/mpam_fb.c
> +++ b/drivers/resctrl/mpam_fb.c
> @@ -190,13 +190,13 @@ static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
>   
>   int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result)
>   {
> -	return mpam_fb_send_request(msc->pcc_chan, msc->mpam_fb_msc_id,
> +	return mpam_fb_send_request(msc->pcc_chan, msc->id,
>   				    reg, result, MPAM_MSC_READ_CMD);
>   }
>   
>   int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
>   {
> -	return mpam_fb_send_request(msc->pcc_chan, msc->mpam_fb_msc_id,
> +	return mpam_fb_send_request(msc->pcc_chan, msc->id,
>   				    reg, &value, MPAM_MSC_WRITE_CMD);
>   }
>   
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index a2193e7df57c..e926b7feb72a 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -77,7 +77,6 @@ struct mpam_msc {
>   	/* Not modified after mpam_is_enabled() becomes true */
>   	enum mpam_msc_iface	iface;
>   	struct mpam_pcc_chan	*pcc_chan;
> -	int			mpam_fb_msc_id;	/* in its own name space */
>   	u32			nrdy_usec;
>   	cpumask_t		accessibility;
>   	bool			has_extd_esr;
> @@ -532,6 +531,11 @@ int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
>   int mpam_fb_get_protocol_version(struct mpam_msc *msc);
>   
>   #define MPAM_FB_PROT_HEADER_LEN		sizeof(u32)
> +/* The longest message is MPAM_MSC_WRITE, with 4 parameters. */
> +#define MPAM_FB_MAX_MSG_SIZE	(MPAM_FB_PROT_HEADER_LEN + 4 * sizeof(u32))
> +
> +#define MPAM_FB_VERSION_MAJOR_MASK	GENMASK(31, 16)
> +#define MPAM_FB_VERSION_MINOR_MASK	GENMASK(15, 0)
>   
>   /*
>    * MPAM MSCs have the following register layout. See:


--
Best Regards,
Srivathsa


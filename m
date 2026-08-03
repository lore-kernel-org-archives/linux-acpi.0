Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7FE3793CC
	for <linux-acpi@vger.kernel.org>; Mon,  3 Aug 2026 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785754206; cv=none; b=SaJn3mmSVlOupSGs6UnBlG0ik4ERgM2dequ97azHtX5GF4pvQXCPSpeT5MBmVaPkwjm/nJzQYsSiZXzILaSKxeBiT80DSt5ehXvNwh4kIjfbQAEtj4ip8ONkjtyt0N3TOyfcRtCrxm/FAtad+e8eKIKxidDQ7P0L3IV6G2iDbNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785754206; c=relaxed/simple;
	bh=0OP9Yq7lLye7fVqsZFDSj0MbYeSHPnxCci/0vJaRlok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcNwvu5pd9RE8FACZ0PaR7JtCdrGH6aNqm39jaBVYSlpIa6AoVlhw/Ui+nl8LPG/u2+XbMeHwSWaLp5twJy8G7WxQA42i5lFbXYNhlZJBZl3Vhrrv2Edt2IwNJPbyB6umru2ivYtb7av+3frQonKDWlwuCZH0XvxBMMNvJhNcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pbe/KUvd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GwRHYXUw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pbe/KUvd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GwRHYXUw"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6736SlmA3759185
	for <linux-acpi@vger.kernel.org>; Mon, 3 Aug 2026 10:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9hkRJdHHeh4LvGjciwvxGygdU4Rqbcvkupv7IYudRX4=; b=Pbe/KUvdhObQu9Kd
	yBAUFYkyh9ubMnvIaz52rDPd64UTKuhaP94V/AsmSzr8QlIwqxXBqelkIskbr1qn
	LzdFymYQXZo+gN7HfQRwazb5aUIXmHp873SoxCfytMa0Pr+7TdQSxGELY5CkI8h7
	hBWg1B/VTqwDKe/F3auiU8QueAwCJ7eWVaOdFA2ZZjm/ZmLyhiXkLTNi/3EgDMT9
	eiukH+Esvg9rwPb8NzYgAcX3oQSIiAj0TUQips44gVG0elSTu3vsrcuteDHk+d/X
	Fe5luCkB4RKeIcOJM+jglq1eUWlOohOtquCSmuyCNJajb4RVvSDtvEr1ze5YMlEI
	6/xrpA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrns3w3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 10:50:03 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c860544c077so7768082a12.3
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 03:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785754202; x=1786359002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9hkRJdHHeh4LvGjciwvxGygdU4Rqbcvkupv7IYudRX4=;
        b=GwRHYXUwjkcCG81bZhHU4nvIoR8Ne9ilAmbTOW5M/FWqSGOcACguwEQ3crPqC/X31L
         woe30lIyriXYe6Sxaik3LLSzDXSqCCxS5Bqf1Fvwk1u6ES8gJEB9qg4YxwngSWLqjg5J
         bc/snp09nFyxUpmuq58q4iIrS40qf04H5lUmquqPwrm4GDArrKhCNE2XHY6kpd2AuI0y
         R+z6PEdNrJjL0QQy32ZQXBgx3MTKpingYflV1lTOgnNmu2WjI9/f1sRUur+jVslb5USe
         4ugfFbadXrIokbIOh2O1Hgj+wpx1l8neD4BNdVjcXCH4kAsA47vYswWnuWq6lyaZIdCk
         laiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785754202; x=1786359002;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9hkRJdHHeh4LvGjciwvxGygdU4Rqbcvkupv7IYudRX4=;
        b=DcFIc5Mt57ObKDdxxNGpzkR1lKH87Jv/kiz7/zftZ28Bz9dMvUk/XHInvbH6oyIUw1
         aSIrARf9+DFn7z64EurD6Y57uo2pBBz7XFgkrmPPPVQuHaHhuMw6xhLmjbcdqLVUYdRq
         7o3CeYw3x72TfGJdSr36c6Ak7XJ+sy+DtByTAlABrw6DKh2Oz/mz8o4worqOQb1a55KB
         s0ESv0A5XuQWjP1N8ZZilhC4jTjJfHFbNXxjXVf1lbKiRaxFUpA5uA+EHGdZuDwYc7hY
         kpTKruzj2cl+sic2141WCrvuyiOQc9lge9Qt8LJ4HEbrcoLsZBqVk2sUuqK7d9qZmTJc
         zHig==
X-Forwarded-Encrypted: i=1; AHgh+RqcbvntTD3VeYTqEBrNEttn4YIghchYabrcpl8mBucSfxMfzfxeCqpPG4gmcXx+ZFIEBuoTsnjU1FM6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywumosmt9eha5/S7PLF5TiCUXvRc4NhLLwL67v8QwkoGZSI2Kkj
	EFruTlod83N2ThUXTzNHqkAviMsz74fwT0ZrGd642ZirtzA3zbbsONFKu3hlGAgBUiVyGZVQYTD
	paqrGlW+NvhY5rz7SIEZ4l8smP9TC5ZOMv6Nwmv2SZwPUxhuMlNR24HagHFogjUcg
X-Gm-Gg: AR+sD12XwwoIT/tREY+Dll05qYU+yA7yHy0jY9D7IFF+39VO/J6j3ADfHxjl0bK8Bgh
	Sw8cVIt0EwUm+KEGYPKzQpe+GNZcPzzV364jL1hi8WpvRYelNDtcqe9ZA8zyVsyuyiQS++xm9EA
	vXOxt1cf/FQYEcnzjzyvuEytZ4N9/tiXYA/yHMykgS3MmBYmsWSiAG0EAeOgWK5ioocye+sYUuZ
	j2zmi3kw5YR8So7gCnNT3Iqo70vptTTvbQplau4yARtx1vIbqvTF/oBYmbCPxz4TVXggYJcELer
	iQtlxCLgKbiMo33lYpdX5pds3GUr1u/eRMHykyPKPwchM2D2x4jezGLa1e5e6gjfVAHuXiio74/
	crGewvX+fU79U84Y8NXzcf+J1TuNu6AkPag==
X-Received: by 2002:a05:6a21:e082:b0:3c3:7d12:a98c with SMTP id adf61e73a8af0-3c92a8b424amr9581877637.52.1785754202379;
        Mon, 03 Aug 2026 03:50:02 -0700 (PDT)
X-Received: by 2002:a05:6a21:e082:b0:3c3:7d12:a98c with SMTP id adf61e73a8af0-3c92a8b424amr9581847637.52.1785754201875;
        Mon, 03 Aug 2026 03:50:01 -0700 (PDT)
Received: from [192.168.1.106] ([106.51.196.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153db2f911sm41210280eec.0.2026.08.03.03.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 03:50:01 -0700 (PDT)
Message-ID: <dd4d5ddc-e198-4747-85ce-aef4c569c593@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 16:19:53 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/11] arm_mpam: detect and enable MPAM-Fb PCC support
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
        Ritwick Sharma <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260731170324.2927758-1-andre.przywara@arm.com>
 <20260731170324.2927758-12-andre.przywara@arm.com>
Content-Language: en-US
From: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
In-Reply-To: <20260731170324.2927758-12-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA5NiBTYWx0ZWRfXxSWxM8wYN2nb
 wRVx+MGO9nbJ1Z0jfAHzP5jcPycE6fsLA94e+jfeD/3r+vPwx+7f0xJD74Pg/0ndpZfxwxL/qdp
 4hGcxmCmhCtZXMDSe+UsuQVWJarMkqs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA5NiBTYWx0ZWRfX/GZsCiQ1M64B
 QjHmQgpbX5Zb/Kr9Aj8lqfRjhjiAnQXYeV3+6nSlthdc7beJLxF37jc04KisnopffJQ01pBN2iI
 /jNSkgQqlzvrtU44rSGw9+j4q5kpl7vuhjmFySt4QOqXtR7k/S7kFPZbWwJs/yqJGQq2VYx0nhn
 06lhdr0RwWUSwKM4DHwk7yK4A04PLAeaXbD3dk/D/iJDnpvNKIafFDPqIaEjsiiNV8pR0yg1S3Z
 dcBZxnkqOkGbidvmXU6GQmP1502aZ/9FWuCH94NTO9MuDqH0TuCm2zfe2QGEYqMOwVW4FpxhzOj
 IkUt8Ium/i0KGfCXwt31Ia1weRQ55BDKKY8QmAKyomWaqOGDqQHOdkqU6WtQP4JvngHM9pr9nW0
 fDO9Xy/srCiUJ7L/hGLVpd6V3xTg+tnjaP0w5sWVXAJAjBN6LsIUsYKsqC4+Ow16l37sDGWrTDi
 jVfVDqwJwH4Y4vFUFZA==
X-Authority-Analysis: v=2.4 cv=Zest8MVA c=1 sm=1 tr=0 ts=6a70725b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=eeZ6Vdm3skWBw8YHU2i37Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=PHT_-lC4Pkg6agqfKfUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: U0IgHSiZXbdMG3pMLyqKciAgvlXAjGuP
X-Proofpoint-ORIG-GUID: U0IgHSiZXbdMG3pMLyqKciAgvlXAjGuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030096

Hi Andre,

On 7/31/2026 10:33 PM, Andre Przywara wrote:
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
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
>   drivers/resctrl/mpam_devices.c  | 113 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_fb.c       |  41 ++++++++++++
>   drivers/resctrl/mpam_internal.h |   2 +
>   3 files changed, 154 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index b238feb559d4..40b247a89f8e 100644
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
> +#include <acpi/pcc.h>
> +#include <acpi/acpi_io.h>
> +
>   #include "mpam_internal.h"
>   
>   /* Values for the T241 errata workaround */
> @@ -49,6 +54,88 @@ static LIST_HEAD(mpam_all_msc);
>   
>   struct srcu_struct mpam_srcu;
>   
> +/* PCC channels might be serving multiple MSCs, so keep a refcounted list. */
> +static DEFINE_MUTEX(pcc_chan_list_lock);
> +static LIST_HEAD(pcc_chan_list);
> +
> +static void mpam_pcc_chan_release(struct kref *ref)
> +{
> +	struct mpam_pcc_chan *cur = container_of(ref, struct mpam_pcc_chan,
> +						 refcount);
> +
> +	pcc_mbox_free_channel(cur->pcc_chan);
> +	list_del(&cur->pcc_chans);
> +	mutex_destroy(&cur->pcc_chan_lock);
> +	kfree(cur);
> +}
> +
> +static struct mpam_pcc_chan *mpam_pcc_chan_get(struct device *dev,
> +					       int subspace_id)
> +{
> +	struct mpam_pcc_chan *cur;
> +
> +	guard(mutex)(&pcc_chan_list_lock);
> +
> +	list_for_each_entry(cur, &pcc_chan_list, pcc_chans) {
> +		if (cur->subspace_id == subspace_id) {
> +			kref_get(&cur->refcount);
> +
> +			return cur;
> +		}
> +	}
> +
> +	cur = kzalloc_obj(*cur);
> +	if (!cur)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cur->pcc_cl.dev = dev;

While testing v7 with multiple PCC MSCs sharing a single PCC channel, I
noticed that pcc_cl.dev is set once at channel creation time (from the
first MSC's device) and never updated when subsequent MSCs reuse the
channel.In mpam_pcc_chan_get(), the first call sets:
  cur->pcc_cl.dev = dev;

Subsequent calls return the existing channel without updating 
pcc_cl.dev. Here dev_err() calls through the channel report errors 
against the first MSC's device, even when a different MSC triggered them.

I reproduced this with four PCC MSCs sharing subspace 0. After unbinding
the first MSC (kref 4→3), triggering dev_err() via a test hook showed 
the device prefix change from "mpam_msc mpam_msc.1:" to "platform 
mpam_msc.1:"

A simple fix maybe to use the MSC's own device for error messages in
mpam_fb_send_request() instead of pcc_chan->pcc_cl.dev

> +	cur->pcc_cl.tx_block = true;
> +
> +	cur->pcc_chan = pcc_mbox_request_channel(&cur->pcc_cl, subspace_id);
> +	if (IS_ERR(cur->pcc_chan)) {
> +		long err = PTR_ERR(cur->pcc_chan);
> +
> +		kfree(cur);
> +		return ERR_PTR(err);
> +	}
> +
> +	/*
> +	 * Timeout based on the "nominal latency" in us, from the
> +	 * PCC ACPI table. tx_tout is in ms.
> +	 * Add some margin here to be on the safe side.
> +	 */
> +	cur->pcc_cl.tx_tout = DIV_ROUND_UP(cur->pcc_chan->latency * 5, 1000);
> +
> +	mutex_init(&cur->pcc_chan_lock);
> +
> +	cur->subspace_id = subspace_id;
> +	kref_init(&cur->refcount);
> +
> +	list_add_tail(&cur->pcc_chans, &pcc_chan_list);
> +
> +	return cur;
> +}
> +
> +static int mpam_pcc_chan_put(struct mpam_pcc_chan *pcc_chan)
> +{
> +	struct mpam_pcc_chan *cur, *tmp;
> +
> +	if (!pcc_chan)
> +		return 0;
> +
> +	guard(mutex)(&pcc_chan_list_lock);
> +
> +	list_for_each_entry_safe(cur, tmp, &pcc_chan_list, pcc_chans) {
> +		if (cur == pcc_chan) {
> +			kref_put(&cur->refcount, mpam_pcc_chan_release);
> +
> +			return 0;
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> +
>   /*
>    * Number of MSCs that have been probed. Once all MSCs have been probed MPAM
>    * can be enabled.
> @@ -2274,6 +2361,8 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>   {
>   	struct mpam_msc *msc = platform_get_drvdata(pdev);
>   
> +	mpam_pcc_chan_put(msc->pcc_chan);
> +
>   	mutex_lock(&mpam_list_lock);
>   	mpam_msc_destroy(msc);
>   	mutex_unlock(&mpam_list_lock);
> @@ -2284,7 +2373,7 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>   static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>   {
>   	int err;
> -	u32 tmp;
> +	u32 pcc_subspace_id;
>   	struct mpam_msc *msc;
>   	struct resource *msc_res;
>   	struct device *dev = &pdev->dev;
> @@ -2328,7 +2417,7 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>   	if (err)
>   		return ERR_PTR(err);
>   
> -	if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
> +	if (device_property_read_u32(dev, "pcc-channel", &pcc_subspace_id))
>   		msc->iface = MPAM_IFACE_MMIO;
>   	else
>   		msc->iface = MPAM_IFACE_PCC;
> @@ -2349,6 +2438,26 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>   		}
>   		msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
>   		msc->mapped_hwpage = io;
> +	} else if (msc->iface == MPAM_IFACE_PCC) {
> +		msc->pcc_chan = mpam_pcc_chan_get(dev, pcc_subspace_id);
> +		if (IS_ERR(msc->pcc_chan)) {
> +			pr_err("Failed to request MSC PCC channel\n");
> +			return ERR_CAST(msc->pcc_chan);
> +		}
> +
> +		err = mpam_fb_check_shared_buffer_size(msc);
> +		if (err) {
> +			mpam_pcc_chan_put(msc->pcc_chan);
> +
> +			return ERR_PTR(err);
> +		}
> +
> +		err = mpam_fb_check_protocol_version(msc);
> +		if (err) {
> +			mpam_pcc_chan_put(msc->pcc_chan);
> +
> +			return ERR_PTR(err);
> +		}
>   	} else {
>   		return ERR_PTR(-EINVAL);
>   	}
> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
> index 61a91c6cec0a..7a7fb6d067ba 100644
> --- a/drivers/resctrl/mpam_fb.c
> +++ b/drivers/resctrl/mpam_fb.c
> @@ -37,6 +37,11 @@
>   #define MPAM_MSC_TOKEN_MASK		GENMASK(27, 18)
>   
>   #define MPAM_FB_PROT_HEADER_LEN		sizeof(u32)
> +/* The longest message is MPAM_MSC_WRITE, with 4 parameters. */
> +#define MPAM_FB_MAX_MSG_SIZE		(4 * sizeof(u32))
> +
> +#define MPAM_FB_VERSION_MAJOR_MASK	GENMASK(31, 16)
> +#define MPAM_FB_VERSION_MINOR_MASK	GENMASK(15, 0)
>   
>   static atomic_t mpam_fb_token = ATOMIC_INIT(0);
>   
> @@ -207,3 +212,39 @@ int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
>   	return mpam_fb_send_request(msc->pcc_chan, msc->id, reg, &value,
>   				    MPAM_MSC_WRITE_CMD);
>   }
> +
> +/* We only support MPAM-Fb protocol version 1.x */
> +int mpam_fb_check_protocol_version(struct mpam_msc *msc)
> +{
> +	u32 version;
> +	int ret;
> +
> +	ret = mpam_fb_send_request(msc->pcc_chan, 0,
> +				   0, &version, MPAM_PROTOCOL_VERSION_CMD);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(MPAM_FB_VERSION_MAJOR_MASK, version) != 1) {
> +		pr_err("Incompatible MPAM-Fb protocol version %ld.%ld\n",
> +		       FIELD_GET(MPAM_FB_VERSION_MAJOR_MASK, version),
> +		       FIELD_GET(MPAM_FB_VERSION_MINOR_MASK, version));
> +
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int mpam_fb_check_shared_buffer_size(struct mpam_msc *msc)
> +{
> +	int min_buffer_size = MPAM_FB_MAX_MSG_SIZE +
> +			      sizeof(struct acpi_pcct_ext_pcc_shared_memory);
> +
> +	if (msc->pcc_chan->pcc_chan->shmem_size < min_buffer_size) {
> +		pr_err("MPAM-Fb PCC channel size too small.\n");
> +
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index f13a79a84c58..8859189088f3 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -528,6 +528,8 @@ static inline void mpam_resctrl_teardown_class(struct mpam_class *class) { }
>   /* MPAM-Fb Firmware-backed protocol wrappers */
>   int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
>   int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
> +int mpam_fb_check_protocol_version(struct mpam_msc *msc);
> +int mpam_fb_check_shared_buffer_size(struct mpam_msc *msc);
>   
>   /*
>    * MPAM MSCs have the following register layout. See:

--
Best Regards,
Srivathsa


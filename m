Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE64379C21
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714229; cv=none; b=H3Cat+q0JXSJCnLvJ8IeyiciQ+5lAOG+KkkRByvYqr3aj8NCZxkGbJV7vyBihO41qLB3S85Op2gQExsQtdWcbZ1HUT7+RsvcNA2eDlNMregb4JnPVqF1vKGHxAqDG5uVW3tb1oL4KK0ir/FJ4JDLAwcX2BUc3rgsxAISJRJ2YgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714229; c=relaxed/simple;
	bh=HqEl3Bt6kFa0Omde86v+VrQFqc8+dG5HiyEWqsuFo20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRl3RohL+12kfbt3q50CyCQ3iUrAJ85ZLPDnARM9w+3+wa1Ifeeftv5em0bne1/sE1PkS15rf7WcRlG+m9fQKE1ZVnCla1PJGEMhl+Hoocqj7LvQ1KIHG+R3jQRi7nuAtoG8n26TRzE3CWxlPejUdJheM3Cq00WVYrlCFtwP38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L0F1RjaQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cxUXPo98; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L0F1RjaQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cxUXPo98"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AK3FSj1621110
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 20:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8KLgjpNYs0v7y/M6BplhBL8vKBHGRufOgWeRkV8k6M4=; b=L0F1RjaQTs/zf29U
	20xWEckVJRTAOFZ95UYBN/j9z+RYiL4WMjs5DBR847fbcmUaVxH9XsVWgwXrYGZe
	gu/h9sc+t11fl2bNBF1k3DAzmbH/9BDCArix5phmA8r7RIEwp1D6YqkqKoNb5UZ3
	nO0YIllFmoFdYfcU49sKAGtekEb/hsUNJUYml9dLB2wRLTD/tHju5wcpvGqPNBtG
	3FVWIyXlL0ZnMc7emB+0vA4CazPLI8NrqrIT7RMUwhjW1ncfr34VN7Xy57ihbKWD
	dnq7Am8GtHDT34Muq77qw/zUKJ/FnZIINjDq8AmzvlRZ7Jv1K/57DPOhzaYcE+IQ
	6w13bQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb4rm8m9h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 20:10:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso1970321a12.1
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783714226; x=1784319026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8KLgjpNYs0v7y/M6BplhBL8vKBHGRufOgWeRkV8k6M4=;
        b=cxUXPo98kDPQt33T70UcKzAmZU5uVJbAqTcfOgUnBcsgB9MMf2IxJXCERR8hujUDhX
         fYjOjN7Hi3AkU6zpbszru2laeK363mYrTc9pKYiK1gcFGD4FD3sQdOlIdIpPuHwDWT2B
         WfdLIEYSqd7zc2bHSosQuKKT5zMbyd0yiboD7hPYG8zFXCYl0kYOcnwHh/ZhUDixEahn
         WTl4XBLVaifcBcY3pmwpa6CMfse+cEPA5v12tUsu35twRGalQeblHleYCg2trUcnHhtO
         dGlTPolc186xDCiovM2jIOpzlCEx/KDAZ+Ku3jKVyT2Msii+ccXQJKl/XWcU5kNPldjo
         Q7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783714226; x=1784319026;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8KLgjpNYs0v7y/M6BplhBL8vKBHGRufOgWeRkV8k6M4=;
        b=mgt28AkDQ6CaQ990u8eSU1HRiV4eKTDMQTuGw0ULfC2GDaw66Nh0+2rvbT/ncv76C4
         r6+co5BLZ4/KEYDmH1y8X0/ZfzOneJAesh+59fdX04H2dC2UuGLhaUL4ps9r9LRlZOtE
         727bvlXjtf2nGf/+GlSV6/Q2ibThmQZa37ApgGecKnbp0AKAZy+drvveDxsRK8Wl3Nz/
         LVmX7PDpGMURPnYL0aMdp2BPuu11kmYbkwS7JzKZEbtV98ZzbGPF1hp8cfrutgZFNA/Y
         vxmvafc+MaeeCdipUWqGsx86wVZLp0FTKTnrRF2sTuHQgO+StFbRjhyInslOwizol656
         enzw==
X-Forwarded-Encrypted: i=1; AHgh+RrL1QuYDMEb87rcYX6KsfU/5lY8W7QQx0lbYkjoN/GSAyZ4ZsqjktomWytPGUVLYKwDeBHmpeuawKnY@vger.kernel.org
X-Gm-Message-State: AOJu0YzW/va6BzWpIFlO57qQt2IF7l9lJqiTtxRud406bRxIPe9hc3UK
	x8K1BhaKRocEAUJ2NTsU27UmEoxaHOoa+Na9k1+BIHnlhhtFjMjAXOTh7YawV1mTcSsf7pufkPr
	obFvqZTqhRdT5X1oS3C3JiDqC/lMHyEFtP0RPeYG+p0KtFZBWQslK1AqX5ZxPyEqn
X-Gm-Gg: AfdE7cl56Ir4z1HwJ4NURf1XJbhV81yfDRBJp/TsdESB0POSdNcABDIomaIgvjdf/AV
	NffdpmucdrEeFTBF9lyxvF0fkE/rdSu//RPnUAV+f7ca2UJpTtRl08AI1GA9J/4hLvLf/hqxXFG
	mLcmp6x4/3Z+kFKGTSPnA4s/Li1UjnuroXfewRKS4ub3Wsfj+iUjLcnE6Rl7LZUtrTmSqp5JIBj
	KVdj1U/TQEo65QsM8acWN3tmSgXf9bCHrMQ886240VtfqjjQRCewTx9mnhp+j1J958CYW3qYXjd
	6hA4bUhs9D0lOwnKUm1Jt1RKZLTFpfOosxu9oH13t/14wugCn9ucFtnxAQojK3nND+l3bNFywhp
	963r0eucOoTyCjXY/+V1IhJCa44TQC9iN9gIF
X-Received: by 2002:a05:6a20:9190:b0:3bf:e2f1:1b12 with SMTP id adf61e73a8af0-3c110bdfb14mr484460637.41.1783714226273;
        Fri, 10 Jul 2026 13:10:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:9190:b0:3bf:e2f1:1b12 with SMTP id adf61e73a8af0-3c110bdfb14mr484429637.41.1783714225814;
        Fri, 10 Jul 2026 13:10:25 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659666e7sm50867465c88.7.2026.07.10.13.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:10:25 -0700 (PDT)
Date: Fri, 10 Jul 2026 13:10:21 -0700
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
 <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 16/16] arm_mpam: detect and enable MPAM-Fb PCC
 support
Message-ID: <20260710131021.0000361d@oss.qualcomm.com>
In-Reply-To: <20260710144520.917375-17-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
	<20260710144520.917375-17-andre.przywara@arm.com>
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
X-Proofpoint-ORIG-GUID: OlTnLbMzFJmWBwaJbpHd4Uk5JpLcrTF5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIwMiBTYWx0ZWRfX4qwQtBmIzAuT
 CN9Qgj/B8EbwPU/IzgPVqaDT272zLQzAjVPeZ+iVd8agrB0807waJCyuPAvtdIDTAFI6Ddn3soD
 QpQJ5friRuUPxjdNgWMCKE01w3BRD7HDhV93fCPyaNP9yWYDD0g69bd177JQG4T+FfReZrCyjGX
 rBN2wTDE+/S8Q/Z5Bl09zzan8STFXgFUe1kepWCsSpYDuza/ma/n44dDgs/jaaPvLL6vQ9vsMc/
 z6BiBDjZR5IDjFiUhRkR/heH5IIGrxEYUta44GFArDDPE210UUlcRJATg5JhkO7J5WajavpgMsp
 6AyU0sOEwk/NBi0N2CFlNeijSIIf0RAQ6y/fahnY8Gnzlcs8F6bf7oLTelPqT7CBDfSdbOtVafs
 7gCJV/sSC7YizCz+yoI7nH5p9vUqqtCzGen2Hn6Uo/Z1dgFRWVRmIBpfRHq2Af9EFOeTqzTqxHM
 GYF85BUhlC1A1K7EBbg==
X-Authority-Analysis: v=2.4 cv=JIYLdcKb c=1 sm=1 tr=0 ts=6a5151b2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7CQSdrXTAAAA:8 a=Pap8kj84UmTLi3EEo9EA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: OlTnLbMzFJmWBwaJbpHd4Uk5JpLcrTF5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIwMiBTYWx0ZWRfX2np3bi32iu+L
 EHEUdiefIE1T5sXcdg0ljNuqlEPYdih0BlmGxYjtlmw7ih0nqkd2tpQtll37LVj956w53JeHnjd
 K5LNRnUx+djqhDKlxcnPQWr4Q4kFL6Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100202

On Fri, 10 Jul 2026 16:45:20 +0200
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
> This will be used by the MPAM-Fb access wrapper code.
> 
> [1] https://developer.arm.com/documentation/den0144/latest
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Hi Andre,

A few things inline.

Thanks,

Jonathan

> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 220b4a06e739..7be98f13dd63 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -19,6 +19,7 @@
>  #include <linux/irqdesc.h>
>  #include <linux/list.h>
>  #include <linux/lockdep.h>
> +#include <linux/mailbox_client.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/printk.h>
> @@ -27,6 +28,9 @@
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>  
> +#include <acpi/pcc.h>
> +#include <acpi/acpi_io.h>
> +
>  #include "mpam_internal.h"
>  
>  /* Values for the T241 errata workaround */
> @@ -49,6 +53,88 @@ static LIST_HEAD(mpam_all_msc);
>  
>  struct srcu_struct mpam_srcu;
>  
> +/* PCC channels might be serving multiple MSCs, so keep a refcounted list. */
> +static DEFINE_MUTEX(pcc_chan_list_lock);
> +static LIST_HEAD(pcc_chan_list);
> +
> +static void mpam_pcc_rx_callback(struct mbox_client *cl, void *msg)
> +{
> +	/* TODO: wake up tasks blocked on this MSC's PCC channel */

That sounds like as significant todo. Does it matter for now?

> +}
> +
> +static struct mpam_pcc_chan *mpam_pcc_chan_get(struct device *dev,
> +					       int subspace_id)
> +{
> +	struct mpam_pcc_chan *cur;
> +
> +	mutex_lock(&pcc_chan_list_lock);

guard()

> +
> +	list_for_each_entry(cur, &pcc_chan_list, pcc_chans) {
> +		if (cur->subspace_id == subspace_id) {
> +			cur->refcount++;
> +			mutex_unlock(&pcc_chan_list_lock);
> +
> +			return cur;
> +		}
> +	}
> +
> +	cur = kzalloc_obj(*cur);
> +	if (!cur) {
> +		mutex_unlock(&pcc_chan_list_lock);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	cur->pcc_cl.dev = dev;
> +	cur->pcc_cl.rx_callback = mpam_pcc_rx_callback;
> +	cur->pcc_cl.tx_block = true;
> +	cur->pcc_cl.tx_tout = 1000; /* 1s */
> +
> +	cur->pcc_chan = pcc_mbox_request_channel(&cur->pcc_cl, subspace_id);
> +	if (IS_ERR(cur->pcc_chan)) {
> +		long err = PTR_ERR(cur->pcc_chan);
> +
> +		kfree(cur);
> +		mutex_unlock(&pcc_chan_list_lock);
> +		return ERR_PTR(err);
> +	}
> +
> +	mutex_init(&cur->pcc_chan_lock);
> +	cur->subspace_id = subspace_id;
> +	cur->refcount = 1;
> +
> +	list_add_tail(&cur->pcc_chans, &pcc_chan_list);
> +
> +	mutex_unlock(&pcc_chan_list_lock);
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
> +	mutex_lock(&pcc_chan_list_lock);

guard()

> +
> +	list_for_each_entry_safe(cur, tmp, &pcc_chan_list, pcc_chans) {
> +		if (cur == pcc_chan) {
> +			if (!--cur->refcount) {

Maybe embed a kref_t? Then release. As much as anything acts as documentation
that this is reference counting.

> +				pcc_mbox_free_channel(cur->pcc_chan);
> +				list_del(&pcc_chan->pcc_chans);
> +				kfree(cur);
> +			}
> +			mutex_unlock(&pcc_chan_list_lock);
> +			return 0;
> +		}
> +	}
> +
> +	mutex_unlock(&pcc_chan_list_lock);
> +
> +	return -ENOENT;
> +}
> +
>  /*
>   * Number of MSCs that have been probed. Once all MSCs have been probed MPAM
>   * can be enabled.
> @@ -2208,6 +2294,8 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>  {
>  	struct mpam_msc *msc = platform_get_drvdata(pdev);
>  
> +	mpam_pcc_chan_put(msc->pcc_chan);
> +
>  	mutex_lock(&mpam_list_lock);
>  	mpam_msc_destroy(msc);
>  	mutex_unlock(&mpam_list_lock);
> @@ -2218,7 +2306,7 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>  static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>  {
>  	int err;
> -	u32 tmp;
> +	u32 pcc_subspace_id;
>  	struct mpam_msc *msc;
>  	struct resource *msc_res;
>  	struct device *dev = &pdev->dev;
> @@ -2263,7 +2351,8 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>  	if (err)
>  		return ERR_PTR(err);
>  
> -	if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
> +	if (device_property_read_u32(&pdev->dev, "pcc-channel",
> +				     &pcc_subspace_id))
>  		msc->iface = MPAM_IFACE_MMIO;
>  	else
>  		msc->iface = MPAM_IFACE_PCC;
> @@ -2279,6 +2368,39 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>  		}
>  		msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
>  		mcc->mapped_hwpage = io;
> +	} else if (msc->iface == MPAM_IFACE_PCC) {
> +		u32 msc_id;
> +		int ret;
> +
> +		if (device_property_read_u32(&pdev->dev, "msc-id", &msc_id)) {

earlier patch included of.h, should have been property.h given quite correctly
you are using the generic firmware accessors.

> +			pr_err("missing MPAM-Fb MSC identifier\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +		msc->mpam_fb_msc_id = msc_id;
> +
> +		msc->pcc_chan = mpam_pcc_chan_get(&pdev->dev, pcc_subspace_id);
> +		if (IS_ERR(msc->pcc_chan)) {
> +			pr_err("Failed to request MSC PCC channel\n");
> +			return (void *)msc->pcc_chan;

ERR_CAST()

> +		}
> +
> +		if (msc->pcc_chan->pcc_chan->shmem_size < MPAM_FB_MAX_MSG_SIZE) {
> +			pr_err("MPAM-Fb PCC channel size too small.\n");
> +			mpam_pcc_chan_put(msc->pcc_chan);
> +			return ERR_PTR(-ENOMEM);
> +		}

Blank line here as next bit is unrelated to the bit above.

> +		ret = mpam_fb_get_protocol_version(msc);
> +		if (ret < 0) {
> +			pr_err("Cannot query MPAM-Fb protocol version.\n");
> +			mpam_pcc_chan_put(msc->pcc_chan);
> +			return ERR_PTR(-EIO);
If there is a good reason to eat the error code, then add a comment. If not.
			return ERR_PTR(ret);

> +		}
> +		if ((ret >> 16) != 1) {
> +			pr_err("Incompatible MPAM-Fb protocol version %d.%d\n",
> +			       ret >> 16, ret & 0xffff);
> +			mpam_pcc_chan_put(msc->pcc_chan);
> +			return ERR_PTR(-EINVAL);
> +		}
>  	} else {
>  		return ERR_PTR(-EINVAL);
>  	}


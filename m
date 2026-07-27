Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B991421243
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169648; cv=none; b=YwVzsscoDxqeg04ac/u0d0Ug2ZA6zBJiPWAgg+63Ih7pZHLruDmoK/ARIscLD11GJWUQRWy+GBQkKFryn9FXLT2F0BavR3cMKiutYfbngDDjxQWDu0sl3W44NRuEk9D7kdkG6Na35QdGbD8KS8xjScorjXXlaGzjoTAy3p4Z7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169648; c=relaxed/simple;
	bh=/8nRWMBWbSjazZ7XAGgjQxgB68+7WKCwlgyo7bNfrtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pK+awRyr9GeRapZTRn8R0tzYjXZwK3DIuHOcqnH4B70mnMK54CTyHeYqkUmbQQbwR3zBI0iMJQu0doELpmrTEtspnGSQUeFfPYDtmdN23rDsIaOAXFEkMIR0JmYM0T6FqZrNLPEY+TCDJfjE1v6d6247HNhcYZVS9zLSJ+xgcnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U3EXNueF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F5/Es4hz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U3EXNueF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F5/Es4hz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlpNl4115543
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 16:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GgYsOGPbuwZ7cF9zpsVC93NbLVuyrbBqaRuEzQrNaDQ=; b=U3EXNueFvvEMmiZ9
	Rxim5FgDacmvNTUt7rQl9N+fAJVOnRi67/gxI4ZkDkPXMBProC5V+QgJA1VplnvP
	QqiKgHqhorsd8L2BFiLqJe+vIZmG+svWKe42sOBN1Ik0zETKlbqSoGAbXY7xrCS4
	ksoRkq+tCatRLvOCogrJyHunN4FI2geavPu6aEGlaB1iGzyUHLqUQlHo+dJrqBeZ
	u/ogkh88/l65KQXDiKwGQwIT2WyhwMjg1iySBMUogcbrE5KfjUNvlG3T0DvJFhtO
	DcYMdBMx6bJFZ1IOmzVVyh4SFPlNomVtbmuJ+/ErFetDNN8AQ7Hr4YKReaNAfTbi
	d3FrOg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4mrsrbp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 16:27:25 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb835525b13so3198969a12.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 09:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785169645; x=1785774445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GgYsOGPbuwZ7cF9zpsVC93NbLVuyrbBqaRuEzQrNaDQ=;
        b=F5/Es4hzvV/9/4GhS8AB/qJGaiO+Hr5a9x63VnKIpqhn290jDExMpCcxmztD7rbh//
         m/T4Bp9gK8fuvT9ZCSyCCoKoUatfiO5Yc+I9N+JZ2WN2q7Pbpw2RFoRL+7s3/kaf72nD
         UXO+hjYyKHNGxKX66DfEo83GTnIK8cgcItPAhYPZu6uv6HO6EUUs7k8znu2HFJybsLnw
         QgZfx0iDLGjGNKRpbGI/0FzNUc1CPvuybfj8PhyvGk9E9JmIzmKn3816sdcuPQyKBs1T
         P4ZHoLenCleRcA8YUD2QF+gSudv2Tg6xIKdWcY9xy0p/JvOBfntsxLxUZdiDs2UyRZiF
         OJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169645; x=1785774445;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GgYsOGPbuwZ7cF9zpsVC93NbLVuyrbBqaRuEzQrNaDQ=;
        b=qugbqHmXiinmuv3q2HhxA4ekrjx9963sS/MUV71h8FMSvyDaViuDJLTaS3KOfqMZ4j
         0INAMGr/g0ZJU6VeSNNEvD+N30WcZ/hBVYfxFczcmv16E8ksmGEeMDSQHmpLHQoU0fI5
         lNbtPdy1M+wmt6J6+cqWBKN9obI+3mqUyk8gdLwKBXpYLnQbOsxBzsuHvC/H9ywaMCfa
         WbDkJCxQicSs2xgk8YAnY3LXn5aSM5AY6Y6VeGP0zOPJroYH387j0zmWgXCatvDIDuqj
         6wkxNpFJDNrkX7X5pIFXqw5HmbIkALuKiuypdqiX/ZYdtY61MW6NwK77WzpGrZZRxCs2
         qyPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMy8qECFsxrmvyQD/3zGfwDtsxPG3fcRf0GHrwNs4dELUrFKnSNcKiRpKNZC162p63V58v8Rh2xlLT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxce6az4IffQkQoeUD84N4eUkMgtNjGa09f/gpZKslswplwzJOU
	1u8ooe1XBRRTXwbBYcOEvWq1I8gBkhYFEz68eERf7G8KzqxOjgIJ6zYlpIaNUh5yG5MKo6pHomg
	oBXcwf8ZxDekPK2YudGrqFcaVjOPpYqUuMO+MyGtIiKfq70fjMn5qncZAb8UIV+Mm
X-Gm-Gg: AR+sD12oi6OiIQrtlS2az1nB6XH/omk8wSoipzUvQZ6WDB9B1CmBhgUM0tP7IGEMhZL
	BeYDRRQgk58ejUuokRuCrul10aNlnoN3r7oPMt8aOgmcBWPCmrbFOppIk+H0ZEfemqn1q9DnmO7
	pBI4Eo5Xbi9lom1Mri+kdBgiK7wkRKN3cUrs82CiXYDNXb+BHjtzxuGXQp8AAkH0Pu/0nDa6Ecn
	tbv4HNj33s8zYI0cwDiR/5E+cSuIvawSlbzHSRde0TI0zrmO409knY00Tvu41BR9kobsQGz2ief
	+0oxF8jN4sxHqyr5IHAsquXcW5iWmqChHYJJkNKKE7Ac8RulB1RH2f1AxMvCY5T9PfGPd9m2Exd
	Azn3CIdpC9WNSzlO4eLY/gVAsbB1SkRKb
X-Received: by 2002:a05:6a20:d12f:b0:3c3:83e6:c705 with SMTP id adf61e73a8af0-3c67df08725mr9450559637.35.1785169644725;
        Mon, 27 Jul 2026 09:27:24 -0700 (PDT)
X-Received: by 2002:a05:6a20:d12f:b0:3c3:83e6:c705 with SMTP id adf61e73a8af0-3c67df08725mr9450504637.35.1785169644259;
        Mon, 27 Jul 2026 09:27:24 -0700 (PDT)
Received: from [192.168.1.106] ([106.51.195.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5c53f3sm30947278eec.30.2026.07.27.09.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 09:27:23 -0700 (PDT)
Message-ID: <4faf0089-4615-4fb1-bc07-e52b4d43f073@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 21:57:15 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] arm_mpam: detect and enable MPAM-Fb PCC support
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
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-11-andre.przywara@arm.com>
Content-Language: en-US
From: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
In-Reply-To: <20260723155454.1760823-11-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfX5E+g2PAk7ReK
 TlZiARYzvfmScBFSYrvMpeOrKx8qc2A9OKdy7mzRR4631UsVjflVZ1AqiUzSzUrW6Z4tI4N83V2
 EUoCr7aOYyAbKyOxax6mDP99UuE8EGQ=
X-Authority-Analysis: v=2.4 cv=UYBhjqSN c=1 sm=1 tr=0 ts=6a6786ed cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=P1XCd3+ZtGMRWLP53chLSQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=7CQSdrXTAAAA:8 a=roaC5YTsdUms_DT7MN4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: OHoUIuhc9964P34_HqcG-vl9e_RTCGGm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfX8Xz75eqN12An
 8U82NdpFM4kgft1XNn3OLwFz1PnkK9L/KF+x4xWMoixAdYbeKu3TritC1OX6/hUqRNyKLa8GpdQ
 xnuZtCD/aV61L949+OfEF0PFu4d9WgUJLrN+ykyY35bl8mpyFLYIZj7L2UwM1iqF3PJ42o+KGU6
 C9pXnkcSTnzQJt0Yt1kGb3M54NtW9fw1yQJyE+XRin97xAchnTARUFXVwf+LXRrnLCJ3zwidW/j
 Gm0ub2/3r/KOJpnBorwedbe/QcwRDz7n+m2twfI/wpo3EG+7H7WgU33RXKucz/DzRoEkihxELrB
 FIh0C+KbYHOqAoUE8inJg9zdq6HRO8Pa7iYaWTPhLfy9/9YH+hshx3CsQneikMOPsYcU/j//jf3
 JVzQeM3PuL0eY/eSvS3+sm2BbFrZiCVN5ikRKeGwbdVbi02zydxUJjP6RU50FPeKHoQme6VZybE
 x2Qi1B31D4KncHCXIag==
X-Proofpoint-ORIG-GUID: OHoUIuhc9964P34_HqcG-vl9e_RTCGGm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270152



On 7/23/2026 9:24 PM, Andre Przywara wrote:
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
> ---
>   drivers/acpi/arm64/mpam.c      |   6 +-
>   drivers/resctrl/mpam_devices.c | 127 ++++++++++++++++++++++++++++++++-
>   2 files changed, 129 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> index 84963a20c3e7..ca9b8754ae5f 100644
> --- a/drivers/acpi/arm64/mpam.c
> +++ b/drivers/acpi/arm64/mpam.c
> @@ -220,8 +220,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
>   	struct platform_device *pdev __free(platform_device_put) =
>   		platform_device_alloc("mpam_msc", tbl_msc->identifier);
>   	int next_res = 0, next_prop = 0, err;
> -	/* pcc, nrdy, affinity and a sentinel */
> -	struct property_entry props[4] = { 0 };
> +	/* pcc, msc-id, nrdy, affinity and a sentinel */
> +	struct property_entry props[5] = { 0 };
>   	/* mmio, 2xirq, no sentinel. */
>   	struct resource res[3] = { 0 };
>   	struct acpi_device *companion;
> @@ -256,6 +256,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
>   	} else if (iface == MPAM_IFACE_PCC) {
>   		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
>   							tbl_msc->base_address);
> +		props[next_prop++] = PROPERTY_ENTRY_U32("msc-id",
> +							tbl_msc->identifier);
>   	}
>   
>   	acpi_mpam_parse_irqs(pdev, tbl_msc, res, &next_res);
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index fea3161ffbe9..fc4b5f87fbe9 100644
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
> @@ -49,6 +54,86 @@ static LIST_HEAD(mpam_all_msc);
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
> +	kfree(cur);
> +}
> +
> +static struct mpam_pcc_chan *mpam_pcc_chan_get(struct device *dev,
> +					       int subspace_id)
> +{
> +	struct mpam_pcc_chan *cur;
> +	int ret;
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
> +	/* Timeout based on the "nominal latency" from the PCC ACPI table. */
> +	cur->pcc_cl.tx_tout = cur->pcc_chan->latency * 5;
> +
> +	ret = devm_mutex_init(dev, &cur->pcc_chan_lock);
> +	if (ret)
> +		return ERR_PTR(ret);
> +

Here, devm_mutex_init() ties the lifetime of pcc_chan_lock to dev, which 
is &pdev->dev of the first MSC to call mpam_pcc_chan_get(). But
mpam_pcc_chan is shared across multiple MSCs via kref, so it can
outlive that first device.

If a second MSC has incremented the refcount and is still active when
the first MSC's device is removed, the devm cleanup on the first device
would call mutex_destroy() on pcc_chan_lock while the second MSC may
still be inside:

     guard(mutex)(&pcc_chan->pcc_chan_lock);

I am not 100% sure this is reachable in practice — it may depend on
the order in which platform devices are unbound, and whether that can
happen with MSCs sharing a channel. I also note that devm_mutex_init()
is a no-op on non-debug kernels, so this would only be observable with
CONFIG_DEBUG_MUTEXES=y. But it felt worth raising in case
it is a real path.

If my understanding is correct, would it make sense to use a plain
mutex_init() here instead, and move mutex_destroy() into
mpam_pcc_chan_release() where the kref guarantees no concurrent users
remain?

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
> @@ -2201,6 +2286,8 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>   {
>   	struct mpam_msc *msc = platform_get_drvdata(pdev);
>   
> +	mpam_pcc_chan_put(msc->pcc_chan);
> +
>   	mutex_lock(&mpam_list_lock);
>   	mpam_msc_destroy(msc);
>   	mutex_unlock(&mpam_list_lock);
> @@ -2211,7 +2298,7 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>   static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>   {
>   	int err;
> -	u32 tmp;
> +	u32 pcc_subspace_id;
>   	struct mpam_msc *msc;
>   	struct resource *msc_res;
>   	struct device *dev = &pdev->dev;
> @@ -2259,7 +2346,8 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>   	if (err)
>   		return ERR_PTR(err);
>   
> -	if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
> +	if (device_property_read_u32(&pdev->dev, "pcc-channel",
> +				     &pcc_subspace_id))
>   		msc->iface = MPAM_IFACE_MMIO;
>   	else
>   		msc->iface = MPAM_IFACE_PCC;
> @@ -2275,6 +2363,41 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>   		}
>   		msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
>   		msc->mapped_hwpage = io;
> +	} else if (msc->iface == MPAM_IFACE_PCC) {
> +		u32 msc_id;
> +		int ret;
> +
> +		if (device_property_read_u32(&pdev->dev, "msc-id", &msc_id)) {
> +			pr_err("missing MPAM-Fb MSC identifier\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +		msc->mpam_fb_msc_id = msc_id;
> +
> +		msc->pcc_chan = mpam_pcc_chan_get(&pdev->dev, pcc_subspace_id);
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
> +		if ((ret >> 16) != 1) {
> +			pr_err("Incompatible MPAM-Fb protocol version %d.%d\n",
> +			       ret >> 16, ret & 0xffff);
> +			mpam_pcc_chan_put(msc->pcc_chan);
> +			return ERR_PTR(-EINVAL);
> +		}
>   	} else {
>   		return ERR_PTR(-EINVAL);
>   	}

Best Regards,
Srivathsa

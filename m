Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA6F34CFC6
	for <linux-acpi@vger.kernel.org>; Mon,  3 Aug 2026 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796149; cv=none; b=By5FtFGP4Lwjt180t6nIvUVmPiWjjdCizzLRUBBbiEQMJCEgM9EY//gHqW3ZXvIEehbXU5ezm8ZPVtAQrQmAj0iteUHyvZqaFupHz3MZyOdFsF7hH/tBzmhui4q8KCoseSiZzvjH61iiILkqcQR8DJzhnXBhPTAmqYA/2IE+PI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796149; c=relaxed/simple;
	bh=ddjOipXehAODpjbycR9ZsNGaVtxKMYm+UzQ8H8R4O4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcbDg3wUFNJyCq+J1/TAcAwgxDwblVvvdWG7RVt2jU1Us2AUjRlH+CXVSH5XrvGKAvuglw3VgB1LQNyLmeXGsCH4wlELlKxkgjdxy03iPQAwvocYHtGA0XWpmJASxQrFAGVRtWrs+MA0YZTcV/gMbUwNN1tQ9hJU4IAYsfhtVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PxjIBm1Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h5CVIOiR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PxjIBm1Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h5CVIOiR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673K2Xof2165664
	for <linux-acpi@vger.kernel.org>; Mon, 3 Aug 2026 22:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sZ80AOwZ+2hx6l5a4gRP6Wc1xQDrMzv5eF1oL8ozawI=; b=PxjIBm1Yq1f01leh
	2aY5HGi0wy6fti4bkHOHYHc5whd32Qf4IKp+R23FwjXaS3dTvagqRLFY9ypn8Do+
	NTopKjNr015QQx6Az9Wix03c2VNUGn85L4s3TGSi6wUpbnSx8nxBKdOntcUgRp4M
	03rNOw6Ao/REOzbBB+7CXbUiotLQzdPWFOBWT/R6kDZbO3tGad7Q2jBFbpbzbNwS
	kdHyIYZdWdrMFOISv8eXMxVwpglN2IHRjmtHpUogXP+EP/exMk6KfIhCyobE5JsC
	Zo/H9rp2oILcAHu/dUxhWRPocFcYT1ZFma99wrJbba6ISyNouGiiO81LqCbBeCqo
	01dXTg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu1p4rh3r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 22:29:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-385d2703b64so314375a91.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 15:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785796145; x=1786400945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sZ80AOwZ+2hx6l5a4gRP6Wc1xQDrMzv5eF1oL8ozawI=;
        b=h5CVIOiR8f9Yeb1W16JOhVz4d9KsB4rZMQVv0bCb20lt0ljW6T1mH4oRpjVmdGWS8l
         fVa19hOt6pyYS57ZHZnlWLpo3Dcy+Z2lZCvtkL+8zY8FxAicbIGwK1l3/N48GMLsg0za
         fQJAhh4P1/wtbJlNIgToZ8hJJbn4roR1/SHloPJEWO94XWLCQKl+Y9OHe6Yh2W4w6Xnf
         K2UrFiQGiugHtkFqGQb2COcwNF5lFZnJm+tbty9jaEsUqykMhcDDAIEs2rvfFyQiNppo
         9spL20e7W8MOrv5kQ7E9E4jSIUoA21CnQbwZwEXQ+aXJc0ZiFIzAj5dw8DbByyj9oCZY
         k6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796145; x=1786400945;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sZ80AOwZ+2hx6l5a4gRP6Wc1xQDrMzv5eF1oL8ozawI=;
        b=QhpUgLoQZYMQhS/J+/VC/AEnj91O6aIlE2kPIQ+t4snw9hHe2J0yVf1o7kf/9HiI5c
         JzndXXepqmfFLW/WTzyMxMphonBnPnmbsVo7HM9svXACQwm8+WuyxM5YXwMh68IhLPsl
         YHFP+CF3DpvoRqk19GC2a8WY2ePpAIu9McidG+E3AlCD0LJVHJEoiFJOS4YS/PcPa7vj
         4rpQ2qdBEBuGa7k51CfSmtlXxkvFY9Y+iVvVPkEcOeoFoopdOucJaUb15Wjcea8MMdUn
         hKghnZQWm6AwqERDPxt4zojv7TcUmVW28LP839vfmNv/sdOzmbulfr+apMhJs/EV6VWp
         WcMA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3hqA3W1+5teJcsTF/RbezlRnL+rpQANTaxOu/i7wegTFsCu/OV2RoErcOIvbN2LpVsRWd9I6sCjZv@vger.kernel.org
X-Gm-Message-State: AOJu0YwfVmL6d5cMLm7B5dhSHI+HIVWxdXwCYDjB61Chz03zMK5Q3QcB
	FJZemo4RaHv4ie6y+ilbglvI9NM5srNB0zZKbluAx93NG5TpX3vVcPNbpaWdHJHEG0FUuqZZT5n
	7rqvLlSU1/XmfbhL3/RDlNWX2e87FcaSH1JvuFOTiqBqz6eNCWqVpTImyWMA+KNaP
X-Gm-Gg: AR+sD137enfcCR00vzz9E2GAgBp1vkjFSacmr0Ms//cZEP+f7+4MxB5iPgkgkG8nSYK
	rDgT7UQdcFyCb47/kHZV+k+2CAbi+5/mou1DEaduLMRwwTj4+ECIqLyvNpvyg5Ose4PpeqtXzcx
	p0OkV9f3hM1F5XbhDWimM+BM7gLErdze+0obtYEnNhvdXzvuSFHsjRJDFjbdzFb7LHnilaBuHEX
	bxysEcp+nn0bDebICvfc62jeHvaufp2IHJ2XwY0GZ9dc5Xk2keXXgXSVvSzJHAdABmDEnRbE7ch
	Q9izhT1cG14GhZdtJP4dyHSOuVgtOm80nuirfz7i5Qg12ka8CDCYmDclbJwjRJ/dJ+PPmt4Wwnb
	NwVHao8e2RDKqe25yCZxhuYnWUA==
X-Received: by 2002:a17:90b:4d05:b0:38e:4f31:8412 with SMTP id 98e67ed59e1d1-38fecc2f007mr1071151a91.11.1785796144752;
        Mon, 03 Aug 2026 15:29:04 -0700 (PDT)
X-Received: by 2002:a17:90b:4d05:b0:38e:4f31:8412 with SMTP id 98e67ed59e1d1-38fecc2f007mr1071121a91.11.1785796144318;
        Mon, 03 Aug 2026 15:29:04 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4e44bcsm49863604c88.12.2026.08.03.15.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:29:04 -0700 (PDT)
Date: Mon, 3 Aug 2026 15:28:59 -0700
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
Subject: Re: [PATCH v7 07/11] arm_mpam: propagate MSC access errors for
 mpam_reprogram_ris_partid()
Message-ID: <20260803152859.00006590@oss.qualcomm.com>
In-Reply-To: <20260731170324.2927758-8-andre.przywara@arm.com>
References: <20260731170324.2927758-1-andre.przywara@arm.com>
	<20260731170324.2927758-8-andre.przywara@arm.com>
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
X-Authority-Analysis: v=2.4 cv=auOCzyZV c=1 sm=1 tr=0 ts=6a711632 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=_W4zCIwx36R_oyA-FJgA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: qU-LvlVwdo1t4xdAyAcv1C_p1gNmY0-l
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE5NyBTYWx0ZWRfX+MlSx25M1Qxu
 pebJbBmKwhKQOL/OvqeoQLafYRVMsyEPro2rxpADP8oy0sE+3ZgitLqwpUEtj6zbBNusybpY6p9
 X/GQQ0uXW61IYT2dSHrotM7+LAuiUJc=
X-Proofpoint-GUID: qU-LvlVwdo1t4xdAyAcv1C_p1gNmY0-l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE5NyBTYWx0ZWRfX6A5pw7kPj5Ea
 Gs/knXAUC4xQWuJMLRZaTwT4X4zpYf9MoGOzaNmrhUEK21+TQZPWEseGR3v3mID2SSfhxupVSXW
 rgtq3RSauBQtF4Rje474PIWYXYSEu7Pmta8T5LD69u1hn2+oRZHzphlLaKy1G5NzCJ/ZnK3g7T1
 JORimOMwpRCsbtOQOaB16Tk2yoT3Ki55Mf/geo/9kF/RQ3MUz9CJZNwh2COTSxA/sG2CIQCH+Q8
 vz0uBZKWXQOfiyIjIOTqxdlwesuJJBKj4ssEtWNM/s10fhv8RgAJ2QgppuWrsNXXgC9TlEw8jsD
 KShJfYzh4nat+o/z8HlHvy8bXERQ5Mt2qLXhHAIhuWMZnljlwdz6pgbKTV4Rx/P5NcuuAx8mO16
 U4JqpnttDg739WdTrCvqvipnA6+82WaoWKHSYMPuOX7FZiK1wmMm3Tvq4v54711J6jqMlv9tjrT
 sTsCeDLDKR7yrwz6eUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030197

On Fri, 31 Jul 2026 19:03:20 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the mpam_reprogram_ris_partid() function check for and return

function to check

> errors, and propagate MSC read and write errors from the lower level up.
> This also covers the callers of this function: mpam_reset_ris() and
> apply_config().
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
One thing below to perhaps modify if you are respinning

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/resctrl/mpam_devices.c | 136 ++++++++++++++++++++++-----------
>  1 file changed, 93 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 38450c55e45e..32088ad1d67e 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1601,7 +1601,7 @@ void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx)
>  	}
>  }
>  
> -static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
> +static int mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
>  {
>  	u32 num_words, msb;
>  	u32 bm = ~0;
> @@ -1610,15 +1610,19 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
>  	lockdep_assert_held(&msc->part_sel_lock);
>  
>  	if (wd == 0)
> -		return;
> +		return 0;
>  
>  	/*
>  	 * Write all ~0 to all but the last 32bit-word, which may
>  	 * have fewer bits...
>  	 */
>  	num_words = DIV_ROUND_UP(wd, 32);
> -	for (i = 0; i < num_words - 1; i++, reg += sizeof(bm))
> -		__mpam_write_reg(msc, reg, bm);
> +	for (i = 0; i < num_words - 1; i++, reg += sizeof(bm)) {

Not really related to what you are doing here, but if you like you could
reduce the scope of i via

	for (int i = 0;...

as it isn't used outside of this loop.

> +		int ret = __mpam_write_reg(msc, reg, bm);
> +
> +		if (ret)
> +			return ret;
Personally I don't like this style but feel free to ignore as this is
very much a personal taste thing. I'd do
		int ret;

		ret = __mpam_write_reg(msc, reg, bm);
		if (ret)
			return ret;
	}
just to keep the source of error and check for error next to each other.

> +	}



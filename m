Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05937E2E5
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438824; cv=none; b=TUCTiL3n6S6qPlM1UHu56HaM+rZpo6Jf1tWCcv4QruRWzCrBiN2J3Mpv8+z2p4IJy1R6z2xqaN5hvV0l9I3fnMXC7Zi67MCusEDUwbC4BxuL7GcKaX2l9qIoJeYty2mB1U0WH8Fg/fdjmc56OORs8X46nioEtV7u4YyM2teSs5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438824; c=relaxed/simple;
	bh=ldpaELCenOBf5R76r7uqphdUuePrJgh1ejEJnNJjL8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deJDIp459mfxJkJoZhWmWVC97bhUfa4IXsJOs/6LOV1pTif0JA/dseLE9gQsbEbgqHMpDuW2cBWWq71/74t3FyYKHhuJU8P1ynLCuXeGtQdKPsnF0vKE8Hd1P4skRyBlTnn+o9gtVQ9QNgmldYk48atD17eRZ1NhQPG1oort9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QmqRE2sy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LcOw9F2o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QmqRE2sy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LcOw9F2o"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UIOQ5H1879301
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 19:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qfn2cECZLsHqprJcGxd/mBRupQRn27rJQwENTMwC0N0=; b=QmqRE2syTkGqVp9U
	uOsp8jix3o5QgYKCMjAHgzo6ebANTU+LlQ6d9MqDBzdNzzceBFWaS6ANREc/dEmL
	WCTPheBvT/xBmrJkJZ8hOxvsUdF8Jnw7IDs/WAWfHaZygXQPzg1C5furt75rbPlw
	XyxP9vwXDhEQuNeX2LmZHn+n0WM7IdnjH8sBGCDhkZe7BaTTj99xh0TJy5QuzPao
	HTIMfMZr2Ql7im1ZcqY+udr/rEfXAy2YYYdNk20WeeaCQJrEA4RrO3o6fYqTYynW
	G3zK0DmUG+repXAQO5VjvC7c7dXoVCry8nk1Il/GhgY2cpU52jxrkMGEgHTvRqHX
	rFjAxg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frbv5075h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 19:13:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb6823efcso946365ad.0
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 12:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785438821; x=1786043621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Qfn2cECZLsHqprJcGxd/mBRupQRn27rJQwENTMwC0N0=;
        b=LcOw9F2owD3ERAhjWkYlcKjP8iWuvnuDeDVq4sgAHzpOOPEmq9GmYM6Uqyaok/GBzG
         K/v6htYn0G7WDENzFs8mhsOSHiP77YClZFPwo+u6u4397U9lqNYthqFZLmREzEMqBcsu
         1bdM1lF27WTC3rS6HbyVm8qyiAiyncJW19uL6PDkJz1QzHILUUlSkoG5n5Yn45GqwNxr
         f3XVEP0KwSDtVw5vuELOqnn/8DPl3QmvbaDJnpq8akuw1LNXNYSAPvW2NCF4aLk7346g
         zGuKTs6BPuOn8BMmbe9s7UyuCDd0wb7lP4Q84KCresPL7VCMh4SUup7/4crsJSlktuyj
         2rQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785438821; x=1786043621;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qfn2cECZLsHqprJcGxd/mBRupQRn27rJQwENTMwC0N0=;
        b=XcgFflqAGLEsI3OX6C0TuOXlB9MHIPZA/ra9d31HJDAp+9O18ZBIZwArspR9w4SPFW
         i/KQymosJYaeFG0+Jwzb8DNdkBYCYd85mYst79KTNSpcFjasU2PW9vk44JOq9Jy2oczn
         FLKGtKkrblDb2pZdL5aN5FuRnLbsVL7WREvzu+zanDhjE4kWnM+KHN3CzRTfylEb6JVi
         slZY/cB/CRIk93639ujEGCPknaNLQgLClGrB173x1XoUN7Vwht1jNeSpKiNOiL84J/mY
         1XKiToZWWqBLQ5IlzyJoX/9WOIkNARmUJ+I6YhGgrSbfFiFAAvZZvCfLQ4o0Pll2ayk/
         /HTg==
X-Forwarded-Encrypted: i=1; AHgh+RrGKIavICl5xkK4PqLtIByudU0J8MxD7fqXKmYPpmXizSw9LTzLlUgJvFJ0oWh1Z0G+yMNcIjNl03s/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz33H6Yu4NvL+OY47HUgqZIoOEhHpCjJLCbEVj1GG6bGnAikyHb
	tcdglFurYQ6zlzd+SjNK5fsMo7q8MYAkdQ9/Y/mRnR7JrsSiGQstL/VB6hLByKKNj6XQDXT9LZ+
	KgMVyiH+9xU5VdUQaUP4IXOhKuslqFLA/a0L3fO67Ck84DJZKeDjieuGz3ujCFU/K
X-Gm-Gg: AR+sD10CSWaoaRrqXG+GA/4I9QWnVtgb1d5MrqVWEQ6sj+pn8pDEl3dnfNU48to1JXF
	qX48KHaI62bzlTI5XS1SuRtPeDXjNma3kAF2+fvyUyw0lLEC2zu8sjC0/xR4Skug/LvQBbxVIwD
	VLbMqJ95t28PpTyY7+/XLQ2X5NiWGeph8q5Bqn0rRCQnWHLyIz+gOEMJ8fYJEzl7XFADdMn/Xxi
	iGDr50gDLbLO7xUlrWNEccRSJpk88uu50FVDXlq4BE23/hj1ASG0wDJPRqER9QpPPRA3Q0CxyHZ
	E3D9r5/zCtPQY2mVe1wrBINjHHHwIQFk90QupvHCBFFmUgpZV2etXtIswNKrbaE7Y/Q2y1vuF3T
	91nVUkaJReX564vJ+dHrvZtc4FA==
X-Received: by 2002:a17:903:2f8f:b0:2ce:b8c5:5de3 with SMTP id d9443c01a7336-2d035e50f61mr33614655ad.36.1785438821184;
        Thu, 30 Jul 2026 12:13:41 -0700 (PDT)
X-Received: by 2002:a17:903:2f8f:b0:2ce:b8c5:5de3 with SMTP id d9443c01a7336-2d035e50f61mr33614395ad.36.1785438820777;
        Thu, 30 Jul 2026 12:13:40 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504dab154sm26198193eec.26.2026.07.30.12.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:13:40 -0700 (PDT)
Date: Thu, 30 Jul 2026 12:13:36 -0700
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
Subject: Re: [PATCH v6 09/10] arm_mpam: change MPAM-Fb error IRQ to use a
 threaded IRQ handler
Message-ID: <20260730121336.00002130@oss.qualcomm.com>
In-Reply-To: <20260730152539.2712312-10-andre.przywara@arm.com>
References: <20260730152539.2712312-1-andre.przywara@arm.com>
	<20260730152539.2712312-10-andre.przywara@arm.com>
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
X-Proofpoint-ORIG-GUID: HTB_kdIRXQQNCOZZEoo3WxZ3UVVBL5d4
X-Authority-Analysis: v=2.4 cv=RcmgzVtv c=1 sm=1 tr=0 ts=6a6ba266 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=7CQSdrXTAAAA:8 a=Ah_BjpGRzk7GCQLzXeIA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE0MSBTYWx0ZWRfX4v5yVj6quiEg
 nSV94fS+rwdhh/BjNedfdw+JNJ4deLyeRD2+nslzpQe/b/ctFV32g0BbjYU345KC6vEbcjENTPB
 /hlh21AMlHBqH9gKeodmEuBHpipwhGmNNa5TubI4nZcL/pV7+tmxsUQW6c35W/LJHwi78wkAtFP
 AIrVb5/Y3TSDTUeG4zQlvJLShS42v+B4Kgkm+wmzZZSmVvobrrMAauhMYVn+ltYo61sVRlvZzGb
 eX5VLneEupOXjW3Ijrh3J0I2OPCh4YlqRrTJFCTm3TtWTJhBjGpinDIzswvB9B8HfWevJka5eIJ
 uIyqjUQYj70yq+RmYxHTqIll3PQt7ZpPTQmyIvBHjZJHr3eIEJXwikO4CDLti4VUkdgL525nW/P
 bwI7GwclUQsLM2iyFiyv3HpxFGkRzrC0xRgG9rTO23N3LBJ2rrnVGCcK6kETb+iGPhtQ7xFiVMK
 p8RJfN3MB3vBQXkJ4dg==
X-Proofpoint-GUID: HTB_kdIRXQQNCOZZEoo3WxZ3UVVBL5d4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE0MSBTYWx0ZWRfX270erg78NOko
 o24df4zDRWHQyK2bmJWV7s4WPgz3SV9FIGJaULSckRpZJvweEdX91L0rB73mcNcx9rCEimCj3aL
 de4HI2bUnGU9xKysGXIh1hw3GqDFwnE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300141

On Thu, 30 Jul 2026 17:25:38 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> When an MPAM MSC gets into an error condition, it can trigger an error
> IRQ. We cannot really do much about those errors, but we at least query
> and log the error, then disable MPAM functionality.
> 
> This error report relies on reading the MSC's error status register
> (ESR) in the current hard-IRQ handler, which is not possible for MPAM-Fb
> based MSC accesses, since they involve mailbox routines that might sleep.
> The same is true for clearing the interrupt at the source, which requires
> an MSC access as well.
> 
> When an MSC is using MPAM-Fb, change the error IRQ to use a threaded IRQ
> handler, with an empty hard IRQ routine, and doing all the MSC accesses
> (to access the status and disable the IRQ line) in the threaded part.
> The change is minimal, we just check for the first MSC access error and
> bail out early. MMIO based MSCs keep using a hard-IRQ handler, since
> they must be at least non-migrate-able when doing MSC accesses, for the
> CPU affinity check to work.
> Also forbid per-CPU interrupts (PPIs) for MPAM-Fb, as we cannot use a
> threaded IRQ here.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

One thing below.

> ---
>  drivers/resctrl/mpam_devices.c | 64 ++++++++++++++++++++++++++--------
>  1 file changed, 49 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index daaf3cf48475..606ae4af2be9 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c

> @@ -2747,9 +2766,24 @@ static int mpam_register_irqs(void)
>  					       &_enable_percpu_irq, &irq,
>  					       true);
>  		} else {
> -			err = devm_request_irq(&msc->pdev->dev, irq,
> -					       &mpam_spi_handler, IRQF_SHARED,
> -					       "mpam:msc:error", msc);
> +			irq_handler_t hard, threaded;
> +
> +			/*
> +			 * MPAM-Fb needs a sleepable context for the MSC
> +			 * accesses, whereas MMIO requires at least a
> +			 * non-migrateable context for the processor ID check.
> +			 */
> +			if (msc->iface == MPAM_IFACE_MMIO) {
> +				hard = &mpam_spi_handler;
> +				threaded = NULL;
> +			} else {
> +				hard = NULL;
> +				threaded = &mpam_spi_handler;
> +			}
> +			err = devm_request_threaded_irq(&msc->pdev->dev, irq,
> +							hard, threaded,
> +							IRQF_SHARED | IRQF_ONESHOT,

IIRC correctly you'll trip a warning message for the case of MMIO and marking
it as IRQF_ONESHOT. See __setup_irq()

That was a fairly recent check to be added and caused all sorts of problems
with cases similar to this one where the handlers are coming from variables.

Upshot, you need to call appropriate registration function.


Jonathan




> +							"mpam:msc:error", msc);
>  			if (err)
>  				return err;
>  		}


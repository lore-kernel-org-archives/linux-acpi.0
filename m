Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969EA27A92D
	for <linux-acpi@vger.kernel.org>; Mon,  3 Aug 2026 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785797181; cv=none; b=R3VyAmJJSliiL/FYjhGLmcy4k4qXvFGKB1y+sUUfLj9WrwjfbFdLrH9SzWEE86+Vlr6GBJWqH/uByE+tE6g74BA3CuHcYGwepaxscMK++VXglR19jLHNPz8FggeP8eS6L0nqbGYhn54C518bCE3gV6gu0sa1yMPrcofFR9+JkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785797181; c=relaxed/simple;
	bh=pBNhm+7IJVXQdUQNd8MXW9Q7j9q1JS9Bk3hiwcP/hdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntSGFyI/44d9PrLN6UlGbjxHDgpMk1iKE0hJkOCZp9Ncgq+sgrU0tElf4Cg3B2DfwGXO0h/1hwZHKQLjDqECaRWu+Ee3knglaIv3D4CF0IvnHmN4L7ggmRe6+K5YD/s8r36LVqC0z81Yk5jvmG4O3WnPoiuuEsHlJ9uDkFB3otY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dPncHTob; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N1RAKzgV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dPncHTob";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N1RAKzgV"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673JkrXb990431
	for <linux-acpi@vger.kernel.org>; Mon, 3 Aug 2026 22:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ld7zw7w+D26Vm9Xh7U9t1auGYWtusnRjK8Wbc8/K4cM=; b=dPncHTobnieZCTIS
	aV2nCorCPU64e2QR3wyF39PfwkyWWfPb5p1zCOfcFPdEsnO5o5Fmh6j+XqtBcNBB
	YAuFwaBl85EaD9AJo71YhJksIrSNUj62+N55Sfav8/oqPLcPu8lqwa/ZXJM6lg6J
	rLI95LirSEwldK8H1vI9H9U/VMyLYigYLR2HpxThX4d199tRxmcmnubk+MwIaaPl
	DmbYDYZdZYu+tom7JapFKeE98l7JpdefnrortprWgcGh6p7spAI9TAVeHL3QLMeJ
	7QrVT+o84Yj0iX+pAxomt0ltWQs+rFUQBjNYYoxdo3G2/Abbg3qxPfmF0i1csJZb
	kybqWA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftx7m1ns0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 22:46:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d004f13426so52985735ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785797177; x=1786401977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ld7zw7w+D26Vm9Xh7U9t1auGYWtusnRjK8Wbc8/K4cM=;
        b=N1RAKzgVeGnWc8RpomNTpi6lQ3RD7Ix7e5HiS/esX8Et/yw6E42/SlCe3VM3XUfE8M
         vIZYev26xs9JJADBjacwzuR9qtyV8Sws5ZuD3fsBOBoaXpTjHJlpCbcbdg31R0ZhQyw4
         SOBDcddNDCzmd6asNWLzuAWTM6MHgOhAML2Id+SzDKP0t41PkMFY86bWnRGG7p/MiiUy
         QKX1RrNc34XKLawD1KO8pzZ+HJ4ojMiLdM/3+ZguLWG/uOMVqrx+t4JCmvkMjN1JGBPw
         Vzu9A5Gv/SNOhSifoTvIH0uR/kqJCUbgA14YQw8NXvGqAHrcfkj109/FAL6wmJT98jm5
         l78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785797177; x=1786401977;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ld7zw7w+D26Vm9Xh7U9t1auGYWtusnRjK8Wbc8/K4cM=;
        b=lDu+fJ/Md4/13EjFsQbpcQK7sXuLIDQQDGu2GGU2sm1ZvmOsK4cfREicwHkhbdB+5Z
         HTQKNEouXGTRP26CqjuBchxXhpq5VhBTuCjkVe7tigfAp7kGmFxPy8/Gt0LciEFIJ7Q9
         B0tNNfX5ceBTfAxr6kgfMLNT5tQVO9E89++tKh6j1d5f2JSltjCyS3l+k4/LDMsCyiz/
         MzzasnVZktxCDwyNRUIKtGXTGGlHTPjIp4x/JjZQYef/+5DVN+0sqHh5B2f9wbhlSJRY
         CVRcY0R8QBJbmgMShp0K9e5wCC5gGDOqeoWeYIus9E3Hmaiuf5Q+L9y/bqHKCqnaevGd
         /x8w==
X-Forwarded-Encrypted: i=1; AHgh+RpD/GB5CtOCVsdn2nh/0qsR2521bRSLYZLPJvXcF2Gm8qcJYMuAF+Y8lFFwdZavNA+I/234QxrRL/EJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb40cnmz0kNr9hBCtPocSvGQyQ2/Qv6NK8+g5Has/0wr7FENtb
	+lSfVCjAgMo7+HkWM+SPEht1XS+ii+CQYoJ6fKj1QSWtV3Q5wvb/qFumi5uzGveazYWsyfmbZR/
	lB1zhkQq4vtDlCybHChB69Tukoq6JoVxQiA7bLqwkD9+R2zlGVA5rtAb6Ld4HV8TD
X-Gm-Gg: AR+sD11bWwSbKBNkTrDrG2/jnEdrv6+PJq8FjCk72YU9HI67Qcabps4VSez/MY0oQSE
	VGLUMiWiOXAAQ2Pf6M9Z3jDiq3WOK0BIdaciA0PsjVYrJk5zA+Z15+nc61clPK912p4XwGZwf0W
	05PCKpGeGQPcWXU+MeBSY/dphRKTdTZzi5465586xanOScGK157nYKmDSbUDRvCQ3C1t0wjgAQk
	nTJlZiQ8zjVJWicM3I57pBdjq4jgIU/WJnb2SMM7p39F7AXOQ6wNtfrFEpGs5eR305NaZ+Wz0wE
	RxUa/wdGjYDzp328w6pX38ycOnIBOunQ8SdEwUSio3lzCjf/ehbt31CJMQxiJOjyYuvYL0gBQBo
	AO6cXDUSyzCenl1liLon/OchGug==
X-Received: by 2002:a05:6a21:9f10:b0:3b4:931c:3c7c with SMTP id adf61e73a8af0-3c92a7bb452mr11971731637.44.1785797176771;
        Mon, 03 Aug 2026 15:46:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:9f10:b0:3b4:931c:3c7c with SMTP id adf61e73a8af0-3c92a7bb452mr11971714637.44.1785797176358;
        Mon, 03 Aug 2026 15:46:16 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab2530c0sm34545273c88.8.2026.08.03.15.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:46:16 -0700 (PDT)
Date: Mon, 3 Aug 2026 15:46:11 -0700
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
Subject: Re: [PATCH v7 10/11] arm_mpam: change MPAM-Fb error IRQ to use a
 threaded IRQ handler
Message-ID: <20260803154611.00007d6d@oss.qualcomm.com>
In-Reply-To: <20260731170324.2927758-11-andre.przywara@arm.com>
References: <20260731170324.2927758-1-andre.przywara@arm.com>
	<20260731170324.2927758-11-andre.przywara@arm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE5OSBTYWx0ZWRfX3rJC9ETdXm0k
 y3ylYDYVBx7xmEa+o1+4j3CTq53ixfijkhm83UyPLgVsAnbXeC8pqQXFk6We0+HvZgt5dVjyBSu
 RXgR/5M435bdCeHr7vop9BylZdkQYBHvRjk3BbZtFajDGJJ1ffKWVQbcq7vNxDFXOABDREtzDJv
 6ZJuHMbLdRk33AstK3dPfNuQ1yEXRnnWivTTwtDEBGksZBgeaB6hOVdl/uwX+clwNy78Ysuuo3A
 Yi/F4RmutVnJzePPnHCvPRjrRzttQ8bEmpCsfYK5xGI1csbB2ge/gPijKKiZZBIkfQZAkTU32eo
 6y4FPABzVpDkeQR6iGOVwG4qBByDUiQBJbz4MtnmBW2Wi7o6KeqLMMQM824btm4X0bRFocxuoW2
 jNjQURFiDUL8APzon4RBUiQkK0h3eDVPSGGzJgiVCK4h9p+HnLIko7LZkenGjz52awTOY1nm9/n
 0Kz2afqz7anvpRSSqYA==
X-Authority-Analysis: v=2.4 cv=TIt1jVla c=1 sm=1 tr=0 ts=6a711a39 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=ePHNPm31KbGbtx5XAOQA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: i6nDmEh8g_bUpXRuL-rRTWB5TDiwfSLf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE5OSBTYWx0ZWRfXzEAxsWfUhwsj
 jjN+I/KX7lQi/eWXJJOdn09udwCDJ+QIxRXcoN6vIjyx3VvRZJjMoBHVbQplccSo3IsJyn6s7d9
 jz+hd0o6vb06kqPGgJJ9zIWfcTZTUGQ=
X-Proofpoint-GUID: i6nDmEh8g_bUpXRuL-rRTWB5TDiwfSLf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030199

On Fri, 31 Jul 2026 19:03:23 +0200
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
> Also forbid per-CPU interrupts (PPIs) for MPAM-Fb, as we cannot use a
> threaded IRQ here.
> 
> The change in the actual IRQ handler is minimal, we just check for the
> first MSC access error and bail out early. MMIO based MSCs keep using a
> hard-IRQ handler, since they must be at least non-migrate-able when doing
> MSC accesses, for the CPU affinity check to work.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

A small thing inline about a refactor that I can't spot a reason for.
May it's one of those cases where the code evolved into something that
would benefit from another look.

Either way I'm fine with this
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/resctrl/mpam_devices.c | 52 +++++++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index ea08c12f717a..b238feb559d4 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -2741,19 +2755,19 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>  			   msc->id, mpam_errcode_names[errcode], partid, pmg,
>  			   ris);
>  
> -	/* Disable this interrupt. */
> +out_disable:
> +	/* Disable this interrupt. Ignore errors, we need to proceed anyway. */
>  	mpam_disable_msc_ecr(msc);
>  
> -	/* Are we racing with the thread disabling MPAM? */
> -	if (!mpam_is_enabled())
> -		return IRQ_HANDLED;
> -
>  	/*
> -	 * Schedule the teardown work. Don't use a threaded IRQ as we can't
> -	 * unregister the interrupt from the threaded part of the handler.
> +	 * Schedule the teardown work. We have to defer it as we can't
> +	 * unregister the interrupt from the threaded part of a handler.
> +	 * Check whether we are racing with the thread disabling MPAM.
>  	 */
> -	mpam_disable_reason = "hardware error interrupt";
> -	schedule_work(&mpam_broken_work);
> +	if (mpam_is_enabled()) {
> +		mpam_disable_reason = "hardware error interrupt";
> +		schedule_work(&mpam_broken_work);
> +	}

Why the logic flip here?  (!mpam_is_enabled() and early return vs
if (mpam_is_enabled())

It seems to be doing exactly the same.
Is it to couple the comment more tightly with the code?

I don't mind it done this way but it is a reasonable amount of churn
for no strong benefit that I can immediately spot.

>  
>  	return IRQ_HANDLED;
>  }

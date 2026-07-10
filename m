Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94DF3254B3
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707726; cv=none; b=r87Nn5IiuXtRBdbLaccY6cqVfz79vX59FJGJIUuAagSG2wr3J4kAbwSGjmywIKYFfgcx5ZhZBnyWe0Uc36lb9UxVFk74cW7VJ3pVIglWZgYDkovYQu3//f4iEHibqs62S0CjZHMYN5fQRM4aSueu3KM1bdqdqcZ2ts6Nohs9tcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707726; c=relaxed/simple;
	bh=cFuUZYwm+ytzPaDMmKj7V3L1voXoBSzcy1/+PMu9EGs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gin/oAoItzVRtB1g8+8b7zwm4nzxT+kschxurTaemCryF0FpczJ1U/I72VPxzarIWkMNNTVXXiKIFafTlT/f5sqqgxVYqcBkbJO+4nGzgxp7Aq7kOqXBrLGgleBQ7BAHjG+RflwTAAsuIJHmai6GuN+AWdI9iN2VtzsXCoDG8rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jt9Car9A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d57r1vvs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jt9Car9A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d57r1vvs"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH47Bi1308346
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zp3AkSb7kz6GKD3cr/eSusRHkHnQftat49AwvvVk17c=; b=Jt9Car9ArCHFFtvH
	+qZq2mY2PacEFBIKMPX5bjlqvFazBPjBEJVijdnnw+joPCLvckjVg0Cqghel9MH5
	mvdjwHTbWV641nYGrkptZT50oU/tuOQa6xNJsD2e0IQXFFATD1h7+9HUgGEchgKv
	9Idg+7LgHqyl/t2TiOZ39/So/ROZj0Bw8bXZY7+ibpwduQSL3dKfXh88zbH8y0Ut
	hLwoF2MN3UvKr4btzt7b19NmEb00vVPHgdk6KLlgp1G3BHKAzcr+5GzSsGS03eQ/
	IQBTnQnQ1pkC0hjHyJGrwTEE8XE//dV4c17JYcZM40Z1uvZbNehTc69QcOwQJjW/
	ENSTgA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5dhxty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:22:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-381ed6616f7so1909127a91.1
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 11:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783707723; x=1784312523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Zp3AkSb7kz6GKD3cr/eSusRHkHnQftat49AwvvVk17c=;
        b=d57r1vvsvIYtHpgUV8+Ik6XSQ7AgetWSyB7gHdKi2yDNpFRH05ucvN3Gd/3JpGfeOp
         jGupqrou34Jzgt1lXdRyYC6iRdTW0aMRAskEPKxdzJTHDSKVALea5yB0qKQv0b1+FEAv
         hd0d9djYZYpVHHR1YRgzsVXIdEInVm6BY9GC4nlRzv4F17CiWcBAwjTegYXcl85+9OKJ
         ljH7OlxWTyR/RYOytYg543TSrxppHPA6OrZnIdR2XvCDi5qvpJBYeahMLQZdxknxME7e
         njM/zZ0V+nfoctqqInx6O/oMz9MYUrUKGhbxREhIhKPjpVXYF3za2EEBaPGTkG41ln6R
         CK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783707723; x=1784312523;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zp3AkSb7kz6GKD3cr/eSusRHkHnQftat49AwvvVk17c=;
        b=ZoV7xf2s2k+Wakr+kyJ6MvSUZkBIyDiAzIsYI47JHyp3xPFXf3e5KlK3OB/7iogbKi
         ZNN/YEnHbXyDxqbPavADZDMejBFLoMeQchgMOW/s5TDUAQ8Rjppr7gCh6WZmQdjs8zxv
         ywxhNheON1cbdEuuSjsptVdwuWWfgpfsI/vUzE1d/zFuLSWiyf9SN778Oe7Sx2IByUAF
         kYzaN1azw4cAXsHXQTL6KuR3o4MA98OyDlA7he/covZfufxDS10EXdsngCTh+YgoGs8n
         mO0IO/x5p0IOElfB/YtqN25xdrSB/6C+7U8iDQAPkCLwhG/NHG5NAX/4BE44bJjULk9b
         YD+w==
X-Forwarded-Encrypted: i=1; AHgh+Rpc1558/rMvBwrCsNKiY23hLotjUP0H+kDOGnwoxbmQWlPilKJE4TvGDjazlXCIbPvXirNyeXmhm+FL@vger.kernel.org
X-Gm-Message-State: AOJu0YxZPSRM1qLUA+9Qagr3WQJIPAwDlrVdfR2Bddn2gJhMQSTDOfgV
	lfzA6auzQYQJuDt5pNae690st0mLCIhTt9XiJccvSrNrFzZvVn/0VlM9wNR2yaG1AxHYCVdSx/J
	PrYsmJxBuK9I6eDLO89gF32i1QXvfaYCJI/XsXiLFef3IWXi+WjdGzW7+trZZmEVp
X-Gm-Gg: AfdE7ckl58Dffh/eA+tIkWU1nV/WFUWs4ug6J0addRx2zMmTYa7adysnhusyUHowSpT
	bJXz+35RJBzfjZm80UU2AweLrDwGjZ49QxYme/ImepbF7fcMSZgVc45zbdCERTqkbc6MBPImKVM
	SBnQkogH3a7MAYu01NmLDJa6QzgbhWKajDapRlJcOpA6xez0z62HO7jPWcFiNWFf+1C5305ew+3
	4MIRnS10ZzoHJyUZmAr8TF6g3V4BKWp73m/I9liKvgMEZk/RXjWobcvjUncI+dyAcXEmzSCaS20
	vd+iQjVqVbPCI/3DNRHldNMzUZwfltwZ7t79KRXtNEAUilwqVLc2nFsB9ps8h+sO4WTE/mImVAp
	TeFWn5u8O/FB+Wg26ip68chz6T3KeATBBTBnP
X-Received: by 2002:a17:90b:4c8f:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-38dc75d1ef9mr95678a91.2.1783707723255;
        Fri, 10 Jul 2026 11:22:03 -0700 (PDT)
X-Received: by 2002:a17:90b:4c8f:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-38dc75d1ef9mr95627a91.2.1783707722569;
        Fri, 10 Jul 2026 11:22:02 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483dec6sm44025766eec.11.2026.07.10.11.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:22:02 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:21:58 -0700
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
Subject: Re: [PATCH v3 02/16] arm_mpam: propagate MSC read errors for
 wrapper functions
Message-ID: <20260710112158.0000490d@oss.qualcomm.com>
In-Reply-To: <20260710144520.917375-3-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
	<20260710144520.917375-3-andre.przywara@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE4NCBTYWx0ZWRfXz4KOhJ2z0nJ/
 DrKS160JPzA7Zajp47SYp15fvirJGrxxnzn1R++gS+HIrLz5uTj6f0o5j3/LzQGG1OV+CqpmPSt
 2QA9Mkm4JjQ5Sim/rXQLz1Y4YX/dIr0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE4NCBTYWx0ZWRfX5hg+Xnnl+zNb
 AcN8BPhla2n5rljz3RNEXF0uhI8uuvGUK4s2WTRzNFlvkEPL5RGK707oaYg/7l+m36qmtrIjFZj
 pzUrWaK8FDBsYs+Ba54Lm609UFrWzuKTE1zqzlnhBQwnTEC4JHnRTQsFdziw+WX5wKjPYYSPidC
 +lRsKzmcClJ3Qq/BuOFuuqibmssLvxEdFUC2RRxuL2GxCdfqu0TyJFEkBTPi5eqZewc4WukaQr/
 GkEWu6VK9IISoAywaQxNojemq+q9pwnRFJxzU0c7nMQOY9ikvOtN3Dk7sDr8EQkBgTDsRgkDe6R
 fRtp5RAIXh65ni2jOr+j1hCw8inze0tqXzi2f0NcXHwlmVutUX8M7ReW8GUpHf16n6PoV7BtpPO
 8t267M4+NNY45eEa2z8xmD8I7dHr42Yl2+JWc/EDz/4Xav30AnweUucOge8BYff9/kuLEQbyhT3
 ShSATuzh7f0l8GIFMEQ==
X-Proofpoint-GUID: Ri3Gu2dOih9WTFzr8Ws07AGOtWHxoc5f
X-Proofpoint-ORIG-GUID: Ri3Gu2dOih9WTFzr8Ws07AGOtWHxoc5f
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a51384c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=7CQSdrXTAAAA:8 a=499MpapIjUE8vGAJtSoA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100184

On Fri, 10 Jul 2026 16:45:06 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the wrapper functions for IDR and ESR accesses to return an
> error, and propagate read errors from the lower level up.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Hi Andre,

Just a few superficial code style comments.

Thanks,

Jonathan

> ---
>  drivers/resctrl/mpam_devices.c | 53 ++++++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_device=
s.c
> index df14b4513382..8fd2c38c821c 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -247,27 +247,38 @@ static bool mpam_msc_check_aidr(struct mpam_msc *ms=
c)
>  	return true;
>  }
> =20
> -static u64 mpam_msc_read_idr(struct mpam_msc *msc)
> +static int mpam_msc_read_idr(struct mpam_msc *msc, u64 *res)
>  {
>  	u32 idr_high =3D 0, idr_low;
> +	int ret;
> =20
>  	lockdep_assert_held(&msc->part_sel_lock);
> =20
> -	mpam_read_partsel_reg(msc, IDR, &idr_low);
> +	ret =3D mpam_read_partsel_reg(msc, IDR, &idr_low);
> +	if (ret)
> +		return ret;
> +
>  	if (FIELD_GET(MPAMF_IDR_EXT, idr_low))
> -		mpam_read_partsel_reg(msc, IDR + 4, &idr_high);
> +		ret =3D mpam_read_partsel_reg(msc, IDR + 4, &idr_high);
> +	if (ret)
> +		return ret;

=46rom a readability point of view, I'd indent the if (ret) as well
given that will then make it visually clear the check only applies
when the if is taken.

	if (FIELD_GET()) {
		ret =3D mpam_read_partsel_reg(msc, IDR + 4 &idr_high);
		if (ret)
			return ret;
	}

> +
> +	*res =3D ((u64)idr_high << 32) | idr_low;
> =20
> -	return ((u64)idr_high << 32) | idr_low;
> +	return 0;
>  }
> =20
> -static void mpam_msc_clear_esr(struct mpam_msc *msc)
> +static int mpam_msc_clear_esr(struct mpam_msc *msc)
>  {
>  	u32 esr_low;
> +	int ret;
> =20
> -	__mpam_read_reg(msc, MPAMF_ESR, &esr_low);
> +	ret =3D __mpam_read_reg(msc, MPAMF_ESR, &esr_low);
> +	if (ret)
> +		return ret;
> =20
>  	if (!esr_low)
> -		return;
> +		return 0;
> =20
>  	/*
>  	 * Clearing the high/low bits of MPAMF_ESR can not be atomic.
> @@ -277,18 +288,30 @@ static void mpam_msc_clear_esr(struct mpam_msc *msc)
>  	 */
>  	if (msc->has_extd_esr)
>  		__mpam_write_reg(msc, MPAMF_ESR + 4, 0);
> +

Might be valid, but to me that smells like an unrelated cleanup
that shouldn't really be in a patch doing more meaningful work.  Perhaps
makes sense when you circle back to do writes.  BTW, I'm not sure
there is real benefit in separate patches doing reads from those doing writ=
es!
Mind you I haven't read all the way through yet, so maybe I'm missing some
subtlety.

>  	__mpam_write_reg(msc, MPAMF_ESR, 0);
> +
> +	return 0;
>  }
> =20
> -static u64 mpam_msc_read_esr(struct mpam_msc *msc)
> +static int mpam_msc_read_esr(struct mpam_msc *msc, u64 *res)
>  {
>  	u32 esr_high =3D 0, esr_low;
> +	int ret;
> =20
> -	__mpam_read_reg(msc, MPAMF_ESR, &esr_low);
> -	if (msc->has_extd_esr)
> -		__mpam_read_reg(msc, MPAMF_ESR + 4, &esr_high);
> +	ret =3D __mpam_read_reg(msc, MPAMF_ESR, &esr_low);
> +	if (ret)
> +		return ret;
> +
> +	if (msc->has_extd_esr) {
> +		ret =3D __mpam_read_reg(msc, MPAMF_ESR + 4, &esr_high);
> +		if (ret)
> +			return ret;

So this is the style I suggest above. Good, but check for consistency.
It may feel like a really small thing (and it is :) but keeping code
very consistent helps a surprising amount when it comes to readability.

> +	}
> +
> +	*res =3D ((u64)esr_high << 32) | esr_low;
> =20
> -	return ((u64)esr_high << 32) | esr_low;
> +	return 0;
>  }


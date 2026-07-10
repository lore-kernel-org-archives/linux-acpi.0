Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F7E351C2A
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709102; cv=none; b=cSXNTNkhog1ucqm8tuhDr3gMw3j/0eKYbHRR0HJE1lNUwDTUU41TFNVadiE8+Yx+AO0AIkFduGTmOwPnxIkcM4KYBfJKRp7UJrUjd/mAmRnGtuubm6jXxZoetrkqbnxlVIuGoVXc+PwBm+n4Mt8qTutC4ojCyTuuuxfXlP2YDRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709102; c=relaxed/simple;
	bh=OWVcBh/B5Q/OzHFhu50NkXsCby3kerKmG8ulK33TFAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwrZrptnbG2GkbdNOiqnkCyBQRCXms+yIEFuiYRsoMqogveOyd4xTC3qqKt6PcO4rf+bx/xD2XNhq525l89bLc+oEBgvAvtIwu42hHGj7Te/JW2sK80BXquVZchvQSK3mSFZAryTVtFiA1IrtOQkvP3eWZeIaZ/TaS9ndWtBBX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BXWcv9yQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zz22gS5q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BXWcv9yQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zz22gS5q"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH3u7j1453344
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z+OQYxq6XVFtfTI3prmJj4k7rM7HASfxezwfOnaXnKk=; b=BXWcv9yQghXGUJfj
	LUV2tpUDR3QUfh2xA1u1WPeXoFSPEAHPahLalkdhVL3d0T/nf35q6NIrDiVpF/Io
	BghSi5DR4tY8YZpn0rRG+fRhvlegUAnjnxalh9gb+Tq4zgQKbfGNs0/EB1RqwsaU
	htbPGrxuKYcwEcRgx1jDHeeZ1cSMlGU1uoLx3w6iuMFLqRmCtoKKKl2V1qD6fUCB
	pORU+v2AjJridYsot+TVZgFFIyr9Zk367qi57IaZvC5oy0UZQVB8DjX4lrLfjbET
	VxGcVM+il5+j+IvoiUtxfXnQe8RbhNwmSMd+Y15LCQa4ewlu6719sUrfmooLaUKU
	7yyVxw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xn0jdd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:45:00 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848693daa20so82719b3a.3
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 11:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783709099; x=1784313899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z+OQYxq6XVFtfTI3prmJj4k7rM7HASfxezwfOnaXnKk=;
        b=Zz22gS5q4HUeuMfOHrP14Sy7ZFVUA66tpDhEDFWNe1v4gOFOhkqzJJCpRq94sdIb0+
         ovx1xBWk1x5VxjGPZYhuZBK4vim0pcpwlOPRz/kN+fo/SGVGMW3Q/KYYT9M2G1HnM7DJ
         1PVpnr32yGzsk9AMr5wVQ1xZ+7CQo4vBGpt68EtDemixeGCG5OJ22tGPicrdsY/V3Gof
         3i/qXOULNcm2WnjlPx+dyIG1ev1Z3XoXZ9Yif6XllOA9I+t1DfdiigRVX9mR3e/FXVdm
         o7maJHX+4eTW9ZBVkgtcWfPaIH2Ch7k83HeFtRW8Vv+tXDIRFIAZ7Ikb9QY3KXJ0XO0O
         NbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783709099; x=1784313899;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+OQYxq6XVFtfTI3prmJj4k7rM7HASfxezwfOnaXnKk=;
        b=cyAS8BLwIlvtVVrAE9NgQM/0KVUq8johb+Tme2+0aNgI81iptLdpQHETvw5C1JnRAi
         lPX0uKisiFnhLPJJ6uxPTYVcnLkdM1k9/jAkrByEHIA+ox+1G5UoVOiUOW2O7y0LhzwB
         wSDlFQ7foJmSwHQ7q7pqLNXEvPa8AoIKnjHsXtpcjLeb3KmEFIUpnQfN5ufPwJtzXmGY
         awbjKWL7h4lSRf/grqzan1H6tiz3xwWrXg6YJNlbMStIs76uH/wHieuGOIBwDMU5Oh6t
         KkawZu3gyW9MaZLBDwK5DYoK6eSglYyGfaY0f/oGqq9QPajpj8xnHArb/pBW5NqclQmY
         +dMQ==
X-Forwarded-Encrypted: i=1; AHgh+RoCDfzWPkXZ2rShEbeAGI1+rygd3HH2FZldt2gJkNksdCJHxPLfQoskvdfDkJCck0LTYIKPCbOYgBf7@vger.kernel.org
X-Gm-Message-State: AOJu0YzEaMH12dAHNIjfaKe+boLJGESdRnI1DzZQ9dHpStdCat/HE9Qs
	J/ppcjSBqKbRPDm6V6LDwkT1GcUNFiB4NC22+X8Nlz+Fz0NsEQU5AcRXrKMGNQyvTN3QAqxvN3h
	wviakRFuplRfbrhNpVHCwWin36gzKDpVhXggTe+LDYNGe56C8X/eRxwuEJlkqXrVk
X-Gm-Gg: AfdE7cmk4GZa9SEhYNZgtyA9fI4RjfBpvQQuNogHPC42WIiWpm/PIELtddZhVardvWs
	tWXVetiok38mSb7cVEF4pD2zqcpJsDg6FdmT5tX7KcXJNw954zODPIztJAs/Q+AyDQhKps4pc4q
	+Pb9/SykTXemsHRBrr3pk21sUhgUtKVpiWlaOZ1/XDAwH3u1obn7AYzBPbO13GYaHpCX214h3AS
	RnS9gS43P+aQDESBRso0n/iSsdX5gO5hNckDnEZOyiw9o7ZLjehIub200xPPjBRlUGfSZ4YpATB
	V/WWvG8epgtcMKUeSPMKU0CMIbSW9EOtYEjxAFe/9vHoOEE70wYDMxYZmDmYGXFjq8xps/QP0Xo
	GckXd4z4zMEts9O8KmnvbDx7x1BdWvMV7jFe9
X-Received: by 2002:a05:6a20:3d0c:b0:3c0:9c1b:d0be with SMTP id adf61e73a8af0-3c110a24bb4mr244268637.73.1783709099610;
        Fri, 10 Jul 2026 11:44:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d0c:b0:3c0:9c1b:d0be with SMTP id adf61e73a8af0-3c110a24bb4mr244236637.73.1783709099235;
        Fri, 10 Jul 2026 11:44:59 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31189cd8234sm33343564eec.9.2026.07.10.11.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:44:58 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:44:54 -0700
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
Subject: Re: [PATCH v3 05/16] arm_mpam: propagate MSC read errors for msmon
 helpers
Message-ID: <20260710114454.00003aa9@oss.qualcomm.com>
In-Reply-To: <20260710144520.917375-6-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
	<20260710144520.917375-6-andre.przywara@arm.com>
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
X-Authority-Analysis: v=2.4 cv=JJYLdcKb c=1 sm=1 tr=0 ts=6a513dac cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=7CQSdrXTAAAA:8 a=gC5c3gsx8QPM0zVGbwkA:9 a=CjuIK1q_8ugA:10
 a=IoOABgeZipijB_acs4fv:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 27OG2WlhgYg-_hAzg4Cmru7ERXnK5Hu8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE4OCBTYWx0ZWRfXy8vO1E4gFUM3
 aTmd6+rcNCplwNJrtF/R3/ZOhefhytDIvilaj4E1453cfwY3reSBKIX6d5exato11UT7/TI6x/f
 zWd2zjEyUHmU3cqlq7Sg0pnVQfTFdQ4=
X-Proofpoint-GUID: 27OG2WlhgYg-_hAzg4Cmru7ERXnK5Hu8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE4OCBTYWx0ZWRfXyPVbKyM6agOk
 ZvzVdmGeeJvWjF74ZxUwQbqt3K2mlMtLrP+yOKhHB1hYvz03421x+UlMtJ3MM+VysyZMZ++UUZX
 IDQPPqTYXguZ4dQF/ZeXTz4geeQfMO5dnQB3B19Fr7VcwS6GMrUU9ZMuLuf53QVDRxMrnVeUqbk
 qDdgiGo+9PS2+K5/QWLGlzQ+y1Yh/8hGFmH8hExIDU8TpY6ZeboZo3+w2NVTqnubHAGn/NrjbzL
 zfhpnVerRHQUQkKqMC2RhWBtJwUUcE0qnyBxfeGq41qy5DFiooqkQGa+s5lRP2UyV9uvCBYySNN
 JNQNSC8wNMi9pNEbHRZTe7U5SKxVXCwjU/9nm1Ex0du1sbLHz044dGLEqDlB8s5cTOoK7gQJSDE
 xuR/Sxjf4DSmP4OsX1q3nim45/nTNvYfgT8aAtv5Wv7f9+DhwHNkyHoC+siWv0+cgDcdL1YJq9O
 1iBsnhCLc376xfmWbOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100188

On Fri, 10 Jul 2026 16:45:09 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the helper functions for msmon accesses to return an error, and
> propagate read errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Hi Andre,

Trivial style suggestions.  I'm fussy - I read a lot of code ;)

Jonathan

> ---
>  drivers/resctrl/mpam_devices.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 3b6f9e552a9f..041fca018e68 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1201,25 +1201,31 @@ static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>  	}
>  }
>  
> -static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
> -				    u32 *flt_val)
> +static int read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
> +				   u32 *flt_val)
>  {
>  	struct mpam_msc *msc = m->ris->vmsc->msc;
> +	int ret;
>  
>  	switch (m->type) {
>  	case mpam_feat_msmon_csu:
> -		mpam_read_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
> -		mpam_read_monsel_reg(msc, CFG_CSU_FLT, flt_val);
> +		ret = mpam_read_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
> +		if (!ret)
> +			ret = mpam_read_monsel_reg(msc, CFG_CSU_FLT, flt_val);
Burn a few lines to make this flow absolutely standard with errors as
the out of line sections.  Obviously it is a minor thing but the more
standard code is, the easier it is to review,

		ret = mpam_read_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
		if (ret)
			return ret;

		return mpam_read_monsel_reg(msc, CFG_CS_FLT, flt_val);


>  		break;
>  	case mpam_feat_msmon_mbwu_31counter:
>  	case mpam_feat_msmon_mbwu_44counter:
>  	case mpam_feat_msmon_mbwu_63counter:
> -		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
> -		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
> +		if (!ret)
> +			ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, flt_val);

Same for this one.

>  		break;
>  	default:
>  		pr_warn("Unexpected monitor type %d\n", m->type);
> +		return -EINVAL;
>  	}
> +
> +	return ret;
With returns above, this can go.

>  }
>  
>  /* Remove values set by the hardware to prevent apparent mismatches. */


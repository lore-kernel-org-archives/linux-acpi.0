Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE81E25B08A
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709830; cv=none; b=mMgyn7ZvjlZvZ0ybpBhAsWU8fjTNEv7H+ZpWHS+DnirjL+ilzm89syLRBF2zO9dmlVd0V2bd+pagkLPnr9lwYOHU9WFuR/b6sagT4LP4oteJh0KkloKbLJ0oSHiX1zSDD9E0txg+CHlKnq8vd/UWYXNgR47ygBDUzlV8J9/I80I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709830; c=relaxed/simple;
	bh=kDvThbzp+hWJ+w9OoNvnOO2Ynuu5PrfxHYDZ4tnceUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3oAzJKKBx0RUbpPCX6tcbWLw8ni++iF0rn/cDEmJuY62Ox2oUr2e6fF6kTCBvvP4ortDDkJ67J6jyWd6VaFUQAvQPzgH8VFe6wuVSYqSpzDejkRmXTnHj26vq9AMb9nOJf2GKsb5IHAJHtmocvQaUzBy6++mOcbMbUUV+xY5Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=osvB0wjH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DiLYn2r/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="osvB0wjH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DiLYn2r/"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH3wTh1400462
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NUwraeVAIbOxkgowZVXW9RaxpXRVvqBvyF4xRm9fCHw=; b=osvB0wjHZUONx161
	Nq48eHZ6D4AUiNb2uhT52YWljU0x7kVtjYOYjpyA2u/n+MsE3jYXNI0CFIGY98ma
	BE+sCzOITKbv9QenjKzkRh7DCL6J/zPZslVnQWwjAtGHYc3rpSq9SH48AvqxXMpQ
	11mXmMjawdsuVu4PE7lJzN2JYIki1KAO0an3JADdVS5TB/MU36ZqVoOWwYOk5y54
	ZrNM/ot3apCY95JUAlycMwaiewe/G+pCr/cXYzHQbkYjGhRr4Gfs3Yp2Ehl0+yiZ
	UH36qmmFdk85RlykTMGZ5qE6e6eC9sXBK4cwK4jktuQJDqoI5zeWiUgFzTzk60/c
	HdYBTg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faxyg9v0n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:57:07 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso108456a12.0
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 11:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783709822; x=1784314622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NUwraeVAIbOxkgowZVXW9RaxpXRVvqBvyF4xRm9fCHw=;
        b=DiLYn2r/dNJSijWLr4CD84nN03T2CFpyaDZ8Y49WkK9H8NUs6ARrnqWm8Fb0toUY5a
         IGvnUHsD5OkBvBaiqDIP+CgNTrE9rUU2p6LqfdC0qGcT6XOpezI0W/VWeqkM1lc+2p8R
         RjURz7g3qsujRr+BlPUVd2gBRtwDlruTHlNND9QFUIsKNGRbr0LQ52jOpyqKPSS98ff2
         APINU+Fx3Wpqac1LwMKjuGUHQhWGeZTcead1o+dIP+Ve5KaqQ0oL0A5GYsPyeYNmmKXt
         f3TLE7HlUW1+h43lMABCaohtc6dyo4HShfKLHYGxTP675nqioEqNdd/M7otlnwprTEci
         Qt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783709822; x=1784314622;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NUwraeVAIbOxkgowZVXW9RaxpXRVvqBvyF4xRm9fCHw=;
        b=rqfnhyFSZbnMOpEWiM9/MLenKmpjNjZxlgi3OGTKV9hQ13rSe2Ir4+RcMTa+VfGirW
         MRT9YwVW/xGIQTlIBP9BYtcgfPeKn/UZhmHnAkJX5CsLftY/A5A9eVHZbWxsdG4LyMZ7
         edUkfxyhup5EHFa6zZRINSFTE8rGITqEGstk97zO5HV5qleQZlukqXVLJRRibFT/1Lir
         k8ktpbcq+Bunccy/zP9Z3jTcTvaQqAGUSOv1mQEJUiWdB+c4+Hb/CIt4CX9VZg3Cn/Hj
         AEkfjE9wIO8DLUTDGYJ742F91BKV6K7BZW0tOoquwoIevPTX/kVHqApLVbtowaVBj4rg
         eCKA==
X-Forwarded-Encrypted: i=1; AHgh+Ron04yTqXV8xmIUZALkijdCTMa9hhlJRiXd10VmIV+akIPHrfb/2J/1CtlErYgVLeBtkdLyv7MRJuh+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj6ip1VS7G5EQPab0E83yPS/kXa4yCpfW54RQqTQUb0XahddzL
	Ir35GJ6MjUcbb57N+9Fb41iHLtsyk2oteDNb3T+khnnL9KOy0U5ZoF0wxPN9+AmqU9KF0+zlTV9
	+Ln2REYSOYgYWJZkCmXFNviMAhyZlBENtX3fXVCA8/nh3sZCBv0x7C2hwnCQXaaYi
X-Gm-Gg: AfdE7cmGlWY2DMSFsUAQKsE8r8OgrD7NOZxpW0zWIJDLInSR1Kd6xqUk+fqQsD2a6R3
	Li6baDNJFzJ9FrAynDAvIj3EJovryRyuTFLmsxnCwFcyxVNe+C5aGwQvX0mgAZH6pqOI0eKfvy0
	5plxPDezzYQ2mcErqZnQqChinB6NwfSjUvmg4U5zlszx0WDPAKhYGyqTeSq8ELVZ4ZNSWccO3qL
	da2TnwrjVOcoEngabntvkxV2kOSolRWTTYcJ3YiNMlHaCQgpjaNQqCkTwfck593E/lvzLEpZsrK
	NDGDpO681gjcuywmPO+F2/G2wbhoRZxMCB/cWzZ7h5EK4VwC+boyH5eGuY7GaAn6JM+Qpf0jign
	jso28lUsUem0+TniE9Hk37FdRCyWCS2Uc8fwT
X-Received: by 2002:a05:6a20:c998:b0:3c0:9c1a:893f with SMTP id adf61e73a8af0-3c110f7f555mr201823637.71.1783709822001;
        Fri, 10 Jul 2026 11:57:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:c998:b0:3c0:9c1a:893f with SMTP id adf61e73a8af0-3c110f7f555mr201789637.71.1783709821554;
        Fri, 10 Jul 2026 11:57:01 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm40499805eec.4.2026.07.10.11.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:57:00 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:56:56 -0700
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
Subject: Re: [PATCH v3 07/16] arm_mpam: __ris_msmon_read(): get rid of nrdy
 special handling
Message-ID: <20260710115656.00001345@oss.qualcomm.com>
In-Reply-To: <20260710144520.917375-8-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
	<20260710144520.917375-8-andre.przywara@arm.com>
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
X-Proofpoint-ORIG-GUID: sGxYjI3Pqot_fMxkpZ4I4rTkT8Lb06QD
X-Authority-Analysis: v=2.4 cv=PLg/P/qC c=1 sm=1 tr=0 ts=6a514083 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=7CQSdrXTAAAA:8 a=TeALGT1HamTeR9oYe0QA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE4OSBTYWx0ZWRfXwBR+dGEIjK/Q
 0YmQ09YdGKf71cYShenyRGnU+O47bQz4g4jrG3UTMEE72Fo0t4rPL+m0CVKCwgi1zl4yhzclSyO
 bCyAVZI+QzSadinW30sUPd82iiPhBcM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE4OSBTYWx0ZWRfX1cbmKt0JSoum
 7WeZgBJQDxya2osVHAKa0v1er6lN6XGtqJb5XmQZmdtJ8wlznl3A5tgr8auEmwSZcPOt9MmZ9lt
 4B5j+4YkbrnCrmCe3uulKxWF+4sugZQnwfC5ug9RhE0yIxPmAwsnfekpig7nDkjxfAwjsKxVsFh
 r2pKuQaXVVeBy87/S/ilbmPBDq/tDW0WcnJvlJAAFZLelo4qFahNhPJjufiAngvoveBftFnBc6+
 pSfx1yz0P2YCKbRG+e4rXH54HlIZJPWhu1tDBtDO4id+/BmJtXpBTdkg004o+6QFHK2qjtsVlrI
 BPqROix/bFFjBG0xMNrscgxqazOVijY7gradUXLpm5p8QYD9WFJmkSeI3E+MpE08POf9Byz4gxf
 jjEhBJsNOmiWkAW4wJs38x1lvVrU+ONbG5+fC5gltikmzfi3ObsF3fESOpyMqHBBoiZygx9lZfu
 ge6Oms/Dhh/uMhz3BAQ==
X-Proofpoint-GUID: sGxYjI3Pqot_fMxkpZ4I4rTkT8Lb06QD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100189

On Fri, 10 Jul 2026 16:45:11 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Although so far MSC accesses couldn't fail, there is one special
> condition that would create an error: when the MBWU counter wouldn't be
> able to read a stable value, we were setting bit 63 to mark this value
> as unstable, and return this as an error later.
> Now since the functions can return a proper error value, we can get rid of
> this kludge and use the return value directly.
> 
> Remove the "nrdy" error flag variable, and assign -EBUSY to "ret" to handle
> this case.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Hi Andre

I'm still fussing about code flow and style :(

Obviously none of this is that important, but it does help make
the code more maintainable in the long run.

Jonathan

> ---
>  drivers/resctrl/mpam_devices.c | 38 +++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 84a8715464be..530ac0fe97b5 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1306,7 +1306,6 @@ static void __ris_msmon_read(void *arg)
>  	u64 now;
>  	int ret;
>  	u32 now32;
> -	bool nrdy = false;
>  	bool config_mismatch;
>  	bool overflow = false;
>  	struct mon_read *m = arg;
> @@ -1371,14 +1370,18 @@ static void __ris_msmon_read(void *arg)
>  	switch (m->type) {
>  	case mpam_feat_msmon_csu:
>  		ret = mpam_read_monsel_reg(msc, CSU, &now32);
> +		if (!ret) {
> +			if ((now32 & MSMON___NRDY))
> +				ret = -EBUSY;
> +
> +			if (mpam_has_quirk(IGNORE_CSU_NRDY, msc) &&
> +			    m->waited_timeout)
> +				ret = 0;
Whilst it is from existing code, this pattern of set and error then clear it
is less than ideal.  Maybe

			if ((now32 & MSMON___NRDY) &&
			    !(mpam_has_quirk(IGNORE_CS_NRDY, MSC && m->waited_timeout))
				ret = -EBUSY;

is clearer as that odd intermediate state of ret never happens.

> +		}
>  		if (ret)
>  			goto out_unlock;
> -		nrdy = now32 & MSMON___NRDY;
> -		now = FIELD_GET(MSMON___VALUE, now32);
> -
> -		if (mpam_has_quirk(IGNORE_CSU_NRDY, msc) && m->waited_timeout)
> -			nrdy = false;
>  
> +		now = FIELD_GET(MSMON___VALUE, now32);
>  		break;
>  	case mpam_feat_msmon_mbwu_31counter:
>  	case mpam_feat_msmon_mbwu_44counter:
> @@ -1394,9 +1397,11 @@ static void __ris_msmon_read(void *arg)
>  				now = FIELD_GET(MSMON___L_VALUE, now);
>  		} else {
>  			ret = mpam_read_monsel_reg(msc, MBWU, &now32);
> +			if (!ret && (now32 & MSMON___NRDY))
> +				ret = -EBUSY;
>  			if (ret)
>  				goto out_unlock;
> -			nrdy = now32 & MSMON___NRDY;
> +
>  			now = FIELD_GET(MSMON___VALUE, now32);
>  		}
>  
> @@ -1404,9 +1409,6 @@ static void __ris_msmon_read(void *arg)
>  		    m->type != mpam_feat_msmon_mbwu_63counter)
>  			now *= 64;
>  
> -		if (nrdy)
> -			break;
> -
>  		mbwu_state = &ris->mbwu_state[ctx->mon];
>  
>  		if (overflow)
> @@ -1419,22 +1421,16 @@ static void __ris_msmon_read(void *arg)
>  		now += mbwu_state->correction;
>  		break;
>  	default:
> -		m->err = -EINVAL;
> +		ret = -EINVAL;
>  	}
> -	mpam_mon_sel_unlock(msc);
> -
> -	if (nrdy)
> -		m->err = -EBUSY;
> -
> -	if (!m->err)
> -		*m->val += now;
> -
> -	return;
>  
>  out_unlock:
>  	mpam_mon_sel_unlock(msc);
>  
> -	m->err = ret;
> +	if (ret)
> +		m->err = ret;
> +	else
> +		*m->val += now;

If you do the earlier suggestion of ACQUIRE() this all get simpler, but if you do keep
this, then burn a line or two of code to make it obvious what is error and what isn't.

	if (ret) {
		m->err = ret;
		return;
	}

	*m->val += now;
>  }


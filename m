Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D332AD3C
	for <linux-acpi@vger.kernel.org>; Mon,  3 Aug 2026 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795230; cv=none; b=Mmr+uqCv/j/KWSlTanCXBRnh4nx+Zp1+Yf8FklKH4NbivLrVeQuJhqzSCNIscG68rTsOi+AYTN2HsLlB9gvbBY/24yLM2x8a+jxamdki0rWvERo2IrmVDriefXUHGB3YjAW0VTmjhmr6rWpwcIO70ohvdv0nufxf3AvAH/VQxjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795230; c=relaxed/simple;
	bh=cmRi7qupxsGmpasRNeQIN0g23ByHP/yPc/jydAD2fiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1jhwp/R2NhYzlv5z1MpH/oe74I2KRXRRE56vUeQyXNXC91GxYanLjVt/8ThjoF0MXOvE9D3niErBEFGfJAzAyF9isIDVeuQE7Le6IQRIFhNfmtT/sc70nf30OEJcos89louc1O7ZedzixJjq9fkj/SP/EJ2glW5jGh6vMJ11eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iYeitjnD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ghsg3paZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iYeitjnD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ghsg3paZ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673LJAvU1546705
	for <linux-acpi@vger.kernel.org>; Mon, 3 Aug 2026 22:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ig95ApWFX9FrE4bSEK82oovW8IQGcBZFRFG4rkok8Cw=; b=iYeitjnDFCqO5O64
	qaNqhGDOeOq4NMgkqbc+n2F4iepZtrMVWI1u6u+AwN05fK0ZZxZ2xRd4ZQ0L58l8
	3dit4SFNnFjLMZugpvta/2QbNMHUfWK/QcdwEyOLpHtIa+nFWZdHmHWDfwIFubvH
	YptyBgPgf1fbyhtqpP24t8cJKMqD/edrB82H7weraYhyzqr2Za8n+XzS39tLrANC
	Z81Ttza/7zwsXfrxgCKjJsKS7rww2mL9hXyKAXimjo6Gya7PR1wRb8I/bvFROZiU
	lYeGMtQnKHTiDZuy6NiFuq0CK+agHpPssTUIa1VdfKDeDV47GxJ9JumL6XeyxZdH
	jLvDmw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu2syg66t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 22:13:48 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-caf5fa127d4so7150679a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785795228; x=1786400028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ig95ApWFX9FrE4bSEK82oovW8IQGcBZFRFG4rkok8Cw=;
        b=ghsg3paZEREPJ4smFUESwTvqd1WLIBsg3kupQ+K3P1tVhZogzZ9keKz2iOsglqf+l6
         +6nxKYJ3W2xglmIoMlcLaOXAj4/1Ue9UxWS0dESui+pi6YcjKh+ysvpo9lXDZz6xXjQ1
         NRH02//POQPYRa1x/qPF0C8r3u4TlkSChVJALDVDMetZTJJvQTL7LQmzFIGpu2CNqBKF
         y3jtP+E1RHhPPYtqMRB/qkYl6kqDr2hsi3Y0cyNKmVhPfTzmstcV/dXth3M9Jew0mE34
         9c3VzDcjTw7DCGz4tZyxFgNuy1MrPdTQxjwJvrVmpH8DwzNMdemwcP1NtpDJgdRsakfL
         WhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785795228; x=1786400028;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ig95ApWFX9FrE4bSEK82oovW8IQGcBZFRFG4rkok8Cw=;
        b=rTfIAcBbkfseAj33uzDiTjKhb3i7dDHdWe0C9ldFsX37VYpe11RFqO3NwpxrT/pWLO
         M8OzXeMV5nJ7vRBWo8dAMxbtQEmFj8QRglj5sqYdnsxv6XcvjVez8keWU22PBorfTqCF
         re+1260y2EoPnfya0F08ggSYahXW0+sw21+6Ye+/PkvLfxunAmwQUjJeUByK6DBmVkB6
         IRzSeZHMnVuAaQD7a3vC2eAM7flK2YkQc+J3GGGpaDplVE1oWxkmnQ3xM6LA4HDjrPpn
         g/2JJwoVEGdHSlZNnc35IYjdFwpxeglAS+grS5qkth8UpwiCvwoY/EOA+X7CgdE3eElC
         D1AA==
X-Forwarded-Encrypted: i=1; AHgh+RqUax7R8rVzI6uk5kuPe9p18Vf2nZOJWhMS1hzCVbgCxOt9t6eeUPdIWiz5Nv47nuFOpdpizqDvpTfl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3JiPjTjvK6kvX4DnGHInBr/CraalvPiaBMXqmr7Cw2hLPuTdR
	uFZf5GYqzz1X0QafXNRCqLN3+uoBIYxTlDZoJxbPq1dH7vOcFwkcjAPZEei3fbFzXZJplMrKpgE
	fy8CEBbZphdrhM5SeqvwDujDaybaZ2JXvOZllaV8quYDoHJTjcGgwizUphklPL57m
X-Gm-Gg: AR+sD13HdkvIQQ+UUkwasIXI7izlllhyk7rcPo5cr/DWTftendAjDazkW8TuxeM075h
	HpsdOeCOy/ALaH90jzYi1jCZBtBDaRZK+1MSLQutyrEXPMvpVHoRb+UptKmQqs+h+ZgSuph6+cz
	55ij3Y7XjmhMJ+EMfXfrs1mzBxQhsY1IciiA9IGmhdIlnG3rs1eg9BT9sffAGN/JGjNdq+K5wXm
	JMOX5JN7NryexjNQszV5ziRUCl/P8iZsRPF5IOeEd3VI8t2xPCYhqx7O3s+Dx5E+jtV6EkUpb++
	OKsLzep601nzCM9efr3gy3Tt17gtC5bO+NXXmFWH/jr66aGTRbYViWPcebzzQjgEH1uSusl3pCJ
	/xXI1A2MOCT4JrjDca7LbZAr7kQ==
X-Received: by 2002:a05:6a21:1fc8:b0:3c8:e10b:7a9b with SMTP id adf61e73a8af0-3c92a58e56dmr11875992637.16.1785795227524;
        Mon, 03 Aug 2026 15:13:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:1fc8:b0:3c8:e10b:7a9b with SMTP id adf61e73a8af0-3c92a58e56dmr11875951637.16.1785795226835;
        Mon, 03 Aug 2026 15:13:46 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06f88fsm40649703eec.20.2026.08.03.15.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:13:46 -0700 (PDT)
Date: Mon, 3 Aug 2026 15:13:42 -0700
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
Subject: Re: [PATCH v7 05/11] arm_mpam: propagate MSC access errors for
 __ris_msmon_read()
Message-ID: <20260803151342.00000c3d@oss.qualcomm.com>
In-Reply-To: <20260731170324.2927758-6-andre.przywara@arm.com>
References: <20260731170324.2927758-1-andre.przywara@arm.com>
	<20260731170324.2927758-6-andre.przywara@arm.com>
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
X-Authority-Analysis: v=2.4 cv=TIh1jVla c=1 sm=1 tr=0 ts=6a71129c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=gj-DCe7_c4ZTHBUR5qIA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE5NSBTYWx0ZWRfX68+IIE+ll9QK
 uSFTaDuLp+eHOJvrwpqjjNgyW5E0M9/0a0ZbBRDdVNaUe8gFg9u86UQLOx9lI211qZy4t8K253B
 EYgcDaOIeM3yDULxmtX1vLQXjUie2WI=
X-Proofpoint-ORIG-GUID: KYkksUXwJDBxvy40zM1jpE19e7F-ieBa
X-Proofpoint-GUID: KYkksUXwJDBxvy40zM1jpE19e7F-ieBa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE5NSBTYWx0ZWRfXyLF1O139E8zd
 ERYrLtwALo8fbUwUaUQ3bSL8Ru4sB4WFVjhwbxly/QEIXc4sVuNndigsPwt/tMOUjFuGCvgB1/z
 COtw1DJhlNUVXhDco1vPtYLUb3NOdujG9CvuVbCDb16/NCyn+vujpdBnsZ7VmY3FdmdykYu7Tmc
 gBTcDg2cm5Syu257niytyW+IJteU5nvIdwWUjnshO3ZztNjoDFY5ZgLc1aBKUC3SlK2nmek2Evt
 ugSnuI3YTF/g77eoMiF2L8gNlSpS+dVUAzNYFxqfq/QyZ9T8fiEYtXwkKvIa7LXKamxdBtVv80b
 e5iC00ielja5oelyQUqXBDLUqgA6X40Uq0CC8J+wdbuxumvDqrr9MoJAtD/4Uwx7WzY5OHVCMxb
 hM104R8SyqOsJxeSL126557hFzQB00weTYrOf8yTf1jA7YOINniM8beP0aMaTM8eU/B4zueI+no
 7ZYrqoRi/GIvRogyWxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030195

On Fri, 31 Jul 2026 19:03:18 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the function for RIS accesses to return an error, and propagate
> read and write errors from the lower level up.
> This function is a bit special, since it can be called via an SMP
> helper, so the prototype must stay as void. So propagate any errors
> using the "err" field in the struct passed in as the sole argument to
> that function.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Just taking a fresh look and one really trivial formatting thing
popped out.

> ---
>  drivers/resctrl/mpam_devices.c | 36 +++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 9d9f0c635527..fa8ed20a6740 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c

> @@ -1390,18 +1398,24 @@ static void __ris_msmon_read(void *arg)
>  			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
>  
>  	if (config_mismatch || reset_on_next_read) {
> -		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
> +		m->err = write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
> +		if (m->err)
> +			return;
>  		overflow = false;
>  	} else if (overflow) {
> -		mpam_write_monsel_reg(msc, CFG_MBWU_CTL,
> -				      cur_ctl &
> -				      ~(MSMON_CFG_x_CTL_OFLOW_STATUS |
> -					MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L));
> +		m->err = mpam_write_monsel_reg(msc, CFG_MBWU_CTL,
> +					    cur_ctl &
> +					    ~(MSMON_CFG_x_CTL_OFLOW_STATUS |
> +					    MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L))

Indent seems to be wrong here.

		m->err = mpam_write_monsel_reg(msc, CFG_MBWU_CTL,
					       cur_ctl &
					       ~(MSMON_CFG_x_CTL_OFLOW_STATUS |
					         MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L));

> +		if (m->err)
> +			return;
>  	}

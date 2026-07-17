Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D04A33
	for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2026 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784247620; cv=none; b=s/twdJR2XKL0gFQlaq5TKmUMWcQLOHVBrmCChMO0pmbMKX14yg5Lyrr+iT3X5iaxmS66TSAbBnhEC37D27Dv5+I6+T5lkxCbffLqBr7TfBKSUqOyO7WCb7iJy2N4hTmZL3iUJh/j38ofQxnLVBAv0ojdtZ+/Lxq3LJ7fCBQFB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784247620; c=relaxed/simple;
	bh=NMWxVa2O0pcZ7CXoIPYnrqJdQNRFng0555z8QlRrJ4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwlyQCYeAGS0zR3dh8ci9HVISdoGv+8sHUg8WEtIqat3gQRWl0eLZA3uHOGTJmZrSp4xsV5uuNV0Yr45JXyk5jWbX60tLz6CJJ+7KNgNKNbrn7Gr7ddZk/s01BA8Tpp+zC6wwdl5D8f7r8/2jSZ8JOT0Ml8zaMU6m9kDEJrtXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L+UJimOi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FnZRmepj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L+UJimOi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FnZRmepj"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNIDjk1129056
	for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2026 00:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	STYZA1LnYQTfXAhvgUb7SwcUx9+N7av2siYHawu2deQ=; b=L+UJimOirvI4UX8N
	fMnQWaJnWdoIaUt62qHwO//4uA02oXHcUonCJMUIRtKI6115x1jdsFyTQ27bbkEK
	Yl8ND3mOQJ5H6w30nQNdRqsQuoHCcy60KXI9bF4GUg33zJMeDeSwM56nrLNXxYA7
	g4CAkL9i7kvAvPOU2nwiSdt6yH6gDy3hsDFwY6mF/lc3R3NQFaLMqAQ0mTbKsK42
	ibUnbpVCCKSW9eczxSWe8QSQrPZWPMzQcB5JOsK1cnFZBxahvWM4swN2YB6OdPcE
	H8VS0jYbLGgK3WZbcTByi/+Rss4T/v0PRMLcPCKl+3SFkbrNxlyQEY83QPe0FYrL
	2fsTfA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u6h958-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2026 00:20:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so1287948a91.0
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jul 2026 17:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784247618; x=1784852418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=STYZA1LnYQTfXAhvgUb7SwcUx9+N7av2siYHawu2deQ=;
        b=FnZRmepjiClwNXLFamVnk+Ag2aoB4f14mFf7hezX8FKvzu7jLaiYVymYc2S0pJwUyK
         pCsoUnWvrbLAjDBjeIXwxv4Tq/3zpYe6AcUJy6Iccey5rGQ/aLyL2ln2ntLynG5wotf2
         R+Gezu5/wIeyL21RbLAOnvmFEpDN80XXlShiIyEt1Egx74FI3LUrPWeatDmgprRbdqXw
         ccuApT13vw/J2aHXWK65iPqkaWFQNsoW75TVy7tQal2rZ1Ag033VzkSL6BEJ9GVGCwBJ
         oHryMsGHTCqS7wUhaDqvPwF3/2X4ED6OySNIQhLJTGZINCGXS2MzOwVuyZ9qR4me5MdQ
         bvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784247618; x=1784852418;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=STYZA1LnYQTfXAhvgUb7SwcUx9+N7av2siYHawu2deQ=;
        b=ZKOqAZIaDcRQKisZboMcJwj6ynWTD1Cs1GFZAXrQbXjz883b+TGvLlMet9KkXWMdi6
         2BMbmDseNjjUv7F2Ctbpx9nKHbu1+BERdScT+0Dt28QUxqTOb4YnihYsb3EMv32d1i8n
         AoFsjxcoagvDIVNICZN/OdBio2iUR9CBRZurjqQum9AQjj9D1UJq5zFdeKh4lcVSGxz5
         9GfkENC9dg3GbLzPVIqzn7aNfHJMo7ji/jffEf7HVQn90AL1nby5dtgZovKgp54XPo8C
         8VSk3vxRSeQnwJNMwYPbX1EEL4Vu72H4E+VIF6iZKpQm686ej/HIamjBlBxqMTn6fYpv
         Fr9A==
X-Forwarded-Encrypted: i=1; AHgh+Rqsr4uCpfgJnZ/4PJjArHDPUCCrZkvXGBwKglBUjCq9HdGZwwVT2GZxREUNkHxxnyexk5E1qdcXTQPb@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm6ugUuBwRqRtDldvBNsu/c2fYsq76RnpaUr2cGmD4dlKerwzo
	xLV6hHkweTIX9+svllXsCZIIEjh/wrkXsm3t8XON6b0png8fyM6cOj1U/ML7853ynyqR9F0cc+U
	Z1wd/qtWMn0LtH1lhNpw5zzUiw8kFCErhie4XUMUvViX0kb1UY4GMrOEjhdd1esaU
X-Gm-Gg: AfdE7cl8cTk//VsU5JiqKHM6/Jq+Fb52ttb1bu2aGWwz7sRl53rbe8xKUAFVeYLHXK8
	9ymCPvRfJofEfbD8V0D1HHaGA1QyUdcskeOID8mkJmaumUPVaRwCvb/YPm8Dr+vJ2PzK2DGObyn
	6KhjvbTWKSeixTlBYlr1ki8Hohw/eSK/LQ0s38WKhCWAjnCwVa+LPKYCfcg7Q4/S7Ox90O1xtKr
	9OVo9F/Ar+YuEoRGr74pSeNNGajw6O81nLAgjwgO9pqlAY/8i9LyxEgrZt+wLgsXfv0AMQt/ylA
	9+bnr1ztkWP4HTlQcWtzil9Ykkl+vz7DZFYLJyjAncr8cQ/UATpBo4kYopDetTm+zKd9D+E1jk5
	JnDlEgc6ohMeg9vwo1/O5DVHE7Q==
X-Received: by 2002:a17:90b:4a10:b0:35f:bb17:39f with SMTP id 98e67ed59e1d1-38e3d133ff8mr5060880a91.1.1784247618208;
        Thu, 16 Jul 2026 17:20:18 -0700 (PDT)
X-Received: by 2002:a17:90b:4a10:b0:35f:bb17:39f with SMTP id 98e67ed59e1d1-38e3d133ff8mr5060858a91.1.1784247617738;
        Thu, 16 Jul 2026 17:20:17 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bbaf6sm495131eec.17.2026.07.16.17.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 17:20:17 -0700 (PDT)
Date: Thu, 16 Jul 2026 17:20:14 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org, rafael@kernel.org,
        Alejandro Lucero
 <alucerop@amd.com>
Subject: Re: [PATCH v2 1/1] acpi/hmat: preserve hmat_adist_nb notifier block
Message-ID: <20260716172014.0000299c@oss.qualcomm.com>
In-Reply-To: <4b146ef6-ffa1-4406-b625-85fe05ed4604@intel.com>
References: <20260716181114.35962-1-alejandro.lucero-palau@amd.com>
	<20260716181114.35962-2-alejandro.lucero-palau@amd.com>
	<4b146ef6-ffa1-4406-b625-85fe05ed4604@intel.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAwMSBTYWx0ZWRfX59Erg32RoFpH
 HQo51Ev6apsQ/sB5E7f7OfsUtvHe/PjYUzuS3/L63UeA7B4wtak0lyAEB1h9mDlzOOHfmAgqWrH
 zfdyRMB8FFIuHPnEwMC3JF/1jeIHuFJVyOx/OE9HGw9M9kmGs1Yvnz7j5FBfTp1B8+a6KNNtGMq
 ZR3Y8+0Mq1rAQZsLM8Pz1aGANFaL/p/a87NesYd+Gzmtx50v5Lhz0ZCaUOptk9GDEqnMQ18foKz
 HFc3mgFwCWL9RLU47GfqbMPxQn12AyGHB8pouxBrMIC4N+zIz4THoU5qP89NzhS+0PYzBSlUbCZ
 4sVmvlSladl2RF6ONJ5Pp9X4iGI4B/bMl1plf9IM0TYh/cwLhELspVZgfQGlOzGMfxhEILYER14
 WsOm/I4lgggMhCv930kxzo8WOY823vZMps2cbBQ6uhw1uU2Fn0qY4zELzRdh7J4o+gl++p9Su5M
 8ScNJtWjAeUsHZfaGig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAwMSBTYWx0ZWRfX+EVic3XRVJGF
 tJgOVolXFv/UwT5FCfAVyZtUClQFej/Gj6u45NIz2bjJWQNAWHo9Kjas8UrvjvedCbKMPUZEk5S
 ScukD3WMF0as4hzd5bxu7/HhiyKefOg=
X-Authority-Analysis: v=2.4 cv=DYMnbPtW c=1 sm=1 tr=0 ts=6a597542 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=QyXUC8HyAAAA:8 a=zd2uoN0lAAAA:8 a=EUspDBNiAAAA:8 a=pp6aupvQFOZKKrBwpXYA:9
 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: dr6KtX6RwxZWwthvtzi0DMMy2Tqn3s5t
X-Proofpoint-ORIG-GUID: dr6KtX6RwxZWwthvtzi0DMMy2Tqn3s5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170001

On Thu, 16 Jul 2026 13:27:56 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 7/16/26 11:11 AM, alejandro.lucero-palau@amd.com wrote:
> > From: Alejandro Lucero <alucerop@amd.com>
> > 
> > Remove __meminitdata from hmat_adist_nb declaration preserving it even
> > when CONFIG_MEMORY_HOTPLUG is not set. Otherwise further notifier
> > registrations using register_mt_adistance_algorithm() will find a
> > notifier chain likely corrupted.
> > 
> > This is the case when cxl_region_probe() calls
> > register_mt_adistance_algorithm() what can happen when CXL regions
> > are dynamically created at any time from Type3 device(s) or when a Type2
> > device is initialized at its driver probe.
> > 
> > Fixes: 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")
> > 

This will trip some of the checker scripts that run on various trees.
No blank lines in a commit tag block. I guess who ever picks this up
can tidy that up though rather than needing a v2.

> > Signed-off-by: Alejandro Lucero <alucerop@amd.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Seems sensible to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> 
> 
> > ---
> >  drivers/acpi/numa/hmat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > index 9792dc394756..3006789ae31f 100644
> > --- a/drivers/acpi/numa/hmat.c
> > +++ b/drivers/acpi/numa/hmat.c
> > @@ -995,7 +995,7 @@ static int hmat_calculate_adistance(struct notifier_block *self,
> >  	return NOTIFY_STOP;
> >  }
> >  
> > -static struct notifier_block hmat_adist_nb __meminitdata = {
> > +static struct notifier_block hmat_adist_nb = {
> >  	.notifier_call = hmat_calculate_adistance,
> >  	.priority = 100,
> >  };  
> 
> 


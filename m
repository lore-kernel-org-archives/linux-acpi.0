Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EB839C008
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584644; cv=none; b=ecotQ3480Z+Y9mwmG3fGijXPmO4GezIdxida+pkYXQ+KLJnqNdzLlEChQNIWLpBDj0j04vHjWmvHT5gbMN+16BAShO48rTyvpNHzHVeEAcvEH+cM7pmnEvBSb6+Bx41BSrX/1IAFtB50obRetVmDcIXmiQDxY88bykeebqtoI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584644; c=relaxed/simple;
	bh=ZrM6lFX2UCFPg5Kjyem9LHqjHIVlenZXidp39hyYm1w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DdBiin22hnoSWkCrhNA2HAgG7KPX7Wf6KV60pRg6MT7IaR2FT51J8GlKOz7T9oq6D8g93BO0AdPstlD2ULjIRgFqKedUf+zK7jDfzXrbaMyb0jVRxh2g049MCyxc6+D/5iKFs0lGBSXR7Zpyz7osdzDG5WRIZqWere+o8411ZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GwRk+e9C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UeV+B5Nq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GwRk+e9C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UeV+B5Nq"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63ULRWsH2099698
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 21:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=; b=GwRk+e9C/NctBONv
	CIKu36r0sw9XwAGbMoUqHqk8F3VsXA1Z1IX+hsOk3wgNN/JYTVQvbelDoTs3yzuo
	w8ezTKWH7Cya2BXuC44TAdPlRU8SQmaJcMNXiKYwjOFvyRGDKVQfv7I2qgynfWTY
	r3EApPmP70ekVWgvhzJfgC6bVqHdGWbty3vae3lGMFqfi8tOR8I2JqlQts85BqhM
	8out9exLsmmNUug79lT5bf9BYWkq6CJsA+vrOol8mk12K5q2bS7qoM5EkB+ewhcY
	Vr6TDrt5AHoCmUfADKd0AGe5/EbNQ87zJKvejDFn3FAwN2iZke4/njr9CTXoUrl3
	5870vQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duyr44dsc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 21:30:42 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ee34588671so656235eec.0
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584641; x=1778189441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=UeV+B5NqiCZ/BrFv0CvfbpPzVZQ86lsYxKf4hOOSM5SIVWZtzfUI6P5HqNvtbyG/rB
         agi/3g6jUssY+cpiirMKM+luydqqrlO49iEDyQqXj/ein/yWTUFJz2cG0MGDg4M6NXrJ
         ZVU3MnU8ls1A2DKFZaf52TzwZBci8k9zscVKvViafw5abb0BV4IBECuQShC7nF3f3H9T
         rs6lj02yBk/bSSGL/02yoPaR18wVY7bZXdEAuIwemUDcjs3mFR8P2Ko5RQfrzC+AgZ6/
         GxdPGT30+zPeMYFx4cUhfVvBXcp2kGCEu1JKbKIJIkzEIJ/UWa9vSsZRoytmto3PWAvH
         qvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584641; x=1778189441;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=DOFcRUDYAULmrCfhwLdtNZbns6k1KxjJJxJM3v4ySHg/TyJlhdV1udyuAeYEOK+vUc
         bqQXgbz6CfQDHzzTApbCKW7UyT1kf0i/T1lO9h9h9Php5Jnn3rfbVWKshylumC9pDwXq
         YU3R33cNqwd/VZX8RTu1KUvpczjGZRaGfSloi01yDUqRiJ02wQD93biMSaApXw5dwXN3
         s0AUiZncARyaw+3wmNncjvQBn1s3YQXKjLHUOfY5ImMPwTCR3owCMTLX1K7dEWDkfIRJ
         fA1Je9YBZtmO2lzyWgMAjZTZtvXCCCETn2N5eqTMibl4fkYaWZoSjPvOsRZTo73HcSyh
         r0Lg==
X-Forwarded-Encrypted: i=1; AFNElJ/KtCVSijv1/a6L8YO9J03RnFMsKB5XITesuLV9YA2ZYjqymLJectOBbpos57vZs1MfhVwRrsT6koK6@vger.kernel.org
X-Gm-Message-State: AOJu0YwzAjO78tFTvR2Grcze7MVwlWmrGYWPox/lMsimDlX5NKtoWM5x
	nCabxwVrRYFqE6Q1Tth1jdmAgtMVOk2rMJGJ/yT5GHH25cxRlOiBBGGsoFH+MBC/FOgUFS8uDDD
	scmFFZhibPgnuV27UpbafvvrcQdPQylPDUEGMl2V0jeQtOk860/cX2NkWahTPVl3q
X-Gm-Gg: AeBDies/zRJYIZIv3SLU2AwUp6NrXXP2FHy6bzfo190007cyBhMpySx9goSYwbemI5n
	W2JDA3Pb4MW7pZ+fpzEEa8c8MzSiPvYR+TQyLsHeQsfa4kW9Vs0nF7piCbKpQmflyrVIT1mrUs4
	pEV5I3eWgIY2ThH/9I09z92V2bv2Kdf8/nk4PGFbUQEBbssMprMPXlIuI5YH99tdq5a9VWR+yMb
	j/2OmgyIbXM4sQ6kyZLP5x/gQH6Buf4AmKm83ndjvmWBYT66UaqBx2JBjQOcxu5F9gcN+maMMmH
	0mUVzoZwfBXz57mMsEa8YjZYDPLutgYAQNpIMphM/oOzUGdhBckyL5/c2GTd0O17f31CdnXSPVv
	HYkgQl9cBClJSjtCV91XSVDUKoPHwBLw8s12+6twJymkV3YdSbSVn/ZvOepacKYqjmnomNGMBhr
	pGw/sQGNJ4PM0=
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496703eec.8.1777584641136;
        Thu, 30 Apr 2026 14:30:41 -0700 (PDT)
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496677eec.8.1777584640462;
        Thu, 30 Apr 2026 14:30:40 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:39 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
        ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
        bcrl@kvack.org, trondmy@kernel.org, longman@redhat.com,
        kees@kernel.org, pengdonglin <dolinux.peng@gmail.com>
Cc: bigeasy@linutronix.de, hdanton@sina.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-nfs@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-s390@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Subject: Re: (subset) [PATCH v3 00/14] Remove redundant
 rcu_read_lock/unlock() in spin_lock
Message-Id: <177758463946.1848985.4916088351427792183.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:39 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=bJcm5v+Z c=1 sm=1 tr=0 ts=69f3ca02 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=R8he2_Gm4Sd0DFq6ycoA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfXyATR7B3FxmEy
 42s90YFnZdwg8p9r03XWe5rl0+jgPXCwHJRyrWO22wZdhFw8NTExAn0UUzsK52GrgPxZzUIimKY
 dyaui3U0/fnoLaAfLKEK8FeHAkov5vk1AktIXMOsHpmcLm3OOB0EPrM3lvJRNgM9a/CIRjWccxe
 Kv5V+eVGfZxndvdJFrrqKhLIy+FTTAlZIhLVe691a/591ZGU5kD7jNwAsbSFwnJLNVxs3RyLOB1
 Qz6GrEkOZpYXfC1xaNNYsQYYisk5wGIW2sfCoXDCKxOe94TKq6ZT2AEgTH69xW2X23i3MWgMEwR
 OCrNunfdMIitRcPpE31cKA2yWCADn4w1qnis026IE1GqE7v6MvUWKt9WQ/wkutHV0pcLe5ajHcP
 BtQkPSxs0M4bLZK6KLd2Zt7d2lwxoygM6YyQnpNkKYii1oOUWrQyOWyUSmf1/UOG6C4iWQy4/EF
 NAvLfBxnALwFzTlefiA==
X-Proofpoint-GUID: xAjrVrKMaRBuLT2FnY0dnSgrnJZ1muib
X-Proofpoint-ORIG-GUID: xAjrVrKMaRBuLT2FnY0dnSgrnJZ1muib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300222


On Tue, 16 Sep 2025 12:47:21 +0800, pengdonglin wrote:
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> [...]

Applied, thanks!

[14/14] wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock
        commit: c4f518736472c8cfbf1d304e01c631babd2bbf34

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


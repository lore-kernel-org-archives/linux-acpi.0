Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3E42C4F0
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765995; cv=none; b=KS0p1kYf9LeXu6BNUqFbcfpl9yqJFsgAMY0dqqfeWevBLxVsrvrbTz77XuHRAaz8FqQtlINzvpDBLo63Qu/ACDt+Pihvdd1YusLa5+VvKx2MByMossJQujaK4y3Z/pKJToAxYMZMrwkQ/PUN1FbHZekYYpWeBHYrqVbVPjxJqBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765995; c=relaxed/simple;
	bh=RNUvVHywhFZF7XRAeZI06z+g6tc5iHKgF20tqzbl9jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvS25EEMjhqQp/TAav/ssSaBpPX6dnG47w2sTBUA4Yc5V8dBG3DS5OS9HcaBjFHuTJb56XF/4vURlluYAu0ntb3bI4rl/BNmOEUoG0R7MhuygEMGoK7Xhf5QgeiW1HQhdlOkP0DgDixcWUAxrJYNfR6BWftaz6QEoxc25gKkSOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TtQOLEGz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kBSeymB0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TtQOLEGz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kBSeymB0"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QGucnA2103202
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 17:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cF2ObdGfsb68PRigF5kDWtjibcdTOJHY9W6xpmS42m0=; b=TtQOLEGzH9pt8AOx
	7brr/MLYU/Lp/wc+sHhQKaLpDe7GK+mBavMrbFcY6Yx3FH8VnTgQyn5M18kbGRE8
	5r2agtr5TaY4S+Knlb1KQBIFqV7RLgzuxh1XsxCRcytRB4ELxrFrSygBWznpedER
	jfYzUSywIS1sUsUMn7r2RAcc001/Z2Pu2jPVCPy9m9vPCtxUnTsPIw6UwUoeG+o7
	zLdBGx/+vbID1Jjj1zetAE5HOkC9RbiHwGTmzdwufY5zaEK5RLI0unrMWlcx5nnl
	FaZNk+hpK1aLOtuYUVePCkwp37lOoDs+XgqNFI6ySliv/kxYX45cOfDY/gg1RkQX
	AM4ibw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga0wbs1pp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 17:39:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccb687f82eso16425775ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787765977; x=1788370777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cF2ObdGfsb68PRigF5kDWtjibcdTOJHY9W6xpmS42m0=;
        b=kBSeymB0NKe1k9hPkktCRQVsZCyrszwtnbsjV7qUy9QQO7pF4QyidLE4DXZ1buBmR1
         AF5NYH7rzqRbtYU53Jjycj9z/7sqIx9ZybIsTvWLxGiJiSvianc36sWPjS0mt66KqfEA
         aPMEV6LUsczaJrZJ1CUMGz7sW/XiRF29xWh0ScN5mUwCQFVZLJy6rAvQGtwU2YokxyvK
         Sv1x4A5iB9qru2aI1grDoXvfMjDe5KQ/unn+KDIGIbgUVJ7RPOeaDshrMIK8VpvxGlar
         eI80yU257gkNo0+e4eIeYQbMuhF5U7++A3e39cKyu0nezDYuikAcYxXvhMgoRGAwJyZm
         qODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787765977; x=1788370777;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cF2ObdGfsb68PRigF5kDWtjibcdTOJHY9W6xpmS42m0=;
        b=q/0DqPv/Om4zJSLuRf+lJPoVufeuyxQ7pE8zgKE6LaeVna6EdQNg/3tBNTgXNUKouv
         Mfg0GcSq8rqkd82nxTCU1DO8ijqiqORPa10487X0R13D9egKfjE5AzQMA9hZt1PPlzDN
         dqStAi38N3r6OB4UdqPd82dzlsEzd5kGscMP5sjsWbMpHn4chTVizFDCGOQTia/+wjs9
         KD6XBKThkPsdPZ/m6ULChb3/VDsbI2zHQWrBNQSr8EKfRsPQL7xHeGzNiCEZMHKpq4mp
         QcTLWK7RRlr+w1yr5O19OrQZye/hgHb0Qexi2LYKnFWU4Q5hRM1wBpso499fp97COkR+
         f4qw==
X-Forwarded-Encrypted: i=1; AHgh+RpbOZ386sgorL8jb27ubcNVVP/3ZfXE85edT6qlyTyidorpUe1ItCihmrIqy32lMg1Ye2L8StQO9tib@vger.kernel.org
X-Gm-Message-State: AFuF++naQ1k0EtjLscrAV/nGxrtOZaN6U/AFj8lMD3uFg1A4kGI62lik
	sg2q/gKv1P0vF31nRdqoTW+tzjWfNRfLpungRU3bqa9IWyJl4miC6W32C5t5PQUY/cAQJyyPdob
	KHk+s4oQ0EPnFiUFVT5NbHBUiNcJka3+W4Ygwv89J7LpTsI6Px+K3xeLmsNI+snUj
X-Gm-Gg: AR+sD11iVOdW/qn5gZg4N70Hpxnz4qcJeoEnMRewYao8q+quIdoE9EXUnu4Xvd+Of6o
	3pvHGoSaIL7FT7iALh8Onx4dm0mXldkj4rqx2SYETucUFWpvYzzaGDrekd4MPFSdz4UuI4SbQKd
	BsUMOIVWWHpZFy0hEM31hATUBDCDmo9aUsUrJ0Yd5rWGp/7uRCwJveCCu/F19ZFAHOWujRDKgmD
	p35DWkLnpbzHhIP3xEK1D7IL/gdNuCFBaeUkdu9hx2kyDxTcacr+WQo+/qEGoaAdiXGyh30awcJ
	TgNyEUsGGIduDzQT8CMB3PqgxsTZosLORFgWsjP+fQ17DHZk7rR9oAcLOWEAEWrzfMI9FLrqFjJ
	HL4FWrSlr4O3fRbj3URHK0PtErJEq/PX/0YHk3MQD2KoI958NdK78N4I3AFflU0mV7ATJFmj9ta
	a1N3oUm/8kwEraX5/UyQ==
X-Received: by 2002:a17:902:ebd2:b0:2d6:61a1:822 with SMTP id d9443c01a7336-2d707af8b52mr47154525ad.10.1787765977018;
        Wed, 26 Aug 2026 10:39:37 -0700 (PDT)
X-Received: by 2002:a17:902:ebd2:b0:2d6:61a1:822 with SMTP id d9443c01a7336-2d707af8b52mr47153405ad.10.1787765976584;
        Wed, 26 Aug 2026 10:39:36 -0700 (PDT)
Received: from [10.50.45.102] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d70497753csm10214575ad.18.2026.08.26.10.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 10:39:36 -0700 (PDT)
Message-ID: <ecccf96f-e201-4dc0-8f61-7ebc6b9a9d4b@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 23:09:27 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/12] arm_mpam: add MPAM-Fb MSC firmware access
 support
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
        Ritwick Sharma <ritwick.sharma@arm.com>, Gavin Shan <gshan@redhat.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260807105451.3728284-1-andre.przywara@arm.com>
 <20260807105451.3728284-11-andre.przywara@arm.com>
Content-Language: en-US
From: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
In-Reply-To: <20260807105451.3728284-11-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: C8H600rfmbpIfXXc5AUOF5zW-nxqoj0P
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0NyBTYWx0ZWRfX8JfdyJAaT5pi
 rCAEL1frJoasMO7lGPBdUXAJc1G17JuXXX4UaBpcWKo9ERGre0tAIZ2nI8hPdII3x2JsI9T3a58
 XzCV48YaHY52eI/nOnZbDO1vzT3KsdI=
X-Proofpoint-GUID: C8H600rfmbpIfXXc5AUOF5zW-nxqoj0P
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a8f24d9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=y8rQOhXNOWzMl4_LRjcA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0NyBTYWx0ZWRfX4TzNL76wLIR0
 POZ/yiyn86jiweTDDpfHPfUvOyK7abL2iB+WMj2dsTDujg6Yy4Y+lM0AaDMy/rB+XtdYQc0t//U
 Ikk9E8EXENSeV0kXHfHuqFtgbe0/oa9kjzGQHKkrTfLzqoXmFbZQNsXzLbQq23TQNdK7pf7SFI7
 6apQ2xtJSNcF2EJUqJr7NnzqA5TN9aQx2jAd9qOXX3swrZhvBbh8ypmE1iK8rtJieiAlrJ+Irya
 GBBeVZV4LJ/RToo5+OJgp0pOZM8ai8ljA+C+eWUVSJEGNZzxaOr+fur+/0YlrO7yNJbyPpwQZK4
 cIMPvFYkaqQLVkhXgxsMqfh68oKbr/1Wrt1npgWobzbxx5hmkdU1zaBFW9Xa3NHeuLaBTX4t9XN
 7wRl0EQpXkl+Gcm7zuo/MAnn6hAYjNxleLsdn5DvsET2sAbbpSNtEG3dvqjUpgAo4jjeROJhbCi
 GHHxhcAqCC9z4IX7mqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260147



On 8/7/2026 4:24 PM, Andre Przywara wrote:
> The Arm MPAM Firmware-backed (Fb) Profile document[1] describes an
> alternative way of accessing the "Memory System Components" (MSC) in an
> MPAM enabled system.
> 
> Normally the MSCs are MMIO mapped, but in some implementations this
> might not be possible (MSC located outside of the local socket, MSC
> mapped secure-only) or desirable (direct MMIO access too slow or needs
> to be mediated through a control processor). MPAM-fb standardises a
> protocol to abstract MSC accesses, building on the SCMI protocol.
> 
> Add functions that do an MSC read or write access by redirecting the
> request through a firmware interface. For now this done via an ACPI
> PCC shared memory and mailbox combination.
> 
> Since the protocol used is only a small subset of the full SCMI spec,
> and the SCMI protocol has no full ACPI support anyway, open-code the
> (simple) SCMI message generation, for just the fields we need.
> 
> [1] https://developer.arm.com/documentation/den0144/latest
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Tested-by: Ritwick Sharma <ritwick.sharma@arm.com> # on Arm AGI CPU
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
> ---
>   drivers/resctrl/Makefile        |   2 +-
>   drivers/resctrl/mpam_devices.c  |  65 ++++++++--
>   drivers/resctrl/mpam_fb.c       | 211 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |  18 +++
>   include/linux/arm_mpam.h        |   2 +-
>   5 files changed, 284 insertions(+), 14 deletions(-)
>   create mode 100644 drivers/resctrl/mpam_fb.c
> 
> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
> index 4f6d0e81f9b8..097c036724e9 100644
> --- a/drivers/resctrl/Makefile
> +++ b/drivers/resctrl/Makefile
> @@ -1,5 +1,5 @@
Reviewed-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>


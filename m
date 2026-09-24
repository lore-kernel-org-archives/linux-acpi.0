Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9343B19AA
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 22:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790288488; cv=none; b=rPnct0xoyNPUarpqyLfmV1Qa2IoAVgf7ArqCousuDMnjMG6Ts6fqT6+tDuEMMdwFYY8DmKQiMNBh4zchZb+bTBW47ANvMUQiPB2LpSPP6Zed+mXJkw8a4gA9LiJhPkr3pXP+FTvdisx8GpuD6Hp37YaViJeqa84zRYzFZZ4Bz6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790288488; c=relaxed/simple;
	bh=KkLrqkkOMipykS26NhHzTN5Hr3AUSyE2UoPnk7qmFu4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILy5RE+tN+l99mfO+7nIwY6STZVVN0xUmmAPvrpyVxHomvFKyPayWeUlGH1JC2CIINXVMbPkGBYQBQhGRa6n5jRBATsdWsMEWnZLVpH+noW1IrpiQN1z6tEnvMndJA+bv4d3UNAX0aaTzCkqiDMEamvFMTP3nFg4tYmX7lkf7Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TD1QmSIs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=guSMjZVC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TD1QmSIs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="guSMjZVC"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OIduWG3614149
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 22:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B7lhxw+XM+Z45cW0aWkRW+XyOgTDsLCB5jNlQmxpIZg=; b=TD1QmSIsY7flrZU+
	7SOZfi9DGtLHZLT1J/4vljwLS3y4Vc5MqJt9Bolvn2w9gHE1e0TpyIF8VlEsUSe/
	yRhU2I0n6IbDCnS7WGGtVIgtPF1oYXyoZ1IGFUTBw1kooNgCiEYQeGPDMMN/fRlK
	aOXmWUQTkg1D0hwp+mbcHi11Sw9mIDXJxuTFFjXWANqW3udlW0BoaIe0tKO6f68t
	IweHYAkTZKoNHSI/iz6P1aEZqsYa6483W3jks7U89wmAgYCg2ngqAnJcpf4bMCjd
	TsvRrWKvXvHUWoa5/nCYjkFZQX+tAZUQdIXRj0DQTZJTJBL3LkirzsPWxjfA9LJN
	H3G9VA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1s92w3r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 22:21:24 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1438fef603cso1063217c88.0
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 15:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790288484; x=1790893284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B7lhxw+XM+Z45cW0aWkRW+XyOgTDsLCB5jNlQmxpIZg=;
        b=guSMjZVC11ZVCHV/+ypPIkeKWrejq4G3BtKcdWXF2SDqTMixMQjbY+rXIqOWogMyuw
         J8i/buqv8b81l4rt/gmoLuAPsWvJCb3P7+W9UzUCMRztYDxQaoTECnH2dKFMDhrPA8N2
         Tkuk8G6cr7AMQ69qxXfP+/BofgFf9HuMdPdbJp1UKZS2S24hNWQUOvOi8hrbQTmnYddc
         4bDWlvztGPmCVeg/3/Kui9B1trMSorowha2rvlCzupB550sr63QpNX69QfjVJpzNXyir
         +8eMDmv9yDHksw8q07mbxJBDX8PEAV6fW0QNyIgXHqqThIebTVuyWNGQ4pFcfhEjonFr
         YC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790288484; x=1790893284;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B7lhxw+XM+Z45cW0aWkRW+XyOgTDsLCB5jNlQmxpIZg=;
        b=U8rBYhbJmw+OErzwffWsMRbRiTkkF0X5LyMqrK7HFEuoZb5PyLgL5gsQrlYWSoYTWp
         2m3upqYlcpHYuG9mTpGfCDTj18LszFMTQgwMLItZYK7MQqUXZRKpSp15MGREnNmowvIz
         7AVd58g7TbmC2X9vIDd0+K0NxubIujwSjR1gg3kG4+9m5d02b+wirPMFv6EhR0i7oxju
         S+CL4Zbq09L5JUpnAi0cEUVAttebqGIZguh5y3MvHq8pCTmBPCcK0Ugs/5x6VEa1fQFv
         PoBMbbq/KzhfvV+l1dlyVD0T4Vjl0V7jQImKkOr4faS13e/595tMIVf+8CPmv+JJfgpS
         S+ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJfDA55GcaLL8XV7d/KxaLIJeeqDarmJFHrVHvJ3pR+IFDcrBfm/OTBBGFPJIuwJ5oYiXy+kM1Aayy@vger.kernel.org
X-Gm-Message-State: AFuF++nIssSgGohiFhR9kCAJeb3+8GMgXFTtu4fs6oVozubphzBbHaVL
	h1ZKz5q5kL70Y/bybuJWcbNeAMN2bOkFxk3kicMsxPFK8XTFAjAQTSr4/ybXCeO2YEbJ9sE77+B
	iQsziLaZpo7mb8K7Ib9uxNfdWs4h17ac1I65C2f+7y6SEWfmsp1tQGA/Q0MbxlhIA
X-Gm-Gg: AYBFou1aJoEWFtYOJQQIqEHvFQCi5ggSzYEW66+4szdsD0EQe9g/zV3wO6t3V6OTV/B
	rggJHp/vmXoUrF/ON2EGj6ni4n0ekiASafLqofrXXuIIpZJ07WaJCPELmagGPCpPfgCApZTI7dh
	d3ivfF0iBIFXE2X1a7GqAIpzR7DgqB6Y6//L3m//j8fXeqyNl6Eb/D4lcPovkzwPnuPLpVAs6f6
	7hmq3MeDBXzeogiym35PXobujb6A7WsELM8BYFqFSZPWLhRFNovs1/PtHk+QJ3X009+jnvJgQGn
	1Aq8hY7d1rj8L2GbVjZtCtuPU/isxJKCwiDJheZoHJ7O/JxiMbxKcbbv42ECvia0ncWpNgI9RuS
	EtZgMQZkcx/x5Cp3GpmfwECwdSuMy6KsPSwfnZfCSYIpbTobzeAnIrg==
X-Received: by 2002:a05:701b:4214:10b0:144:eb46:c40 with SMTP id a92af1059eb24-14503fa7654mr3140944c88.9.1790288483857;
        Thu, 24 Sep 2026 15:21:23 -0700 (PDT)
X-Received: by 2002:a05:701b:4214:10b0:144:eb46:c40 with SMTP id a92af1059eb24-14503fa7654mr3140902c88.9.1790288482396;
        Thu, 24 Sep 2026 15:21:22 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad8e43d2sm1402048c88.12.2026.09.24.15.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:21:22 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:21:18 -0700
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
 <ritwick.sharma@arm.com>,
        Gavin Shan <gshan@redhat.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 09/13] arm_mpam: propagate MSC access errors in
 mpam_reset_class_locked()
Message-ID: <20260924152118.00001671@oss.qualcomm.com>
In-Reply-To: <20260924152739.2865510-10-andre.przywara@arm.com>
References: <20260924152739.2865510-1-andre.przywara@arm.com>
	<20260924152739.2865510-10-andre.przywara@arm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5MSBTYWx0ZWRfX0mImHLTmDbUB
 5mwgkOpK52PGL75uGg69tccbO9hScAkxRnJkfDE+PtMj9Q7W3le1Hc7B/+kqAh1qfM3cWh/yWi4
 ZYHt1acSrDoBcFiaF7teWCYe4oArAXc220cTy2Qtk6wJXLUxQuni+NPj2YKcubpEATWMg15rFHQ
 vtsY1p/tBjTPes4SuAmN9Eutjzu91TdUP2Gus8DYjIoCZHsNyfnrV23y8399Z+DpdROQIntFiNw
 sBwKECuqQT/Tj0uaUcE3jmnKn6U7UYIth8Og9fx9/XucTEg/D3GTW0vMHqqdVifkIRTisWThyGs
 M9RIyNg1710ZH/0/j0Tb6Ge+X/jRTRy+HjOJbGzK6WFCbBIDmPVOQ9oHMdtgJ2oB6ebXvLAV0Nr
 yP3uzvn19JpWwyoBDOUVMsjBKAaFonnhCL2Azr0b1a0ZluERMcFcvQHYcaZ7jthNsJu4llF4WRd
 wA1UA6Btlp9F2z8KQxw==
X-Authority-Analysis: v=2.4 cv=VPxIDNPX c=1 sm=1 tr=0 ts=6ab5a264 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=ESexO8LFGIdw5cpBbeIA:9 a=CjuIK1q_8ugA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5MSBTYWx0ZWRfXyvqGK09XnR/4
 j7ZKSJ/HZZECmtOFmZWldaRduQ3bxrjgB248wSEkMxvCdSdntw23NmrDSDHL8aYuZfRwA7gL0UY
 fOR0dYLcpI9fG7jZoz3Er+kuifQYeyY=
X-Proofpoint-ORIG-GUID: iaXWZGampUpFCRzJuHl9j5a8OlMGdRpk
X-Proofpoint-GUID: iaXWZGampUpFCRzJuHl9j5a8OlMGdRpk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240091

On Thu, 24 Sep 2026 17:27:35 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> The mpam_reset_ris() function can return an error, propagate this up
> through mpam_reset_component_locked() to mpam_reset_class_locked(),
> which is exported. The external caller is a void function, so cannot
> really handle the error at the moment, but at least we report everything
> on the MPAM interface side.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


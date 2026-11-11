Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395935;
	b=XtAaIbSzfgyLXuum2iJweMvqGQY68og5YEbLncAR6/H+l3pWKyRZMfhJQDybNyGLI9ee
	 uPR++UKt0UgYLaijUS0cTYSnAiEdq5rhI81FhhPvxg9RCnlZ3d5/kpparVVvKJ8rG55+0
	 zyOfIAwtvf+xTdmS4Ct2wrjLypwrX1PTkwTov/R1zVvybXU5Pu3+DEAngLR4GzGfIqCEv
	 y/SmVJOuRNMgww022KcMmjzEW1sJW75spFnLTBqrhQbIgTCVrIMZz1MlXHmVnNFsbWsFz
	 ZZcyeWn7WEsoJDt/XvQYLv//hmwqbbTRRkY5LgSmz7DJ6/Dr3Dzii+NmbWXk8iKvwvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395935;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TPBAimFTxSZd3Y5OeVj6SECMmnSpH4mL0Rms57DrSHM=;
	b=oghSiRqpDKRDLOzPMdYXDf1R+UHZQ3nYFPhWHYkDXuOTpBqkOZQk4Z5V2QJ3bStd2QUk
	 jg4yaLYE2CPM8lvHkolwSGrD6TU0JLj/UsjMK/wW2N6ulmrV5d/iWYR4vAGN8iozpT6o3
	 Pg7RJbzrBuXx50901O3EnFxmSf53qkwa5wFNGe/t9gqjnX/IdG/SbfS2ZteRXT+j36y97
	 X5ePT5UiTDc61dAaYS7aNEjqyDJhXdc5+I7iWCldQf3kJNOGhcAJ4EzHcGCPSt5NVChid
	 WvEklLJG9syX9zTwh1603l3xUbYyDDG8Xd81gb+yTMKYUy8u7hPddqm2OHbSkwN8HpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LJ+7Tr36;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L6oD6PNd;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4792606A88A
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 11:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4792606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LJ+7Tr36;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L6oD6PNd
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABANtw9013640
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 11:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TPBAimFTxSZd3Y5OeVj6SECMmnSpH4mL0Rms57DrSHM=; b=LJ+7Tr360xzcgazj
	DnFEggp3Cb+r85NfE1EkbRoNSOkShXoB5uwE0w9XJtBHd71O67NaElCK4UaQCMmE
	UaTjRRflWbTpZQXhBxtrpnQO7Xw3N3S7HR+5HEgNMqCnRBSjCsXK4O+y01dvHUNz
	r+IDB/8vlEm0O5d5JyJx5f5YwRLWSZTvLvj/kpc98cv7/+YfnSjlBOxh/OFoXfC4
	AIwQxiEbsbqzN8qZgShbxEB6ioL9JlZvu7dNjxjkSz1A4+u4ofVNdmnMqTEQRTWg
	Q+DrmHmbCrFBslaQHoHq0aTNJAm0D1ojCciOLoES87/nD/R44S8AIdcTLmFnWm4v
	RMg52A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvpjjr6qp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 11:18:53 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b7cc3f8a4aso2424583b3a.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 03:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794395933; x=1795000733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TPBAimFTxSZd3Y5OeVj6SECMmnSpH4mL0Rms57DrSHM=;
        b=L6oD6PNdtxAbOD257EnFCfYzStJhE755HDa2wYnEyRe2MTtcuwVr5rtYFQGCjV/clL
         Mg7p+HhBsaTRomsnwBb0zHKQvZ1usI51wXNn9/3baeQLPWR+VK68V0r0Sxd5I81e7xfR
         ClNKaD/2KBiYxgPNweIneQcndiJjYSRitWrAkh/v7ZbIw3nTQlb0Ad46NER+xOnvNLDq
         snCjBYMICGyf4IivH81t5VQDiddiE6X7xipHxqA8caq6XAqVYPhgfHKkJQoM/1YdfmPX
         IHRJqOOfv19g5ZMsIcGz1lGpyNJw2WZHyBwgsvwEgIsho9q1qH4zVCC7uS2GDbU0jWpk
         1prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395933; x=1795000733;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TPBAimFTxSZd3Y5OeVj6SECMmnSpH4mL0Rms57DrSHM=;
        b=cR2W84A1fk5NlDsG/TtNGWTX/DzAQbfi1VYETsFC1s/NrEOArkmiETn4ZWsSrfHClC
         kYI3yIfQnyithZNI4XOpNShCjhs2AeDg5UrUbkVU9rvvX/ZDjHbULLc+6Td0yj38y2Qa
         tuzhXbTAAHhZqki296c8jWMBbZLPwL8uXWfkoeyxdav9wRR89bm1dQae4p5JeQmMFklo
         AI0WRjLONuRlX6ji3JPiSWXcDreT9xrg17VyE2LvSB0s2Z0M7yd6sqaGtEksJmg1E4EV
         mOOUe2SbTY2xDhukxLK9pMjZXDglIOgEuPz2N96h7Xw0Du0g3/y02tumBUapD4TtGWKr
         8nsQ==
X-Forwarded-Encrypted: i=1; AL+hErE0lnOA+aeNRpNDRb2vTqPafdDeyUUY7FQf/BrXvkKEiZw9E4W44VSiWm9Bnu0yATOOcv9iyAz2BiL9@vger.kernel.org
X-Gm-Message-State: APuU4Z8MMjeeC/qd85uzhtBq5wVLxD1uPLz4NuWzN+1YT8ozMm/BDk6V
	cHXefH22lxUwO1XvTPpq2bMEppbXVqWjj0L3x+PK8nvggs1PX7Nixl5u9SsoQ9/AH8xKFlQUrbN
	kJiQrlWQCWUqfL+smninLHgTL6klvimUehdoR/FarsDhwbiRy7t1hpdGW3oZ0mtoB
X-Gm-Gg: AYBFou02J0HIN40n1d4uO32jKLKvNhijciKujZcTiP7kkzK+OFboEWZjQpMoIC6ADcK
	8z/uAXHXImfahoUkZ9s99/xDVN18HLB1d00rZb/ILZBACuTVu2JNRKY7XM7Wyl3NsBO7aKH4w26
	5+kaugNxeREQrRdqYBQBmpeRyFWVOO2S9Bb2PzOCpcmZM8JosBXiFIkaeI4+yvCTqVD+KFBTERp
	6SDrv9YdqIqu9rmKwf1OTWrhHTwkC5wshUkuZIYHkkYnQD7a2kFm5REvJyrMr9qiHIzP8ypxGBz
	OjEtIE0BEigpqMIHiWsWxMUEIFO00tUCNR5W3KruUURkuLLuAo7Ex8Q0RNoy6tCK2gFptZCob8t
	h7NJ71f8Q1O6GOqL3vUX67Y4WbqZ1xL+VxWwLcFjCfFAV5dJC1/r/xGpnVu6jF72MleKGfb5sOs
	H6KRi1BKInRGQvR9d1QlHue62wizdVsg9K
X-Received: by 2002:a05:6a00:98b:b0:886:18b2:361c with SMTP id d2e1a72fcca58-8bc19dce039mr2367193b3a.7.1794395932699;
        Wed, 11 Nov 2026 03:18:52 -0800 (PST)
X-Received: by 2002:a05:6a00:98b:b0:886:18b2:361c with SMTP id d2e1a72fcca58-8bc19dce039mr2367170b3a.7.1794395932192;
        Wed, 11 Nov 2026 03:18:52 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bcc3d61dd1sm282366b3a.18.2026.11.11.03.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 03:18:51 -0800 (PST)
Message-ID: <32021bd4-e144-4674-a5ed-ef8b38950b7a@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 19:18:47 +0800
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [rafael-pm:bleeding-edge 9/22]
 drivers/platform/x86/hp/hp-wmi.c:1057:16: error: implicit declaration of
 function 'devm_battery_hook_register'; did you mean
 'acpi_battery_hook_register'?
To: kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki"
 <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <202611111143.CWKE7ewK-lkp@intel.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <202611111143.CWKE7ewK-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0NCBTYWx0ZWRfX5BcwmTl6ZYdA
 aiCzHObAYBhbhwfP5ZvLTyk4tMXrB0/7T9eWv5AYY31/mnKU+IdONfCBNY1lzcIMj5cWgYJWlaR
 kEWzoUqd4h4doV7Hvn6K7k7DCUzSjZfyY175aXGg1a69lQUE8GhMF4weEs1xzKsZ6nRf7EenHs+
 r3fHELXWr+N42nwfaUWfyXyaI5NEcxuCraNY1h2usQRf8USHFzlW4A03LV4i/7BHxRnlv1Uj7Af
 NK3oPMg/WePfI21CFeRn+XQOUDjnmBdbj0W1Fbfk0TUPXyOXqLyTokd2j9zs7H5e8gkRtTY8lPB
 WBwbUE2Ea5R4+k6ugLmwZN3vfQ+yI4uzjR5cll6/WsV+qzuGoTsgJOi9kXuU2IJ/nEK1z1tFKm/
 Jp7oFuXgdZDik8SafnzNAZVSjyyJUHptJMoOWhomGjShktitQuNY8di9tJQZOT9CpDf3p5PcREi
 IBkpbJj3SAGu1ZC9ung==
X-Proofpoint-ORIG-GUID: y2TTRO3NUWzD60pfTeYh-GFxOXCK_Kmd
X-Authority-Analysis: v=2.4 cv=FeuiV5+6 c=1 sm=1 tr=0 ts=6af44f1d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=NEAV23lmAAAA:8 a=pblzrQVLAAAA:8 a=txJK9vjdTDeU5cjP6X4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=mmqRlSCDY2ywfjPLJ4af:22
 a=zigF7KAJN4Oc2YRatsUt:22
X-Proofpoint-GUID: y2TTRO3NUWzD60pfTeYh-GFxOXCK_Kmd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0NCBTYWx0ZWRfXwPlKjTIsw+xE
 SrwDJ+MBVIsK6Sont58ybK3bnPBQ/IgllfM0VxS7GnylP0Co98IWWrh9iPrf3KNSdyT/F5vENm2
 Saw635WWz5dest6iwM22CENoxPacRkQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110044

On 11/11/2026 6:46 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   51bafe2e7302403a43ba45415bf9a268a7fcaa05
> commit: fafe4f5166bc3d43e28967efb9ea82b1f456b798 [9/22] Merge branch 'acpi-battery' into bleeding-edge
> config: x86_64-randconfig-2003-20261111 (https://download.01.org/0day-ci/archive/20261111/202611111143.CWKE7ewK-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261111/202611111143.CWKE7ewK-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202611111143.CWKE7ewK-lkp@intel.com/
> 

Addressed the same issue on 
https://lore.kernel.org/all/cbd2aee7-95ae-4d30-8458-b7da2910867f@oss.qualcomm.com/


> All errors (new ones prefixed by >>):
> 
>     drivers/platform/x86/hp/hp-wmi.c: In function 'hp_wmi_charge_control_setup':
>>> drivers/platform/x86/hp/hp-wmi.c:1057:16: error: implicit declaration of function 'devm_battery_hook_register'; did you mean 'acpi_battery_hook_register'? [-Wimplicit-function-declaration]
>      1057 |         return devm_battery_hook_register(dev, &hp_wmi_charge_battery_hook);
>           |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
>           |                acpi_battery_hook_register
> 
> 
> vim +1057 drivers/platform/x86/hp/hp-wmi.c
> 
> 929433336e0a6e Shang En Sim 2026-09-30  1033
> 929433336e0a6e Shang En Sim 2026-09-30  1034  static int __init hp_wmi_charge_control_setup(struct device *dev)
> 929433336e0a6e Shang En Sim 2026-09-30  1035  {
> 929433336e0a6e Shang En Sim 2026-09-30  1036  	enum power_supply_charge_behaviour behaviour;
> 929433336e0a6e Shang En Sim 2026-09-30  1037  	int ret;
> 929433336e0a6e Shang En Sim 2026-09-30  1038
> 929433336e0a6e Shang En Sim 2026-09-30  1039  	if (!dmi_check_system(hp_wmi_charge_control_quirks))
> 929433336e0a6e Shang En Sim 2026-09-30  1040  		return 0;
> 929433336e0a6e Shang En Sim 2026-09-30  1041
> 929433336e0a6e Shang En Sim 2026-09-30  1042  	/*
> 929433336e0a6e Shang En Sim 2026-09-30  1043  	 * Firmware retains inhibit across reboot, so seed from GBCO rather
> 929433336e0a6e Shang En Sim 2026-09-30  1044  	 * than assuming auto.
> 929433336e0a6e Shang En Sim 2026-09-30  1045  	 */
> 929433336e0a6e Shang En Sim 2026-09-30  1046  	ret = hp_wmi_charge_mode_read();
> 929433336e0a6e Shang En Sim 2026-09-30  1047  	if (ret < 0)
> 929433336e0a6e Shang En Sim 2026-09-30  1048  		return 0;
> 929433336e0a6e Shang En Sim 2026-09-30  1049
> 929433336e0a6e Shang En Sim 2026-09-30  1050  	ret = hp_wmi_charge_mode_to_behaviour(ret, &behaviour);
> 929433336e0a6e Shang En Sim 2026-09-30  1051  	if (ret)
> 929433336e0a6e Shang En Sim 2026-09-30  1052  		return 0;
> 929433336e0a6e Shang En Sim 2026-09-30  1053
> 929433336e0a6e Shang En Sim 2026-09-30  1054  	scoped_guard(mutex, &hp_wmi_charge_lock)
> 929433336e0a6e Shang En Sim 2026-09-30  1055  		hp_wmi_charge_behaviour = behaviour;
> 929433336e0a6e Shang En Sim 2026-09-30  1056
> 929433336e0a6e Shang En Sim 2026-09-30 @1057  	return devm_battery_hook_register(dev, &hp_wmi_charge_battery_hook);
> 929433336e0a6e Shang En Sim 2026-09-30  1058  }
> 929433336e0a6e Shang En Sim 2026-09-30  1059  #else
> 929433336e0a6e Shang En Sim 2026-09-30  1060  static int __init hp_wmi_charge_control_setup(struct device *dev)
> 929433336e0a6e Shang En Sim 2026-09-30  1061  {
> 929433336e0a6e Shang En Sim 2026-09-30  1062  	return 0;
> 929433336e0a6e Shang En Sim 2026-09-30  1063  }
> 929433336e0a6e Shang En Sim 2026-09-30  1064  #endif
> 929433336e0a6e Shang En Sim 2026-09-30  1065
> 
> :::::: The code at line 1057 was first introduced by commit
> :::::: 929433336e0a6e5014af7b8849f369712d2c8964 platform/x86: hp-wmi: add charge_behaviour support for Spectre 8C15/8C17
> 
> :::::: TO: Shang En Sim <sim@shangen.org>
> :::::: CC: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


-- 
Thx and BRs,
Zhongqiu Han

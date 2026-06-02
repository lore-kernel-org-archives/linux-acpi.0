Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6833F2101
	for <linux-acpi@vger.kernel.org>; Tue,  2 Jun 2026 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416631; cv=none; b=VzBmFJwF67q6+1OxR64EnBsYgQtKOyNyf5FK0nSfIZjOYWAffDvYRbOCBwCzp0xxN3F02gwK8V6f6EwI2ps4Jq9cimrRDQ6YtfYJgk3dLjo5xbT+WUYkKCiywzsJ7P4c2RWC9DKt3LDzZyohoXzLlYA893imN59UUzaonmtLkO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416631; c=relaxed/simple;
	bh=G7eYHj9tlnDiI1d3hfnzgPcXdN7BBHFSjCI4dSopmyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6ulaGkwSZiy0Mj390GDWL8k8iFjlpWzjV8mn3m+uFDTR30rSADGZtBumbuNLQaMNYHkS+ep4HoBCHKWLJL+sWZsrkJLwUAAtrIaYB7LLmU0NVyQu5lVq6bV5QJ1DbBx6zBnm0dSLh+u7BqaBQxM58ZFC3NUHLGslfv7XKgWf64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CrsBW21D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j49bQf36; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CrsBW21D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j49bQf36"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652DF38A2884681
	for <linux-acpi@vger.kernel.org>; Tue, 2 Jun 2026 16:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4wuW/Yokzii57HXL/z3H+3SCKWh40lWXglHNdQClPAg=; b=CrsBW21DYrzUoj39
	LSZG/g+HQ1czUCOfiW5AI9AgHw5zw6fjbd6pvyuNSmPbPF08VGO3D1slcgqznn9a
	3SINRsyYzPGI7e8cMXT9AT5N7LgsWlK+7YgQb0AGS7Dm3SicCXfcBxXY5/ss2+EC
	TSSqL5ZcyEIZaWXiG+daLy1ibhnuWr7zGH7J7s4pJE0SK9LOhH8siUV35CzuGYbk
	HEtAqlGgieVJErm0WSJVwESs3f0Tq/qgRupknT+S/Vm75Z3MdT5P8qdEgegp5KAC
	joxuomMDVECFRAKY1rJB13gE0gYslRkJhxFA0PtWxoZRbS8QudVOJ4gTzZUPO8Ze
	kGl5NQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsu12ctk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 02 Jun 2026 16:10:29 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9639fa7f2a7so1378329241.3
        for <linux-acpi@vger.kernel.org>; Tue, 02 Jun 2026 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780416629; x=1781021429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wuW/Yokzii57HXL/z3H+3SCKWh40lWXglHNdQClPAg=;
        b=j49bQf3601uDzXR6tODRWk0/amYq36AxkCbcWABfqyzYd4rBDCE8oMNngfg9ZRLe9U
         KKFmLc3Nms6QhltxfDlaMwB0OK/7Zb+M5NobtXdBzcdqHhMrAzx5vf6LSi++eqg9pHPo
         Bh6YosZ8/bB7qnSt3egS2k+10yFIcM2C3aKElNIjFabXCufsAyRlG8OY/e0ME0m9ak4m
         S21ZIVcKELddX2fnJ4TjMkbFSyAaLXWS13aFBBwH9u3WoBE3G85UXFaK5u71z+pCR2Ck
         qbi7nvPJj6G8e7yVhVGuXYna+uG0e8jIrMXh/O5RoKgqvYuewinouuoPoA6ZOao0cN4T
         j+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780416629; x=1781021429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wuW/Yokzii57HXL/z3H+3SCKWh40lWXglHNdQClPAg=;
        b=BB+SNRJECTTyzqyyPr3jbCrnfQwTeQvaJzbBbVW1McAeN6ZoeVNFTtGmQUMyq2Sgam
         7FwrqTh624jmD+teF9uewMdBKP88mrFCkCDBdry4zAsLEjtafgLj9xqwJhGDwSsnyyH0
         YDEpuwvZArU2MmI1+hUt7BlMTUovJphubtVrzKKGcCZFzb3B8tHCajlm7xV5xDJYHIne
         b2mZN3uk0gCxWnhue47185JlgO3XYYTnRbZIO84UkmMabVjQ3ZlvyXjPBGnBWQnmUJ7a
         VT/KaSKrv5znmfQRP3fCf/IkvMd/TWMigMe4AByXx6VTgyzG1nY8unqZkdvZV5X/sEYq
         KX/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+OkJyoT6yztG9w7fyCYdSlVBvHIZH9MdDXbW0qSpbAhyHTTDZ/bD/BWF1H2Sq+zd/uZBL9mNLPWkS4@vger.kernel.org
X-Gm-Message-State: AOJu0YzrNxhDPB6Gj3V9jreeOYpASj8UYOj/8ESLJ7PthOzBel3tgEUs
	jTWcv2ym2z2rPXCZL0z9il3tpJ60D+yu7C4BJ5ExrvwZv6WS26L58lGHmnWQeK0x/QCN+SBJ5fH
	NurbWOmbEVJVTIcNPYUxy3SX7tnr5UeOPVzVKXBgeiuAbJCx99Ou5LhgdGKNQeicl
X-Gm-Gg: Acq92OFsFc7nJpXRinlB9M209dc8QyKlNfWxFOhWsuREPZR0qR9ZsYus4dNIzvKBt9H
	KsgLwoYTvqAf8dYwh894cXqTyA3Rp+45FonDz8le6Z8eb4sRmw5azUo/c8xQvUu5SNpooCcThsL
	F3De+cVXI3toOQGE1HYeDjw1XXry+e8uzM9gFyMH/TH3pT0AJ9Qm7h/g/jM9DMvFqpSSL4oExTk
	b4JvXet04KVi61yKgs/ifyh0azy3P/qjrVksly6/dzZjVMl1rTJpQt76qkhcpsUs7WQs5DgbgNu
	RMsLhr1jBN3QyCKyTlQkzLcPfXLPy4dpif1SYxCegEXhwsM9ZdA3QsdTOiTz0HazKlUuqcMYk6s
	BycTUptgXp/L0/i9LoXLYqmBp5k/BNvKcrHqmM3dbdH9ZOOYMBMygHC7xbswTUVMGi06jr+cElS
	iM
X-Received: by 2002:a05:6122:1984:b0:5a1:de02:b177 with SMTP id 71dfb90a1353d-5a6974e7e80mr582268e0c.13.1780416628857;
        Tue, 02 Jun 2026 09:10:28 -0700 (PDT)
X-Received: by 2002:a05:6122:1984:b0:5a1:de02:b177 with SMTP id 71dfb90a1353d-5a6974e7e80mr582191e0c.13.1780416628462;
        Tue, 02 Jun 2026 09:10:28 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e37851sm80264715e9.13.2026.06.02.09.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 09:10:27 -0700 (PDT)
Message-ID: <13afc706-2513-4fd5-9e5a-50c4307508a2@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 18:10:15 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/17] arm64: Use EL2 virtual timer when running VHE
To: Marc Zyngier <maz@kernel.org>, Daniel Lezcano
 <daniel.lezcano@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland
 <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ge Gordon <gordon.ge@bst.ai>,
        BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>,
        =?UTF-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?=
 <eleanor.lin@realtek.com>,
        Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Simek <michal.simek@amd.com>
References: <20260523140242.586031-1-maz@kernel.org>
 <8633z5ugzi.wl-maz@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <8633z5ugzi.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DwvxxbD3iSJxvaLlAE_28f_b2sl_EkR8
X-Proofpoint-GUID: DwvxxbD3iSJxvaLlAE_28f_b2sl_EkR8
X-Authority-Analysis: v=2.4 cv=MKFQXsZl c=1 sm=1 tr=0 ts=6a1f0075 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=0vUytTvmGukYalHcjhgA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE1NSBTYWx0ZWRfX0QfRO1AtCKkV
 HlJel0FJzjcZP613aqRzT7M9QETI1T4EnqRVXUqXokcT+iKp4zfcUGUWrGD0GTBYUoDlqfJpmjJ
 p306FZfrN+Ht/vwGoc0kofNMBPZqgBilZzg6zaLXJA8C5Ey94GU4j8wls5UfLn+iW0nImNWdK3L
 tlVVWbda4Be/GNNwbMmnnue1C1dIBpSUQCuVEPT2pvpKG7pZ4GlzLySHLSUE2AZ65OzmDgJYUXI
 V1xsIyYMqZ2HugK+z5RxQlhQ5Q8XtyCRCUI2WZ5McuptkVc19vkwpy3gS4HnjtPxuvs6rsC6IJy
 LwmTzdpwWdX2PDZ7Ksch3TIClV5cOZYgbDxiIOy40dQUhimwreZlDLxe1wFFZELjfSdoaxwWMHu
 oeha6zKYYE6oSxsPB1hcUqHSuBg1rq8GvH3gFITHf/JT6C1x4ZGyxR/SZI9yN9KW5d2Ch71BDSt
 jeVS6KyopKD3es09UPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1011 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020155

On 6/2/26 16:58, Marc Zyngier wrote:
> On Sat, 23 May 2026 15:02:25 +0100,
> Marc Zyngier <maz@kernel.org> wrote:
>>
>> This is the third version of the series initially posted at [1],
>> which
>>
>> - updates the ACPI GTDT parsing to deal the v3 layout and the EL2
>>    virtual timer,
>> - moves the architected timer driver to use it when running VHE,
>> - fixes a number of DTs to reflect the reality of the HW.
>>
>> This results in significant performance uplift in deeper nested virt
>> scenarios, at no overhead to the host.
>>
>> Patches based on -rc3, tested on Amlogic SM1, QC X1E, Ampere Altra,
>> and Apple M2, as well as KVM NV guests.
> 
> [...]
> 
> Daniel, can you please pick the first 3 patches? Or would you rather
> have them routed via the arm64 tree?

I'll pick them up

Thanks

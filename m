Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B719D33CEA2
	for <linux-acpi@vger.kernel.org>; Wed, 20 May 2026 05:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779253473; cv=none; b=Ehj8TUTwOcNUY2+vI5HSb5a0Ok/ppMQ462dw91H3aY29MKyrCv31+6hBWp0G3Z1Vx9gOhsOP09ldBD+RrsUf+OGMHKWKDNYIiUvCVRqV8XRIwiWY+bF8Qd2RExgL23U5fZtz6du73QiL/qPW5VWLyz7TG58ajFr81V5WrLK5JOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779253473; c=relaxed/simple;
	bh=GBw4sTQ51qv3RHbSz6bJbjqhdBcQ63A9uBz66nhSXZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTbMyHPLhLxhR3d5ElN0t4SJDzQkxIl80NpCGRoZRBK9SvkizLJm8F1WwfCI779gWStv6oCgCZGdcjv84Y3+8C1YAXPyeDuFUwoLnaCgIUfHJF3y1lXLJhOCTY1LP7ow22PMEwnfpaKzVVUeQgnSNf9MSKuOeJjsaWDXFSF4s5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AGxCSdId; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fBT6J5w8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AGxCSdId";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fBT6J5w8"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JN4PDb1237947
	for <linux-acpi@vger.kernel.org>; Wed, 20 May 2026 05:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OmSQknuukmFtpHIF3IEi2WKgAfnolG31trNYBiHuO94=; b=AGxCSdIdhznPmytD
	r5V/e9lDrCuH3/0gRJtb8HQ1SX6d/D4TTxqd452zKW/4bVNVhKdIOtWoTy7rkUtz
	oaHp51iBf5NigPanwjK9HgCS1hdYtLEI9UqckFlx/NNqSrCGnFInTO6ibecveqO8
	by2G3adovXR4GpPtgBxlOAlBCIQNRTTOrWK0Kr1FrGr4Hr+cmXpnt1mDNd8jfAm5
	qThdm3DxJPNVxI8uZV/X+ZlYS64CfDduc/Cps0PSv3bvVO6u9PrbDFSLQbHgcsvV
	ei7VuDKkJjQP7E0DGy/2l/GoktWqN2/s+cHPdy68a/MxslOAhMj3ikC6biXtdyQQ
	sv3Q7w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3su2yx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 20 May 2026 05:04:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b45b74f693so13529865ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 22:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779253470; x=1779858270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmSQknuukmFtpHIF3IEi2WKgAfnolG31trNYBiHuO94=;
        b=fBT6J5w8af8boljQ5ifhwwhAbnTAWqATRGdNUqLM8Y9FhLKSdleIFHBnFIB/FWD/Vo
         +go76bZLayzU4nR3N0md5WCf08Wdm0dYRISSGbcwkj52Kr/2yDvLoyNUdOcMdnepgMnk
         HLzNC+MGVRRnTt3DV2dJPYhYNFH8aZOjdGUsTEUMfporaS6LuCUGeCWi285UaeI5EpSk
         5ZRiD+bDmdwjFa+Ftmxt8H3t1glbX7geBQiQG60rpcughej9yjyHgKSyBwR9AV7vrnB9
         i5qqQkgCHt9KOlH6ooADj46+haK3OvYiKtQPiRiMrr+tIYjugBd33+mogn65miNAKipr
         REEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779253470; x=1779858270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmSQknuukmFtpHIF3IEi2WKgAfnolG31trNYBiHuO94=;
        b=EqJii922q5xoJcKvLAeOYT83tYlRj3hXluqWgOIOU/1XHVDW2af7l8DhfUroCJ8GRR
         pZXD7c7pGbtRQE/8JocJMwVOjC0UrPcQhdGxx3Z4iBRy1C3cEK5rVrtAkOlWuG2aPyK3
         Eta1XihnyaUZLleRwCjKZ29yCxByCFn9Ws748BX5LI5+38qPesYMaCMP1HNXhcYb7ZQL
         Ahr+DQ3rulJgYyqdv7u5U9HZs8p6Zjue3ulD0jdo6VuAEOCauNjpVAf0VtywkcEsRs2P
         /YAVvAwoybHiZHyiK9ZU6hcLZspUAWRGoRkeneUyIwVIr2utqCTlZKeNVgSu1ZThGMAH
         nKyg==
X-Forwarded-Encrypted: i=1; AFNElJ9zLA9HV8jgnXKpGTor1gJ2XXlmqgkvishQcDftk2hxhVUUViyoWK9FOBjtfihxWFVlAL4rzROd4LYq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+9H2rRx1vK2LbC1TmeaLqYRHD640VrkDZqSU+1i5SnSQoXxuY
	cOF5dG3sRyHnputIhui3nVDHhPTWrS05nRcAgBA941uCWOGoZLC8zGDscNEzHHfWs7PXw1ltgDQ
	eAG42MEIXI7JcX1yEQnKyUPNc6X93NdjaoOeNFQ8A6GmGIGv9Fkuq8h2uliId6c2O
X-Gm-Gg: Acq92OEUOVA5btDOyTHIyRjxrFfzNIzfjxB7vzcHdCqHYLshI2VpqHryuRoGtp5ALep
	ZEYjKTXuRnQmHCjmOos6znbHPeI3kFDpNlmoZsZW5l8Cuf6WcJF/UdzzdIwuuBR0S0piTJAhSdf
	/W6qTyMzfG/hoEY/u0W0Q8wb8p3+Wba2ohqBS3ta04gZX2kZee6jcfGJW4wlpKTuOUJZv2OWR6A
	+du8IlGo2d7RqTodAeqPt2Jg5pQcOL5ZAIcFFc8+huo7yhNFlrB4IOu0aTaX+Yn3Ftwa8owCg73
	7pZbnmxaOS2SQgtpe3p5GoK7Jg4ml4BRfLZlSkJd+eP03Yduumo0bi//hQzNXDWjkmbhmdutS6N
	nojj0v4BFPcJ7F+auoO75966sd9TfHZVoS4gIgwQ3YfepVkcdjWnD4ZVJYg1XxBHcd87+l/QFPQ
	6hWJ8l4g==
X-Received: by 2002:a17:903:3c6e:b0:2bc:cb8f:c286 with SMTP id d9443c01a7336-2bd7e8cfe0cmr139206325ad.7.1779253470281;
        Tue, 19 May 2026 22:04:30 -0700 (PDT)
X-Received: by 2002:a17:903:3c6e:b0:2bc:cb8f:c286 with SMTP id d9443c01a7336-2bd7e8cfe0cmr139206045ad.7.1779253469796;
        Tue, 19 May 2026 22:04:29 -0700 (PDT)
Received: from ?IPV6:2406:b400:b5:60e5:312a:8741:b738:744? ([2406:b400:b5:60e5:312a:8741:b738:744])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f287sm270216785ad.24.2026.05.19.22.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 22:04:29 -0700 (PDT)
Message-ID: <55470717-3e9e-4548-b12a-8e2a2e1f6c63@oss.qualcomm.com>
Date: Wed, 20 May 2026 10:34:19 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: qcom: monaco: add AEST error nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Ruidong Tian <tianruidond@linux.alibaba.com>,
        Tony Luck
 <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, catalin.marinas@arm.com,
        will@kernel.org, lpieralisi@kernel.org, rafael@kernel.org,
        mark.rutland@arm.com, Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
References: <20260505-aest-devicetree-support-v1-0-d5d6ffacf0a5@oss.qualcomm.com>
 <20260505-aest-devicetree-support-v1-8-d5d6ffacf0a5@oss.qualcomm.com>
 <71eee892-1c0b-49e7-a82d-9016c56e8592@oss.qualcomm.com>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <71eee892-1c0b-49e7-a82d-9016c56e8592@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oK8Cm-3Eb38qZ1ys4UQo62Uf5TcQ1C4p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA0NiBTYWx0ZWRfX1E4Qi/+9aYpd
 b2CNGPEoRbdrXQiQx2d+0I7VAiBN3iWzL3/RgL3cPfr+H5XQSEVdu3poNRxOTCFM96U4xuokb7K
 N0QFOWq37dCdcd2E1KqlqzbOFlnugOMsGvvB7KXLuuJTTcOjfeXnrC0M8WHLgMo8Bgp1VzukNJp
 oMvZGPHk8LbhZmi+/k4yl2ZYLleqXUCb1kKnHkovrrQeOBdJVriOsZe7Ug6M2zTOE8f5ZpLvdFO
 o1jmYAqT844ubmeqKP/4ApEqlegLS3urNtZrqPpG1lzrSNYsdQMSUyK5Cbls0t7mGb50BD5Xpo5
 /tv2AsKy3zfLu4LUy/6+v/cKGLRaZeyjCk1VTLZYJcSemx+1YVrWIB7HQax7QEZJjpe2zTW2Xbq
 dUYBUIa4Z2COyo5RGb265qCezXYPZMnyy/hEqo/4lojSgf0Nd71Ufl9msyDoHa5s+W5vZPXc4e7
 9CobuW1YYC5e/NrVqkw==
X-Proofpoint-ORIG-GUID: oK8Cm-3Eb38qZ1ys4UQo62Uf5TcQ1C4p
X-Authority-Analysis: v=2.4 cv=SNhykuvH c=1 sm=1 tr=0 ts=6a0d40df cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=8C-fUGBXRnHmYMWNGq8A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200046



On 5/12/2026 4:58 PM, Konrad Dybcio wrote:
> On 5/5/26 2:23 PM, Umang Chheda wrote:
>> Add AEST RAS error source nodes for the Monaco SoC.
>>
>> The DT describes a processor error source covering all CPU cores and a
>> shared L3 cache error source for the cluster. These nodes model the
>> hardware error reporting blocks and associated interrupts as required
>> by the Arm AEST specification.
>>
>> Co-developed-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/monaco.dtsi | 41 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
>> index 7b1d57460f1e..8e43ceed7d84 100644
>> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
>> @@ -3,6 +3,7 @@
>>   * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>   */
>>  
>> +#include <dt-bindings/arm/aest.h>
>>  #include <dt-bindings/clock/qcom,dsi-phy-28nm.h>
>>  #include <dt-bindings/clock/qcom,qcs8300-gcc.h>
>>  #include <dt-bindings/clock/qcom,rpmh.h>
>> @@ -29,6 +30,46 @@ / {
>>  	#address-cells = <2>;
>>  	#size-cells = <2>;
>>  
>> +	aest {
>> +		compatible = "arm,aest";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
> 
> These 3 properties aren't necessary if none of the subnodes have a
> 'reg' property
Ack

> 
> Konrad

Thanks,
Umang

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D964943D515
	for <linux-acpi@vger.kernel.org>; Thu,  8 Oct 2026 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459766; cv=none; b=Aej7BJPfSRzOH5Q59upuzvoex/XAb+9nJVq4BeUdYQ9+JNL043oF5BI88eQajYFyB4+P9AS2FWlTxZbgovMp1tdktHnXVEWl2mJokwcEemIQCqp2bfgF4tgSd+z0P8UCMz86TQduqWSYKs//RKXDXjXIqgfEhLxn4q5JNZs4UM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459766; c=relaxed/simple;
	bh=cAGkPVYlrmH3K4nr2n7hsxNQEWLouB39/2CAuZGLZhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEsLf0WKVmDCQwdPI6mYsiZweRmD16HMH1yfP3I+pstUS42+uCAmWI7d/yToQTD+eRngPIkEmpSo1iXmw9e5D7pYullFxCt650GThqkHNXFyV6S9/U0aHiKOpFnD/0UyL4OyQSBRDRQ7BCGuOD5LhvxhpXH/++4fK09d+O9E4R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TnABhFxq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hhYy2Noe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TnABhFxq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hhYy2Noe"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698BK62f2705044
	for <linux-acpi@vger.kernel.org>; Thu, 8 Oct 2026 11:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lmC3SrCvP8skXHJ/mHFyl+TVaRxCu8ilerp6R7htgl0=; b=TnABhFxqn5/+RLet
	8wyGelZ8cIJkvWPZ9KH2pi1H8k8O9pWJ+Kw/Wy0jJ5QGwtx1+n4klRvuAWqc+Va/
	gYVTyeS9Vm7twA3BkB/4/f6KOWm5DZAtj/nKhuRdyM1EPongJiGliKyI1FKhm7Pm
	MXaHyh2F8OYUMfy6xJ+Ig0tw0HVbJSEPlx/+DylapCdjLnv6vW1UYE3S338RhlOu
	XqecD6vzJCJMxS7yd2Ys65NB3Q4uFLhgj8NQ+M8diN0igPBXfWA42ZNMMKekqIya
	G1/dC8FESxiiINDlNxK/BDuGl+MG9KpyCi79Tzts/WEkyiOT/rhahcGVhe5l6NYU
	Q5IfVQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2tthn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 08 Oct 2026 11:42:43 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-339628f2bbaso689561eec.1
        for <linux-acpi@vger.kernel.org>; Thu, 08 Oct 2026 04:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791459763; x=1792064563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmC3SrCvP8skXHJ/mHFyl+TVaRxCu8ilerp6R7htgl0=;
        b=hhYy2NoeC7pUp6rOr/nbAdtbKJWEjA6hvRNZbf8fxgq2kqrYT5XLMN7OMXwmDshWpn
         x1kLBadTPwtrFdNVqYoCYc8D3p/WxjQIPhvEpqToN6eY/ARpgzgFfMdajOpWcxSazvMa
         3wqifrHS7PZxzPkfpucEvUT4xtAIxU6c8cFupl/dacxdtyv7kV1LfovF+DGQXxmGSn7S
         5BCSI4jyiQso0YzKHoDn9Or6De6clW61D+K80NlZC2x8yp8aB00qw714k7+BC/uQSkvb
         Q7a7/sg2fKsomKxFG+82iwz2oIo3iMiAua9lFyDKR09VK2ddeTqfcF5IMXRLLeoWbqDy
         PlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791459763; x=1792064563;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lmC3SrCvP8skXHJ/mHFyl+TVaRxCu8ilerp6R7htgl0=;
        b=AOR4VawcFajLmZSmfY/LRrxJu/9wggbi2kJb/kSv6Il6ixaA3u/t9eV4aeZ+1T0gPa
         m5pT53u/ot31r2H1dd8XGud9YU4C1SD3wxYnZR6SIPUqQaE3lGTtpz3kfV7kJO5KQSwz
         USRthyqNiNw7l1imsJzkRcI+xKigQ0tV7OHl3uFr4JWpoxw3hctCrtxZafU5jdaQ8MTx
         /2WFLSdWUzJYBkTLgXlkXXmhjLs3Vr9+1LyDDg2dfMthLoGpkwI/Yk6XDz+dpOxzRV7V
         QbUGadj+9AF/9sIqTnKCOUZkzV+KCfpsdhuQ1ODVYxhKmlNF6HK1ruHA5JotsUjYFMAR
         sTqA==
X-Forwarded-Encrypted: i=1; AKwUvBwd40cXnpQBrKQDW1xuqbGyrUjO1znPmqOAS1c+zMCI4vk2+v/b6B7mS4z49Hw/jxCZRQyQrQFKUF9t@vger.kernel.org
X-Gm-Message-State: AFq9FYLLP/6OEHomaAg67d1O8MKEClG0JGJH9/TjVQFmL3zZ6NCBPqZE
	ceoCcvXAC33ykSvgAuxyDR+aIIvR0bdHim9JOX2fe4kegTrQwV+gT2udb+8XO4Jp8QVVQe+R7ij
	T+7WgQLVl4Nkew5ZlNMovnNV621YX59yd9JS/VVnePxj4cvQOWrSNjPpqB+hjejoZ
X-Gm-Gg: AYBFou1smcD+UCDu2dOA3J7KwqWlCvXNOY8sGanGzE5gAOkkST0HSNblyuxDugZK6WB
	uMuSZYwjrrXXS8FnBcwhr/P+vik9QbLkoZ1h8Ff0vrN7KUDnSCWfFDASfrRDPCqv12pUHLCEan8
	vusFKYjrdpGogiUeO8nPvF5eDwquxxguchNJeL7WIHEstVaL4sEYbtzjxwQQzHY1nkaa5O84PZb
	e0uVRSY9AThYY5wS0GI/kcbjkN/PhmYV9YCntWdslmIvCncXhPV4rmLQevuJnyRZXg5REHHrhvl
	u/wbgrIg6McbD9GnTCuGWzE8AP/FlsNKN2Nk3WXekZ49dk30oLGiEXALFYuY8Tv3iyqDLtJnSk8
	XCauROTXPkolNdUFxvFGKYY+WEdwvvz8=
X-Received: by 2002:a05:693c:630c:b0:351:d38e:6c0a with SMTP id 5a478bee46e88-351d38e6d5cmr2228651eec.0.1791459762637;
        Thu, 08 Oct 2026 04:42:42 -0700 (PDT)
X-Received: by 2002:a05:693c:630c:b0:351:d38e:6c0a with SMTP id 5a478bee46e88-351d38e6d5cmr2228565eec.0.1791459761768;
        Thu, 08 Oct 2026 04:42:41 -0700 (PDT)
Received: from [10.217.216.239] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515aeb6076sm17870481eec.9.2026.10.08.04.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 04:42:41 -0700 (PDT)
Message-ID: <3aa2f7ba-734a-4d50-9eb4-cb7322449919@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 17:12:34 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: ras: Introduce bindings for ARM
 RAS error sources
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ruidong Tian <tianruidong@linux.alibaba.com>,
        Tony Luck
 <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        faruque.ansari@oss.qualcomm.com, avaneesh.dwivedi@oss.qualcomm.com
References: <20260720081954.1858180-1-umang.chheda@oss.qualcomm.com>
 <20260720081954.1858180-2-umang.chheda@oss.qualcomm.com>
 <20260731203515.GA1619665-robh@kernel.org>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <20260731203515.GA1619665-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AbMkjHXG c=1 sm=1 tr=0 ts=6ac781b3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=txCGJbmANruv-OSAE2cA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: oFljz_lzlnnWt5fcpGuJLu0HQwkTHupi
X-Proofpoint-ORIG-GUID: oFljz_lzlnnWt5fcpGuJLu0HQwkTHupi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0NiBTYWx0ZWRfX6qBneC2yGN9d
 +5UB4oaXcqXscBnDCkox0/uBbmuQswIfYrGHk9kZdw/VOvqkoUK2bjRCv2m3mv0Tlv8MOHobgfF
 1REPyR7z1/nCX5OZfFzP8ho7/q7I8e8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0NiBTYWx0ZWRfXyxC9nZPlR2iB
 wjPva2Zwsco6oxwM13lmmb6W5btTX+B11fv5ADWXOX/5P/BvKRYvMsdWH+zKXM0sPzzFfacP4en
 1qLr2oxwlslA2mqLkeNHfnsfsqTBtrmcvWQoJ+Z7FWrdwiYuXMQJCWeXIQBqoxhKzQxRV2tu5z7
 l9QcV6lj9BUVL70SuuHoJpTXSscVFZHoUbQJWI/7v/sqCkv8P4yBftOKpbKxzycy0eoaJpFQNbQ
 iK094tWX2muUcyCJtiz+FesNwmMcOWvfEkKN1TG4oCj4nYR+wwah4o//dR8oh4Cf+vGhlYB7LJT
 ngj41TZLbZIA3LbCn0Z74Kcsax0o5vEpUi/DsZf7juJ0/NQl9DQy/3TqLorHdTLpiRFmBEcF4CX
 tF8hiE6ct1lUdb2MQN5qPT7P9De+B3hthJQDOiinHlFyQ7Er2A1zG3HhPWc7cjdD1mDSrUOiMYM
 mBFibiWGsPxm5W40L6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080046

Hello Rob, Krzysztof,

On 8/1/2026 2:05 AM, Rob Herring wrote:
> On Mon, Jul 20, 2026 at 01:49:51PM +0530, Umang Chheda wrote:
>> ARMv8 and later processors implement the RAS (Reliability,
>> Availability and Serviceability) extensions, exposing hardware
>> error records through a standardised register interface.
>>
>> Add Device Tree bindings to describe RAS error sources.
>>
>> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
>> ---
>>  .../bindings/arm/arm,ras-error-source.yaml    | 330 ++++++++++++++++++
>>  include/dt-bindings/arm/arm-ras.h             |  11 +
>>  2 files changed, 341 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml
>>  create mode 100644 include/dt-bindings/arm/arm-ras.h
>>
[...]

Thanks for reviewing dt-bindings change of v2 of this patch series - I
have address all the comments and posted v3 [1].

[1]
https://lore.kernel.org/all/20260918095746.3347893-2-umang.chheda@oss.qualcomm.com/

Thanks,
Umang

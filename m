Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0481C3BCD1E
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728356; cv=none; b=tuvyf6bY5SEFhFlgEsvlpdPcGKYjR+Q8WdBl7LMBWF8si2XvXlZgI6OwDQ9YQlear6VxwgQp1pfyrcZuHsHsnAab2Smqi/4knBML0NrWTwobuSdo5vjIWDGsCyYS+9UXt1bjJv5GJdkVJ4BwPnD9m0wjNZeoa3b/QyXQZvoFVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728356; c=relaxed/simple;
	bh=WKC79AJGEDwb3It0QfE7Gjokli0aIVhTp3q5Itfdu2w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GPB7vNimey2z8W7L7wCdmfqWJiMjFC/JwDzWpaK6HYaJWydpqYebAKLdM+MlBtik6ZfSEPdUg4OxKLUYOCDZuI6/U//gmp4fm5oSQq4JZfdi3U6D1ffOUgn0+R1F0ZI+kMG9ri1hWeN3c7AuP4bNZJ4Hke+q/KTSOUxejyNlvEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K/MwGPFq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jtM9tevQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K/MwGPFq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jtM9tevQ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6r8sL2088908
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 10:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hPS3DNCL3/Yn4BNjN2CWMU+Gv8TsbwlcQhpLX/U9HR8=; b=K/MwGPFqI08YNPbp
	f4Zrag58UQ1FvWjwkooH3+SDpLux6d25XGzvtCBP6TRoMZtT0Vkm2lfTv1T+UMDw
	iAh45umz0ZQ+eTsiVRUSflczfdZPCTYoYdyVXbnL+LU9pEY7QYVvS1hvl/1iwzYR
	WgK1y9MEkcs2kP1JIt2xRmuhxGA3+WtRjnCZNzc6VnYEF+CpIRVXmd87FHl8RsX9
	nNzLZl+HUsNaZY+lPDtyB8/RhuA/ydqmByKgmn5KRgRyNoYQZoqKWvwLbzpOz43r
	+244KQJisNfu+QaP9FoEQYn/8WR6xW9twAy2Xg0WW/QH+7MMy0qUI2tUiNwfRuFT
	SOyCZg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3k7vh643-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 10:19:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92ae405b5eeso375146585a.0
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 03:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782728353; x=1783333153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hPS3DNCL3/Yn4BNjN2CWMU+Gv8TsbwlcQhpLX/U9HR8=;
        b=jtM9tevQrUnPM6o+Bl6uXoCwhxrk82yZDwJ4KXorT4fWbLZ1cSrpYO/fb0xKAcQ1G2
         UKpRoAG1kBTqAY1WKgT1AtN5f6CztiYVwNfIN+jCaowa6uihEY5BQjzSNCdL04uFnXVg
         k0+CD3AOlKSX4IKHS/RQYT9H0io6CKOKFO0eSOhxjjW9AHVwWczOXPZOHu2XaVGbi+F3
         z5nxgz1cHf7VB8cjugewcSd6PKCP2VU/7TE2O0yUzBWPrSwKuyCU3+hkCk+fVkzfIwGl
         97EG20AvgO60NaMjWRgKTJgptUGjMix0zxtps+BS0asA54LiJ54l9DSTSR07PQXWAedR
         D/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782728353; x=1783333153;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPS3DNCL3/Yn4BNjN2CWMU+Gv8TsbwlcQhpLX/U9HR8=;
        b=P8AEWh48IaVLfRfxRzrODiBVp139j483xygF2mZEG8YfE8WzfuLmS6r/9ebXKT4cVt
         qqa0zaKBeX9onNmNnfZ96cfHqZFoABdzLmT6khBnVtDAYEzaeZFg3HOKMEYUygwZMyRX
         49NisYfM6d3JwkvM5SDzT+Pmpbx2lXx52DKBEc28+0wooQavY06SHreRkXfw8IjFJ9GU
         z2EKZU779qZullw45gBpNihi4hZzlmx3N+Vi94+ezkjZwruXdu5lMU2R9/xGy/DxTJRp
         B9yY2gwdXdMzc7pbrrZR7AqO5G/1iojy6tQ1V+lWqJvt1V4z+tBEotSqGh2hT6PrQq9e
         dPgA==
X-Forwarded-Encrypted: i=1; AFNElJ/vnIAg+hLHk3TrLQSlEFO0ILs1c0+jLXGNOnuHaRriwzLQgurwAe2Nnexj5agAzSXjOKqTJWbZKPsQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yypw2teKEzAhY3nmCP5vlj+7JiWZbYOSALKWf4OBlTAzIM6xOht
	NPAI0hD5Ux7MGeFd6rUoGxpYlz1huu5F6AllndviezPXMsm+JB2VR+qcVF7Jhd4NUiUHLMGmbOp
	6L17x2RkxwFXlAjD1pQTg8a1SOhd6uX6ilrgGuIbrG51APqjRdRT3tSJ2Y8AoEs2e
X-Gm-Gg: AfdE7ck9K5s1LFgGrZN6p7NMC8rl1keHN31plq94BjLxgsVE+oUL/JYQacaYsMg8WDx
	Lz3zLkoj+FBOgpUVd1KsPBCxC82CZrJCAuDu5baN/ScZxIXUEhdn4UFzAMvCQ35wyn5wDPPAx/h
	U+vT2st/hKHmiltih6i1xWRbvowA1lwpGJcJU0OheJIFAWb8pvfSU4ChCz1vyeeIGc1o0cu7l1i
	T832PNlUO2gpjiXFcbJg7GfMWaM6xvRBYiCEHY2V6VNsAGk1SoORIJlxVTLUI0B9r5U8Cjxik8b
	QkWQo4EiLo5ibK72eO8qRitPThmv2rU6cqNKChe5MNLcYSq/XKvUD9jmMPBz4s3ABTGSjIvu7aS
	0aJcq7efQ7m4VWCjD282zyK0xx4CLJQ==
X-Received: by 2002:a05:620a:270d:b0:92e:5cb6:81be with SMTP id af79cd13be357-92e5cb683f4mr92676185a.3.1782728353201;
        Mon, 29 Jun 2026 03:19:13 -0700 (PDT)
X-Received: by 2002:a05:620a:270d:b0:92e:5cb6:81be with SMTP id af79cd13be357-92e5cb683f4mr92672085a.3.1782728352640;
        Mon, 29 Jun 2026 03:19:12 -0700 (PDT)
Received: from [10.40.99.10] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12749e4e2fsm69732966b.50.2026.06.29.03.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 03:19:11 -0700 (PDT)
Message-ID: <916a4a45-9e54-43f2-95c9-0344455daba4@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:19:10 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [RFC 12/12] arm64: dts: qcom: x1e78100-thinkpad-t14s: Move keyb
 and touchpad to ACPI enumeration
To: Bjorn Andersson <andersson@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
 <20260623145225.143218-13-johannes.goede@oss.qualcomm.com>
 <akHMf0MiXrYydnAg@baldur>
Content-Language: en-US, nl
In-Reply-To: <akHMf0MiXrYydnAg@baldur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Yoe_yKRNrCb_9-fhS45UsjCP0YCRFyDA
X-Authority-Analysis: v=2.4 cv=CqCPtH4D c=1 sm=1 tr=0 ts=6a4246a1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=rrvG0T/C2D967D07Ol03YQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wMK-mFH0N7_quViQIGsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4MyBTYWx0ZWRfX2Xgi2pAMM3wr
 UpdX6NgzJsKepLixDjGTu6R2/eanP29efRY1AqIeAwwKoqDp8N1WR5d2Hg6FO9aaIhrITEiXiBH
 O7VJKCJg6CceqMAfsOOGaKjVYj2PuIo=
X-Proofpoint-ORIG-GUID: Yoe_yKRNrCb_9-fhS45UsjCP0YCRFyDA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4MyBTYWx0ZWRfX1Q1LAUE48ZeF
 MKuH8CrFQLEvwyzrYnYVDcObGLzQsOLiuetVXZiwtXf8yq57AZ9h3z8NENFtRbuXAeC2hLBzY98
 WCHX+uYPl2kd8Iymiv7l+RJ7kk+w9w/jtnLKjciPY/uPpEafh+18dG1PilAhtq0w+Og2hHC68ra
 6CmAtxw4qEqMfKvwAJVSov1O+SopMDwR85mMk9tEdHvOuSfiXFYGdzXAhPar7e2M+2BYx+Ip+ok
 chlEt4X1uB9lMt1prg+a3Duyhd7/2uD4dA+36XwUffOMlDLHZcvTGXnCfkoBnzSnLJQS+ge0aGC
 9WWihcW4bDu/Ha81BmMysW4c4tVNB8YFfsprcUPxysSEOrtVwOLqfv6bpz2S+CK1fRSv2o/g7dW
 USFWD6UscL65XkMAcHfdpaRjDm+scYcS83DYG2IHPmJD54MkUqtGatu+krR8eYbE14u3VOkbEbQ
 6HsauFMTcQ9CweSlA8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290083

Hi,

On 29-Jun-26 3:43 AM, Bjorn Andersson wrote:
> On Tue, Jun 23, 2026 at 04:52:25PM +0200, Hans de Goede wrote:
>> Add acpi-path properties for DT-ACPI hybrid mode and remove the keyboard
>> and touchpad description switching to relying on ACPI to enumerate these.
>>
>> Also drop the clock-frequency this is also provided by ACPI now.
>>
>> FIXME: Needs DT-bindings patch as pre-req
>>
>> Note this depends on these 2 patch-series for working PDC support on Hamoa:
>> https://lore.kernel.org/linux-arm-msm/20260410184124.1068210-1-mukesh.ojha@oss.qualcomm.com/
>> https://lore.kernel.org/linux-arm-msm/20260616-hamoa_pdc_v3-v3-0-4d8e1504ea75@oss.qualcomm.com/
>>
>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>> ---
>>  .../qcom/x1e78100-lenovo-thinkpad-t14s.dtsi   | 59 +------------------
>>  1 file changed, 3 insertions(+), 56 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
>> index 2fc01e8e8c04..a73576ec238d 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
>> @@ -1017,57 +1017,8 @@ &gpu_zap_shader {
>>  };
>>  
>>  &i2c0 {
>> -	clock-frequency = <400000>;
>> -
>> -	pinctrl-0 = <&qup_i2c0_data_clk>, <&tpad_default>;
>> -	pinctrl-names = "default";
>> -
>> +	acpi-path = "\\_SB.I2C1";
> 
> The +/- are not equivalent, you're removing both pinctrl state and
> device power management - relying on the default state (or other
> client's votes).

Yes for pinctrl I'm relying on the UEFI/firmware to have already
set that up.

As for device power management the regulator references being
removed refer 3 regulators which are all marked as always-on, so
there is no change there.

FWIW I've been dogfooding this on my T14s (where I'm actually typing
this now) for quite a while now and it works fine.

Regards,

Hans




> 
> In addition \\_SB.I2C1 is not a stable ABI.
> 
> Regards,
> Bjorn
> 
>>  	status = "okay";
>> -
>> -	/* ELAN06E2 or ELAN06E3 */
>> -	touchpad@15 {
>> -		compatible = "hid-over-i2c";
>> -		reg = <0x15>;
>> -
>> -		hid-descr-addr = <0x1>;
>> -		interrupts-extended = <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
>> -
>> -		vdd-supply = <&vreg_misc_3p3>;
>> -		vddl-supply = <&vreg_l12b_1p2>;
>> -
>> -		wakeup-source;
>> -	};
>> -
>> -	/* SYNA8022 or SYNA8024 */
>> -	touchpad@2c {
>> -		compatible = "hid-over-i2c";
>> -		reg = <0x2c>;
>> -
>> -		hid-descr-addr = <0x20>;
>> -		interrupts-extended = <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
>> -
>> -		vdd-supply = <&vreg_misc_3p3>;
>> -		vddl-supply = <&vreg_l12b_1p2>;
>> -
>> -		wakeup-source;
>> -	};
>> -
>> -	/* ELAN06F1 or SYNA06F2 */
>> -	keyboard@3a {
>> -		compatible = "hid-over-i2c";
>> -		reg = <0x3a>;
>> -
>> -		hid-descr-addr = <0x1>;
>> -		interrupts-extended = <&tlmm 67 IRQ_TYPE_LEVEL_LOW>;
>> -
>> -		vdd-supply = <&vreg_misc_3p3>;
>> -		vddl-supply = <&vreg_l15b_1p8>;
>> -
>> -		pinctrl-0 = <&kybd_default>;
>> -		pinctrl-names = "default";
>> -
>> -		wakeup-source;
>> -	};
>>  };
>>  
>>  &i2c3 {
>> @@ -1598,6 +1549,8 @@ wcd_tx: codec@0,3 {
>>  };
>>  
>>  &tlmm {
>> +	acpi-path = "\\_SB.GIO0";
>> +
>>  	gpio-reserved-ranges = <34 2>, /* Unused */
>>  			       <44 4>, /* SPI (TPM) */
>>  			       <72 2>, /* Secure EC I2C connection (?) */
>> @@ -1655,12 +1608,6 @@ hdmi_hpd_default: hdmi-hpd-default-state {
>>  		bias-disable;
>>  	};
>>  
>> -	tpad_default: tpad-default-state {
>> -		pins = "gpio3";
>> -		function = "gpio";
>> -		bias-pull-up;
>> -	};
>> -
>>  	nvme_reg_en: nvme-reg-en-state {
>>  		pins = "gpio18";
>>  		function = "gpio";
>> -- 
>> 2.54.0
>>


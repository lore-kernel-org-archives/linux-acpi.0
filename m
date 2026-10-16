Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5488736DA15
	for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141288; cv=none; b=o67w118rAaWRnNemMNyp5X3AxFdHFUORzi23ZCUDTpv5RZvfqPj/0pjA+mjD2xESAWlpGbc5Ih9KaMHdaZz92pgfDH5aAxSnnm9vJS5omly5BTIuAHaKUdyBnwLreYRXx34NSLBOaM0b7e5PwO4mXfb85C4BirZwLDUt7MYJ+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141288; c=relaxed/simple;
	bh=9u2kKnDX/HmSD/5prrmfnP15yYTfnWpzqOSS67OmG7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMwF27vJ6LhVT9c9o1Ea2OSyWfA/LinxEKRu2cWGmFoi3hZ2msWIzN0CDVeJK8iAIUH5tzeQRo0crKPbUxOv4YCqP41z51tjr/IGRbb563QsR06GvB3p2Nz4RZqQhSW4Y7vIbtfRd6ns6KZObwh09DdM9XWYn+x9N4th0xvHzII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l9Rc4iot; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ed5RzAfN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9Rc4iot";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ed5RzAfN"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G8lMcD1798031
	for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 09:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LgRtMO3KtPTVu+iC+z1x0udOzvLloACS/goI7lMZ9mc=; b=l9Rc4iotWW5cG9a5
	3iVzSC2jOhy+l3QhXhDXCOKFEvzMft1bqiv3cBsMA1NSCTyN+W7UgyRRnVoGcCSV
	gspo635s9sblD1f3MqeySAJb/SjCJQok6hA+l0gPf3d+QD+V1BP1HuEcUgg2XWtJ
	+ZM6dtAIib5Dj615IP1UslCsmMCocX+oAhE3nI9u+vEtX/gol9JvirWHfXKBFfCX
	vJ7KptZRdj6YIyh/HvRmSK6Q7N3tsDoVmQ9fmvZg9pYhhTAW3GmEjQJubOAyyOep
	UEDWDrktAdyg1q1sE/DFcBvXmGl2wo9KuCzkMMAeRCmzoAkRJsJu/oqKtj4GmWPj
	ssqQcA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8a89u4c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 09:01:25 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9179d9cde17so24740386d6.0
        for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792141285; x=1792746085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LgRtMO3KtPTVu+iC+z1x0udOzvLloACS/goI7lMZ9mc=;
        b=Ed5RzAfNwqaw/4yAUQjmYmRBFSoFPJCuxFAxqgYcAIPU10ilGXUo+a9gxz/cA1l+5f
         bUX7savZNybxQf60SyM4YLpFmW+R2NRLrVgDuLF6zREahTsf/TnWOgOymmiFdKcxeT7m
         F0l9x0Ic3kublhd40qzgfw60Uh572/CV0IqKrHEryHCRtYPxBVK49EGHtWGhxHvoQfIP
         /NpCCWXeWvCx2/nulB6S5jRphSEz1iUZtPwj7TKtYdJGOB9gkSdoduY23Vqhj3AO/HoQ
         xy0n0kUwA9QGI/O6zvK2kipH1zTnJoxB9t12n7mW4Lw31QOYaJBHGsAZfLC7bOKJhlhC
         LmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141285; x=1792746085;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LgRtMO3KtPTVu+iC+z1x0udOzvLloACS/goI7lMZ9mc=;
        b=V83QPjlHykdmGzKlHmQ7TkGqTyJp1FX/RwuGGRCdgShnTUkc7OgSTPLvY7SQ7rGm6H
         ID7CfFSa/ZoSt5Utj3SC8uCaWiZcyMAguZs7mxixltLxPDjtDfgWPLuW8ZrGpVOhWrQw
         nrYOkGxHkDZKP9wI8p1Z/rIY/qg2bhbeqIhgAEz4BM0zV2CZ6R7PX5bXAX99AnWndLRL
         /vC+61RZrQB1cgoiNxvbKGPAWw98AaK07+PNYmv9KLx3cqoWtsw2cmhGtPI4iIcrxYv/
         0UyCdVFnluCITj+EMQ2xKcLE9tywtd3ShOX1NQqPFuZwj8TPWeJyNz5Y4w4rMuJl0UYD
         lu4A==
X-Forwarded-Encrypted: i=1; AKwUvBzk4C4XgicraFn4LJTTLV3ByXiHSQV0gHqXYhZjOiRESMEuk/uFBlYnbQo+SVyK6hGe/kCVL3jO8THw@vger.kernel.org
X-Gm-Message-State: AFq9FYKosgkp46Z2d5nBQCEZWB17WBbbNTRVYLBEMbwTRlLnjmJ4GG11
	4+vVqLxfkvXv7sMWBrUTX764ce9qrubWqVpICoVTiKS74Jk3PX8WCbTqGEGiJQPIOTRBFihq8QE
	0S/5Uk6e12OyDlt/00AuHgo66IlWpa3+NbLqMNYOCYFMtAl1SK7WKwQA8jLmqNuBy
X-Gm-Gg: AYBFou14RaO6JHgACv9/u+UnRbdBwyVm4I5rrfpisKi1nZVM1ssQ9ZSvNwTEH/VwOES
	3TGvKigqqXxUy6vVs9SD/oxRvsiJjdu/uOf9pYYdS4Gvz8dWl1m/bbeUxXTg1L+d5N2u/ZfzDvL
	j8QUlKnRe64amrDNYZFOkprnovf2Rb5cTgz54LRKGzNU8+zR9KKRiKg4S9Rmv8796B4Gl2xSDu2
	Cyf8Co/T4qHruvKImXY4MySrFLUqKwmcZl/ys3fOVxXgC/3PeKSSBNEKoDBDM6hSaFt7nVPFUjC
	ENs7VQcC7psGFB5MkEodI1dVhjdZ5c7dTD4aeO6xThcD40BI6+mkt9Iq87C0i6TRqtRqnbLdb2T
	MxHEP+Pe57zdoGYOwQT2wKC1deBg=
X-Received: by 2002:a05:620a:4629:b0:93e:c12c:fbcf with SMTP id af79cd13be357-93ec12d0664mr3309755585a.75.1792141284869;
        Fri, 16 Oct 2026 02:01:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4629:b0:93e:c12c:fbcf with SMTP id af79cd13be357-93ec12d0664mr3309741185a.75.1792141283402;
        Fri, 16 Oct 2026 02:01:23 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8abfae7sm19101725e9.0.2026.10.16.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:01:22 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: westeri@kernel.org, andriy.shevchenko@linux.intel.com, linusw@kernel.org,
        brgl@kernel.org, Mario Limonciello <mario.limonciello@amd.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Nikodem Sanecki <nikodemsanecki@gmail.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Ignore GPIO 11 interrupt on ThinkPad L13 Gen 2a
Date: Fri, 16 Oct 2026 11:01:20 +0200
Message-ID: <179214127561.43403.4930516828077355711.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261015193924.4081906-1-mario.limonciello@amd.com>
References: <20261015193924.4081906-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNSBTYWx0ZWRfXxPRw+s9+V+v4
 S8eV0sl7eCa6bjGXEdZjdFv2eQXd4Gpu7bmkgyBqI2dJpUCCEduO38qAS8sn5t8z+nCuYC9IjnJ
 767fLnzXuZg/iWD7w4YAytmLywDMp38=
X-Proofpoint-ORIG-GUID: G-b6IXzlJCUEBeXJsQFcZ5RCtdqx3FjC
X-Authority-Analysis: v=2.4 cv=GJadgeNK c=1 sm=1 tr=0 ts=6ad1e7e5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Z07AUoqqrmmnNCNeWx0A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNSBTYWx0ZWRfX/vB3wYKgm73Z
 OQxNY8psdpMKM6wtVPMgvctk3f0v+uOZ1PUy87kE/ItoCrCT0ZnQKJ6QexPb0i6t5/HZxnMvq0T
 fzvF4RpjbOajvBxPfu+dVgSZRe+aPxax2o7iUlcKeQRnbjWTFSv2LM0FFaIJYYhryOemzPlXph1
 hDZL7nOGfqKQ8J+7WuccZ9oDIsAamGxqz3jpfS4hkXjJ7xsH+fSVRvfDrZb1UZHwdX7XGN0pMtM
 eQm5UIkP5A0Hx3hYqLS3dwIjl+4UGED3lWQ72toqQaIdHK7Jom1T8ATZKB6ZElZOAUN4tLjGHug
 LVp7l50wFcoa67/73zmjItIcdkeL9O+vImI1N1lZ+DGTPF42Xm0LlG/VRHIyC6ZRLPJ1P6tEt33
 2daRu6Sr/Xj+iYC5NuJazl4tnEWuTlyliGc8chsfyY/jUp1ew2b0JYDomSiO8pE5f3zfHC641Ju
 yELrHmNEAcdiTz1lI3A==
X-Proofpoint-GUID: G-b6IXzlJCUEBeXJsQFcZ5RCtdqx3FjC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160035


On Thu, 15 Oct 2026 14:39:21 -0500, Mario Limonciello wrote:
> The ThinkPad L13 Gen 2a firmware declares GPIO 11 as an edge-triggered
> interrupt in _AEI, but the EC uses the same GPIO as an output to drive the
> Caps Lock LED.
> 
> When gpiolib registers the ACPI event, the pin is configured as an input and
> firmware writes can no longer control the LED.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: acpi: Ignore GPIO 11 interrupt on ThinkPad L13 Gen 2a
      https://git.kernel.org/brgl/c/ac46dac1613a7c971e28e16d3a7a6ad4b1ae6c5a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

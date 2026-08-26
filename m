Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382384503FA
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756012; cv=none; b=Sokfg+3ttWptIgqi3ygaPfn4CCf7b3n0Wg8odWVt9AkHU7yzderEzBkCeJ1EvEjl49Csf/7t9iigQaUwgeKWfKodmdwdKwcwdk+ScoVLt99kxdprZpm+8Ut/YNBo3x1Z9gyZaQ3gBOCjZODWwskxgzjHm+MR2rSy5br0JNomf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756012; c=relaxed/simple;
	bh=vi3S6o/aCX6InBuOsTN52Sk60siVGMjgF514ONXxk5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFEE5cpaqZFYEZ2aIWWEX+TZ7w2JvmULWjknmRaGB0WZhDtYm1QRL6CKsyuovXCvy1FPDJLT5bc8Vm15hmq4Y9PqI4SQKF+vdYG3W9WaTimhOTbSFsCAfjAHb9zjWASGRp27DCpVpYUmV+MJ3mXBjz9uSnkfvB0WPXM1XbO3/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZXAWjUO2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kWivV9d7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZXAWjUO2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kWivV9d7"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QDuqWk611917
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 14:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xgITQOLCNa8poMm2HFJ4MO8AYZclvE5sM2FJ5XQeS38=; b=ZXAWjUO2tCeY5iwi
	MWAoRQf0doU2qOQ52qZIaqbuhIWW1zYZY8f1F2/dZLVh6r/kYQ33yTHtGcfIybWu
	gvEPOHRjXMeWGI9HO7iWY/TytmwvQdlDuKQdEa6RzuG2lIK/I5Gq1fXS0u8pxhuo
	7U9an6EY2n2ZnldTRjEN5iLiZ80LHC4nmA/gPREAAjXmP3bVHCI6Btbl75nj+Dex
	EGoFVBCwwO+DvjGuw0ZVb8VOtmtd8wpSfNLxru2akPB0QI96nQrj6dRk7DUWG1L/
	UFvLOIBVv1328lLjlkq+Gx8kakdDia4bHESmloC9z3yHNAh7U+Dxgy+9LP1nY5K8
	LkoopQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9smxabfx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 14:53:23 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f39a46efd9so19313796d6.1
        for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787756002; x=1788360802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xgITQOLCNa8poMm2HFJ4MO8AYZclvE5sM2FJ5XQeS38=;
        b=kWivV9d7k2ygHReaufVlyxC9yHUpYPZaZAxSR0nQzK8r1cRyyB/JlCNJuoldCGZb0v
         3pV+Y21AO+g/qXwMOBbhvE+5Ww/B/xyaZdGBRRj2aDz/kZfntxLc3SGBaInGQkOqxcJL
         iUyPY6mEB0dLFfLQFZG4l/B8jCrq3+QEZaMJca0tELZ0UPMEi5TPwZxnV75ZTwzwmT1Q
         O2GBmx4lN6JQXAc6ne+gqMZrqpXrVyr6n4/a2rj47EdQqH5S6HF+rG/aVb0CGX825zNy
         8sPqhebg1T3rN4WLJjK2Tdz/87UP5CO1fBLoLUbBjpWUOTiC1RalxLw0ngNDwpmJ2XGW
         s+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787756002; x=1788360802;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xgITQOLCNa8poMm2HFJ4MO8AYZclvE5sM2FJ5XQeS38=;
        b=IiB3/eQUrRr+up/Bq3IJVKbMLNRZ+h9zwBEpTdcMGge5GHzZh0jfjSmWiPJqYEMK6f
         6FrLhLEiOqQ4mzDV9f8yNLQ0NlxwBTBmXmMLpJKRNumtPHqwUrmf2NVOYd6kjGNC/f1i
         d33XVakfdBg1oIGuIgwTfJd3kqofgYaVIz4EEil93LGSmDJlE/rVsfoDB6rgpPHb3jON
         0kQfpJSPtgAprpn0ynlyifIz+HxCSLDAn7BP5/zq9AyhZZaDDEyeu9zx2wIhamCACCT2
         WhE85QPPPZ8XEyRO7TAjRMfn3u5lxaf3fKCOTLEl/8leVS1N1FnhP1YGjgIPzuQBaG9a
         3T0g==
X-Forwarded-Encrypted: i=1; AHgh+Rry1pqhUR9SMSKT9zhz+09no1vfXLPajLYCGj6n+TMoKB19/tye+LxBPvGnuDF5MoN+KVJ6ERbRE+Dw@vger.kernel.org
X-Gm-Message-State: AFuF++kMpHp9XMw7zBsOhcpGuqjLcMESrebU9WzhFkswvkTJ2LV549Fn
	HuSE2lnKNTdtydDuU1HTogXrFVp10e7IiosXBJJfhNxmOkACtWE60JpD0t3IqmCB5ANBk6v1lD+
	nmcZ+L4Qbcb3pEoqTcUCwWpNdevukDEgyx15sk/8ujWIUhQyZJOdZ7Uob9WaVWIMA
X-Gm-Gg: AR+sD1387/xFPPPxLnMe9AsKccyzU6A2mBWPp+5TW7FnxuycfFrvIOM/NS37mt4lJ9+
	EoFv0FoidgJCko4EtCNtFMnZHz1vvgixz7Wvydlm5GPmSnaJpq9hpOm1IPHM8M2WadhWqyWSK0Z
	m4d/NeGaZSqK6bpm18YX4m/36YvZQ3o+DVSg9Wry56imKED/V/sTbJFCAZTD4TzgCaug/2Cro3Y
	TaslrZdRAaX3DFys44QT4AF+n6qJJ6blRpBlYQIk1Q7h4uD4d8N/jRyHAUaHqjnZXEkcD7OX4cI
	YZ3QtzsHYvZZrq06GUr3XWTNTicmlH1oFHY1pnzHeypDmgpQGbUr9+Jhjvyy63aDf1ZVDIP03Zv
	qog5E1B8qoKR47+1wZNOvNOYXGRA=
X-Received: by 2002:ac8:6f05:0:b0:52d:d12c:3ee0 with SMTP id d75a77b69052e-52e2ecc086fmr172469901cf.11.1787756002054;
        Wed, 26 Aug 2026 07:53:22 -0700 (PDT)
X-Received: by 2002:ac8:6f05:0:b0:52d:d12c:3ee0 with SMTP id d75a77b69052e-52e2ecc086fmr172469401cf.11.1787756001627;
        Wed, 26 Aug 2026 07:53:21 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dfd4:a0a3:2df2:7724])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dc3f5sm2972592f8f.21.2026.08.26.07.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:53:20 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com,
        mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org,
        laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
        nuno.sa@analog.com, andy@kernel.org, dmitry.torokhov@gmail.com,
        hansg@kernel.org, ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de,
        ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com,
        kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org,
        pedro.pbg@usp.br, paulmck@kernel.org, frederic@kernel.org,
        kees@kernel.org, saket.dumbre@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpica-devel@lists.linux.dev, Eliav Farber <farbere@amazon.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 00/13] notifier: add device-managed registration APIs and convert drivers
Date: Wed, 26 Aug 2026 16:53:17 +0200
Message-ID: <178775599400.65906.5565986908119438731.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260816060648.4030-1-farbere@amazon.com>
References: <20260816060648.4030-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a8efde3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Oj9lYo1IyMao6333VE4A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 3n907fXs_ZfWLpUNj-FpbjAMEX61j-BF
X-Proofpoint-ORIG-GUID: 3n907fXs_ZfWLpUNj-FpbjAMEX61j-BF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX6IFzW8kYLK9g
 D4qxReEZ4wsw78klpsSS2RJdXbk5jkjAZIAku9AHPXUlke/g9lQv+eMzVNmIAP2SXE+dZY3hXC+
 IOZyKao9SZ8fJ/7bLOAKS5muTEPONUPynCYSP6//2ssKMVV59PiZyY9uuc2Fv5Y2CJbrWUsIEow
 WlatsZ/9XJSpyjU04Qd2NXlT3xjKuoQFUloFXoZA4fxqGWExfXpx3hgk4MqP5CTBW5Wi4qiMloO
 npv7G7Y+YASFpvpBw9dvBZ+TN1f7QwVjf98CWfiCO5LVur/b36eYBmm3mJygIC5B3JFOtrTM7v1
 LpLFYhVry8q19gSq+ZW+EiyUCRWERFgMMqG+N1urn2pTPlKdyF04YH8sKwBRtj9QfvopzQM8VZD
 5lINKS+D4pE5jfi0F6wSvkp3QMrXLPJ++HRrBOij9bksinjUdRI6hGex6DzlRFV5V+4s2iSuAkq
 g0nN+naZwiW7s82cKxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX0irliKr611OH
 zbZhp17/3I+K3XDtTza5t00XW75yswJuK0IpmMEHuJQLklAVjdPH/lwq9sFteNSxNVJ+WMWS765
 havW8NCkB1uzI/amVaWg2ggTVxEcoLI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260124


On Sun, 16 Aug 2026 06:05:59 +0000, Eliav Farber wrote:
> Many drivers repeat the same boilerplate when registering notifiers with
> device lifetime:
> 
>   1. Register the notifier with *_notifier_chain_register()
>   2. Check for error
>   3. Register a devm action to unregister on teardown
>   4. Implement a per-driver static unregister callback
> 
> [...]

Applied, thanks!

[05/13] gpio: adp5585: use devm_blocking_notifier_chain_register()
        https://git.kernel.org/brgl/c/870f46a42afdc65d39587d2c56cf35eca294d201
[11/13] gpio: eic-sprd: use devm_atomic_notifier_chain_register()
        https://git.kernel.org/brgl/c/32390690610190f63a31f92ca555077f7861657c
[12/13] gpio: gpiolib-kunit: use devm_blocking_notifier_chain_register()
        https://git.kernel.org/brgl/c/df6501bf6fc4b16c9f502a7ab8e785ec91f3f7e3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

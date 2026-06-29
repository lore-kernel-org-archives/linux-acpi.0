Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB33DCDBF
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782729007; cv=none; b=PHgIvGS++m9tiHTgYxymZVrKxnPolVNpIYAMmmGXVSxGBym2eGvUPf6HifhYc5etNH0KM7wbF6X8A8Hru8U6eSLy2+DaZHsP+DMs5ywZvuneq/XEpB95KXBlPauJ0TOOHize//OaAihC81YBQPNU+Y6aqbw1h81MWrP4X9KmJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782729007; c=relaxed/simple;
	bh=f4+4llNW9QdhdeH+apJcGMWAMTcPwb5TvVtwKEjFvW8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EWSV9hmzR8AXKAlI+0/EdXjcgITHPk8ER1mPrt9dlhTl2HMrM4sn6KQl/FKDyJQhXQWLVEBNM7KD9cAfuVGwxc7RANH32eyhcdDkLrerC+MFCr9KzZ2DoW61MrXYdofsDN9PvXZgqaA9/aoCIngdGHa0zcczfJUyqw1a18Uti0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=enazcpVc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cSLyWYgp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="enazcpVc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cSLyWYgp"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TATBlT2647650
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 10:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YAVzcg6dPMdyNGOIBoidBHCGALgpEE2VWjE3OvdvjsU=; b=enazcpVcgvqwtQ1H
	VUhCQZ2XvpfTBXyanURAs0xpxISnWOcQUQJGz6qKxzX/xIaU5+cHPlcQB32+8nNz
	rdvAn9vrgzRibnjx3286KaOwVtCbdOKgdO3LuNe4Z16+TseZDlgWaq3/OwYAJBq9
	m4lESQGc21xLk/0XxEdshwuH48bZe0yGhD4SBBgbFIxJrWkL4eUIV6wx2so+VjJN
	aD868SVQhoQve9LFRPtvnWni7my8rTiutMxd/QrN1D32/YRWaUYo+cXSwZBs2bcy
	1M7adkmuU+mON8g+EQmVen7CkC0d75l957eK2Rt3acH181thkat0b/d0MLBUiRg/
	5p7DEQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kyjguc4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 10:30:04 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5bd7ea84c73so4250125e0c.1
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 03:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782729004; x=1783333804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YAVzcg6dPMdyNGOIBoidBHCGALgpEE2VWjE3OvdvjsU=;
        b=cSLyWYgpM8mnqaqc4oRhfZZMZWeZn8CKn5qDzfF/bQYK6kmwcLzBq2QK0RcEwYYMbH
         0NZHqvLjxs2vovmQ6IO0xSywLpmvAUHsyz46S3ucC5MA9QNqH0xWZm1w9R5w73zPFRer
         9SAb0RQQo9K4vgSx7NJJaegr5i+VM7fQq/8+ZKdqPPMSDBc5N72EjFjY2kbG5Q9tmRzO
         bHpt1CCm8vDmj3W1nGEaeCu/20mHidxZfyETrxSytz1S4UHWEBBmz2I+firQHNzgeenj
         QhN/ByQdi0WkZkr3AKkjJkeMgYG6AkrC9yGZzorbH9JWOfkWCLwT2woMJbEv7C0Dhr2F
         n7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782729004; x=1783333804;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAVzcg6dPMdyNGOIBoidBHCGALgpEE2VWjE3OvdvjsU=;
        b=Ioxvyha0tcUyurQzEPtunN3iC1F4BWFfY/IzTkS6HQ04Qin5bHnmuuW8yf94dgaJ4P
         zlstjKwPPd25Q8LOSVJIzxLUSLXL2nyfu0hytn63dm5G2Pzfg9FD8bvE99k/dAqwBoK6
         NbaA/10lTNaAWRYPmDlhjlLQrY9E6rhvBMySjqcmXdu7c3kGP537ug5MRYhjLL+lqry8
         79B6RWtXO6NJnelA28yboz39fh6IaRhooW5rd++xyotRf3SbOBSaikS6fPGRzAvyVJgW
         DB3T+QqNohLtGxZ2ve7pziiOXPlG0lCO5x5K6GEuI3Ys8h7EizCZFVhmUX8fuOBEpy3Z
         B8Og==
X-Forwarded-Encrypted: i=1; AHgh+RrGgfWkYyzH+QcQSrEBSMCKfWZWUeggguGSEljnJMfLJiEW6WjAtoNwYB/+AzBTNSjJR1k6dcb+rKoX@vger.kernel.org
X-Gm-Message-State: AOJu0YxGjg1XUKLHJUEc6ZlJXhsCBKP7KVkYcRjobXgQ8i3rdGR4XngH
	IrFc3pkUXDRUDUGX1GWQdDng5VVLLrNG+hrDmIQpsCXDyx9v9dYNs09wk4RLXGrUC+tOf0+8di8
	a8slQhlQ9oJKPNLkc6wbtw44s3J8PAjBG3nj7kAF+P+2fxy7y+FYE1p/46FCvANbF
X-Gm-Gg: AfdE7cm1FNMhbTWqc6PqaM1ao7J7P+Pb4m83OBHlaeOnQmskHDhmiCigza5Uf8pFPs6
	CgL2jmUgzVFKEiqIj7nQnB3hbGUI8FSAoU8o988bdCbyyzYn431anbFbOCCSS8zNldUA8BCvKlZ
	mwl10yhNvQNem4TIbUokWSSIbE9vi4UJI3L+hgnkc9Kz9yYEursKgL3txs+aAAnBy9aTvQdSkDI
	F5tJd5VS31uWasHGynP6u7EB8RbTHBWh8iRBX1JksamaznafXR5kcN0K9kYjX6S55E32svJ47l0
	A4H01BLTl5BdxqucJ2VKLhR2w1YISrkUlwOhYLSVB562DexEM1gEIjYvQIdn1ijyiH+/nJaRZcK
	1uE5dqR71zFdWHgAk0XkOPdf9AAMG0g==
X-Received: by 2002:a05:6123:5d6:10b0:5bd:a6a3:3066 with SMTP id 71dfb90a1353d-5bda6a336abmr855618e0c.2.1782729003625;
        Mon, 29 Jun 2026 03:30:03 -0700 (PDT)
X-Received: by 2002:a05:6123:5d6:10b0:5bd:a6a3:3066 with SMTP id 71dfb90a1353d-5bda6a336abmr855607e0c.2.1782729003139;
        Mon, 29 Jun 2026 03:30:03 -0700 (PDT)
Received: from [10.40.99.10] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f49ca131sm6721952a12.20.2026.06.29.03.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 03:30:01 -0700 (PDT)
Message-ID: <6893c0fb-16a4-4e88-92f9-bd072e26547f@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:30:00 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [RFC 09/12] pinctrl: qcom: Add support for WoA ACPI tables
 virtual TLMM pin numbers
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
 <20260623145225.143218-10-johannes.goede@oss.qualcomm.com>
 <akHOI2Ki1L1pVEVy@baldur>
Content-Language: en-US, nl
In-Reply-To: <akHOI2Ki1L1pVEVy@baldur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sLBr7osfipzwCzYryhtlvZRQIpH5u4sz
X-Proofpoint-ORIG-GUID: sLBr7osfipzwCzYryhtlvZRQIpH5u4sz
X-Authority-Analysis: v=2.4 cv=Ftk1OWrq c=1 sm=1 tr=0 ts=6a42492c cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=rrvG0T/C2D967D07Ol03YQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=CZlP5E7Tkv4MzdeRfuQA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4NSBTYWx0ZWRfXzhWy3LOUhivM
 c37+HhiU8scD0beRPJdK4krL7CB0AWcfl8NtZKj64DNSHN206eQf6fQHgfJu1duY0IHu4TtbOUh
 JEVdFtHrJFq1iahMNkLPFC5Cp1mFeEw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4NSBTYWx0ZWRfX9++56OhFF8MS
 2OvTjEW3ejZoyMArP5I1Z2QrVhBfiTrS9uqB4LHPNe1MvjQmBGHgUIIeElYVAyVWYY/DdouxGBb
 3KiYtMiYRgLG0sCdSKU8F5wcUeW8UOSBnC3KsECIi/HOFmqPgZ5RX3I36hLC8m3hx+3vaRrQqJL
 KYgzDAFoKZI8FSt5ZPr3DnvIrmrgWvocgCL5GSCVIJ8BgzvR2+6SO36bTIOLWAa8Z15Buu04sdn
 EzuujxnaJN0AD5QawKKEnXJEIEAapX7+h85Eij8akY3HJmkrSEZ0eOjWCqme66Ksp90f3fb8oZb
 TwR2PN5z0ErrZRlQk1R+k483BeNMqJu1UhkRwN3aIIgwyBXZUID0aJ66/qrju1oj74rBfOX47j6
 0TizbkbnljcJONkvWFSK9jgbW1LpD6WbboMrlV4F4gvHhuLJYNxj9gpaaZYH3kMWNxqqZxvZp4F
 FTlWEmneiEWQa/RMdZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290085

On 29-Jun-26 3:59 AM, Bjorn Andersson wrote:
> On Tue, Jun 23, 2026 at 04:52:22PM +0200, Hans de Goede wrote:
>> The ACPI tabled on Windows on ARM laptops use TLMM pin numbers outside of
>> the actual TLMM pin number range. These are a rather convoluted way to let
>> the Windows Qualcomm GPIO driver now to use the PDC for some pins because
>> these are wakeup sources.
>>
>> This adds support for translating the magic Windows virtual GPIOs for these
>> back to a regular TLMM GPIO so that ACPI described devices using these
>> virtual GPIOs can work with Linux.
>>
>> For now this code only tries to do this mapping when booting in DT-ACPI
>> hybrid mode which is only used on some WoA devices so this should not
>> impact any other use-cases.
>>
>> The new functions use woa_acpi in their name to make clear that these
>> are for dealing with the ACPI tables found on WoA devices, rather then
>> ACPI tables found on other devices, like ARM system ready devices which
>> also use ACPI.
>>
>> Note that simply mapping these virtual GPIOs back to TLMM pin numbers can
>> safely be done on Linux, because Linux always uses the PDC for GPIO IRQs
>> where possible.
>>
> 
> This adds a fair amount of complexity to the driver,

The changes to pinctrl-msm.c itself are pretty minimal and the 200 lines
in pinctrl-msm-acpi.c are not too bad given that they fix a bunch of
GpioInt-s in the ACPI tables not working.

> to support a model
> that I am not convinced we want to retain - and that only works in the
> hybrid case.

With the exception of relying on the pdc-ranges from DT, this should
work fine in an ACPI only mode too and would be quite useful to have
in ACPI only mode.

Now that I think of it, why are the pdc-ranges in DT at all ?

AFAICT this is a property of the Soc, so this could just be in the pinctrl
driver based on the compatible. Just like the wakeirq_map is coded
in the driver. It feels a bit weird to have one defined in DT and
the other coded in the driver?



> 
>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>> ---
>>  drivers/pinctrl/qcom/Makefile           |   4 +-
>>  drivers/pinctrl/qcom/pinctrl-msm-acpi.c | 196 ++++++++++++++++++++++++
>>  drivers/pinctrl/qcom/pinctrl-msm.c      |  47 +++++-
>>  drivers/pinctrl/qcom/pinctrl-msm.h      |  35 +++++
>>  4 files changed, 278 insertions(+), 4 deletions(-)
>>  create mode 100644 drivers/pinctrl/qcom/pinctrl-msm-acpi.c
>>
>> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
>> index 84bda3ada874..9029d99190d2 100644
>> --- a/drivers/pinctrl/qcom/Makefile
>> +++ b/drivers/pinctrl/qcom/Makefile
>> @@ -1,6 +1,8 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  # Qualcomm pin control drivers
>> -obj-$(CONFIG_PINCTRL_MSM)	+= pinctrl-msm.o
>> +obj-$(CONFIG_PINCTRL_MSM)	+= pinctrl-msm-core.o
>> +pinctrl-msm-core-y		:= pinctrl-msm.o
>> +pinctrl-msm-core-$(CONFIG_ACPI)	+= pinctrl-msm-acpi.o
>>  obj-$(CONFIG_PINCTRL_APQ8064)	+= pinctrl-apq8064.o
>>  obj-$(CONFIG_PINCTRL_APQ8084)	+= pinctrl-apq8084.o
>>  obj-$(CONFIG_PINCTRL_ELIZA)	+= pinctrl-eliza.o
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm-acpi.c b/drivers/pinctrl/qcom/pinctrl-msm-acpi.c
>> new file mode 100644
>> index 000000000000..df180fd04749
>> --- /dev/null
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm-acpi.c
>> @@ -0,0 +1,196 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * ACPI GPIO lookup handling for WoA (Windows on ARM) laptop ACPI tables.
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/device.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/gpio/driver.h>
>> +#include <linux/list.h>
>> +#include <linux/math.h>
>> +#include "pinctrl-msm.h"
>> +
>> +#define MSM_GPIO_WOA_ACPI_GPIOS_PER_BANK	64
> 
> Wasn't this 32 for a while?

Not AFAICT on my Samsung Galaxy Go with Snapdragon 7c gen 2 /
sc7180 using 64 is the right thing to do, as is on the x1e laptops.

> 
>> +#define MSM_GPIO_WOA_ACPI_IRQ_OFFSET		32
>> +#define MSM_GPIO_WOA_ACPI_INVALID_GPIO		~0U
>> +#define MSM_GPIO_WOA_ACPI_MAX_PDC_RANGES	16
>> +
>> +#define PDC_RANGE_PIN_BASE			0
>> +#define PDC_RANGE_GIC_BASE			1
>> +#define PDC_RANGE_COUNT				2
>> +#define PDC_RANGE_ELEMENTS			3
>> +
>> +/**
>> + * struct msm_gpio_woa_acpi_parse_data - Data for parsing WoA ACPI GPIO ctl resources
>> + * @chip:		gpiochip handle
>> + * @data:		Data for mapping virtual WoA ACPI PDC IRQ GPIOs
>> + * @soc_data:		Reference to soc_data of platform specific data
>> + * @pdc_range:		PDC GIC to PDC map ranges
>> + * @pdc_range_count:	PDC GIC to PDC map range-count
>> + */
>> +struct msm_gpio_woa_acpi_parse_data {
>> +	struct gpio_chip *chip;
>> +	struct msm_gpio_woa_acpi_data *data;
>> +	const struct msm_pinctrl_soc_data *soc_data;
>> +	u32 pdc_range[MSM_GPIO_WOA_ACPI_MAX_PDC_RANGES][PDC_RANGE_ELEMENTS];
>> +	unsigned int pdc_range_count;
>> +};
>> +
>> +/*
>> + * Mapping does not need translating the acpi_resource in to a regular resoure
>> + * and adding it to the resource list. Always return 1 to disable this.
>> + */
>> +static int msm_gpio_woa_acpi_resource(struct acpi_resource *ares, void *_parse)
>> +{
>> +	struct msm_gpio_woa_acpi_parse_data *parse = _parse;
>> +	const struct msm_pinctrl_soc_data *soc_data = parse->soc_data;
>> +	struct msm_gpio_woa_acpi_data *data = parse->data;
>> +	struct gpio_chip *chip = parse->chip;
>> +	u32 gic_irq, pdc_pin;
>> +
>> +	if (ares->type != ACPI_RESOURCE_TYPE_EXTENDED_IRQ ||
>> +	    ares->data.extended_irq.interrupt_count != 1)
>> +		return 1;
>> +
>> +	if (data->nmap == MSM_GPIO_WOA_ACPI_MAX_VIRT_GPIOS) {
>> +		dev_err(chip->parent, "ACPI resources contain more than %d IRQs\n",
>> +			MSM_GPIO_WOA_ACPI_MAX_VIRT_GPIOS);
>> +		return 1;
>> +	}
>> +
>> +	/*
>> +	 * Windows ACPI tables divide GPIOs into banks of 64 pins with one IRQ
> 
> Is this really "Windows ACPI tables"?

I'm using "Windows ACPI" / Woa ACPI" in comments and naming here to distinguish
this from ARM System Ready ACPI tables, for which there also seems to be some
support directly inside pinctrl-msm.c .

> 
>> +	 * per bank. The resources start with listing the real TLMM IRQ for
>> +	 * as many banks as are necessary to cover the real GPIOs. The Windows
>> +	 * virtual GPIO indexes skip these banks, mark them as unavailable.
>> +	 */
>> +	if (data->nmap < DIV_ROUND_UP(chip->ngpio, MSM_GPIO_WOA_ACPI_GPIOS_PER_BANK)) {
>> +		data->map[data->nmap++] = MSM_GPIO_WOA_ACPI_INVALID_GPIO;
>> +		return 1;
>> +	}
>> +
>> +	/*
>> +	 * Use the "pdc-ranges" property on the PDC to translate the GIC IRQ
>> +	 * from the acpi_resource to a PDC pin.
>> +	 */
>> +	gic_irq = ares->data.extended_irq.interrupts[0] - MSM_GPIO_WOA_ACPI_IRQ_OFFSET;
>> +	pdc_pin = MSM_GPIO_WOA_ACPI_INVALID_GPIO;
>> +	for (unsigned int i = 0; i < parse->pdc_range_count; i++) {
>> +		u32 gic_base = parse->pdc_range[i][PDC_RANGE_GIC_BASE];
>> +		u32 count = parse->pdc_range[i][PDC_RANGE_COUNT];
>> +		if (gic_irq >= gic_base && gic_irq < (gic_base + count)) {
>> +			pdc_pin = parse->pdc_range[i][PDC_RANGE_PIN_BASE] +
>> +				  gic_irq - gic_base;
>> +			break;
>> +		}
>> +	}
>> +	if (pdc_pin == MSM_GPIO_WOA_ACPI_INVALID_GPIO)
>> +		goto no_map;
>> +
>> +	/* Use wakeirq-map to map PDC pin to TLMM pin */
>> +	for (unsigned int i = 0; i < soc_data->nwakeirq_map; i++) {
>> +		if (soc_data->wakeirq_map[i].wakeirq == pdc_pin) {
>> +			data->map[data->nmap++] = soc_data->wakeirq_map[i].gpio;
>> +			return 1;
>> +		}
>> +	}
>> +
>> +no_map:
>> +	dev_warn(chip->parent, "Cannot map GIC IRQ %u to TLMM pin\n", gic_irq);
>> +	data->map[data->nmap++] = MSM_GPIO_WOA_ACPI_INVALID_GPIO;
>> +	return 1;
>> +}
>> +
>> +int msm_gpio_woa_acpi_init(struct gpio_chip *chip, struct msm_gpio_woa_acpi_data *data,
>> +			   const struct msm_pinctrl_soc_data *soc_data)
> 
> This function name makes me think this deals with "the ACPI case", but
> it requires both ACPI and DT tables to define the TLMM block - in other
> words, it complicates the DT-only case and it's useless in a ACPI-only
> system.

Ack, see above. We could just hardcode the PDC ranges on a per compatible
bases (assuming we want this patch at all). Then this should work fine for
the pure ACPI case too.

This would actually be an interesting thing to have for people interested
in doing further experiments with a pure ACPI mode.


>> +{
>> +	struct msm_gpio_woa_acpi_parse_data parse;
>> +	struct fwnode_handle *fwnode;
>> +	struct device_node *pdc_np;
>> +	LIST_HEAD(resources);
>> +	unsigned int ngpio;
>> +	int ret;
>> +
>> +	/* WoA ACPI tables are only used in DT-ACPI hybrid mode */
>> +	fwnode = chip->parent->fwnode;
>> +	if (!is_of_node(fwnode) || !is_acpi_device_node(fwnode->secondary))
>> +		return 0;
>> +
>> +	parse.chip = chip;
>> +	parse.data = data;
>> +	parse.soc_data = soc_data;
>> +
>> +	/* Get PDC ranges, the PDC is the TLMM's wakeup-parent. */
>> +	pdc_np = of_parse_phandle(chip->parent->of_node, "wakeup-parent", 0);
>> +	if (!pdc_np)
>> +		return 0;
>> +
>> +	ret = of_property_count_elems_of_size(pdc_np, "qcom,pdc-ranges", sizeof(u32));
> 
> That said, do you actually need to do this? Doesn't the ACPI resource
> give you the INTID directly? (Perhaps I'm misremember? Or perhaps that's
> of no use to us)

The ACPI Interrupt resource gives a GIC IRQ number, which needs to go through
pdc-range mapping to become a PDC pin number, which then needs to go through
soc_data->wakeirq_map to find the TLMM pin number.

Regards,

Hans



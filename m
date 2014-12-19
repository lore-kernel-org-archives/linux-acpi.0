From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v5 18/18] Documentation: ACPI for ARM64
Date: Fri, 19 Dec 2014 21:04:42 +0800
Message-ID: <5494226A.4040006@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org> <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org> <54933299.9030902@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:46322 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbaLSNE6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2014 08:04:58 -0500
Received: by mail-pa0-f51.google.com with SMTP id ey11so1184585pad.10
        for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2014 05:04:57 -0800 (PST)
In-Reply-To: <54933299.9030902@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, "Charles.Garcia-Tobin@arm.com" <Charles.Garcia-Tobin@arm.com>, "Kangkang.Shen@huawei.com" <Kangkang.Shen@huawei.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>"linux-kernel@vger.kernel.org" <li>

On 2014=E5=B9=B412=E6=9C=8819=E6=97=A5 04:01, Suravee Suthikulanit wrot=
e:
> On 10/17/2014 8:37 AM, Hanjun Guo wrote:
>
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> Add documentation for the guidelines of how to use ACPI
>> on ARM64.
>>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   Documentation/arm64/arm-acpi.txt |  323
>> ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 323 insertions(+)
>>   create mode 100644 Documentation/arm64/arm-acpi.txt
>> [...]
>
> AMD has reviewed this document, and currently implements ACPI table i=
n
> the firmware for AMD Seattle platform based on the documentation
> published here:
>
> http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2012/10/Seattl=
e_ACPI_Guide.pdf
>
>
> Reviewed-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Thank you very much, Suravee.

Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

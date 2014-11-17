From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 3/3] ACPI / processor: Rename acpi_(un)map_lsapic() to
 acpi_(un)map_cpu()
Date: Mon, 17 Nov 2014 10:31:01 +0800
Message-ID: <54695DE5.2080309@linaro.org>
References: <1414662780-2147-1-git-send-email-hanjun.guo@linaro.org> <5452CE9D.6000403@linaro.org> <10283319.F5QMI6fbWn@vostro.rjw.lan> <1820875.eppNBckBcQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:53541 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbaKQCdJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Nov 2014 21:33:09 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so7648294pab.21
        for <linux-acpi@vger.kernel.org>; Sun, 16 Nov 2014 18:33:08 -0800 (PST)
In-Reply-To: <1820875.eppNBckBcQ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Tony Luck <tony.luck@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Grant Likely <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 2014-11-15 7:35, Rafael J. Wysocki wrote:
> On Friday, October 31, 2014 11:55:46 PM Rafael J. Wysocki wrote:
>> On Friday, October 31, 2014 07:49:49 AM Hanjun Guo wrote:
>>> On 2014=E5=B9=B410=E6=9C=8831=E6=97=A5 04:12, Rafael J. Wysocki wro=
te:
>>>> On Thursday, October 30, 2014 05:53:00 PM Hanjun Guo wrote:
>>>>> acpi_map_lsapic() will allocate a logical CPU number and map it t=
o
>>>>> physical CPU id (such as APIC id) for the hot-added CPU, it will =
also
>>>>> do some mapping for NUMA node id and etc, acpi_unmap_lsapic() wil=
l
>>>>> do the reverse.
>>>>>
>>>>> We can see that the name of the function is a little bit confusin=
g and
>>>>> arch dependent so rename them as acpi_(un)map_map() to make arch
>>>>
>>>> That's acpi_(un)map_cpu() I guess?
>>>
>>> ah, yes, typos, it should be acpi_(un)map_cpu(), my fault.
>>> should I send another version?
>>
>> No, I can fix this up.
>=20
> I've queued up the series for 3.19, thanks!

Thanks!

Hanjun

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v5 03/18] ACPI / table: Count matched and successfully
 parsed entries without specifying max entries
Date: Wed, 19 Nov 2014 08:34:42 +0800
Message-ID: <546BE5A2.6030101@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org> <1413553034-20956-4-git-send-email-hanjun.guo@linaro.org> <546B4EDD.9050804@linaro.org> <7743567.TJcygJtKD3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:63478 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbaKSAgw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Nov 2014 19:36:52 -0500
Received: by mail-pd0-f173.google.com with SMTP id ft15so3478701pdb.18
        for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2014 16:36:52 -0800 (PST)
In-Reply-To: <7743567.TJcygJtKD3@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, Kangkang.Shen@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@l

On 2014-11-19 4:15, Rafael J. Wysocki wrote:
> On Tuesday, November 18, 2014 09:51:25 PM Hanjun Guo wrote:
>> Hi Rafael,
>>
>> On 2014=E5=B9=B410=E6=9C=8817=E6=97=A5 21:36, Hanjun Guo wrote:
>>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>
>>> It is very useful to traverse all available table entries without m=
ax
>>> number of expected entries type. Current acpi_parse_entries()
>>> implementation gives that feature but it does not count those entri=
es,
>>> it returns 0 instead, so fix it to count matched and successfully
>>> entries and return it.
>>>
>>> NOTE: This change has no impact to x86 and ia64 archs since existin=
g code
>>> checks for error occurrence only (acpi_parse_entries(...,0) < 0).
>>>
>>> Acked-by: Grant Likely <grant.likely@linaro.org>
>>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> Patch 2 and patch 3 are only for ACPI cores, and have no harm to x86
>> and IA64, could you merge first in 3.19?
>=20
> I can do that if that helps.

Yes, it helps to keep the next version of ARM64 ACPI patch set smaller
and easy for review. If any rebase work needed, please let me know.

Thanks
Hanjun

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH v3 2/9] ACPI: clear up warnings on use of printk reported
 by checkpatch.pl
Date: Wed, 25 Feb 2015 13:56:04 -0700
Message-ID: <54EE36E4.5070404@linaro.org>
References: <1424824585-6405-1-git-send-email-al.stone@linaro.org> <1424824585-6405-3-git-send-email-al.stone@linaro.org> <54EDC64D.8040301@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:49701 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbbBYU4I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Feb 2015 15:56:08 -0500
Received: by mail-ig0-f176.google.com with SMTP id hl2so39028477igb.3
        for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2015 12:56:07 -0800 (PST)
In-Reply-To: <54EDC64D.8040301@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, robert.moore@intel.com, tony.luck@intel.com, fenghua.yu@intel.com
Cc: linaro-kernel@lists.linaro.org, linux-ia64@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devel@acpica.org

On 02/25/2015 05:55 AM, Hanjun Guo wrote:
> On 2015=E5=B9=B402=E6=9C=8825=E6=97=A5 08:36, al.stone@linaro.org wro=
te:
>> From: Al Stone <al.stone@linaro.org>
>>
>> In preparation for later splitting out some of the arch-dependent co=
de from
>> osl.c, clear up all the warnings reported by checkpatch.pl where pr_=
* should
>> be used instead of printk(KERN_* ...).
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/osl.c | 46 +++++++++++++++++++-----------------------=
----
>>   1 file changed, 19 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>> index 1dc3a3b..865317c 100644
>> --- a/drivers/acpi/osl.c
>> +++ b/drivers/acpi/osl.c
>> @@ -141,7 +141,7 @@ static u32 acpi_osi_handler(acpi_string interfac=
e, u32
>> supported)
>>   {
>>       if (!strcmp("Linux", interface)) {
>>
>> -        printk_once(KERN_NOTICE FW_BUG PREFIX
>> +        pr_notice_once(FW_BUG PREFIX
>=20
> I think you can use pr_fmt() and then remove all the PREFIX in
> this patch, just
>=20
> #define pr_fmt(fmt) "ACPI: " fmt
>=20
> in top of this file before all #includes.
>=20
> Thanks
> Hanjun

Argh.  Yup, you're right.  That was an oversight on my part.
=46ixed in next version.

--=20
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

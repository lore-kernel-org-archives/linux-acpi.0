From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v6 04/10] acpi: Add some basic struct and functions in
 GTDT driver
Date: Thu, 30 Jun 2016 09:32:34 +0800
Message-ID: <CADyBb7s3=tjSQPwwyzfZBfWoXQXXjD1fPrVtxD4V+jH8fPNwdw@mail.gmail.com>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <CAJZ5v0gw7E6DnGhpACAws2WdF3j=eUkjKBhfo2RKmyKnpoLUbQ@mail.gmail.com>
 <CADyBb7v70YVL4yM_U335eQfa+NEd+jXDEaMN3iAhgnyL9Dk=WA@mail.gmail.com> <3079554.3ECV4uzklN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35370 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbcF3Bcf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jun 2016 21:32:35 -0400
Received: by mail-oi0-f45.google.com with SMTP id r2so44560341oih.2
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jun 2016 18:32:35 -0700 (PDT)
In-Reply-To: <3079554.3ECV4uzklN@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Suravee

Hi Rafael,

On 30 June 2016 at 09:26, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, June 30, 2016 09:17:56 AM Fu Wei wrote:
>> Hi Rafael,
>>
>> Great thanks for your review :-)
>>
>> On 30 June 2016 at 05:24, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> > On Wed, Jun 29, 2016 at 8:15 PM,  <fu.wei@linaro.org> wrote:
>> >> From: Fu Wei <fu.wei@linaro.org>
>> >
>> > No changelog?
>>
>> it's on [0/10]
>
> That's not enough.  The [0/10] will not go into the git log, mind you.

OK, thanks for your reminding, will add changelog for this driver in
this patch[4+5+6].

>
> Thanks,
> Rafael
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat

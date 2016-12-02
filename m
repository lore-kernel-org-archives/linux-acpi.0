From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v2] ACPI / APEI: Fix NMI notification handling
Date: Fri, 2 Dec 2016 19:39:31 +0800
Message-ID: <CADyBb7s=B5U3nUwKAtT145q2_yoQYjZ+wGEc6NHEUKE-PcEfzg@mail.gmail.com>
References: <20161129193624.krjz2bpinl2ioi7o@pd.tnic> <10086382.uM7IovncFW@aspire.rjw.lan>
 <20161201224717.4tkp5glpib5fhusv@pd.tnic> <5033158.rooYzydQzm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:34011 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753396AbcLBLjd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Dec 2016 06:39:33 -0500
Received: by mail-io0-f181.google.com with SMTP id c21so436124031ioj.1
        for <linux-acpi@vger.kernel.org>; Fri, 02 Dec 2016 03:39:32 -0800 (PST)
In-Reply-To: <5033158.rooYzydQzm@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@kernel.org>, Prarit Bhargava <prarit@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Tyler Baicar <tbaicar@codeaurora.org>, Punit Agrawal <punit.agrawal@arm.com>, Don Zickus <dzickus@redhat.com>, Linux ACPI <linux-acpi@vger.kernel.org>

Hi Rafael,

On 2 December 2016 at 07:12, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, December 01, 2016 11:47:17 PM Borislav Petkov wrote:
>> On Thu, Dec 01, 2016 at 11:29:45PM +0100, Rafael J. Wysocki wrote:
>> > Well, there's another ARM-related patch touching APEI.
>> >
>> > I guess whoever takes this one should also take the other one and
>> > honestly they can go in via any tree as far as I'm concerned, I'm just trying to
>> > avoid merge clashes here. :-)
>>
>> Maybe have ARM-folk ACK the other one and take both through your ACPI
>> tree? They both do have ACPI in common :-)
>
> That one have been ACKed already.

I guess that is "[PATCH v15] acpi, apei, arm64: APEI initial support
for aarch64."

>
> OK, I'll take them both.

Great thanks, Rafael :-)

>
> Thanks,
> Rafael
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat

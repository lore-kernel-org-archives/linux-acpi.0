From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPICA serialized objects?
Date: Thu, 3 Dec 2015 02:24:09 +0100
Message-ID: <CAJZ5v0jz+NJ2689Hi=k5_zjLjugwJm5oxik8Xdetw=ZcR51wsg@mail.gmail.com>
References: <CALCETrWFSs0Ornr9airzqL=9ph06WDghOUaKmA_8cAorrw1Kpw@mail.gmail.com>
	<CAJZ5v0gxE2kN75K4F9TxNAhz1Xb0zoi1CMn_R36OPeBHuQ9-Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33820 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbbLCBYK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2015 20:24:10 -0500
Received: by lffu14 with SMTP id u14so73644231lff.1
        for <linux-acpi@vger.kernel.org>; Wed, 02 Dec 2015 17:24:09 -0800 (PST)
In-Reply-To: <CAJZ5v0gxE2kN75K4F9TxNAhz1Xb0zoi1CMn_R36OPeBHuQ9-Qw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, Lv <lv.zheng@intel.com>

On Thu, Dec 3, 2015 at 2:13 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> Hi,
>
> On Thu, Dec 3, 2015 at 1:37 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>> [resend as plain text]
>>
>> I want to bundle up an arbitrary ACPI_OBJECT into a copyable stream of
>> bytes, is there some standard way to do this?
>>
>> I'm asking because I want to try to upstream something resembling the
>> rusty old acpi_call module to allow users with debugfs access who are
>> willing to taint their kernel to evaluate ACPI objects from userspace.
>> Presumably there would be a user tool to get object info and to
>> evaluate methods, and we could handle translation to/from strings in
>> userspace, but I still need some way to shove the data back and forth.
>
> Please don't do that, this is broken as a concept.
>
> User space has no idea whatsoever about when and it what conditions a
> given AML can be executed in the first place, so in addition to
> tainting the kernel it may just outright break things.
>
> Not to mention the possibility of confusing the kernel's reference
> counting and breaking assumptions made by it on the current state of
> things based on what AML has been already executed.

Besides, we're adding an AML debugger to the kernel right now, maybe
it will be sufficient for your use case.

Lv is working on it.

Thanks,
Rafael

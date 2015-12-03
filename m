From: Andy Lutomirski <luto@kernel.org>
Subject: Re: ACPICA serialized objects?
Date: Wed, 2 Dec 2015 17:22:27 -0800
Message-ID: <CALCETrXnbVCnisYrq_+GrT0PPqi6tG51TBtcx1rnQTdbLetK0A@mail.gmail.com>
References: <CALCETrWFSs0Ornr9airzqL=9ph06WDghOUaKmA_8cAorrw1Kpw@mail.gmail.com>
 <CAJZ5v0gxE2kN75K4F9TxNAhz1Xb0zoi1CMn_R36OPeBHuQ9-Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42810 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757948AbbLCBWt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Dec 2015 20:22:49 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B3B5220552
	for <linux-acpi@vger.kernel.org>; Thu,  3 Dec 2015 01:22:48 +0000 (UTC)
Received: from mail-ob0-f171.google.com (mail-ob0-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 7244E2054A
	for <linux-acpi@vger.kernel.org>; Thu,  3 Dec 2015 01:22:47 +0000 (UTC)
Received: by obbnk6 with SMTP id nk6so46067125obb.2
        for <linux-acpi@vger.kernel.org>; Wed, 02 Dec 2015 17:22:46 -0800 (PST)
In-Reply-To: <CAJZ5v0gxE2kN75K4F9TxNAhz1Xb0zoi1CMn_R36OPeBHuQ9-Qw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Robert Moore <robert.moore@intel.com>

On Wed, Dec 2, 2015 at 5:13 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
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

This is something that I want as a reader of decompiled DSDTs and a
writer of drivers.  I think we could do it in a way that it doesn't
get used for evil.  For example, make it a module, taint the kernel if
it's loaded and enabled, only expose the interface if an actual *boot*
parameter allow_user_acpi_calls=1 is set, encourage distros to
seriously consider not building the module, disallow it entirely under
secure boot, etc.

I want to use it for things like "hey, it looks like \NEXP might have
a funny value -- let's see what's there without manually figuring out
how to peek at the relevant OpRegion".

We allow ACPI custom methods -- surely this is slightly less awful.
Heck, we have /dev/mem, too.  That's arguably much more dangerous.

--Andy

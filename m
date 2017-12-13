From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [BUG] acpica: ltp_acpi test case causes kernel crash at acpi_ns_walk_namespace
Date: Wed, 13 Dec 2017 17:52:38 +0100
Message-ID: <CAJZ5v0iKWMBZXqGcpJqhdLLqPTY02yQOFJtn8zuCvsXd902nYQ@mail.gmail.com>
References: <1513094360-1414-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <9523980.S2jPabPoO5@aspire.rjw.lan> <20171213145547.GB6692@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:39144 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752811AbdLMQwj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Dec 2017 11:52:39 -0500
In-Reply-To: <20171213145547.GB6692@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Lv <lv.zheng@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vadim.lomovtsev@cavium.com

On Wed, Dec 13, 2017 at 3:55 PM, Vadim Lomovtsev
<Vadim.Lomovtsev@caviumnetworks.com> wrote:
> On Wed, Dec 13, 2017 at 12:45:50AM +0100, Rafael J. Wysocki wrote:
>> On Tuesday, December 12, 2017 4:59:19 PM CET Vadim Lomovtsev wrote:
>> > Hi guys,
>> >
>> > While running LTP tests I've faced kernel crash caused by ltp_acpi test case.
>> > I have ACPI support enabled in kernel but kernel is boot with FDT having ACPI
>> > disabled. The ltp_acpi test case application is built along with ltp_acpi_cmds
>> > module to run ACPI tests.
>> >
>> > So my question is - should we update acpica implementation at kernel side by
>> > adding 'acpi_disabled' variable checking to the 'acpi_get_devices' function (see
>> > patch next to this email, maybe not a good approach) or this should be fixed at LTP
>> > side so the ltp_acpi_cmds should be updated in order to check if acpi is enabled
>> > before running tests ?
>>
>> There should be a check preventing acpi_get_devices() from being called in the
>> acpi_disabled case.
>
> In my case I have to update ltp_acpi code then.

RIght.

>>
>> acpi_disabled is Linux-specific and the ACPICA code isn't, so the code calling
>> ACPICA functions should check acpi_disabled when necessary.
>
> Agree. However getting back to LTP tests it looks like such calls were implemented
> intentionally without checking of aspi_disabled value.
>
> Don't we have any self-testing stuff in acpica to prevent such scenarious ?

ACPICA doesn't know anything about acpi_disabled as I said already.

I would argue that testing unsupported use cases in LTP is not very useful.

Thanks,
Rafael

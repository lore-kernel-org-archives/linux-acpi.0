From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 1/1] acpi: apei: Enable APEI multiple GHES source to
 share a single external IRQ
Date: Thu, 27 Jul 2017 16:34:59 +0200
Message-ID: <CAJZ5v0jVSrsufoWyexb_MWS=ni0CDn7Oo1-oHOcaTxdYpfpQMg@mail.gmail.com>
References: <1500661477-6536-1-git-send-email-lho@apm.com> <20170722055954.GA2082@nazgul.tnic>
 <1893763.BLgt1zgLk5@aspire.rjw.lan> <1632667.Vgem7HtdXu@aspire.rjw.lan> <20170727055825.GA4611@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:37412 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751509AbdG0OfA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jul 2017 10:35:00 -0400
In-Reply-To: <20170727055825.GA4611@nazgul.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Loc Ho <lho@apm.com>, Mark Salter <msalter@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Tyler Baicar <tbaicar@codeaurora.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, patches@apm.com, "Luck, Tony" <tony.luck@intel.com>

On Thu, Jul 27, 2017 at 7:58 AM, Borislav Petkov <bp@suse.de> wrote:
> On Wed, Jul 26, 2017 at 08:57:03PM +0200, Rafael J. Wysocki wrote:
>> > Should I apply this or will Tony do that?
>>
>> So am I suppsed to drop this?
>
> Well, as suggested in another mail, I think it'll be best if Tony and I
> put ourselves as reviewers for the APEI crap and you still collect it.
>
> Unless you want to give it to us and we can arrange some pull order to
> send it to you.
>
> What do you prefer?

I can collect it, no problem.

So from now on I will pick up APEI things with ACKs from you or Tony.

Thanks,
Rafael

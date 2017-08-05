From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: Re: [PATCH 0/2] Updated SPCR quirks for Moonshot/Mustang
Date: Sat, 5 Aug 2017 08:25:16 +0100
Message-ID: <CAGCh1+=wYJbP4OS1W-2CJDRWNHStKNG1M8Y=iUM3rffO4JrqGA@mail.gmail.com>
References: <20170804214944.3910-1-graeme.gregory@linaro.org> <CAJZ5v0hDxZcRScWrym8htX3fzkgq4ZymiQdRZE4Fc0L5M1LfNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:34862 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbdHEHZR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Aug 2017 03:25:17 -0400
Received: by mail-io0-f171.google.com with SMTP id m88so12529879iod.2
        for <linux-acpi@vger.kernel.org>; Sat, 05 Aug 2017 00:25:17 -0700 (PDT)
In-Reply-To: <CAJZ5v0hDxZcRScWrym8htX3fzkgq4ZymiQdRZE4Fc0L5M1LfNQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Loc Ho <lho@apm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>

On 4 August 2017 at 23:51, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Aug 4, 2017 at 11:49 PM, Graeme Gregory
> <graeme.gregory@linaro.org> wrote:
>> A couple of patches to build on the SPCR quirks support already upstreamed.
>>
>> 1 - Moonshot m400 cartridge has the same soc but ACPI tables have different
>> HPe specific headers so extend quirk to understand those too.
>>
>> 2 - Relevant vendors do not seem to be working on DBG2/SPCR update for
>> situation where the clock is unknown. We want these machines to boot with
>> console initialised from SPCR before I die of old age so use the previous
>> quirk handling to also handle the clock problem as well.
>
> It increasingly seems to me that spcr.c firmly belongs in
> drivers/acpi/arm64/.  Any chance to move it in there and then mess up
> with it further?
>
Apparently x86 machines exist with SPCR table.

But if that is your wish I can certainly add that to series.

Graeme

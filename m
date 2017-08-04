From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] Updated SPCR quirks for Moonshot/Mustang
Date: Sat, 5 Aug 2017 00:51:55 +0200
Message-ID: <CAJZ5v0hDxZcRScWrym8htX3fzkgq4ZymiQdRZE4Fc0L5M1LfNQ@mail.gmail.com>
References: <20170804214944.3910-1-graeme.gregory@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:36311 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbdHDWv4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Aug 2017 18:51:56 -0400
In-Reply-To: <20170804214944.3910-1-graeme.gregory@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Loc Ho <lho@apm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>

On Fri, Aug 4, 2017 at 11:49 PM, Graeme Gregory
<graeme.gregory@linaro.org> wrote:
> A couple of patches to build on the SPCR quirks support already upstreamed.
>
> 1 - Moonshot m400 cartridge has the same soc but ACPI tables have different
> HPe specific headers so extend quirk to understand those too.
>
> 2 - Relevant vendors do not seem to be working on DBG2/SPCR update for
> situation where the clock is unknown. We want these machines to boot with
> console initialised from SPCR before I die of old age so use the previous
> quirk handling to also handle the clock problem as well.

It increasingly seems to me that spcr.c firmly belongs in
drivers/acpi/arm64/.  Any chance to move it in there and then mess up
with it further?

Thanks,
Rafael

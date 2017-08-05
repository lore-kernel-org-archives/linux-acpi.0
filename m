From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] Updated SPCR quirks for Moonshot/Mustang
Date: Sat, 5 Aug 2017 14:32:33 +0200
Message-ID: <CAJZ5v0iosfEPs2q7Gou=ToTYKNRZLZckQv0SghKeD=nv3Vi7TQ@mail.gmail.com>
References: <20170804214944.3910-1-graeme.gregory@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:33158 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752140AbdHEMcf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Aug 2017 08:32:35 -0400
In-Reply-To: <20170804214944.3910-1-graeme.gregory@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Loc Ho <lho@apm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Graeme Gregory <graeme.gregory@linaro.org>, Jon Masters <jcm@redhat.com>

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

Anyone any objections against this series?

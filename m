From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] Updated SPCR quirks for Moonshot/Mustang
Date: Fri, 11 Aug 2017 01:09:01 +0200
Message-ID: <2573038.EqNCH5mGWC@aspire.rjw.lan>
References: <20170804214944.3910-1-graeme.gregory@linaro.org> <CAJZ5v0iosfEPs2q7Gou=ToTYKNRZLZckQv0SghKeD=nv3Vi7TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45881 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753400AbdHJXRU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Aug 2017 19:17:20 -0400
In-Reply-To: <CAJZ5v0iosfEPs2q7Gou=ToTYKNRZLZckQv0SghKeD=nv3Vi7TQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Loc Ho <lho@apm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Graeme Gregory <graeme.gregory@linaro.org>, Jon Masters <jcm@redhat.com>

On Saturday, August 5, 2017 2:32:33 PM CEST Rafael J. Wysocki wrote:
> On Fri, Aug 4, 2017 at 11:49 PM, Graeme Gregory
> <graeme.gregory@linaro.org> wrote:
> > A couple of patches to build on the SPCR quirks support already upstreamed.
> >
> > 1 - Moonshot m400 cartridge has the same soc but ACPI tables have different
> > HPe specific headers so extend quirk to understand those too.
> >
> > 2 - Relevant vendors do not seem to be working on DBG2/SPCR update for
> > situation where the clock is unknown. We want these machines to boot with
> > console initialised from SPCR before I die of old age so use the previous
> > quirk handling to also handle the clock problem as well.
> 
> Anyone any objections against this series?

OK

Applied now, thanks!


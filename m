From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 3/4] ACPI / APEI: Drop uninformative messages during boot
Date: Thu, 27 Jul 2017 10:35:45 +0100
Message-ID: <87zibqi5n2.fsf@e105922-lin.cambridge.arm.com>
References: <20170720110402.15313-1-punit.agrawal@arm.com>
        <20170720110402.15313-4-punit.agrawal@arm.com>
        <20170720111732.GC18515@nazgul.tnic>
        <87d18vmgv6.fsf@e105922-lin.cambridge.arm.com>
        <20170720135446.GA20641@nazgul.tnic>
        <87shhrknes.fsf@e105922-lin.cambridge.arm.com>
        <20170721132731.GA5041@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43802 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbdG0Jfs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Jul 2017 05:35:48 -0400
In-Reply-To: <20170721132731.GA5041@nazgul.tnic> (Borislav Petkov's message of
        "Fri, 21 Jul 2017 15:27:31 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Boris,

Apologies for the delayed response. I somehow managed to lose updates on
this thread.

Borislav Petkov <bp@suse.de> writes:

> On Thu, Jul 20, 2017 at 06:50:51PM +0100, Punit Agrawal wrote:
>> "Firmware does not support APEI firmware first mode"
>> 
>> Thoughts?
>
> I guess the simplest would be to add a third state to that hest_disable
> to denote "HEST table not found" and then exit ghes_init() early, based on
> checking it.

Although simple, won't it make the already convoluted code flow more
so. Instead in addition to not setting hest_disable when the table is
not found ...

>
> Otherwise ghes_init() inits a bunch of things which you probably don't
> want on a platform which doesn't support APEI.

... would you be open to a patch re-working the ghes driver
initialisation to only do the platform driver registration. The the rest
of the initialisation (including the apei_osc_setup and related
messages) can be performed when the first ghes device gets probed.

Does that sound like a better alternative?

>
> -- 
> Regards/Gruss,
>     Boris.
>
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)

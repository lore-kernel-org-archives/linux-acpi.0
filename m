From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 3/4] ACPI / APEI: Drop uninformative messages during boot
Date: Thu, 27 Jul 2017 10:55:21 +0100
Message-ID: <87shhii4qe.fsf@e105922-lin.cambridge.arm.com>
References: <20170720110402.15313-1-punit.agrawal@arm.com>
        <20170720110402.15313-4-punit.agrawal@arm.com>
        <20170720111732.GC18515@nazgul.tnic>
        <87d18vmgv6.fsf@e105922-lin.cambridge.arm.com>
        <20170720135446.GA20641@nazgul.tnic>
        <87shhrknes.fsf@e105922-lin.cambridge.arm.com>
        <20170721132731.GA5041@nazgul.tnic>
        <87zibqi5n2.fsf@e105922-lin.cambridge.arm.com>
        <20170727095218.GB4611@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44066 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751160AbdG0JzX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Jul 2017 05:55:23 -0400
In-Reply-To: <20170727095218.GB4611@nazgul.tnic> (Borislav Petkov's message of
        "Thu, 27 Jul 2017 11:52:18 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Borislav Petkov <bp@suse.de> writes:

> On Thu, Jul 27, 2017 at 10:35:45AM +0100, Punit Agrawal wrote:
>> ... would you be open to a patch re-working the ghes driver
>> initialisation to only do the platform driver registration. The the rest
>> of the initialisation (including the apei_osc_setup and related
>> messages) can be performed when the first ghes device gets probed.
>> 
>> Does that sound like a better alternative?
>
> If you split it by doing one logical change per patch so that it is
> obvious what's going on and you don't break existing usage, I don't see
> why not.

Good! I'll try and get the patches out in the next few days.

Thanks.

>
> -- 
> Regards/Gruss,
>     Boris.
>
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)

From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 2/3] GHES: Move memory initialisation to ghes_probe()
Date: Tue, 15 Aug 2017 11:31:57 +0100
Message-ID: <87fuctp1eq.fsf@e105922-lin.cambridge.arm.com>
References: <20170801133608.21017-1-punit.agrawal@arm.com>
        <20170801133608.21017-3-punit.agrawal@arm.com>
        <20170814192256.56zoo5hgbyake25b@pd.tnic>
        <87o9rhp2f6.fsf@e105922-lin.cambridge.arm.com>
        <20170815083543.rz7lr4sbjcn65xc4@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49844 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753423AbdHOKb7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Aug 2017 06:31:59 -0400
In-Reply-To: <20170815083543.rz7lr4sbjcn65xc4@pd.tnic> (Borislav Petkov's
        message of "Tue, 15 Aug 2017 10:35:43 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: linux-acpi@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, James Morse <james.morse@arm.com>

[ thanks for dropping the bad email! ]

Borislav Petkov <bp@suse.de> writes:

> On Tue, Aug 15, 2017 at 11:10:05AM +0100, Punit Agrawal wrote:
>> In the absence of any GHES entries these are wasted.
>
> I know. This whole APEI init code would need a proper cleanup, like
> acpi_pci_root_init() calls acpi_hest_init() and it shouldn't have to
> communicate through a variable with GHES whether to init or not but it
> should initialize GHES itself. And ghes_init() being a device_initcall()
> is just yuck.

I'd seen the link between acpi_pci_root_init() and acpi_hest_init() but
didn't want to open another can of worms... :)

$SUBJECT was my attempt (small) at improving the situation but I guess I
didn't go far enough.

>
> Something for the todo list I guess...
>
>> The system does not provide the Hardware Error Source Table (HEST) which
>> is checked in the hest driver (drivers/acpi/apei/hest.c).
>> 
>> I think I'll go with your original suggestion to change hest_disable
>> from a boolean to something with more states. Re-checking for the HEST
>> table again feels like duplication.
>> 
>> Makes sense?
>
> Right, and then depending on the setting of hest_disable, either issue
> the "HEST is not enabled" message or not.

Ack!

>
> Thanks.
>
> -- 
> Regards/Gruss,
>     Boris.
>
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)

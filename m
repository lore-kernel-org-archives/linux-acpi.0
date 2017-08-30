From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v3] ACPI / APEI: Suppress message if HEST not present
Date: Wed, 30 Aug 2017 13:54:50 +0100
Message-ID: <878ti1gqqt.fsf@e105922-lin.cambridge.arm.com>
References: <20170829132020.31471-1-punit.agrawal@arm.com>
        <20170829150219.4gg3443phihudvbv@pd.tnic>
        <87d17dgx80.fsf@e105922-lin.cambridge.arm.com>
        <4871557.DtPhj4UV3s@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43980 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751641AbdH3Myw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Aug 2017 08:54:52 -0400
In-Reply-To: <4871557.DtPhj4UV3s@aspire.rjw.lan> (Rafael J. Wysocki's message
        of "Wed, 30 Aug 2017 13:54:57 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Borislav Petkov <bp@suse.de>, linux-acpi@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Wednesday, August 30, 2017 12:34:55 PM CEST Punit Agrawal wrote:
>> Borislav Petkov <bp@suse.de> writes:
>> 
>> > On Tue, Aug 29, 2017 at 02:20:20PM +0100, Punit Agrawal wrote:
>> >> According to the ACPI specification, firmware is not required to provide
>> >> the Hardware Error Source Table (HEST). When HEST is not present, the
>> >> following superfluous message is printed to the kernel boot log -
>> >> 
>> >> [    3.460067] GHES: HEST is not enabled!
>> >> 
>> >> Extend hest_disable variable to track whether the firmware provides this
>> >> table and if it is not present skip any log output. The existing
>> >> behaviour is preserved in all other cases.
>> >> 
>> >> Suggested-by: Borislav Petkov <bp@suse.de>
>> >> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> >> Cc: Borislav Petkov <bp@suse.de>
>> >> Cc: James Morse <james.morse@arm.com>
>> >> ---
>> >> 
>> >> Changes in v3:
>> >> * Grouped hest_disable status checking into a switch/case for clarity
>> >> 
>> >>  drivers/acpi/apei/ghes.c |  7 ++++++-
>> >>  drivers/acpi/apei/hest.c | 13 +++++++------
>> >>  include/acpi/apei.h      |  8 +++++++-
>> >>  3 files changed, 20 insertions(+), 8 deletions(-)
>> >
>> > Reviewed-by: Borislav Petkov <bp@suse.de>
>> 
>> Thanks!
>> 
>> Hopefully Rafael can pick the patch for the upcoming merge window.
>
> Applied already, should show up in linux-next tomorrow.

Neat! Thanks for picking up the patch.

>
> Thanks,
> Rafael
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v3] ACPI / APEI: Suppress message if HEST not present
Date: Wed, 30 Aug 2017 11:34:55 +0100
Message-ID: <87d17dgx80.fsf@e105922-lin.cambridge.arm.com>
References: <20170829132020.31471-1-punit.agrawal@arm.com>
        <20170829150219.4gg3443phihudvbv@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbdH3Ke6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Aug 2017 06:34:58 -0400
In-Reply-To: <20170829150219.4gg3443phihudvbv@pd.tnic> (Borislav Petkov's
        message of "Tue, 29 Aug 2017 17:32:02 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>

Borislav Petkov <bp@suse.de> writes:

> On Tue, Aug 29, 2017 at 02:20:20PM +0100, Punit Agrawal wrote:
>> According to the ACPI specification, firmware is not required to provide
>> the Hardware Error Source Table (HEST). When HEST is not present, the
>> following superfluous message is printed to the kernel boot log -
>> 
>> [    3.460067] GHES: HEST is not enabled!
>> 
>> Extend hest_disable variable to track whether the firmware provides this
>> table and if it is not present skip any log output. The existing
>> behaviour is preserved in all other cases.
>> 
>> Suggested-by: Borislav Petkov <bp@suse.de>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: James Morse <james.morse@arm.com>
>> ---
>> 
>> Changes in v3:
>> * Grouped hest_disable status checking into a switch/case for clarity
>> 
>>  drivers/acpi/apei/ghes.c |  7 ++++++-
>>  drivers/acpi/apei/hest.c | 13 +++++++------
>>  include/acpi/apei.h      |  8 +++++++-
>>  3 files changed, 20 insertions(+), 8 deletions(-)
>
> Reviewed-by: Borislav Petkov <bp@suse.de>

Thanks!

Hopefully Rafael can pick the patch for the upcoming merge window.

>
> -- 
> Regards/Gruss,
>     Boris.
>
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)

From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 3/3] Drop platform sysfs attributes from compal-laptop
Date: Sat, 22 Aug 2009 10:31:27 +0100
Message-ID: <9b2b86520908220231v6d4ab9aahfe69914e5c5fb796@mail.gmail.com>
References: <1250706980-10424-1-git-send-email-Mario_Limonciello@Dell.com>
	 <9b2b86520908200217j6a62b19dk6214b827af34418@mail.gmail.com>
	 <4A8F1500.6070208@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:44662 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005AbZHVJb1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Aug 2009 05:31:27 -0400
In-Reply-To: <4A8F1500.6070208@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: cezary.jackiewicz@gmail.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 8/21/09, Mario Limonciello <mario_limonciello@dell.com> wrote:
> Alan Jenkins wrote:
>> On 8/19/09, Mario Limonciello <Mario_Limonciello@dell.com> wrote:
>>
>> Don't you still need to call platform_device_del() for the fail_rfkill
>> case?
>>
>>
> It was previously only called if the sysfs attribute creation failed.
> So if it does need to be called, then there was a bug previously there too.

Nope, look at it again.

> @@ -481,11 +326,7 @@ static int __init compal_init(void)
>         return 0;
>
>   fail_rfkill:
>  -fail_platform_device2:
>  -
>  -       platform_device_del(compal_device);
>  -
>  -fail_platform_device1:
>  +fail_platform_device:
>
>         platform_device_put(compal_device);

Without this patch, fail_rfkill falls through to
fail_platform_device2, and calls platform_device_del().  With the
patch, the call to platform_device_del() is removed, so it will no
longer be called for the fail_rfkill case.  It's not a pre-existing
bug.

Regards
Alan

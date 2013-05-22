From: Michael Marineau <mike@marineau.org>
Subject: Re: ACPI v5 sleep registers broken on Toshiba laptops
Date: Wed, 22 May 2013 16:50:54 -0400
Message-ID: <CAHW-aUcKQ5pe4qsr+qu335-ELccfWh7D=QKsW97Hk9L6g5ZOzQ@mail.gmail.com>
References: <CAHW-aUcG7kT6uMFwbjUJ4DnvU=c+aj-Z8vaq94Gnt_UbJ6QRjA@mail.gmail.com>
	<1552539.vmT8XH6Vrv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:55047 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802Ab3EVUu5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 May 2013 16:50:57 -0400
Received: by mail-wg0-f48.google.com with SMTP id f12so1250793wgh.27
        for <linux-acpi@vger.kernel.org>; Wed, 22 May 2013 13:50:56 -0700 (PDT)
Received: from mail-wg0-x230.google.com (mail-wg0-x230.google.com [2a00:1450:400c:c00::230])
        by mx.google.com with ESMTPSA id d5sm31478615wic.1.2013.05.22.13.50.54
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 May 2013 13:50:55 -0700 (PDT)
Received: by mail-wg0-f48.google.com with SMTP id f12so1250771wgh.27
        for <linux-acpi@vger.kernel.org>; Wed, 22 May 2013 13:50:54 -0700 (PDT)
In-Reply-To: <1552539.vmT8XH6Vrv@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>

One thing that wasn't clear to me from the code is why the new sleep
registers are used any time they have defined addresses rather than
only when the reduced hardware flag is set. I poked through the ACPI
v5 spec and it seems to indicate that the sleep registers are only for
reduced hardware. On the other hand it doesn't explicitly say to not
use them on non-reduced hardware either. But maybe I missed something,
that document is huge. :-P

Cheers,
Mike

On Wed, May 22, 2013 at 3:36 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi Bob,
>
> What do you think about this?
>
> Rafael
>
>
> On Wednesday, May 22, 2013 09:39:12 AM Michael Marineau wrote:
>> Greetings,
>>
>> On the recently released Toshiba Kirabook and kernels >= 3.4
>> suspend/resume only works once. After resume input from things like
>> the power button, brightness buttons, lid switch, etc. no longer work
>> and the laptop simply hangs when suspended for a second time. This
>> appears to also impact other recent Toshiba laptops (although the bug
>> claims the hang is during the second resume rather than the second
>> suspend as is my case).
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1094800
>>
>> Suspend/resume and all the buttons work just fine on v3.3. I bisected
>> the v3.3->v3.4 change (with the help of patching in a kvm clock fix as
>> needed) and tracked it down to this commit:
>>
>> commit 2feec47d4c5f80b05f1650f5a24865718978eea4
>> Author: Bob Moore <robert.moore@intel.com>
>> Date: Tue Feb 14 15:00:53 2012 +0800
>>
>>     ACPICA: ACPI 5: Support for new FADT SleepStatus, SleepControl registers
>>
>>     Adds sleep and wake support for systems with these registers.
>>     One new file, hwxfsleep.c
>>
>>     Signed-off-by: Bob Moore <robert.moore@intel.com>
>>     Signed-off-by: Len Brown <len.brown@intel.com>
>>
>> Specifically, when the sleep status/control registeres are detected
>> they are used instead of the traditional registers. The failure to
>> resume a second time is triggered by this write in the new
>> acpi_hw_extended_wake_prep function:
>>
>>     status = acpi_get_sleep_type_data(ACPI_STATE_S0,
>>                       &acpi_gbl_sleep_type_a,
>>                       &acpi_gbl_sleep_type_b);
>>     if (ACPI_SUCCESS(status)) {
>>         sleep_type_value =
>>             ((acpi_gbl_sleep_type_a << ACPI_X_SLEEP_TYPE_POSITION) &
>>              ACPI_X_SLEEP_TYPE_MASK);
>>
>>         (void)acpi_write((u64)(sleep_type_value | ACPI_X_SLEEP_ENABLE),
>>                  &acpi_gbl_FADT.sleep_control);
>>     }
>>
>> Replacing that write with the corresponding code from
>> acpi_hw_legacy_wake_prep while leaving the other acpi_hw_extended_*
>> functions alone gets suspend/resume working consistantly. That isn't
>> quite enough as events don't seem to get re-enabled so acpi buttons
>> and such don't work after resume. Copying the enable power button code
>> from acpi_hw_legacy_wake to acpi_hw_extended_wake at least gets the
>> power button back but lid, brightness, etc remain dead.
>>
>> At the moment I've hacked these changes into v3.10.0-rc2 along with
>> another hack to fix a video regression and it seems to behave
>> reasonably well (minus the brightness keys and lid). I'm not sure what
>> the apropriate fix is. Maybe find some way beyond their presence to
>> detect if these registers are safe to use or just a device blacklist?
>
>
>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.



--
Michael Marineau

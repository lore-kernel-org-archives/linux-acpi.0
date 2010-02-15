From: Xavier Chantry <chantry.xavier@gmail.com>
Subject: Re: Suspend to RAM freeze with kernel modesetting (thinkpad r50e /
	855gm)
Date: Mon, 15 Feb 2010 11:29:00 +0100
Message-ID: <b67489df1002150229m22abafg86f665e826beb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:35077 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab0BOK3E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Feb 2010 05:29:04 -0500
Received: by fxm7 with SMTP id 7so5498709fxm.28
        for <linux-acpi@vger.kernel.org>; Mon, 15 Feb 2010 02:29:00 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: ykzhao <yakui.zhao@intel.com>, Wagner Ferenc <wferi@niif.hu>

From: Wagner Ferenc <wferi <at> niif.hu>
Subject: Re: Suspend to RAM freeze with kernel modesetting
Newsgroups: gmane.linux.acpi.devel
Date: 2009-10-09 21:20:12 GMT (18 weeks, 2 days and 13 hours ago)

On Fri, 9 Oct 2009, ykzhao wrote:

> On Thu, 2009-10-08 at 09:40 +0800, wferi wrote:
>
>> I'd like to solicit your opinion on the
>> https://bugs.freedesktop.org/show_bug.cgi?id=22126 issue.
>> In short, if I load the Intel graphics driver with kernel
>> modesetting enabled, my ThinkPad R50e won't suspend to RAM
>> anymore, it freezes instead (ie. does not enter S3).
>> Tracing seems to show that the freeze happens in a
>> particular line of drivers/acpi/acpica/hwsleep.c:
>> /* Run the _PTS method */
>> status = acpi_evaluate_object(NULL, METHOD_NAME__PTS, &arg_list, NULL);
>>
>> in acpi_enter_sleep_state_prep, as described in the bug
>> report. Can anybody provide a clue why this happens?
>> Suspend to disk works invariably, just like suspend to RAM
>> until I enable the kernel modesetting by a module option.
>
> Will you please attach the output of acpidump on your box?

Sure, please find it attached (or ask Bugzilla for
https://bugs.freedesktop.org/attachment.cgi?id=30231).
-- 
Regards,
Feri.


Hello list,

I am hit by the same issue as Feri.
Is there any more information we can provide, anything else we can do
to help resolving this problem ?

cheers,
Xavier

PS : please keep me in CC

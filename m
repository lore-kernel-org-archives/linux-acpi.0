From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v2] ACPI: Support for platform initiated graceful shutdown
Date: Wed, 22 Jun 2016 09:20:44 -0600
Message-ID: <36a56658-1bfb-21be-0245-2c757e1fd67d@codeaurora.org>
References: <1463430112-8843-1-git-send-email-pprakash@codeaurora.org>
 <58e509ba-383d-1f9c-9595-d225e8af32a8@codeaurora.org>
 <1690297.d25mR60BpH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51322 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbcFVPVV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jun 2016 11:21:21 -0400
In-Reply-To: <1690297.d25mR60BpH@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, harba@codeaurora.org, ahs3@redhat.com, cov@codeaurora.org

Hi Rafael,

On 6/21/2016 5:50 PM, Rafael J. Wysocki wrote:
> On Wednesday, June 15, 2016 02:05:05 PM Prakash, Prashanth wrote:
>> Hi Rafael,
>>
>> Any inputs on this patch?
> Does it actually work?
Yes, it works :)
> It looks like sybus_evaluate_ost() schedules itself with a delay in an
> endless loop and the poweroff will happen anyway without waiting.
>
> I guess the idea is that acpi_sybus_notify() will schedule a delayed work
> doing the sybus_evaluate_ost() and that will do the orderly_poweroff() thing,
> but that's not what the patch is doing.
The specification requires us to start graceful shutdown and then keep evaluating _OST
method every 10 seconds with a status code of 0x81 to indicate that shutdown is in
progress.

Since we need not trigger a graceful shutdown every time we evaluate _OST method. I
am calling orderly_poweroff only when we get the initial request via Notify.
> That "sybus" naming looks sort of lame BTW.  What's wrong with using "sb"
> instead?
Sure, I will change the naming to use sb instead of sybus.
>
> Besides actypes.h is an ACPICA file and patches updating it have to go via
> upstream ACPICA.
I can split this into 2 patches, so that they can be merged independently. Would that work?
>
> And one more thing, if you checked acpi_get_handle() for "\\_SB" once,
> it will succeed every time going forward.  No need to check again.
OK, I will remove the checks from sybus_evaluate_ost().
>
> Thanks,
> Rafael
>

Thanks,
Prashanth

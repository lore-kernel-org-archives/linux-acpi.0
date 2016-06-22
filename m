From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] ACPI: Support for platform initiated graceful shutdown
Date: Thu, 23 Jun 2016 00:43:10 +0200
Message-ID: <CAJZ5v0iCTDHoH5nxDGr7JiLjAu=Wt+Sp2Zr0j-YAtdu0Ye8H3w@mail.gmail.com>
References: <1463430112-8843-1-git-send-email-pprakash@codeaurora.org>
 <58e509ba-383d-1f9c-9595-d225e8af32a8@codeaurora.org> <1690297.d25mR60BpH@vostro.rjw.lan>
 <36a56658-1bfb-21be-0245-2c757e1fd67d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37876 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbcFVWnN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jun 2016 18:43:13 -0400
Received: by mail-wm0-f51.google.com with SMTP id a66so25079143wme.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jun 2016 15:43:12 -0700 (PDT)
In-Reply-To: <36a56658-1bfb-21be-0245-2c757e1fd67d@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, harba@codeaurora.org, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>

On Wed, Jun 22, 2016 at 5:20 PM, Prakash, Prashanth
<pprakash@codeaurora.org> wrote:
> Hi Rafael,
>
> On 6/21/2016 5:50 PM, Rafael J. Wysocki wrote:
>> On Wednesday, June 15, 2016 02:05:05 PM Prakash, Prashanth wrote:
>>> Hi Rafael,
>>>
>>> Any inputs on this patch?
>> Does it actually work?
> Yes, it works :)
>> It looks like sybus_evaluate_ost() schedules itself with a delay in an
>> endless loop and the poweroff will happen anyway without waiting.
>>
>> I guess the idea is that acpi_sybus_notify() will schedule a delayed work
>> doing the sybus_evaluate_ost() and that will do the orderly_poweroff() thing,
>> but that's not what the patch is doing.
>
> The specification requires us to start graceful shutdown and then keep evaluating _OST
> method every 10 seconds with a status code of 0x81 to indicate that shutdown is in
> progress.

So add a comment like this, so people don't have to wonder.

Also I'm not sure if the delayed_work_pending() really does what you
expect it to do.

And why to you need a delayed work instead of just a work that will do
"evaluate _OST; wait" in an endless loop?

> Since we need not trigger a graceful shutdown every time we evaluate _OST method. I
> am calling orderly_poweroff only when we get the initial request via Notify.

That's OK.

>> That "sybus" naming looks sort of lame BTW.  What's wrong with using "sb"
>> instead?
> Sure, I will change the naming to use sb instead of sybus.
>>
>> Besides actypes.h is an ACPICA file and patches updating it have to go via
>> upstream ACPICA.
> I can split this into 2 patches, so that they can be merged independently. Would that work?

I guess so, unless the ACPICA maintainers have objections to the ACPICA one.

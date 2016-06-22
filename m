From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v2] ACPI: Support for platform initiated graceful shutdown
Date: Wed, 22 Jun 2016 17:21:31 -0600
Message-ID: <c17e6a0e-2a21-d7ff-dc93-5c59dda6c157@codeaurora.org>
References: <1463430112-8843-1-git-send-email-pprakash@codeaurora.org>
 <58e509ba-383d-1f9c-9595-d225e8af32a8@codeaurora.org>
 <1690297.d25mR60BpH@vostro.rjw.lan>
 <36a56658-1bfb-21be-0245-2c757e1fd67d@codeaurora.org>
 <CAJZ5v0iCTDHoH5nxDGr7JiLjAu=Wt+Sp2Zr0j-YAtdu0Ye8H3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60574 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbcFVXVe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jun 2016 19:21:34 -0400
In-Reply-To: <CAJZ5v0iCTDHoH5nxDGr7JiLjAu=Wt+Sp2Zr0j-YAtdu0Ye8H3w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, harba@codeaurora.org, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>

Hi Rafael,

On 6/22/2016 4:43 PM, Rafael J. Wysocki wrote:
> On Wed, Jun 22, 2016 at 5:20 PM, Prakash, Prashanth
> <pprakash@codeaurora.org> wrote:
>> Hi Rafael,
>>
>> On 6/21/2016 5:50 PM, Rafael J. Wysocki wrote:
>>> On Wednesday, June 15, 2016 02:05:05 PM Prakash, Prashanth wrote:
>>>> Hi Rafael,
>>>>
>>>> Any inputs on this patch?
>>> Does it actually work?
>> Yes, it works :)
>>> It looks like sybus_evaluate_ost() schedules itself with a delay in an
>>> endless loop and the poweroff will happen anyway without waiting.
>>>
>>> I guess the idea is that acpi_sybus_notify() will schedule a delayed work
>>> doing the sybus_evaluate_ost() and that will do the orderly_poweroff() thing,
>>> but that's not what the patch is doing.
>> The specification requires us to start graceful shutdown and then keep evaluating _OST
>> method every 10 seconds with a status code of 0x81 to indicate that shutdown is in
>> progress.
> So add a comment like this, so people don't have to wonder.
ok.
>
> Also I'm not sure if the delayed_work_pending() really does what you
> expect it to do.
>
> And why to you need a delayed work instead of just a work that will do
> "evaluate _OST; wait" in an endless loop?
I will change it to a simple work instead of delayed work.

Thanks for your feedback! I will update the patch and post v3.


Thanks,
-Prashanth


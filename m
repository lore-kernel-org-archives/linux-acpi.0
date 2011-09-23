From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] acpica events: Call acpi_os_hotplug_execute on Ejection
 Requests
Date: Fri, 23 Sep 2011 06:48:38 -0400
Message-ID: <4E7C6406.1050300@redhat.com>
References: <1316733417-22528-1-git-send-email-prarit@redhat.com> <CAErSpo70F012EEh3TEdgK=rSst-27P-j8JxMDkcUaJGd29BnDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6695 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753141Ab1IWKsl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Sep 2011 06:48:41 -0400
In-Reply-To: <CAErSpo70F012EEh3TEdgK=rSst-27P-j8JxMDkcUaJGd29BnDg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, mjg@redhat.com



On 09/22/2011 09:08 PM, Bjorn Helgaas wrote:

>> The problem is that the event is placed on the wrong queue.  The code already
>> contains a kacpi_hotplug_wq queue for hotplug events to be added to in order
>> to prevent hangs like this.
> 
> Ugh.  I see the issue, and I see how this patch works around it.
> 
> But I don't really like it because we're adding complexity and (I
> think) extending knowledge of the special hotplug queue into the CA,
> when I don't think we should have added the hotplug queue in the first
> place.
> 
> I think the main reason we need the hotplug queue (added in
> c02256be79a) is that we have driver .remove() methods calling
> acpi_os_wait_events_complete() via acpi_remove_notify_handler().

Yup -- the documentation implies that's why it was added.

> 
> I would argue that drivers should not be using
> acpi_remove_notify_handler() in the first place.  Adding/removing
> notify handlers should be done by the ACPI core itself.  The acpiphp
> notify handlers (handle_hotplug_event_bridge() and
> handle_hotplug_event_func()) are for bus-level, device-independent
> events that should be handled not by the driver, but by the ACPI core.
> 
> Obviously, the ACPI core doesn't have hotplug support today (it has
> nice "TBDs" in the EJECT_REQUEST/DEVICE_CHECK cases), so I guess all I
> can do is complain without proposing a good alternative.  I hate that,
> sorry :)

:)  It's okay ... I understand what you're saying.  It would be a
significant rewrite and modification of the code to get this working
"right".

> 
> I think this is a very important issue and merits a Bugzilla reference
> so we can revisit it in the future.

I'll open up a BZ.

> 
>> Cc: mjg@redhat.com
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> ---
>>  drivers/acpi/acpica/evmisc.c |   13 ++++++++++---
>>  1 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
>> index d0b3318..a78aecc 100644
>> --- a/drivers/acpi/acpica/evmisc.c
>> +++ b/drivers/acpi/acpica/evmisc.c
>> @@ -181,9 +181,16 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
>>                notify_info->notify.value = (u16) notify_value;
>>                notify_info->notify.handler_obj = handler_obj;
>>
>> -               status =
>> -                   acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_ev_notify_dispatch,
>> -                                   notify_info);
>> +               /* Is this an Ejection Request? */
>> +               if (notify_value == 0x03)
> 
> Don't you want ACPI_NOTIFY_EJECT_REQUEST here instead of "0x03"?

Ah :)  I knew that value had to be #define'd somewhere :)  I just couldn't
find it ;).  I'll fix that up.

> 
> I'm not confident that EJECT_REQUEST is the only value that might be a
> problem.  For example, ACPI_NOTIFY_DEVICE_CHECK in
> handle_hotplug_event_{bridge,func} () leads to acpiphp_check_bridge(),
> which can also wind up calling acpi_remove_notify_handler().

I'm only testing an EJECT_REQUEST at this point but I see your
point.  I'll also add in a DEVICE_CHECK in [v2].

P.

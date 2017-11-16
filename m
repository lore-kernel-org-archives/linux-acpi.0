From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] ACPI: button: Add an info message when we're sending
 a LID closed event
Date: Thu, 16 Nov 2017 10:33:04 +0100
Message-ID: <c6139108-b209-b0e6-6a65-74b09609a46b@redhat.com>
References: <20171115140718.13026-1-hdegoede@redhat.com>
 <CAJZ5v0iHNj3XD1XWPrp_XZD+Nq-YzG665Ar+BeyCLfJEUT-nbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758148AbdKPJdH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Nov 2017 04:33:07 -0500
In-Reply-To: <CAJZ5v0iHNj3XD1XWPrp_XZD+Nq-YzG665Ar+BeyCLfJEUT-nbQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi,

On 15-11-17 18:16, Rafael J. Wysocki wrote:
> On Wed, Nov 15, 2017 at 3:07 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> I've been debugging some spurious suspend issues on various devices,
>> at least on some devices these spurious suspends are caused by surious
>> LID closed events being send to userspace.
>>
>> Running e.g. evemu-record after noticing a spurious suspend is too late
>> to detect that a LID closed event it the (probable) cause of this.
>> This commit adds a pr_info("ACPI LID closed\n") call to help debugging.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/acpi/button.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
>> index ef1856b15488..07da60fe9cae 100644
>> --- a/drivers/acpi/button.c
>> +++ b/drivers/acpi/button.c
>> @@ -210,6 +210,9 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
>>          }
>>          /* Send the platform triggered reliable event */
>>          if (do_update) {
>> +               if (!state)
>> +                       pr_info("ACPI LID closed\n");
> 
> Why pr_info()?

The purpose of the patch is to help debug spurious suspends seen on
some devices (typically Intel based tablets or 2in1s) so the goal is to
look at the logs after the fact and figure things out, so we want something
which shows up by default (typically a lid close leads to a suspend which
already causes some logging anyways), but this is not an error or a warning,
so I ended up with pr_info.

Regards,

Hans

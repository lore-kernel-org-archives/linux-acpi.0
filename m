From: Oleksij Rempel <bug-track@fisher-privat.net>
Subject: Re: [PATCH] ACPI / PCI: Make _SxD/_SxW check follow ACPI 4.0a spec
Date: Sat, 26 May 2012 10:15:22 +0200
Message-ID: <4FC0911A.5080301@fisher-privat.net>
References: <Pine.LNX.4.44L0.1205251511170.1907-100000@iolanthe.rowland.org> <201205252200.24331.rjw@sisk.pl> <4FC0723D.7080208@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:44535 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751166Ab2EZIP0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 May 2012 04:15:26 -0400
In-Reply-To: <4FC0723D.7080208@fisher-privat.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Am 26.05.2012 08:03, schrieb Oleksij Rempel (fishor):
> Hi,
> 
> On 25.05.2012 22:00, Rafael J. Wysocki wrote:
>> On Friday, May 25, 2012, Alan Stern wrote:
>>> Oleksij:
>>>
>>> Please take a look at this bug report:
>>>
>>>     https://bugzilla.kernel.org/show_bug.cgi?id=43278
>>>
>>> Apparently your patch breaks wakeup on this machine by preventing the
>>> USB host controllers from being put into D3.
>>
>> I think the patch is incorrect, actually.
>>
>> First, if you look at the first hunk:
>>
>> -       if (acpi_target_sleep_state>  ACPI_STATE_S0)
>> +       if (acpi_target_sleep_state>  ACPI_STATE_S0) {
>> +               acpi_status status;
>> +
>>                  acpi_evaluate_integer(handle, acpi_method, NULL,&d_min);
>>
>> +               if (device_may_wakeup(dev)) {
>> +                       acpi_method[3] = 'W';
>> +                       status = acpi_evaluate_integer(handle,
>> acpi_method,
>> +                                                      NULL,&d_max);
>> +                       if (ACPI_FAILURE(status))
>> +                               d_max = d_min;
>> +               }
>> +       }
>>
>> it will do something like this: if the device is wakeup-capable, get
>> d_max
>> from _SxW, unless it fails.  However, the code just below in that
>> function:
>>
>>     if (acpi_target_sleep_state == ACPI_STATE_S0 ||
>>         (device_may_wakeup(dev)&&
>>     adev->wakeup.sleep_state<= acpi_target_sleep_state)) {
>>         acpi_status status;
>>
>>         acpi_method[3] = 'W';
>>         status = acpi_evaluate_integer(handle, acpi_method, NULL,
>>                         &d_max);
>>         if (ACPI_FAILURE(status)) {
>>             if (acpi_target_sleep_state != ACPI_STATE_S0 ||
>>                 status != AE_NOT_FOUND)
>>                 d_max = d_min;
>>         } else if (d_max<  d_min) {
>>             /* Warn the user of the broken DSDT */
>>             printk(KERN_WARNING "ACPI: Wrong value from %s\n",
>>                 acpi_method);
>>             /* Sanitize it */
>>             d_min = d_max;
>>         }
>>     }
>>
>> does _exactly_ the same thing (it only has a more sophisticated error
>> code path).
> 
> Not really correct. The code below check _SxW state on wake up. This
> code checks _SxW on suspend.

oops i misreaded the code. it really do the same. except this part is
not executed because of this check: "adev->wakeup.sleep_state <=
acpi_target_sleep_state"


-- 
Regards,
Oleksij

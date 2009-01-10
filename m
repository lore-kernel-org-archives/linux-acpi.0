From: Daniel Smolik <marvin@mydatex.cz>
Subject: Re: [patch 6/6] acpi dock: terminate eject request is the dock is
 not present
Date: Sat, 10 Jan 2009 08:42:31 +0100
Message-ID: <49685167.7050804@mydatex.cz>
References: <200901092017.n09KHEqd015005@imap1.linux-foundation.org> <alpine.LFD.2.00.0901091607200.16697@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fwc.sitour.cz ([62.209.212.18]:3109 "EHLO kali.sitour.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbZAJIJF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Jan 2009 03:09:05 -0500
In-Reply-To: <alpine.LFD.2.00.0901091607200.16697@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, hmacht@suse.de, rui.zhang@intel.com, shaohua.li@intel.com, stable@kernel.org

Len Brown napsal(a):
> The bug report suggest that this patch is not a complete fix for the 
> issue, so I'd prefer we get a resolution, or at least a better
> understanding of the failure, before sending patches upstream
> for this issue.
>   
Hi,
you are right I don't  understand how it works. I only diff dock.c from 
2.6.26 to .26.28 and search differences.
But I apply this patch  5 days ago and dock and undock witout problems 
as with 2.6.26.

Regards
                      Dan Smolik


> thanks
> Len Brown, Intel Open Source Technology Center
>
> On Fri, 9 Jan 2009, akpm@linux-foundation.org wrote:
>
>   
>> From: Daniel Smolik <marvin@mydatex.cz>
>>
>> Taken from http://bugzilla.kernel.org/show_bug.cgi?id=12360
>>
>> nfi if it's right - I merged it so it wouldn't get lost.
>>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: "Li, Shaohua" <shaohua.li@intel.com>
>> Cc: <hmacht@suse.de>
>> Cc: <stable@kernel.org>		[2.6.26.x, 2.6.27.x, 2.6.28.x]
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
>>  drivers/acpi/dock.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff -puN drivers/acpi/dock.c~acpi-dock-terminate-eject-request-is-the-dock-is-not-present drivers/acpi/dock.c
>> --- a/drivers/acpi/dock.c~acpi-dock-terminate-eject-request-is-the-dock-is-not-present
>> +++ a/drivers/acpi/dock.c
>> @@ -668,6 +668,9 @@ EXPORT_SYMBOL_GPL(unregister_hotplug_doc
>>   */
>>  static int handle_eject_request(struct dock_station *ds, u32 event)
>>  {
>> +	if (!dock_present(ds))
>> +		return -ENODEV;
>> +
>>  	if (dock_in_progress(ds))
>>  		return -EBUSY;
>>  
>> _
>>
>>     


From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: wrong ACPI estimate (fwd)
Date: Thu, 15 Jan 2009 23:17:50 +0300
Message-ID: <496F99EE.1040807@suse.de>
References: <alpine.LFD.2.00.0901151411290.4737@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:42692 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932463AbZAOURm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jan 2009 15:17:42 -0500
In-Reply-To: <alpine.LFD.2.00.0901151411290.4737@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, power@bughost.org

Len Brown wrote:
> Alexey, Henrique,
> Is this related to the power supply sysfs wrong-units bug?
Yes.

Regards,
Alex.
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 
> ---------- Forwarded message ----------
> Date: Thu, 15 Jan 2009 10:14:41 -0800
> From: "Kok, Auke" <auke-jan.h.kok@intel.com>
> To: Winfried Tilanus <winfried@tilanus.com>
> Cc: "power@bughost.org" <power@bughost.org>
> Subject: Re: wrong ACPI estimate
> 
> Winfried Tilanus wrote:
>> Hi,
>>
>> I am running Debian Lenny on a thinkpad x61s, with tp_smapi modules. I
>> incorrectly thought the following problem was fixed:
>>
>> $ sudo powertop -d | grep "Power usage"
>> Power usage (ACPI estimate): 200.4W (0.3 hours)
>>
>> This problem is discussed in Debian bug 497929
>> (http://bugs.debian.org/497929)
>> The problem is fixed by reverting the a code change mentioned there:
>>
>> @@ -644,7 +651,7 @@ void print_battery_sysfs(void)
>>                         continue;
>>                 memset(line, 0, 1024);
>>                 if (fgets(line, 1024, file) != NULL) {
>> -                       watts_drawn = strtoull(line, NULL, 10) / 1000000.0;
>> +                       amperes_drawn = strtoull(line, NULL, 10) /
>> 1000000.0;
>>                 }
>>                 fclose(file);
>>
>> Is there a way to fix this?
> 
> I doubt that we can fix this for everyone :/
> 
> unfortunately it seems that the numbers reported back to the kernel are of
> different types on various systems.
> 
> I will revert this change in the next release, just because the initial change
> that did this did not take this into account, and I'd rather be back at the
> initial (broken) stage than another (broken) stage.
> 
> We'll have to figure out we somehow can distinguish between the two units when we
> read the data, which will likely be more complex, or involve fixing various ACPI
> drivers to unify their number reporting.
> 
> Auke
> 
> _______________________________________________
> Power mailing list
> Power@bughost.org
> http://www.bughost.org/mailman/listinfo/power


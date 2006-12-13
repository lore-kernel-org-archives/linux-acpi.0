From: "Lincoln Baxter, III" <lincolnbaxter@gmail.com>
Subject: Re: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works
 again after booting windows
Date: Wed, 13 Dec 2006 02:54:09 -0500
Message-ID: <457FB1A1.2030602@gmail.com>
References: <457F37C0.3090003@gmail.com> <1165966936.29844.37.camel@pcjc2lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:37356 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932612AbWLMHyM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Dec 2006 02:54:12 -0500
Received: by wx-out-0506.google.com with SMTP id h27so96087wxd
        for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2006 23:54:12 -0800 (PST)
In-Reply-To: <1165966936.29844.37.camel@pcjc2lap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Clifton <pcjc2@cam.ac.uk>
Cc: linux-acpi@vger.kernel.org

Wow. You're completely right... so this isn't an ACPI issue (directly.)

I don't seem to experience any of the other problems you describe, but I 
do have a different model. I don't have an external lid-switch sensor. 
Hm.. Suspend doesn't quite work for me either, I'll look into this 
farther and get back to you.

The battery meters and other ACPI functionality is working now with your 
workaround. Should this be a bug report? Which group should get the 
report if this is the case?

Thanks so much!
Lincoln

Peter Clifton wrote:
> On Tue, 2006-12-12 at 18:14 -0500, Lincoln Baxter, III wrote:
>   
>> Hi everyone, I recently tried to install gentoo linux on my HP nc6400 
>> laptop, and everything works fine except for the following issues.
>>
>>    This may be related to:
>>    http://marc.theaimsgroup.com/?l=linux-acpi&m=115583434909936&w=2
>>
>> Here are the problems:
>>   1. After booting gentoo, when I reboot, I can no longer enter the BIOS 
>> setup screen by pressing F10.
>>   2. After booting gentoo, when I reboot, the ACPI battery file does not 
>> update the power status / events.
>>
>> Here's how they happen:
>>   1. Boot windows: everything works fine.
>>   2. Reboot from windows: I can get into setup by pressing F10.
>>   3. Boot Gentoo after having booted windows first: power status meter 
>> works, files are updated, etc.
>>   4. Reboot into Gentoo: I can no longer enter setup via F10.
>>   5. Reboot into windows: Everything works again. On next bootup, F10 
>> works fine.
>>     
>
> Crazy as it seems, add an init script to rmmod psmouse before you
> shutdown or reboot linux. Somehow having it loaded when the machine
> shuts down causes the BIOS to get upset.
>
> Works on my nc6320 as a workaround, although I've got a few odd issues
> still:
>
> Critically, when the lid-switch is pressed, the backlight extinguishes,
> but if the touchpad senses any movement, a key is pressed, or for some
> random reason, the backlight fires back up again, then doesn't switch
> off.
>
> This leaves the laptop very toasty if you shut the lid and it does this.
>
> Does yours do this?
>
>
> Suspend doesn't work out of box, I've not really tried to diagnose.
>
> Regards,
>
> Peter Clifton
>
>
>
>   


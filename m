From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Wed, 12 Nov 2008 14:23:21 +0200
Message-ID: <491ACAB9.40203@redhat.com>
References: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain> <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu> <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com> <20081110083938.GD22392@elte.hu> <20081110115732.GA30181@srcf.ucam.org> <20081110125630.GC28643@elte.hu> <20081110130029.GC30894@srcf.ucam.org> <alpine.LFD.2.00.0811111802440.4480@localhost.localdomain> <20081112115806.GD11352@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:34014 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022AbYKLMX7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 07:23:59 -0500
In-Reply-To: <20081112115806.GD11352@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>

Ingo Molnar wrote:
>>
>> We knows XP and Vista do it.
>>
>> But upstream doesn't currently check the FADT.flags.reset-reg-supported bit
>> due to a recent bad guess on my part on how to be bug compatible with 
>> windows.
>>
>> The (revert) patch to add that check is in my tree, along with
>> the trivial patch to flip the default to acpi-reset.
>>
>> Technically, that is the only "unanced" thing we should need
>> to check.  However, it will not fix Avi's box, where it appears
>> that flag is present, the reset works, but for some reason the
>> keyboard fails after reset.  More likely that is a device driver
>> issue specific to Linux interacting with "unexpected" BIOS behavior.
>>     
>
> hm, will that also fix Andrey's box?
>   

This describes Andrey's box, not mine.  Mine (and others) have working 
acpi reset and non-working keyboard reset; so reset was done using 
triple-fault which fails when virtualization is enabled.


-- 
error compiling committee.c: too many arguments to function


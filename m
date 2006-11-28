From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: new pmtools available for testing
Date: Tue, 28 Nov 2006 17:00:45 +0300
Message-ID: <456C410D.9090201@linux.intel.com>
References: <B28E9812BAF6E2498B7EC5C427F293A401671EDA@orsmsx415.amr.corp.intel.com>	 <1164708222.4656.203.camel@queen.suse.de>	 <456C0E5A.5090703@linux.intel.com> <1164712459.4656.253.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:65425 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S933705AbWK1OAx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Nov 2006 09:00:53 -0500
In-Reply-To: <1164712459.4656.253.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: "Moore, Robert" <robert.moore@intel.com>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

Thomas Renninger wrote:
> On Tue, 2006-11-28 at 13:24 +0300, Alexey Starikovskiy wrote:
>   
>> Thomas Renninger wrote:
>>     
>>> On Mon, 2006-11-27 at 10:13 -0800, Moore, Robert wrote:
>>>   
>>>       
>>>> I don't know what's going on here.
>>>>
>>>> I wrote acpixtract in C in order to get away from Perl and Perl issues.
>>>>
>>>> I certainly hope that we don't have yet another version of acpixtract.
>>>>     
>>>>         
>>> Second.
>>> Better remove this one soon. People are packing Len's pmtools. As soon
>>> as it's spread confusion and maintenance work will grow.
>>>   
>>>       
>> There was no confusion between two utilities with the same name, and now you claim to have lost between two with different names, how so?
>>     
> It's not the two names, it simply makes no sense to provide two
> utilities which do the same.
>   
So blaim Bob for making second utility and distributing it in ACPICA.

> Why do you want to do that?
>
> You have other params, other output, double amount of bug fixing or
> feature enhancements work. I only see cons not one single pro argument
> to do so.
>
>   
Params are compatible with acpidump. What do you mean by "other output"?
>> pmtools used to be complete in sense it was able to decode that was it 
>> has produced, and it will remain complete.
>>     
> But why not just move/copy Robert's acpixtract, it's already well
> tested?
> It does not include any APCICA stuff and changing the license shouldn't
> be a problem for you...
>
>   
Writing new utility from scratch took half a day, while porting ACPICA 
acpidump with change in license would take weeks.
It does include ACPICA types, so it will require ACPICA headers at least.
Also it relies on ACPICA subset of libc, so it will be pain to both 
maintain it  and  make any improvements.
We already tried to have acpidump utility in both ACPICA and pmtools and 
ended with two completely different programs.

Regards,
    Alex.

From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: state of some x86 acpi patches
Date: Thu, 01 Jan 2009 17:49:35 +1100
Message-ID: <495C677F.6080707@goop.org>
References: <4947FF4C.80706@goop.org> <20081216192534.GB843@elte.hu> <alpine.LFD.2.00.0812311821110.3854@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:58341 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbZAAGuE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jan 2009 01:50:04 -0500
In-Reply-To: <alpine.LFD.2.00.0812311821110.3854@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Yinghai Lu <yinghai@kernel.org>, linux-acpi@vger.kernel.org

Len Brown wrote:
> On Tue, 16 Dec 2008, Ingo Molnar wrote:
>
>   
>> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>>
>>     
>>> Hi Len,
>>>
>>> Have you seen these three patches?  Do they look OK to you?
>>>
>>> Yinghai Lu improve the third patch ("acpi: remove final __acpi_map_table 
>>> mapping before setting acpi_gbl_permanent_mmap"), which I think Ingo 
>>> sent you instead.
>>>       
>> Len,
>>
>> i asked about these patches before too - and if that's fine with you we'd 
>> just queue them up in the x86 tree (like we did before the .28 merge 
>> window). Most of the impact will be on x86. So an Acked-by from you would 
>> be fine to start this.
>>     
>
> Sorry for the delay.
> I recall reading your e-mail on this and thought I replied to it,
> but for some reason I found neither your original message nor
> my reply when I searched my archives today.
>
> But I did recall Ingo making a branch for this one, and so looking
> at remotes/origin/acpi-for-len in ingo's tree...
>
> It isn't immediately clear to me what problem this patch series solves,
> and thus it is hard to judge how important this is.
>
> It touches a lot of files, and it is going to run into a bunch of merge 
> conflicts.
>
> I'm not thrilled that the first part of the series makes changes
> which are then undone by the later part of the series --
> that doesn't help w/ conflict resolution...
>
> The change to tbxface.c is an ACPICA API change.
> It looks reasonable and it might be the right change,
> but it is extra work -- we should sync with Bob
> when he gets back from break.
>
> So, this one is sort of a headache, how important is it?
>   

Well, there's several aspects to this series:

The important one from my perspective is using early_ioremap to map the 
acpi memory, rather than using a private mapping function; this is 
necessary when running under Xen, so that the right memory gets mapped.

This in itself is pretty straightforward, but it raises a few issues.  
One is that the acpi code doesn't properly unmap its mapped memory, but 
relies on a "new mapping replaces old" semantic.  Putting a wrapper 
around early_ioremap to emulate this is fairly straightforward, but it 
does leave one trailing mapping, which causes early_ioremap to raise a 
warning.

I addressed this warning by putting in a hook to unmap the last 
mapping.  This was simple, but pretty hackish.  Yinghai went the extra 
distance by making the acpi code properly pair map and unmap calls on 
all the resources it needs, doing away with the "new map unmaps 
previous" behaviour, and cleaning up the warning in the process.

Thanks,
    J

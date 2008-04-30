From: Richard <tuxbox.guru@gmail.com>
Subject: Re: ACPI on Compaq 6715b - BIOS from the wrong end of the planet
Date: Wed, 30 Apr 2008 14:09:32 +0100
Message-ID: <48186F8C.5060201@gmail.com>
References: <48144209.7080203@gmail.com>	 <1209476717.1784.853.camel@queen.suse.de>  <4817457C.6000103@gmail.com>	 <1209493771.1784.892.camel@queen.suse.de>  <4817B0E1.7080102@zytor.com>	 <1209544792.29352.78.camel@linux-2bdv.site>  <48184885.2090703@gmail.com> <1209557260.1784.905.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:6825 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758978AbYD3NJu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Apr 2008 09:09:50 -0400
Received: by yw-out-2324.google.com with SMTP id 5so278294ywh.1
        for <linux-acpi@vger.kernel.org>; Wed, 30 Apr 2008 06:09:36 -0700 (PDT)
In-Reply-To: <1209557260.1784.905.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org, andreas.herrmann3@amd.com

Thomas Renninger wrote:
> Also something at the C1E check which should come here then, does it
> match?
> Maybe it really is a RevE and the second CPU is not brought up yet?
>   

This machine is a single processor system (Single core) .. its loading a 
MP kernel tho.  It can wait forever for the second processor :-D

>>>   
>>>       
>> Hi there,
>>
>> The results are in.. and the patch done nothing on my notebook. The 
>> symptoms are exactly the same as before. Kernel loads, INIT starts and 
>> then the machine shuts down a few seconds later. noapictimer still fixes 
>> it tho' 
>>     
>
> Googled this:
> Sempron 3600+ (CN),256K,rev.F2,62W,SocketAM2    ALL  0107
> So this Sempron probably is RevF already but the C1E check does not
> work?
> Hope you still have the kernel compiled flying around?
> Could you add a lot printks at the place (some examples above) where it
> is checked for broken apic timer.
> Maybe you can also just return that it's broken to check whether setting
> noapictimer variable at this place generally works for you...
>
> Thanks,
>
>     Thomas
>
>
>
>   
Building again...  should be completed in a minute or so.


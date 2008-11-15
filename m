From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: ACPI: EC: GPE storm detected, transactions will use polling mode
Date: Sat, 15 Nov 2008 12:06:05 +0000
Message-ID: <491EBB2D.70106@tuffmail.co.uk>
References: <1226722577.3104.4.camel@LiNuX> <491E94FD.4090002@gmail.com> <9b2b86520811150237r454b0a38l8d34f0e322573da@mail.gmail.com> <200811151236.16748.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756139AbYKOMG3@vger.kernel.org>
In-Reply-To: <200811151236.16748.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Justin P. Mattock" <justinmattock@gmail.com>, Alexey Starikovskiy <aystarik@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Rafael J. Wysocki wrote:
> On Saturday, 15 of November 2008, Alan Jenkins wrote:
>   
>> On Sat, Nov 15, 2008 at 9:23 AM, Alexey Starikovskiy <aystarik@gmail.com> wrote:
>>     
>>> Andrew Morton wrote:
>>>       
>>>> (cc linux-acpi)
>>>>
>>>> On Fri, 14 Nov 2008 20:16:17 -0800 "Justin P. Mattock"
>>>> <justinmattock@gmail.com> wrote:
>>>>
>>>>  
>>>>         
>>>>> just pulled the latest git today and am now noticing
>>>>> the lovely gpe storm being triggered.(dmesg below);
>>>>>    
>>>>>           
>>>> Are any other effects observeable?
>>>>
>>>> I assume that 2.6.27 didn't do this.
>>>>
>>>>  
>>>>         
>>> It did. Justin even opened a bug -- #11724.
>>>       
>> In case anyone else tries to follow that, it's actually #10724 :).
>>     
>
> Yes, the "transaction in interrupt context" patch fixed that IIRC and the one
> of the patches in the recet ACPI merge broke it again.
>
> Justin, can you see if reverting one or more of the following commits helps:
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8517934ef6aaa28d6e055b98df65b31cedbd1372
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=06cf7d3c7af902939cd1754abcafb2464060cba8
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=0b7084ac67fb84f0cf2f8bc02d7e0dea8521dd2d
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a2f93aeadf97e870ff385030633a73e21146815d
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=dd15f8c42af09031e27da5b4d697ce925511f2e1
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f8248434e6a11d7cd314281be3b39bbcf82fc243
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1cfe62c8010ac56e1bd3827e30386a87cc2f3594
>
> (please revert in this order)?
>   
Be aware there's a real possibility this was only a cosmetic fix (and 
regression).

I think the original GPE storm avoidance printed that message by 
default.  Then the "transaction in interrupt context" made the message 
into a pr_debug(), - i.e. disabled it by default.  And then my "make 
messages more useful when GPE storm is detected" re-enabled it.

IIRC, this flip-flopping is contained within 2.6.28-rc.  I.e. I don't 
think it will show up as a (cosmetic) regression when jumping straight 
from 2.6.27 to 2.6.28.  Though I suspect it will shows up between 
certain versions of -stable.

Regards
Alan

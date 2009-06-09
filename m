From: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH] sony-laptop: no need to unblock rfkill on load
Date: Tue, 09 Jun 2009 09:31:31 +0100
Message-ID: <4A2E1DE3.4020509@tuffmail.co.uk>
References: <4A2CE86F.9040209@tuffmail.co.uk> <1244457418.18863.8.camel@johannes.local> <20090608224915.GA4583@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090608224915.GA4583-pM3i+3kAS8Rg9hUCZPvPmw@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>
Cc: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Mattia Dongili wrote:
> On Mon, Jun 08, 2009 at 12:36:58PM +0200, Johannes Berg wrote:
>   
>> On Mon, 2009-06-08 at 11:31 +0100, Alan Jenkins wrote:
>>     
>>> The re-written rfkill core ensures rfkill devices are initialized to
>>> the system default state.  The core calls set_block after registration
>>> so the driver shouldn't need to.
>>>
>>> Signed-off-by: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
>>>       
>> Good catch, thanks.
>>     
>
> Just to confirm, is this patch going to sit in the wireless-testing tree
> and you will submit it for inclusion together with the rfkill work
> right?
>   

Yes.  I probably didn't need to ping you at this point.

It just bothered me because I was effectively reverting a recent 
commit.  I figuired I should let you know.  In case it didn't work, when 
it was merged you'd know why I did it and who to blame.  But there is 
always Git history for that :-).

Regards
Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

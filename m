From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH 2/3] ipmi: Turn off all activity on an idle ipmi interface
Date: Mon, 24 Feb 2014 11:08:50 -0600
Message-ID: <530B7CA2.2050700@mvista.com>
References: <1393208616-16500-1-git-send-email-minyard@acm.org> <1393208616-16500-3-git-send-email-minyard@acm.org> <20140224165738.GB26479@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140224165738.GB26479@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, minyard@acm.org
Cc: OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>, Linux Kernel <linux-kernel@vger.kernel.org>, Russ Anderson <rja@sgi.com>, Matthew Garrett <matthew.garrett@nebula.com>, lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 02/24/2014 10:57 AM, Dmitry Torokhov wrote:
> On Sun, Feb 23, 2014 at 08:23:35PM -0600, minyard@acm.org wrote:
>> @@ -1194,7 +1223,17 @@ int ipmi_set_gets_events(ipmi_user_t user, int val)
>>  	INIT_LIST_HEAD(&msgs);
>>  
>>  	spin_lock_irqsave(&intf->events_lock, flags);
>> -	user->gets_events = val;
>> +	if (user->gets_events == !!val)
>> +		goto out;
>> +
>> +	user->gets_events = !!val;
> Why not have val declared as bool and let compiler convert as needed?
>
> Thanks.
>
Because I've been programming in C since long before there was a bool
type, and I need to change the way I think.  Fixed, thanks.

-core

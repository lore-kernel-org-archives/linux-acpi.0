From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI: EC: GPE storm detected, disabling EC GPE
Date: Wed, 11 Jun 2008 14:29:35 +0400
Message-ID: <484FA90F.3010005@gmail.com>
References: <dd18b0c30806062321x2918f6feq7c817bde52ba0c4c@mail.gmail.com> <20080606235526.783acc83.akpm@linux-foundation.org> <dd18b0c30806070847t63b8dbc0x8bfcbafc359f7031@mail.gmail.com> <484AE148.6000204@suse.de> <20080608142106.GD4739@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:52379 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbYFKK3H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 06:29:07 -0400
Received: by gv-out-0910.google.com with SMTP id e6so697079gvc.37
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jun 2008 03:29:05 -0700 (PDT)
In-Reply-To: <20080608142106.GD4739@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Justin Mattock <justinmattock@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
> On Sat 2008-06-07 23:28:08, Alexey Starikovskiy wrote:
>   
>> Justin Mattock wrote:
>>     
>>> On Sat, Jun 7, 2008 at 6:55 AM, Andrew Morton 
>>>       
>
>   
>>> This issue just recently started, 2.6.25-rc9 and below 
>>> don't give me
>>> this message.
>>>
>>>       
>> Yes, the problem which we are fighting here is that 
>> almost all Acer notebooks come with
>> broken EC. It sends interrupts not regarding the fact 
>> that we already ACKed it.
>> It comes unnoticed on almost all machines (some notice 
>> laggy keyboard, because it's the same controller after 
>> all and it's busy with sending ACPI interrupts and then 
>> providing same status byte over and over), but on some 
>> machines keystrokes become missing, which is not 
>> tolerable (#9998).
>>     
>
> But the acer workaround breaks other machines, right?
>
>   
As I know, the first workaround broke your machine,
may be you could check if it is broken now?
> So what about
>
> a) use dmi blacklist for acers?
>
>   
It is not only Acers. ASUS eeePC is known to be affected, some Apple 
notebook too.
> or
>
> b) if EC storm is detected print message telling 'please pass
> ec_polled=true if you experience keyboard problems', but do nothing
> else?
>
>   
There are no reports about broken machines for 2.6.26-rc5 beside #10724,
which has same broken controller, sending same amount of stray interrupts.
If there will be report from a good machine affected by this workaround 
then I will
certainly go with b)

Thanks,
Alex.



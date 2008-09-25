From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [RFC] [Patch 0/4]  ACPI : several patches for EC
Date: Thu, 25 Sep 2008 12:31:49 +0400
Message-ID: <48DB4C75.5090403@gmail.com>
References: <1222314812.4023.31.camel@yakui_zhao.sh.intel.com>	 <48DB20DB.4080802@gmail.com> <1222324860.4023.62.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:28301 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbYIYIby (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 04:31:54 -0400
Received: by fk-out-0910.google.com with SMTP id 18so306906fkq.5
        for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2008 01:31:51 -0700 (PDT)
In-Reply-To: <1222324860.4023.62.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Zhao Yakui wrote:
> On Thu, 2008-09-25 at 09:25 +0400, Alexey Starikovskiy wrote:
>   
>> Hi Yakui,
>>
>> As a current maintainer of EC driver I NAK the whole series,
>> as conflicting with the patch proposed by me.
>>     
> Please NAK the whole series if my patch is not reasonable or will cause
> some regression. If so, please give some explanation.
>   
I gave you explanations for two weeks already. Enough is enough.
> Otherwise it is unconvincing if you NAK my patch only because it is
> conflicted with your patch.
>
> Now the patch proposed by your patch is already reverted in acpi_test
> tree. There are a lot of errors in it.
>   
This is a lie.
> At the same time I raise two issues about your proposed patch. But there
> is no explanation.
>    a. Bogus timeout
>   
You are referring to bug report, there system was stalling to 120 seconds
due to broken HPET.  While there is no need to try to workaround such 
things,
changing to udelay() from msleep() in poll mode will fix it.
>    b. How to deal with the laptop with "incorrect EC status before EC
> GPE arrives". For example: bug 11309 (GPE storm happens and OS will
> report the incorrect temperature while EC GPE is disabled.)
>   
This is _your guess_. None of your patches was reported to fix a situation,
and submitter is not able to compile kernel.
>       Maybe the laptop of bug 8110 is broken again by your proposed
> patch.
>   
It is not, and I explained to you why.

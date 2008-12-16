From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Bug 11884 - _REG and _INI
Date: Tue, 16 Dec 2008 13:17:29 +0300
Message-ID: <49478039.5090101@gmail.com>
References: <1229313063.19540.86.camel@minggr.sh.intel.com>	 <1229326070.3991.7.camel@yakui_zhao.sh.intel.com>	 <494622E0.4020600@suse.de>  <494635B2.60001@gmail.com> <1229389666.3991.19.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:32985 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbYLPKRe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Dec 2008 05:17:34 -0500
Received: by bwz14 with SMTP id 14so3478074bwz.13
        for <linux-acpi@vger.kernel.org>; Tue, 16 Dec 2008 02:17:32 -0800 (PST)
In-Reply-To: <1229389666.3991.19.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Lin, Ming M" <ming.m.lin@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Zhao Yakui wrote:
> On Mon, 2008-12-15 at 18:47 +0800, Alexey Starikovskiy wrote:
>   
>> It's not that simple... Here is relevant part of dmesg from my thinkpad:
>>
>> ------------------------------------------------------------------------
>> ACPI Error (evregion-0315): No handler for Region [ECOR] 
>> (ffff8800bf814558) [EmbeddedControl] [20080926]
>> ACPI Error (exfldio-0291): Region EmbeddedControl(3) has no handler 
>> [20080926]
>> ACPI Error (psparse-0524): Method parse/execution failed 
>> [\_SB_.PCI0.LPC_.EC__._INI] (Node ffff8800bf817300), AE_NOT_EXIST
>> ACPI: EC: EC description table is found, configuring boot EC
>> ACPI: Interpreter enabled
>> ACPI: (supports S0 S3 S5)
>> ACPI: Using IOAPIC for interrupt routing
>> ACPI: EC: non-query interrupt received, switching to interrupt mode
>> ACPI: EC: GPE = 0x1c, I/O: command/status = 0x66, data = 0x62
>> ACPI: EC: driver started in interrupt mode
>> --------------------------------------------------------------------------
>>     
> There exists too much difference on different vendors.
> In theory there exists the EC flag in AML code, which indicates whether
> the EC operation region can be accessed.  After the EC _REG object is
> evaluated, the EC flag will be set and it means that EC operation region
> can be accessed. Before the EC _REG object is evaluated, it had better
> be zero.
> >From the above dmesg it seems that the above warning is related with one
> of the two following factors:
>    a. EC flag is initialized as one. In such case it means that EC
> operation region can be accessed before EC initialization.
>    b. EC flag is not used correctly in some methods. 
>
>   
I've added a patch to #11884, which will limit _INI check to ASUS machines.
Thus, registration of handlers on HP will happen only after all _INI 
methods are run.
I think, it is a simpler way out of this mess.
> At the same time from the above message we know that there exists the
> ECDT table. So when there exists the ECDT table, we can continue to use
> the current flowchart of EC initialization.
>
> Can Lin ming's proposal be applied to the situation that there is no
> ECDT table?
>   
If ECDT exists, we must register EC driver before calls to _INI methods.
in absence of ECDT, we check for EC._INI method as a clue, with the new 
patch,
we check EC._INI only on ASUS, so we will register EC driver early only 
if it is ASUS and has EC._INI.

Regards,
Alex.
>   

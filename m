From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Vortex86SX: only works with irqpoll
Date: Mon, 23 Nov 2009 19:29:20 -0600
Message-ID: <4B0B36F0.30109@gmail.com>
References: <be7a9f3d0911191311p45d4438bg84d55234eacdd320@mail.gmail.com>	 <20091123134002.bac1e664.akpm@linux-foundation.org>	 <4B0B1B62.2030302@gmail.com> <be7a9f3d0911231601p4dcfa519q4d1504a8ee37fdad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:46676 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbZKXB3U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2009 20:29:20 -0500
In-Reply-To: <be7a9f3d0911231601p4dcfa519q4d1504a8ee37fdad@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Otavio Salvador <otavio@ossystems.com.br>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 11/23/2009 06:01 PM, Otavio Salvador wrote:
> Hello,
>
> On Mon, Nov 23, 2009 at 9:31 PM, Robert Hancock<hancockrwd@gmail.com>  wrote:
>> On 11/23/2009 03:40 PM, Andrew Morton wrote:
>>>> [    0.000000] ACPI Error: A valid RSDP was not found
>>>> (20090903/tbxfroot-219)
>>>
>>> No ACPI.
>>>
>>> Please raise a report against acpi_bios@kernel-bugs.osdl.org at
>>> bugzilla.kernel.org, thanks.
>>
>> I believe that just means the machine doesn't support ACPI at all..
>
> Yes; same as me.
>
> Andrew should I report it anyway?
>
>  From Alan message I understand that he believes it is a firmware
> issue. I tried (without success) to contact DM&P about it asking for a
> newer BIOS but nothing yet.
>
> If I could workaround it, it would be nice since it could avoid issues
> for users of those devices. I did research on Internet and found a lot
> of users having the network adaptor not work and like and those
> problems mostly looks like same issue I'm having.

Looking at the BIOS manual on their web site:

ftp://download@ftp.dmp.com.tw/vortex86sx/Vortex86SX_BIOS_Manual.pdf

you can try toggling a few of the options: Try switching OnBoard IDE 
Operate Mode between Legacy Mode and Native Mode. If the kernel and the 
actual device disagree here, that could cause IRQ delivery problems. You 
can also try playing with the "Plug & Play OS" setting.

From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Vortex86SX: only works with irqpoll
Date: Mon, 23 Nov 2009 17:31:46 -0600
Message-ID: <4B0B1B62.2030302@gmail.com>
References: <be7a9f3d0911191311p45d4438bg84d55234eacdd320@mail.gmail.com> <20091123134002.bac1e664.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:62332 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbZKWXbn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2009 18:31:43 -0500
In-Reply-To: <20091123134002.bac1e664.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Otavio Salvador <otavio@ossystems.com.br>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 11/23/2009 03:40 PM, Andrew Morton wrote:
> On Thu, 19 Nov 2009 19:11:49 -0200
> Otavio Salvador<otavio@ossystems.com.br>  wrote:
>
>>
>> I got this machine working booting it with "irqpoll" parameter however
>> it drops the performance a lot and I'd like to try to fix the root
>> problem of it.
>>
>> Without 'irqpoll' the disk and network adaptor doesn't work.
>>
>> ...
>>
>> [    0.000000] ACPI Error: A valid RSDP was not found (20090903/tbxfroot-219)
>
> No ACPI.
>
> Please raise a report against acpi_bios@kernel-bugs.osdl.org at
> bugzilla.kernel.org, thanks.
>

I believe that just means the machine doesn't support ACPI at all..

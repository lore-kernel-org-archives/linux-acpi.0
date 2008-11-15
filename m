From: "Alan Jenkins" <alan-jenkins@tuffmail.co.uk>
Subject: Re: ACPI: EC: GPE storm detected, transactions will use polling mode
Date: Sat, 15 Nov 2008 10:37:05 +0000
Message-ID: <9b2b86520811150237r454b0a38l8d34f0e322573da@mail.gmail.com>
References: <1226722577.3104.4.camel@LiNuX>
	 <20081114224321.ed9b1d7c.akpm@linux-foundation.org>
	 <491E94FD.4090002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:33347 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbYKOKhI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Nov 2008 05:37:08 -0500
Received: by gxk10 with SMTP id 10so470921gxk.13
        for <linux-acpi@vger.kernel.org>; Sat, 15 Nov 2008 02:37:05 -0800 (PST)
In-Reply-To: <491E94FD.4090002@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Justin P. Mattock" <justinmattock@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sat, Nov 15, 2008 at 9:23 AM, Alexey Starikovskiy <aystarik@gmail.com> wrote:
> Andrew Morton wrote:
>>
>> (cc linux-acpi)
>>
>> On Fri, 14 Nov 2008 20:16:17 -0800 "Justin P. Mattock"
>> <justinmattock@gmail.com> wrote:
>>
>>  
>>>
>>> just pulled the latest git today and am now noticing
>>> the lovely gpe storm being triggered.(dmesg below);
>>>    
>>
>> Are any other effects observeable?
>>
>> I assume that 2.6.27 didn't do this.
>>
>>  
>
> It did. Justin even opened a bug -- #11724.

In case anyone else tries to follow that, it's actually #10724 :).

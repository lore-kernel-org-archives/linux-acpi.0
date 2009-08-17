From: Lin Ming <lin@minggr.cn>
Subject: Re: acpi_ex_system_memory_space_handler oops
Date: Mon, 17 Aug 2009 21:22:39 +0800
Message-ID: <d3f22a0908170622x7dd9ce73m5c3ea86406cc9935@mail.gmail.com>
References: <20090812201034.GA2983@localdomain.by>
	 <1250498613.28336.68.camel@minggr.sh.intel.com>
	 <20090817113059.GA3245@localdomain.by>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:62751 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbZHQNWi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Aug 2009 09:22:38 -0400
In-Reply-To: <20090817113059.GA3245@localdomain.by>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Lin Ming <ming.m.lin@intel.com>, "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> Hi, Lin
>
>> 2. Debug kernel patch
>>
>> Currently, we exit the interpreter when setup region, because it may
>> execute control methods, such as _REG.
>>
>> The attached debug kernel patch (region-debug.patch) don't exit the
>> interpreter if the region is temporary, namely, it is defined inside a
>> method.
>>
>
> rc6-git2
> 25 successful reboots.
>
> I'll need some more time to test against rc5.
>
> /*should I also test DSDT in case region-debug.patch fixed the problem?*/

Yes, please also help to test the custome DSDT.
region-debug.patch is just a debug patch.
We need to root cause the problem clearly and then work out a clean solution.

Many thanks.
Lin Ming

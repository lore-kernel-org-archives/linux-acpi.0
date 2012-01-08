From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH]Kconfig:acpi Fix typo in comment.
Date: Sat, 07 Jan 2012 19:51:17 -0800
Message-ID: <4F0912B5.7000808@gmail.com>
References: <1325970608_1267@mail4.comsite.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38499 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab2AHDvV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jan 2012 22:51:21 -0500
In-Reply-To: <1325970608_1267@mail4.comsite.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Milton Miller <miltonm@bga.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On 01/07/2012 01:10 PM, Milton Miller wrote:
> On Tue, 3 Jan 2012 about 08:49:48 -0800, "Justin P. Mattock" wrote:
>
>> The below fixes a typo I found in a comment.
>
> Except its not in a comment that only programmers read, but in the help
> text of a config entry, and so would be eligible for stable.

should I resubmit with a change to the summary?

>
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -374,7 +374,7 @@ config ACPI_CUSTOM_METHOD
>>   	depends on DEBUG_FS
>>   	default n
>>   	help
>> -	  This debug facility allows ACPI AML methods to me inserted and/or
>> +	  This debug facility allows ACPI AML methods to be inserted and/or
>>   	  replaced without rebooting the system. For details refer to:
>>   	  Documentation/acpi/method-customizing.txt.
>>
>
> milton
>


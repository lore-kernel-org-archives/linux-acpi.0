From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
Date: Thu, 07 Dec 2006 22:48:37 +0300
Message-ID: <45787015.3020909@linux.intel.com>
References: <E3C0BCA40296C347AF7142161DB9FC828618B8@mssmsx411> <200612072047.31473.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28255 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935271AbWLGTso (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 14:48:44 -0500
In-Reply-To: <200612072047.31473.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org, "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>

Rafael J. Wysocki wrote:
> Hi,
>
> On Thursday, 7 December 2006 19:57, Karasyov, Konstantin A wrote:
>   
>> Hi,
>>
>> Unfortunately, I cannot reproduce this bug on my system, but the problem
>> could be solved by adding a resume handler for AC adapter device. Could
>> you try the attached patch to see if it helps.
>>     
>
> I can reproduce it and the patch doesn't help.
>
> Greetings,
> Rafael
>
>   
Any ACPI errors in dmesg?

Regards,
    Alex.

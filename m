From: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>
Subject: RE: 2.6.19: ACPI reports AC not present after resume from STD
Date: Thu, 7 Dec 2006 23:40:01 +0300
Message-ID: <8E389A5F2FEABA4CB1DEC35A25CB39CE82FE9F@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:16365 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163312AbWLGUkK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Dec 2006 15:40:10 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org


Please register new bug, attach acpidump and dmesg.


-----Original Message-----
From: Alexey Starikovskiy [mailto:alexey.y.starikovskiy@linux.intel.com]

Sent: Thursday, December 07, 2006 10:49 PM
To: Rafael J. Wysocki
Cc: Karasyov, Konstantin A; Andrey Borzenkov;
linux-acpi@vger.kernel.org; Lebedev, Vladimir P
Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD

Rafael J. Wysocki wrote:
> Hi,
>
> On Thursday, 7 December 2006 19:57, Karasyov, Konstantin A wrote:
>   
>> Hi,
>>
>> Unfortunately, I cannot reproduce this bug on my system, but the
problem
>> could be solved by adding a resume handler for AC adapter device.
Could
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

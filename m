From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: 2.6.24-rc1 and 2.6.24.rc2 hangs while running udev on my laptop
Date: Fri, 9 Nov 2007 10:10:43 -0800
Message-ID: <924EFEDD5F540B4284297C4DC59F3DEE15F8BE@orsmsx423.amr.corp.intel.com>
References: <2C8305E0BE090E47A2BAD52A48AC911D17BCE242@exchange1.lloyd.com> <20071109020321.b26b293f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43081 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbXKISKo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Nov 2007 13:10:44 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20071109020321.b26b293f.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, SANGOI DINO LEONARDO <dino.leonardo.sangoi@allianz.it>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

 

>-----Original Message-----
>From: Andrew Morton [mailto:akpm@linux-foundation.org] 
>Sent: Friday, November 09, 2007 2:03 AM
>To: SANGOI DINO LEONARDO
>Cc: linux-kernel@vger.kernel.org; Rafael J. Wysocki; Brown, 
>Len; Pallipadi, Venkatesh; linux-acpi@vger.kernel.org
>Subject: Re: 2.6.24-rc1 and 2.6.24.rc2 hangs while running 
>udev on my laptop
>
>
>(cc's added)
>
>On Fri, 9 Nov 2007 09:47:02 +0100  SANGOI DINO LEONARDO 
><dino.leonardo.sangoi@allianz.it> wrote:
>
>> Hi,
>>  
>> My laptop (an HP nx6125) doesn't boot with kernels 2.6.24-rc1 and
>> 2.6.24.rc2. 
>> It works fine with 2.6.23 and older.
>> 
>> I seen this bug first while running fedora rawhide, so you 
>can find hardware
>> 
>> info and boot logs at 
>https://bugzilla.redhat.com/show_bug.cgi?id=312201.
>> 
>> I did a git bisect, and got this:
>> 
>> $ git bisect bad
>> 4f86d3a8e297205780cca027e974fd5f81064780 is first bad commit
>> commit 4f86d3a8e297205780cca027e974fd5f81064780
>> Author: Len Brown <len.brown@intel.com>
>> Date:   Wed Oct 3 18:58:00 2007 -0400
>> 
>>     cpuidle: consolidate 2.6.22 cpuidle branch into one patch
>> [SNIP full commit log]
>> 
<snip>
> --------
>> 
>> Config is taken from Fedora kernel. CONFIG_CPU_IDLE is set 
>to y (tell me if
>> full config is needed).
>> 
>> If I use 'nolapic' parameter, kernel 2.6.24-rc1 boots fine. 
>> Setting CONFIG_CPU_IDLE=n also gives me a working kernel.
>> 
>> Ask me if more info is needed (please CC me).
>> 
>> Thanks,
>> 
>> Dino


Dino,

Thanks for all the dumps and information in bugzilla. I am looking at it
to root cause the failure and I should have more updates later today.
Can you also post the full config you are using with rc1 rc2.

Thanks,
Venki

From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: 2.6.25 regression: powertop says 120K wakeups/sec
Date: Mon, 31 Mar 2008 11:34:01 -0700
Message-ID: <924EFEDD5F540B4284297C4DC59F3DEEC84342@orsmsx423.amr.corp.intel.com>
References: <20080322202454.9D69DCC0EF@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <200803281509.23107.david-b@pacbell.net> <20080328225604.GA7136@linux-os.sc.intel.com> <200803290001.18912.rjw@sisk.pl> <47F12289.4030300@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2538 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbYCaSoD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Mar 2008 14:44:03 -0400
Content-class: urn:content-classes:message
In-Reply-To: <47F12289.4030300@rtr.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

 

>-----Original Message-----
>From: Mark Lord [mailto:lkml@rtr.ca] 
>Sent: Monday, March 31, 2008 10:43 AM
>To: Rafael J. Wysocki
>Cc: Pallipadi, Venkatesh; David Brownell; Andrew Morton; 
>linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; Len Brown
>Subject: Re: 2.6.25 regression: powertop says 120K wakeups/sec
>
>Rafael J. Wysocki wrote:
>> On Friday, 28 of March 2008, Venki Pallipadi wrote:
>>> On Fri, Mar 28, 2008 at 03:09:22PM -0700, David Brownell wrote:
>>>> On Friday 28 March 2008, Pallipadi, Venkatesh wrote:
>>>>> You should have a dmesg line which looks like
>>>>> ACPI: CPU0 (power states: C1[C1] C2[C2]
>>>>> Do you see C2 in such line?
>>>> Yes:
>>>>
>>>> ACPI: CPU0 (power states: C1[C1] C2[C2])
>>>
>>> David,
>>>
>>> I think I figured out the bug...
>>>
>>> Can you try the below patch and confirm that it works (over 
>upstream - ignore
>>> the earlier revert patch I sent to you).
>>>
>>> Thanks,
>>> Venki
>>>
>>> ----
>>>
>>>
>>> Patch to fix huge number of wakeups reported due to recent 
>changes in
>>> processor_idle.c. The problem was that the entry_method 
>determination was
>>> broken due to one of the recent commits (bc71bec91f987) causing
>>> C1 entry to not to go to halt. This should also fix the 
>hang reported here.
>>> http://bugzilla.kernel.org/show_bug.cgi?id=10093
>> 
>> Ah, thanks for figuring that out.  As a regression fix, it 
>should go upstream
>> ASAP, I think.
>..
>
>Would this have any applicability to 2.6.24 as well?
>

No. This patch is for a regression that happened post .24.
pre .24 will be a different problem.

Thanks,
Venki

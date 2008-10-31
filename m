From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: Bisection result: eeepc hotk breakage
Date: Fri, 31 Oct 2008 15:04:46 +0000
Message-ID: <490B1E8E.1000606@tuffmail.co.uk>
References: <4907A511.3040603@tuffmail.co.uk> <490B0D48.7040209@suse.de> <490B0DCB.40009@tuffmail.co.uk> <200810311558.53888.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:34784 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbYJaPGP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Oct 2008 11:06:15 -0400
Received: by ey-out-2122.google.com with SMTP id 6so459614eyi.37
        for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2008 08:04:52 -0700 (PDT)
In-Reply-To: <200810311558.53888.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Alexey Starikovskiy <aystarik@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, Matthew Wilcox <willy@linux.intel.com>

Rafael J. Wysocki wrote:
> On Friday, 31 of October 2008, Alan Jenkins wrote:
>   
>> Alexey Starikovskiy wrote:
>>     
>>> Alan Jenkins wrote:
>>>       
>>>> Alexey Starikovskiy wrote:
>>>>         
>>>>> Alan Jenkins wrote:
>>>>>           
>>>>>> Well, that didn't work.
>>>>>>             
>>>>> Pity...
>>>>> Could you produce a debug log from EC?
>>>>> Probably it's a good time to open a new bug report...
>>>>>           
>>>> <http://bugzilla.kernel.org/show_bug.cgi?id=11917>
>>>> "Asus Eee PC hotkeys stop working after prolonged usage"
>>>>
>>>> I stuck at it, found a reliable test and bisected successfully.
>>>> 2.6.28-rc2 is broken, but I can fix it by reverting the bad commit.
>>>> (There were some conflicts, I fixed up the dock driver manually and
>>>> avoided building the rest).
>>>>         
>>> Alan, to make things clear -- reverting following commit makes EC work
>>> without
>>> a problem?
>>>
>>>       
>> Yes, that's right.
>>     
>
> Hm, so in fact it _is_ a regression from 2.6.27 (this commit could not be
> present in that kernel).
>   

Yes, I suppose it is distinct from the previous EC regression.

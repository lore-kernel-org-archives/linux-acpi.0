From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: Bisection result: eeepc hotk breakage
Date: Fri, 31 Oct 2008 15:46:43 +0000
Message-ID: <490B2863.7040602@tuffmail.co.uk>
References: <4907A511.3040603@tuffmail.co.uk> <4907A856.3050204@gmail.com> <4908307C.8060503@tuffmail.co.uk> <49086F67.1030607@suse.de> <490872BF.2010908@tuffmail.co.uk> <4908C714.5040104@tuffmail.co.uk> <4908C8EB.1010403@suse.de> <490ADD62.7090507@tuffmail.co.uk> <490B0D48.7040209@suse.de> <490B0DCB.40009@tuffmail.co.uk> <490B12F2.9050903@suse.de> <490B132A.3000904@tuffmail.co.uk> <490B1C3C.2080305@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:56733 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbYJaPrb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Oct 2008 11:47:31 -0400
Received: by ey-out-2122.google.com with SMTP id 6so470860eyi.37
        for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2008 08:46:48 -0700 (PDT)
In-Reply-To: <490B1C3C.2080305@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, Matthew Wilcox <willy@linux.intel.com>

Alexey Starikovskiy wrote:
> Alan Jenkins wrote:
>> Alexey Starikovskiy wrote:
>>> Alan Jenkins wrote:
>>>> Alexey Starikovskiy wrote:
>>>>> Alan Jenkins wrote:
>>>>>> Alexey Starikovskiy wrote:
>>>>>>> Alan Jenkins wrote:
>>>>>>>> Well, that didn't work.
>>>>>>> Pity...
>>>>>>> Could you produce a debug log from EC?
>>>>>>> Probably it's a good time to open a new bug report...
>>>>>> <http://bugzilla.kernel.org/show_bug.cgi?id=11917>
>>>>>> "Asus Eee PC hotkeys stop working after prolonged usage"
>>>>>>
>>>>>> I stuck at it, found a reliable test and bisected successfully.
>>>>>> 2.6.28-rc2 is broken, but I can fix it by reverting the bad commit.
>>>>>> (There were some conflicts, I fixed up the dock driver manually and
>>>>>> avoided building the rest).
>>>>> Alan, to make things clear -- reverting following commit makes EC
>>>>> work
>>>>> without
>>>>> a problem?
>>>>>
>>>>
>>>> Yes, that's right.
>>> Great!
>>> What kernel version is that -- 32 or 64?
>>
>> 32 bit, my EeePC doesn't do 64.
> is the attached patch enough to fix ?
>
Nice.  Yes, that fixes it, thanks!

I checked the commit diff for any similar potential errors.  Most of the
changes are "obviously correct".  However, there are changes in
thermal.c which look similar to the one that caused the problem in the
EC driver.

I think someone knowledgeable needs to audit the changes to the thermal
driver, in case the Thinkpads start melting again :-P.  The commit#
again: 27663c5855b10af9ec67bc7dfba001426ba21222.

Alan

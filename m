From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI / blacklist: disable Win8 mode for ThinkPad X201
 and Latitude E6230
Date: Wed, 11 Dec 2013 08:26:27 +0800
Message-ID: <52A7B133.3080809@intel.com>
References: <52A15F72.1050408@intel.com> <20131209165817.GA30717@srcf.ucam.org> <52A684F1.7070502@intel.com> <20131210170124.GA26978@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59478 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157Ab3LKA0Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Dec 2013 19:26:24 -0500
In-Reply-To: <20131210170124.GA26978@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Jeffery To <jeffery.to@gmail.com>, Wouter Depypere <wouter.depypere@ugent.be>

On 12/11/2013 01:01 AM, Matthew Garrett wrote:
> On Tue, Dec 10, 2013 at 11:05:21AM +0800, Aaron Lu wrote:
>> On 12/10/2013 12:58 AM, Matthew Garrett wrote:
>>> On Fri, Dec 06, 2013 at 01:24:02PM +0800, Aaron Lu wrote:
>>>>  	/*
>>>> +	 * The bluetooth functionality is unconditionally enabled
>>>> +	 * after a S3 cycle on Thinkpad X201 under Win8 mode.
>>>> +	 */
>>>
>>> Can you describe this in a little more detail? Does the thinkpad-acpi 
>>> rfkill code just not work?
>>
>> Yes it works, the problem is, even the bluetooth is disabled before
>> hibernate, it will be enabled after resume.
> 
> Ok. thinkpad_acpi should be ensuring that the state is the same before 
> and after resume. I don't think it's worth working around this in the 
> core.
> 
>>>> +	/*
>>>> +	 * The hardware switch for enable/disable wifi on
>>>> +	 * Dell Latitude E6230 is broken under Win8 mode.
>>>> +	 */
>>>
>>> Can you define "broken"? Do you see the same behaviour under Windows 8?
>>
>> As Wouter has put in comment #12:
>> "
>> I also have trouble with this commit, it disables my hardware switch for
>> enable/disable wifi. See [1] for full explanation.
>>
>> When I add acpi_osi="!Windows 2012" it fixes my issue.
>> "
> 
> I'd like to be able to dig into this rather than just going straight to 
> blacklisting.

Sure, I'll re-assign that bug to Drivers/Platform then, thanks for
helping.

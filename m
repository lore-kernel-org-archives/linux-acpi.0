From: david@lang.hm
Subject: Re: [Fwd: Re: long-term regression - Parallel Port broken?]
Date: Sat, 21 Jul 2007 19:04:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707211902180.6747@asgard.lang.hm>
References: <1183030080.4249.172.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:52311
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbXGVCKZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Jul 2007 22:10:25 -0400
In-Reply-To: <1183030080.4249.172.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>

On Thu, 28 Jun 2007, Thomas Renninger wrote:

> Hi David,
>
> Could this problem have to do with this one:
> https://bugzilla.novell.com/show_bug.cgi?id=180390
> Tell me if you have problems accessing the bug, it should be public.
> Unfortunately the ongoing of the bug stopped a bit for various reasons.

it's requireing a login, and I'm not particularly eager to play 20 guesses 
to find a userid that's not already in use.

> The first comments pointed in the wrong direction, it's getting
> interesting when Vojtech joined the conversation and things pointed to
> acpi, possibly acpipnp.
>
> First a collection of acpidump outputs of affected machines would be
> great, hopefully other reporters start helping again...

how do I generate an acpidump?

David Lang

> If it is the same bug, it's interesting that 2.6.18-rc3 worked for you
> (vanilla or gentoo?). Because SLE[DS]10 is 2.6.16 based, we could have
> backported the bug and that might help finding it?
>
> Thanks,
>
>   Thomas
>
> PS: I stripped the CC list, things seem to point to acpi...
>
> PSS: Has there already been a bug at bugzilla.kernel.org opened where
> dmesg, acpidump and other info can be reviewed? If not this should be
> done.
>
> On Wed, 2007-06-27 at 09:19 -0700, Randy Dunlap wrote:
>> [adding linux-acpi@vger.kernel.org]
>>
>> On Wed, 27 Jun 2007 00:38:17 -0700 (PDT) david@lang.hm wrote:
>>
>>> On Tue, 26 Jun 2007, Randy Dunlap wrote:
>>>
>>>> On Mon, 25 Jun 2007 15:56:17 -0700 (PDT) david@lang.hm wrote:
>>>>
>>>>> due to the size the files are posted at http://linux.lang.hm/linux
>>>>>
>>>>> let me know what else I can send to help.
>>>>>
>>>>> David Lang
>>>>
>>>>
>>>> I suggest that you test 2.6.22-rcN using one or both of these
>>>> boot options:
>>>>
>>>> noisapnp
>>>> pnpacpi=off
>>>>
>>>> Somewhere between 2.6.18 and 2.6.22-development, the ACPI config
>>>> symbol also starting enabling (selecting) PNP.  That's one of many
>>>> differences....
>>>
>>> with the 2.6.22-rc4 kernel that I was useing earlier, adding these two
>>> options clears up the problem. Thanks.
>>>
>>> should I test the two individually? or just plan on useing both from now
>>> on?
>>
>> Yes, please test them individually.  I expect that just one of them
>> will suffice, but I don't know which one.
>>
>>> I normally disable PnP (both ISA and PCI), should I leave it enabled with
>>> the newer kernels and this motherboard?
>>
>> ACPI recently began enabling (selecting) PNP for you...
>>
>> How do you normally disable PCI PNP?
>>
>> What kind of hardware is this?  Please show us lspci output.
>>
>>>> I would also disable CONFIG_USB_USS720, at least for testing.
>>>
>>> for ease of testing (I got time to reboot the box around midnight) I used
>>> the same config as before, so this is still on.
>>>
>>> David Lang
>>>
>>>>
>>>>> On Mon, 25 Jun 2007, Randy Dunlap wrote:
>>>>>
>>>>>> Date: Mon, 25 Jun 2007 15:40:28 -0700
>>>>>> From: Randy Dunlap <randy.dunlap@oracle.com>
>>>>>> To: david@lang.hm
>>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
>>>>>>     linux-usb-devel@lists.sourceforge.net
>>>>>> Subject: Re: long-term regression
>>>>>>
>>>>>> david@lang.hm wrote:
>>>>>>>  On Thu, 21 Jun 2007, Randy Dunlap wrote:
>>>>>>>
>>>>>>>>  Date: Thu, 21 Jun 2007 08:36:59 -0700
>>>>>>>>  From: Randy Dunlap <randy.dunlap@oracle.com>
>>>>>>>>  To: Andrew Morton <akpm@linux-foundation.org>
>>>>>>>>  Cc: david@lang.hm, linux-kernel@vger.kernel.org,
>>>>>>>>      linux-usb-devel@lists.sourceforge.net
>>>>>>>>  Subject: Re: long-term regression
>>>>>>>>
>>>>>>>>  On Thu, 21 Jun 2007 05:28:07 -0700 Andrew Morton wrote:
>>>>>>>>
>>>>>>>>>>  On Sun, 17 Jun 2007 10:57:55 -0700 (PDT) david@lang.hm wrote:
>>>>>>>>>>  I haven't had time to bisect this, but I'm having a problem on a
>>>>>>>>>>  AMD64
>>>>>>>>>>  gentoo system where the printer doesn't work with recent kernels.
>>>>>>>>>>
>>>>>>>>>>  2.6.18-rc3 worked
>>>>>>>>>>  2.6.21.1 doesn't
>>>>>>>>>>  2.6.22-rc4 doesn't
>>>>>>>>>>
>>>>>>>>>>  unfortunantly the system is gooted on 2.6.18 at the moment and I'm
>>>>>>>>>>  out of
>>>>>>>>>>  town so my ability to test is limited I can provide the 2.6.22-rc4
>>>>>>>>>>  (attached) and 2.6.18-rc3 configs.
>>>>>>>>>>
>>>>>>>>>>  dmesg appears to show the port being detected, but writes to the
>>>>>>>>>>  port
>>>>>>>>>>  under newer kernels appear to complete, but no data gets to the
>>>>>>>>>>  printer.
>>>>>>>>>>
>>>>>>>>>>  any suggestions other then doing the large bisect?
>>>>>>>>>
>>>>>>>>>  That would be good, thanks.  Please be sure to cc linux-usb-devel on
>>>>>>>>>  the results.
>>>>>>>>
>>>>>>>>  OK, I'm curious about how someone deduced that this is a problem
>>>>>>>>  with a USB printer vs. parallel port printer since the config file has:
>>>>>>>>
>>>>>>>>  CONFIG_PRINTER=y
>>>>>>>>  CONFIG_USB_PRINTER=y
>>>>>>>>
>>>>>>>>  The kernel boot log should probably be posted also.
>>>>>>>
>>>>>>>  here is the dmesg from 2.6.22-rc4 and kern.log showing 2.6.22.-rc4 and
>>>>>>>  2.6.180rc3
>>>>>>>
>>>>>>>  the printer not working is the parallel port.
>>>>>>
>>>>>> This email didn't show up on lkml or linux-usb-devel due to size limits (it
>>>>>> was 900+ KB).
>>>>>>
>>>>>> David, please send your working 2.6.18 config file.
>>>>>>
>>>>>> Can you post the kernel log files on the web somewhere?
>>
>> ---
>
>
>

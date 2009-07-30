From: =?UTF-8?B?Q8OpZHJpYyBHb2Rpbg==?= <cedric@belbone.be>
Subject: Re: [Bug 13865] Can only resume with HP_WMI selected on compaq nc6000
 when 4c395bdd3f2ca8f7e8efad881e16071182c3b8ca is reverted
Date: Thu, 30 Jul 2009 11:20:24 +0200
Message-ID: <4A7165D8.8060705@belbone.be>
References: <bug-13865-10028@http.bugzilla.kernel.org/> <200907292257.41573.rjw@sisk.pl> <200907292331.34214.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:56811 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750924AbZG3JUZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Jul 2009 05:20:25 -0400
In-Reply-To: <200907292331.34214.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: bugzilla-daemon@bugzilla.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

Frans Pop wrote:
> On Wednesday 29 July 2009, Rafael J. Wysocki wrote:
>   
>> On Wednesday 29 July 2009, you wrote:
>>     
>>> Just for testing I enabled HP_WMI. But from then, I could not resume
>>> anymore. I just reverted the last git commit on the
>>> 'drivers/platform/x86/hp-wmi.c' code
>>> (4c395bdd3f2ca8f7e8efad881e16071182c3b8ca) and now I can resume. The
>>> problem still persists on .31-rc serie
>>>       
>> Frans, that's something for you to take care of.
>>     
>
> I'll at least give it a try.
>
> Cedric, as a start, can you please provide the output of the following 
> commands after the system is booted and with hp-wmi loaded:
> $ grep . /sys/devices/platform/hp-wmi/*
> $ ls -l /dev/input/*
> $ cat /proc/bus/input/devices
>
> Does an unload and reload of the module work correctly? What gets output 
> in dmesg by that?
>
> The strange thing is that the resume function does not do anything that's 
> not also done in hp_wmi_input_setup(). The only thing I can think of is 
> that we might need to test for wmi_has_guid(HPWMI_EVENT_GUID) because 
> that model simply does not support input events.
>
> Cheers,
> FJP
>   
I tested your patch (from buzilla) and now I can resume.

Thanks ! You have my tested-by ;-)

PS: I suppose you don't need this infos anymore ?

From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
Subject: Re: Problems since commit Recognize that Interrupt Line 255 means
 "not connected"
Date: Mon, 15 Feb 2016 11:02:48 +0800
Message-ID: <56C13FD8.9080409@cn.fujitsu.com>
References: <56B52990.3030103@gmail.com>	<1676062.Zh6hUgWIix@vostro.rjw.lan>	<56B5AA4B.5040705@gmail.com>	<20160206151922.GB22119@localhost>	<56B61492.40507@gmail.com>	<20160209164435.GB20171@localhost> <CAJZ5v0huANzD29-oB9tpQXodx936MtRf+316PYPAuYh1h_Pa+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:56300 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751519AbcBODIL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Feb 2016 22:08:11 -0500
In-Reply-To: <CAJZ5v0huANzD29-oB9tpQXodx936MtRf+316PYPAuYh1h_Pa+w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>


On 02/10/2016 03:24 AM, Rafael J. Wysocki wrote:
> On Tue, Feb 9, 2016 at 5:44 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Sat, Feb 06, 2016 at 04:43:14PM +0100, Heiner Kallweit wrote:
>>> Am 06.02.2016 um 16:19 schrieb Bjorn Helgaas:
>>>> On Sat, Feb 06, 2016 at 09:09:47AM +0100, Heiner Kallweit wrote:
>>>>> Am 06.02.2016 um 00:37 schrieb Rafael J. Wysocki:
>>>>>> On Saturday, February 06, 2016 12:00:32 AM Heiner Kallweit wrote:
>>>>>>> Since commit a44c386a361e "x86/PCI/ACPI: Recognize that Interrupt Line 255
>>>>>>> means "not connected"" I get several "PCI INT not connected" warnings on
>>>>>>> a Zotac CI321 and EHCI failes to load:
>>>>>> That doesn't follow clearly from your report, but I'm assuming that it works
>>>>>> correctly without that commit, right?
>>>>>>
>>>>> Right, w/o this commit it looks like this:
>>>>>
>>>>> dmesg
>>>>> ehci-pci 0000:00:1d.0: irq 23, io mem 0xf7d1b000
>>>>>
>>>>> /proc/interrupts
>>>>> IO-APIC  23-fasteoi   ehci_hcd:usb3
>>>> Thanks a lot for your report!  This is a bit of a minefield, and I was
>>>> worried that we'd trip over something with a44c386a361e.
>>>>
>>>> Oops, I think I see a problem with a44c386a361e.  We're checking for
>>>> Interrupt Line == 255 even before we try to look it up in the _PRT.  I
>>>> think we should only check Interrupt Line *after* everything else has
>>>> failed.  Can you try the patch below instead of a44c386a361e?
>>>>
>>> With the attached patch everything is fine. No warnings and EHCI loads properly.
>> Great, thanks a lot for testing this!
>>
>> Chen, will you update and repost your patch?  I know Rafael already
>> had it on a branch, but I think he dropped it, so we need to get the
>> update merged somehow.
> I'd prefer a new updated patch if that's possible.
patch is coming soon, thank all of your help.

Chen
>
> Thanks,
> Rafael
>
>
>




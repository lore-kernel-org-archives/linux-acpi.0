From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [3.1-rc6] kmalloc(64) leak from IDE
Date: Fri, 23 Sep 2011 10:40:25 -0600
Message-ID: <CAErSpo5xK8iExuaNdHejRBjVYEXAjbyJ8V0FGZA0QUA8LB-wFA@mail.gmail.com>
References: <20110922072643.GA27232@hostway.ca> <20110922084811.GC17640@liondog.tnic>
 <20110922202337.GB32661@hostway.ca> <20110923072118.GA13293@liondog.tnic>
 <j5iab7$j8m$1@dough.gmane.org> <CAErSpo4H9_Fwyic9crHTGwWaDk5bevK7r6pTb+tpMFxHZ2MajQ@mail.gmail.com>
 <4E7CB522.6080208@itwm.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:49752 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab1IWQks convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Sep 2011 12:40:48 -0400
Received: from hpaq7.eem.corp.google.com (hpaq7.eem.corp.google.com [172.25.149.7])
	by smtp-out.google.com with ESMTP id p8NGelMK014042
	for <linux-acpi@vger.kernel.org>; Fri, 23 Sep 2011 09:40:47 -0700
Received: from gyf2 (gyf2.prod.google.com [10.243.50.66])
	by hpaq7.eem.corp.google.com with ESMTP id p8NGdKCC026706
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 23 Sep 2011 09:40:46 -0700
Received: by gyf2 with SMTP id 2so4237664gyf.27
        for <linux-acpi@vger.kernel.org>; Fri, 23 Sep 2011 09:40:45 -0700 (PDT)
In-Reply-To: <4E7CB522.6080208@itwm.fraunhofer.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Sep 23, 2011 at 10:34 AM, Bernd Schubert
<bernd.schubert@itwm.fraunhofer.de> wrote:
> On 09/23/2011 06:08 PM, Bjorn Helgaas wrote:
>>
>> On Fri, Sep 23, 2011 at 9:58 AM, Bernd Schubert
>> <bernd.schubert@itwm.fraunhofer.de> =A0wrote:
>>>
>>> On 09/23/2011 09:21 AM, Borislav Petkov wrote:
>>>>
>>>> On Thu, Sep 22, 2011 at 01:23:37PM -0700, Simon Kirby wrote:
>>>>>
>>>>> Yes, that seems to have made it stop complaining about the IDE pa=
th.
>>>>
>>>> Good, thanks for testing. It would be great if you left it running=
 for
>>>> a couple of days like this to see whether there aren't any other i=
ssues
>>>> with the patch. I'll send it with a proper description to Dave soo=
nish
>>>> since this is a real bug.
>>>>
>>>>> All I see from kmemleak now is:
>>>>
>>>> Yep, not IDE-related. Adding linux-acpi.
>>>
>>>
>>>>
>>>>> unreferenced object 0xe7481a00 (size 256):
>>>>> =A0 comm "swapper", pid 1, jiffies 4294892509 (age 515.560s)
>>>>> =A0 hex dump (first 32 bytes):
>>>>> =A0 =A0 00 00 00 28 ff ff ef ff 60 78 4e e7 00 02 00 00 =A0...(..=
=2E.`xN.....
>>>>> =A0 =A0 47 01 f8 0c f8 0c 01 08 00 00 00 00 0c 03 00 00 =A0G.....=
=2E.........
>>>>> =A0 backtrace:
>>>>> =A0 =A0 [<c1495c47>] kmemleak_alloc+0x27/0x50
>>>>> =A0 =A0 [<c10b3563>] __kmalloc+0xf3/0x1c0
>>>>> =A0 =A0 [<c149e0b0>] pci_acpi_scan_root+0x11e/0x272
>>>>> =A0 =A0 [<c149916b>] acpi_pci_root_add+0x163/0x256
>>>>> =A0 =A0 [<c12adddc>] acpi_device_probe+0x3a/0xf4
>>>>> =A0 =A0 [<c1302e38>] driver_probe_device+0x68/0x160
>>>>> =A0 =A0 [<c1302fb9>] __driver_attach+0x89/0x90
>>>>> =A0 =A0 [<c1302718>] bus_for_each_dev+0x48/0x70
>>>>> =A0 =A0 [<c1302cc9>] driver_attach+0x19/0x20
>>>>> =A0 =A0 [<c130213f>] bus_add_driver+0x17f/0x240
>>>>> =A0 =A0 [<c1303345>] driver_register+0x65/0x120
>>>>> =A0 =A0 [<c12af273>] acpi_bus_register_driver+0x3a/0x3f
>>>>> =A0 =A0 [<c16d421f>] acpi_pci_root_init+0x1b/0x2a
>>>>> =A0 =A0 [<c1001030>] do_one_initcall+0x30/0x160
>>>>> =A0 =A0 [<c16b920b>] kernel_init+0x78/0x10c
>>>>> =A0 =A0 [<c14a1b76>] kernel_thread_helper+0x6/0xd
>>>>> unreferenced object 0xe74e7860 (size 16):
>>>>> =A0 comm "swapper", pid 1, jiffies 4294892509 (age 515.560s)
>>>>> =A0 hex dump (first 16 bytes):
>>>>> =A0 =A0 50 43 49 20 42 75 73 20 30 30 30 30 3a 30 30 00 =A0PCI Bu=
s 0000:00.
>>>>> =A0 backtrace:
>>>>> =A0 =A0 [<c1495c47>] kmemleak_alloc+0x27/0x50
>>>>> =A0 =A0 [<c10b3563>] __kmalloc+0xf3/0x1c0
>>>>> =A0 =A0 [<c1290cce>] kvasprintf+0x2e/0x50
>>>>> =A0 =A0 [<c1290d01>] kasprintf+0x11/0x20
>>>>> =A0 =A0 [<c149e0da>] pci_acpi_scan_root+0x148/0x272
>>>>> =A0 =A0 [<c149916b>] acpi_pci_root_add+0x163/0x256
>>>>> =A0 =A0 [<c12adddc>] acpi_device_probe+0x3a/0xf4
>>>>> =A0 =A0 [<c1302e38>] driver_probe_device+0x68/0x160
>>>>> =A0 =A0 [<c1302fb9>] __driver_attach+0x89/0x90
>>>>> =A0 =A0 [<c1302718>] bus_for_each_dev+0x48/0x70
>>>>> =A0 =A0 [<c1302cc9>] driver_attach+0x19/0x20
>>>>> =A0 =A0 [<c130213f>] bus_add_driver+0x17f/0x240
>>>>> =A0 =A0 [<c1303345>] driver_register+0x65/0x120
>>>>> =A0 =A0 [<c12af273>] acpi_bus_register_driver+0x3a/0x3f
>>>>> =A0 =A0 [<c16d421f>] acpi_pci_root_init+0x1b/0x2a
>>>>> =A0 =A0 [<c1001030>] do_one_initcall+0x30/0x160
>>>>>
>>>>> ...which is probably a separate, non-recurring leak.
>>>>>
>>>>>> Also, I'm sure you know IDE is deprecated, so what are the chanc=
es of
>>>>>> moving this box to libata? Also, can you send me your .config pl=
s?
>>>>>
>>>>> Yeah, I was going to get around to that eventually. :) Config (an=
d
>>>>> earlier kmemleak output) here: http://0x.ca/sim/ref/3.1-rc6-blue/
>>>>
>>>> Ok, thanks.
>>>>
>>>
>>> I think I reported those already some time ago:
>>>
>>> https://lkml.org/lkml/2011/6/21/95
>>
>> Rats. =A0And you even posted a patch
>> (https://lkml.org/lkml/2011/6/21/132). =A0I was cc'd, but unfortunat=
ely
>> to an old email address that no longer works. =A0I'll follow up on i=
t
>> and make sure it's fixed (probably in 3.2 since it's minor and we're
>> so late in 3.1).
>
> Ah great, I thought you are simply too busy to look into it. We are a=
ll just
> changing our mail addresses too often :)
>
> Do you mind if I ping you directly once kernel.org is up again? We ha=
ve a
> few test systems here, that fail to boot with recent kernels (just a =
system
> hard reset). The issue was introduced in between 2.6.27 and 2.6.32 an=
d it is
> pci mmconfig related, probably due to a troublesome acpi bios. I fill=
ed a
> bugzilla some time ago and never got a responds on it. But I also nee=
d to
> update it with my latest finding...

Please do, and you don't need to wait for kernel.org to come back
(though it'd be good to include any bugzilla URLs if you know them).
Just email me and copy linux-pci (since it seems PCI
MMCONFIG-related), and we can try to make some progress.  It's very
important to fix regressions as quickly as possible.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

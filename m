From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [3.1-rc6] kmalloc(64) leak from IDE
Date: Fri, 23 Sep 2011 10:08:49 -0600
Message-ID: <CAErSpo4H9_Fwyic9crHTGwWaDk5bevK7r6pTb+tpMFxHZ2MajQ@mail.gmail.com>
References: <20110922072643.GA27232@hostway.ca> <20110922084811.GC17640@liondog.tnic>
 <20110922202337.GB32661@hostway.ca> <20110923072118.GA13293@liondog.tnic> <j5iab7$j8m$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:31026 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab1IWQJN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Sep 2011 12:09:13 -0400
Received: from hpaq12.eem.corp.google.com (hpaq12.eem.corp.google.com [172.25.149.12])
	by smtp-out.google.com with ESMTP id p8NG9Cx8015295
	for <linux-acpi@vger.kernel.org>; Fri, 23 Sep 2011 09:09:12 -0700
Received: from gwj20 (gwj20.prod.google.com [10.200.10.20])
	by hpaq12.eem.corp.google.com with ESMTP id p8NG8rpN011792
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 23 Sep 2011 09:09:10 -0700
Received: by gwj20 with SMTP id 20so4592257gwj.26
        for <linux-acpi@vger.kernel.org>; Fri, 23 Sep 2011 09:09:10 -0700 (PDT)
In-Reply-To: <j5iab7$j8m$1@dough.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Sep 23, 2011 at 9:58 AM, Bernd Schubert
<bernd.schubert@itwm.fraunhofer.de> wrote:
> On 09/23/2011 09:21 AM, Borislav Petkov wrote:
>>
>> On Thu, Sep 22, 2011 at 01:23:37PM -0700, Simon Kirby wrote:
>>>
>>> Yes, that seems to have made it stop complaining about the IDE path=
=2E
>>
>> Good, thanks for testing. It would be great if you left it running f=
or
>> a couple of days like this to see whether there aren't any other iss=
ues
>> with the patch. I'll send it with a proper description to Dave sooni=
sh
>> since this is a real bug.
>>
>>> All I see from kmemleak now is:
>>
>> Yep, not IDE-related. Adding linux-acpi.
>
>
>>
>>> unreferenced object 0xe7481a00 (size 256):
>>> =A0 comm "swapper", pid 1, jiffies 4294892509 (age 515.560s)
>>> =A0 hex dump (first 32 bytes):
>>> =A0 =A0 00 00 00 28 ff ff ef ff 60 78 4e e7 00 02 00 00 =A0...(....=
`xN.....
>>> =A0 =A0 47 01 f8 0c f8 0c 01 08 00 00 00 00 0c 03 00 00 =A0G.......=
=2E.......
>>> =A0 backtrace:
>>> =A0 =A0 [<c1495c47>] kmemleak_alloc+0x27/0x50
>>> =A0 =A0 [<c10b3563>] __kmalloc+0xf3/0x1c0
>>> =A0 =A0 [<c149e0b0>] pci_acpi_scan_root+0x11e/0x272
>>> =A0 =A0 [<c149916b>] acpi_pci_root_add+0x163/0x256
>>> =A0 =A0 [<c12adddc>] acpi_device_probe+0x3a/0xf4
>>> =A0 =A0 [<c1302e38>] driver_probe_device+0x68/0x160
>>> =A0 =A0 [<c1302fb9>] __driver_attach+0x89/0x90
>>> =A0 =A0 [<c1302718>] bus_for_each_dev+0x48/0x70
>>> =A0 =A0 [<c1302cc9>] driver_attach+0x19/0x20
>>> =A0 =A0 [<c130213f>] bus_add_driver+0x17f/0x240
>>> =A0 =A0 [<c1303345>] driver_register+0x65/0x120
>>> =A0 =A0 [<c12af273>] acpi_bus_register_driver+0x3a/0x3f
>>> =A0 =A0 [<c16d421f>] acpi_pci_root_init+0x1b/0x2a
>>> =A0 =A0 [<c1001030>] do_one_initcall+0x30/0x160
>>> =A0 =A0 [<c16b920b>] kernel_init+0x78/0x10c
>>> =A0 =A0 [<c14a1b76>] kernel_thread_helper+0x6/0xd
>>> unreferenced object 0xe74e7860 (size 16):
>>> =A0 comm "swapper", pid 1, jiffies 4294892509 (age 515.560s)
>>> =A0 hex dump (first 16 bytes):
>>> =A0 =A0 50 43 49 20 42 75 73 20 30 30 30 30 3a 30 30 00 =A0PCI Bus =
0000:00.
>>> =A0 backtrace:
>>> =A0 =A0 [<c1495c47>] kmemleak_alloc+0x27/0x50
>>> =A0 =A0 [<c10b3563>] __kmalloc+0xf3/0x1c0
>>> =A0 =A0 [<c1290cce>] kvasprintf+0x2e/0x50
>>> =A0 =A0 [<c1290d01>] kasprintf+0x11/0x20
>>> =A0 =A0 [<c149e0da>] pci_acpi_scan_root+0x148/0x272
>>> =A0 =A0 [<c149916b>] acpi_pci_root_add+0x163/0x256
>>> =A0 =A0 [<c12adddc>] acpi_device_probe+0x3a/0xf4
>>> =A0 =A0 [<c1302e38>] driver_probe_device+0x68/0x160
>>> =A0 =A0 [<c1302fb9>] __driver_attach+0x89/0x90
>>> =A0 =A0 [<c1302718>] bus_for_each_dev+0x48/0x70
>>> =A0 =A0 [<c1302cc9>] driver_attach+0x19/0x20
>>> =A0 =A0 [<c130213f>] bus_add_driver+0x17f/0x240
>>> =A0 =A0 [<c1303345>] driver_register+0x65/0x120
>>> =A0 =A0 [<c12af273>] acpi_bus_register_driver+0x3a/0x3f
>>> =A0 =A0 [<c16d421f>] acpi_pci_root_init+0x1b/0x2a
>>> =A0 =A0 [<c1001030>] do_one_initcall+0x30/0x160
>>>
>>> ...which is probably a separate, non-recurring leak.
>>>
>>>> Also, I'm sure you know IDE is deprecated, so what are the chances=
 of
>>>> moving this box to libata? Also, can you send me your .config pls?
>>>
>>> Yeah, I was going to get around to that eventually. :) Config (and
>>> earlier kmemleak output) here: http://0x.ca/sim/ref/3.1-rc6-blue/
>>
>> Ok, thanks.
>>
>
> I think I reported those already some time ago:
>
> https://lkml.org/lkml/2011/6/21/95

Rats.  And you even posted a patch
(https://lkml.org/lkml/2011/6/21/132).  I was cc'd, but unfortunately
to an old email address that no longer works.  I'll follow up on it
and make sure it's fixed (probably in 3.2 since it's minor and we're
so late in 3.1).

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

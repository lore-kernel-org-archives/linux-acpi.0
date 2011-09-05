From: Huang Ying <ying.huang@intel.com>
Subject: Re: APEI: Can not request iomem region for GARs
Date: Mon, 05 Sep 2011 10:05:42 +0800
Message-ID: <4E642E76.4010309@intel.com>
References: <CAG1a4rs4Cr1z50gGuK9SLE6aOvibE1sdV_GSLPv+gqYC8g+ORQ@mail.gmail.com> <CAErSpo4FfBoGDUquoLNsJ9=z-M-x6NQgP8xJL_VqEXpsL2H5PA@mail.gmail.com> <4E520149.3010802@intel.com> <CAG1a4rtMnDXSGLkmwE+6N9smoghWp0W4b5-X_gogzJ9fDLTeBg@mail.gmail.com> <4E571D66.1070302@intel.com> <CAG1a4rtckCtpNjg9ApiLt4zQWArAu7N2ivoiMjueqYDRrr-G+g@mail.gmail.com> <4E5B258D.9090904@intel.com> <CAG1a4rtXhK-TtgayUDBK34kB2rEHUSN_6ZEX2B6Zg2-GprwCEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24570 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab1IECFo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 4 Sep 2011 22:05:44 -0400
In-Reply-To: <CAG1a4rtXhK-TtgayUDBK34kB2rEHUSN_6ZEX2B6Zg2-GprwCEA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Ivanov <paivanof@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 09/03/2011 10:44 AM, Pavel Ivanov wrote:
> On Mon, Aug 29, 2011 at 1:37 AM, Huang Ying <ying.huang@intel.com> wrote:
>> On 08/27/2011 11:28 AM, Pavel Ivanov wrote:
>>> Also I noticed there's another suspicious message in dmesg and it was
>>> there earlier too (although it's not shown on console):
>>>
>>> GHES: Failed to enable APEI firmware first mode
>>>
>>> Is it bad? What does it mean?
>>
>> Maybe this has been fixed, please this patch,
>>
>> https://lkml.org/lkml/2011/8/11/297
> 
> Yes, this patch indeed fixed this failure message. It's now replaced by
> 
> GHES: APEI firmware first mode is enabled by WHEA _OSC.
> 
> Can I ask you another question: what does the following message mean?
> 
> [Firmware Warn]: GHES: Poll interval is 0 for generic hardware error
> source: 1, disabled.

This means:

The generic hardware error source with ID 1 is notified by poll, that
is, Linux should poll the specified address to check whether there is
hardware error report from hardware.  But the poll interval specified by
firmware is "0".  I think this should be a firmware error, and disabled
it.  I think maybe you can contact firmware vendor to fix this.

Best Regards,
Huang Ying

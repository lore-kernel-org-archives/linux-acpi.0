From: Ike Panhc <ike.pan@canonical.com>
Subject: Re: [Resend] [PATCH] asus-laptop: add Lenovo SL LenovoCare LED 	support
Date: Wed, 09 Dec 2009 14:53:23 +0800
Message-ID: <4B1F4963.3070405@canonical.com>
References: <1260257829-7343-1-git-send-email-ike.pan@canonical.com>	 <20091208154154.GA26435@srcf.ucam.org> <71cd59b00912080932nf334ba7uf65c70178fec41a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:43913 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756693AbZLIGxY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 01:53:24 -0500
In-Reply-To: <71cd59b00912080932nf334ba7uf65c70178fec41a5@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, Alexandre Rostovtsev <tetromino@gmail.com>

Corentin Chary wrote:
> On Tue, Dec 8, 2009 at 4:41 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>> On Tue, Dec 08, 2009 at 03:37:09PM +0800, Ike Panhc wrote:
>>
>>>  ASUS_HANDLE(rled_set, ASUS_HOTK_PREFIX "RLED");      /* W1JC */
>>>  ASUS_HANDLE(pled_set, ASUS_HOTK_PREFIX "PLED");      /* A7J */
>>>  ASUS_HANDLE(gled_set, ASUS_HOTK_PREFIX "GLED");      /* G1, G2 (probably) */
>> The driver is controlling the ATKD device, which has a HID of ATK0101.
>> These devices are all underneath it...
>>
>>> +ASUS_HANDLE(lled_set, "\\_SB_.PCI0.SBRG.EC0_.HKEY.TVLS"); /* LenovoCare */
>> And this one isn't, which is a bit jarring. Looking closer, it's under
>> the LEN0014 device, which means that you're trying to touch a method
>> that belongs to a device other than the one this driver is bound to.
>> That's wrong. You want a separate ACPI driver for the LEN0014 device,
>> and this should be called for there. Looking at it, you seem to get
>> rfkill as well (the GWAN/SWAN, GBDC/SBDF and GUWB/SUWB methods) and
>> maybe some other stuff.
>>
>> So this shouldn't go in asus-laptop. You'll need to add another separate
>> driver for the SL-specific functionality.
> 
> That means asus-laptop and sl-laptop will be both needed for a SL
> laptop, but I don't think this is a problem.
> 
I think your suggestion is that one acpi driver for one acpi device.
It makes sense to me. I will build a new driver.


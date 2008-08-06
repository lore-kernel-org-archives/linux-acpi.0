From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Do not return true to all kind of Windows OSI calls
Date: Wed, 6 Aug 2008 10:12:26 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B3C9C5BC@orsmsx415.amr.corp.intel.com>
References: <1217632817.4610.6.camel@hidalgo> <200808031531.54725.trenn@suse.de> <20080803141231.GA14272@srcf.ucam.org> <200808031824.06670.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:60276 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755001AbYHFRM2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Aug 2008 13:12:28 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200808031824.06670.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: corsac@debian.org, ak@linux.intel.com, "Zhang, Rui" <rui.zhang@intel.com>, nokos@gmx.net, linux-acpi@vger.kernel.org, hmh@debian.org


We ran _OSI on a Windows XP machine with the following results:

>
>Name(buf, Buffer() {0, 0, 0, 0, 0, 0, 0, 0})
>Store(\_OSI("Windows 2000"), Index(buf, 0))
>Store(\_OSI("Windows 2001"), Index(buf, 1))
>Store(\_OSI("Windows 2001.1"), Index(buf, 2))
>Store(\_OSI("Windows 2001.1 SP1"), Index(buf, 3))
>Store(\_OSI("Windows 2001 SP1"), Index(buf, 4))
>Store(\_OSI("Windows 2001 SP2"), Index(buf, 5))
>Store(\_OSI("Windows 2001 SP3"), Index(buf, 6))
>Store(\_OSI("Windows 2006"), Index(buf, 7))
>
>The result is:
>Buffer: 0xff 0xff 0x00 0x00 0xff 0xff 0x00 0x00
>
>So "Windows 2000", "Windows 2001", "Windows 2001 SP1", "Windows 2001
SP2"
>are supported.
>
>Lin Ming





>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Thomas Renninger
>Sent: Sunday, August 03, 2008 9:24 AM
>To: Matthew Garrett
>Cc: corsac@debian.org; ak@linux.intel.com; Zhang, Rui; nokos@gmx.net;
>linux-acpi@vger.kernel.org; hmh@debian.org
>Subject: Re: Do not return true to all kind of Windows OSI calls
>
>On Sunday 03 August 2008 04:12:31 pm Matthew Garrett wrote:
>> On Sun, Aug 03, 2008 at 03:31:53PM +0200, Thomas Renninger wrote:
>> > This is even worse, because that means that Lenovo and everyone
>> > else who has to add Windows hotfixes to their BIOS and potentially
>> > have to break their Linux supported OS by that cannot guarantee
>> > their customers full Linux support (without providing a separate
>> > Linux BIOS).
>>
>> That's fine. Where we diverge from the Windows behaviour we already
have
>> a bug.
>
>Yes.
>I take above statement back.
>This Windows behaviour very much de-escalates the situation.
>
>If Windows sticks to this then there is no urgent need for
OSI(notWindows)
>or OSI(Linux).
>
>Thanks for pointing this out.
>
>       Thomas
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

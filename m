From: "Koornstra, Reinoud" <koornstra@hp.com>
Subject: RE: 2.6.28-rc7 acpi error messages
Date: Fri, 5 Dec 2008 17:57:10 +0000
Message-ID: <E92FAF79A8BBC642A36EEE3AA7F152D82A17260C68@GVW1089EXB.americas.hpqcorp.net>
References: <4911F71203A09E4D9981D27F9D8308580DD52E96@orsmsx503.amr.corp.intel.com>
 <20081203230332.GA26733@srcf.ucam.org>
 <4911F71203A09E4D9981D27F9D8308580DD52F0F@orsmsx503.amr.corp.intel.com>
 <20081203233557.GA27180@srcf.ucam.org>
 <4911F71203A09E4D9981D27F9D8308580DD53280@orsmsx503.amr.corp.intel.com>
 <E92FAF79A8BBC642A36EEE3AA7F152D82A172606EE@GVW1089EXB.americas.hpqcorp.net>
 <4911F71203A09E4D9981D27F9D8308580DD53927@orsmsx503.amr.corp.intel.com>
 <4911F71203A09E4D9981D27F9D8308580DD53D0B@orsmsx503.amr.corp.intel.com>
 <20081205163752.GA26710@srcf.ucam.org>
 <4911F71203A09E4D9981D27F9D8308580DD53D76@orsmsx503.amr.corp.intel.com>
 <20081205172144.GA27396@srcf.ucam.org>
 <4911F71203A09E4D9981D27F9D8308580DDBE4E3@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:28313 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbYLER6z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Dec 2008 12:58:55 -0500
In-Reply-To: <4911F71203A09E4D9981D27F9D8308580DDBE4E3@orsmsx503.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>

HI,

Let me test the patch and see how that works out.
I am willing to install windows on the machine and get any output you'll need as well.
Kind Regards,

Reinoud.

-----Original Message-----
From: Moore, Robert [mailto:robert.moore@intel.com]
Sent: Friday, December 05, 2008 9:43 AM
To: Matthew Garrett
Cc: Koornstra, Reinoud; linux-acpi@vger.kernel.org; Brown, Len; Lin, Ming M; Zhao, Yakui
Subject: RE: 2.6.28-rc7 acpi error messages


> I think some people in Intel had
>something like this for some previous testing?

I'm not sure. If not, we are prepared to develop the testbed necessary to answer these questions once and for all.


Here's my current list of outstanding questions:

1) What does Windows do when both a valid RSDT and XSDT are present? Does Windows ever detect problems with one such table and use the other?

2) What does Windows do if the FADT has two different but valid addresses (32/64) for the FACS (meaning there are two FACS tables)? How does it determine which one to use? Does it attempt to use both? (Two wake vectors, two global locks).

3) What does Windows do for ACPI register addresses in the FADT if both the 32-bit and 64-bit(X) versions exist, but are different? Does it fall back to the 32-bit version? Does it ever even attempt to use the 64-bit versions?

4) What does Windows do for ACPI register lengths in the FADT if they are non-standard? Does it even use these lengths or does it just hardcode them? Also, what if the 32/64 versions are different?

Any others I've missed?

Bob

>-----Original Message-----
>From: Matthew Garrett [mailto:mjg59@srcf.ucam.org]
>Sent: Friday, December 05, 2008 9:22 AM
>To: Moore, Robert
>Cc: Koornstra, Reinoud; linux-acpi@vger.kernel.org; Brown, Len; Lin, Ming
>M; Zhao, Yakui
>Subject: Re: 2.6.28-rc7 acpi error messages
>
>On Fri, Dec 05, 2008 at 08:58:39AM -0800, Moore, Robert wrote:
>> >> 1) Use the RSDT instead of the XSDT and automatically get the
>"correct"
>> >FADT with no 64-bit register definitions.
>> >>
>> >> 2) Use the XSDT as is done today, but use the 32-bit values instead of
>> >the 64-bit values in the extended FADT.
>>
>>
>> What we really want to know is what does windows do, (1), or (2).
>
>So far I haven't managed to find any machines that have differing values
>in the version 1 FADT and the 32-bit values of the version 2 one, so
>it's difficult to know. Best bet would probably be a qemu setup that
>feeds different values for this - I think some people in Intel had
>something like this for some previous testing?

From: Darren Hart <dvhart@infradead.org>
Subject: Re: [RFC PATCH v2 01/16] ACPI: Add support for device specific
 properties
Date: Mon, 06 Oct 2014 09:25:35 -0700
Message-ID: <D058106C.ABC8C%dvhart@linux.intel.com>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com>
 <1410868367-11056-2-git-send-email-mika.westerberg@linux.intel.com>
 <20141006135021.0EB04C43FBE@trevor.secretlab.ca>
 <20141006143248.GE1583@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17905 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbaJFQZc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Oct 2014 12:25:32 -0400
In-Reply-To: <20141006143248.GE1583@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Grant Likely <grant.likely@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Aaron Lu <aaron.lu@intel.com>

On 10/6/14, 7:32, "Mika Westerberg" <mika.westerberg@linux.intel.com>
wrote:

>On Mon, Oct 06, 2014 at 02:50:21PM +0100, Grant Likely wrote:
>>
>> > +/* ACPI _DSD device properties UUID:
>>daffd814-6eba-4d8c-8a91-bc9bbf4aa301 */
>> > +static const u8 prp_uuid[16] = {
>> > +	0x14, 0xd8, 0xff, 0xda, 0xba, 0x6e, 0x8c, 0x4d,
>> > +	0x8a, 0x91, 0xbc, 0x9b, 0xbf, 0x4a, 0xa3, 0x01
>> > +};
>> 
>> ?
>> 
>> What is the encoding used here? I see the first 4 bytes for "daffd814"
>> encoded in little endian (0x14 first), and then the remaining values
>> encoded in big-endian for each number. Is this typical for UUID values?
>
>The buffer format is explained in ACPI 5.1 spec, page 823.
>
>I generated the above so that I compiled a _DSD with correct UUID using
>iASL and then disassambled it with the same tool.
>

I bugged Mika with the same question, it's a fairly non-intuitive encoding
:-)

-- 
Darren Hart
Intel Open Source Technology Center




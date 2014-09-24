From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] gpio / ACPI: Use pin index and bit length
Date: Wed, 24 Sep 2014 13:25:03 +0200
Message-ID: <CACRpkdbdY2JFDbYWaqZ2KepKUv8fQnNAR4bH0KVjVS8zcMbFoA@mail.gmail.com>
References: <715ed7865378d29b78003c710d50dba77b2cb9bb.1411439631.git.lv.zheng@intel.com>
	<7b41a3ca1f673c6e3d6e6b7c94c0792c7b18badf.1411439632.git.lv.zheng@intel.com>
	<20140923102728.GK1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38090 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbaIXLZF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Sep 2014 07:25:05 -0400
Received: by mail-ig0-f175.google.com with SMTP id h18so6316204igc.14
        for <linux-acpi@vger.kernel.org>; Wed, 24 Sep 2014 04:25:04 -0700 (PDT)
In-Reply-To: <20140923102728.GK1786@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>

On Tue, Sep 23, 2014 at 12:27 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Tue, Sep 23, 2014 at 10:35:54AM +0800, Lv Zheng wrote:
>> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>
>> Fix code when the operation region callback is for an gpio, which
>> is not at index 0 and for partial pins in a GPIO definition.
>> For example:
>> Name (GMOD, ResourceTemplate ()
>> {
>>       //3 Outputs that define the Power mode of the device
>>       GpioIo (Exclusive, PullDown, , , , "\\_SB.GPI2") {10, 11, 12}
>>       })
>> }
>>
>> If opregion callback calls is for:
>> - Set pin 10, then address = 0 and bit length = 1
>> - Set pin 11, then address = 1 and bit length = 1
>> - Set for both pin 11 and pin 12, then address = 1, bit length = 2
>>
>> This change requires updated ACPICA gpio operation handler code to
>> send the pin index and bit length.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Adding the GPIO maintainers since we need their ACK to get this merged
> through ACPI tree.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

When it comes to ACPI GPIO stuff I basically trust Rafael, Mika
and Darren to do the right thing. I'm trying to learn a bit as we go.

Yours,
Linus Walleij

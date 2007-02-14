From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: no fan detected
Date: Wed, 14 Feb 2007 09:46:06 +0300
Message-ID: <45D2B02E.7040302@linux.intel.com>
References: <e30fb88b0702130638g9e26873ned471eceaa309719@mail.gmail.com>	 <200702131510.56754.lenb@kernel.org>	 <e30fb88b0702131400p7aa0c1b6ifcde1eca191fea8c@mail.gmail.com> <e30fb88b0702131545y5ee3b5eeq992344926f32fde8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:28088 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751136AbXBNGqO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Feb 2007 01:46:14 -0500
In-Reply-To: <e30fb88b0702131545y5ee3b5eeq992344926f32fde8@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: martin schneebacher <martin.schneebacher@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

martin schneebacher wrote:
> On 2/13/07, martin schneebacher <martin.schneebacher@gmail.com> wrote:
>> On 2/13/07, Len Brown <lenb@kernel.org> wrote:
>> > Did /proc/acpi/fan have any contents with any previous version of 
>> Linux?
>> > If so, what version and what was there?
>
> i tried with 2.6.12.6, which was the first one on this machine. but
> without success.
>
Good chance your BIOS vendor did not export control of the fun to userspace.
> the fans are running up and down acording to the temperature, but i
> have no control in /proc nor any info about their state.
>
So you don't need to have control too.
You could look at your DSDT, it is in /proc/dsdt. it is possible to 
disassemble it with "iasl" which should
be available either in repository of the packages for your Linux version,
or as part of acpica-unix, available at www.intel.com.
Look for a device with id from /drivers/acpi/fun.c file (PNP*).
If such a device exists, then we should deliver it to you as 
/proc/acpi/fun/name.
> bye...masc.
> -

Regards,
    Alex.

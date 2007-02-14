From: "martin schneebacher" <martin.schneebacher@gmail.com>
Subject: Re: no fan detected
Date: Wed, 14 Feb 2007 15:11:24 +0100
Message-ID: <e30fb88b0702140611m3ea994b1l56cf44278b80c044@mail.gmail.com>
References: <e30fb88b0702130638g9e26873ned471eceaa309719@mail.gmail.com>
	 <200702131510.56754.lenb@kernel.org>
	 <e30fb88b0702131400p7aa0c1b6ifcde1eca191fea8c@mail.gmail.com>
	 <e30fb88b0702131545y5ee3b5eeq992344926f32fde8@mail.gmail.com>
	 <45D2B02E.7040302@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:55379 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312AbXBNOL0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Feb 2007 09:11:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so200579uga
        for <linux-acpi@vger.kernel.org>; Wed, 14 Feb 2007 06:11:24 -0800 (PST)
In-Reply-To: <45D2B02E.7040302@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On 2/14/07, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com> wrote:
> So you don't need to have control too.
> You could look at your DSDT, it is in /proc/dsdt. it is possible to
> disassemble it with "iasl" which should
> be available either in repository of the packages for your Linux version,
> or as part of acpica-unix, available at www.intel.com.
> Look for a device with id from /drivers/acpi/fun.c file (PNP*).
> If such a device exists, then we should deliver it to you as
> /proc/acpi/fun/name.

this is this device id, right?     .ids = "PNP0C0B",
there is nothing in the dsdt, nor something with fan or similar. i
tried with iasl 20061109.

i stored the dsdt on the acpi sf site, if anybody is interested in it
(aopen/barebook1559as).

thanx&bye...masc.

From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [PATCH 1/2] RFC: ACPI: Interface for ACPI drivers to place quirk
	code which gets executed early
Date: Tue, 3 Feb 2009 14:45:17 +0100
Message-ID: <68676e00902030545x131e4144ya751bf6af3e4d33@mail.gmail.com>
References: <20090125210520.GA12963@dreamland.darkstar.lan>
	 <200902021822.11906.trenn@suse.de>
	 <20090202202246.GA9023@dreamland.darkstar.lan>
	 <200902031408.12237.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:60300 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbZBCNpT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Feb 2009 08:45:19 -0500
In-Reply-To: <200902031408.12237.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Jean Delvare <khali@linux-fr.org>, Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>

On Tue, Feb 3, 2009 at 2:08 PM, Thomas Renninger <trenn@suse.de> wrote:
> On Monday 02 February 2009 21:22:46 Luca Tettamanti wrote:
>> Il Mon, Feb 02, 2009 at 06:22:10PM +0100, Thomas Renninger ha scritto:
>> > These two patches are tested on a ASUS machine and worked as expected,
>> > but probably may still need some cleanup.
>>
>> I'd keep the DMI+HID approach since it's more flexible:
>> - (AFAICS) Thinkpads have different methods for hwmon depending on the
>>   model and no fixed HID
>> - With DMI it would be possible to include ASUS motherboards (ATK w/
>>   hwmon) but exclude ASUS laptops (ATK w/o hwmon).
> I thought the ATK01[01]0 devices are ASUS specific.

Me too, I was thinking about using DMI_CHASSIS_TYPE to restrict the
match only to motherboard (not notebooks).

> I now found an ATK0100 (not the ATK0110 this is about) on a Sony and a
> Samsung.
> I still wonder why you want to restrict the check to ASUS.
> Your ATK0110 driver would also load on any other machine which has such
> a device. And why shouldn't a Samsung/Sony/... machine with a ATK0110
> device not access the hwmon sensor through it?

Ah, I was unaware that it was used also by other vendors. It the same
interface though? Do you have a dump of the DSDT of such machines?

> Should we already look a bit deeper into the ATK0110 device in the quirk
> to make sure it provides thermal, fan or other hwmon device accessing
> functionality?

Hum, maybe it's the best thing to do. Hans,  Jean what do you think?

Luca

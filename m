From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Date: Tue, 21 Feb 2006 14:34:59 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840AFD4B93@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:3984 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161413AbWBUGfF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Feb 2006 01:35:05 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jaya Kumar <jayakumar.acpi@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


>On 2/20/06, Yu, Luming <luming.yu@intel.com> wrote:
>> I found _BCM, _BCL ... which are reserved methods for
>> ACPI video extension device. If the vendor follows
>> ACPI video extension spec, this proposed driver is
>> NOT needed. Because, we do have acpi video driver
>> in kernel today.  Could you please show me acpidump
>> output?
>>
>> Thanks,
>> Luming
>
>Hi Luming,
>
>Thanks for your reply.
>
>Note that aside from the ACPILCD00 HID, there's also the ASIM0000 HID
>that I'm supporting in this driver. I've appended the DSDT info you
>requested. Let me know what you feel needs to be done to either make
>the current acpi video driver detect this extension device (Should I
>just try adding the ACPILCD00 HID to the video driver?).
>
It would be better if you can merge this stuff with acpi video driver.
If you look at video.c, there is NO HID definition for video device.
we rely on acpi_video_bus_match to recoginize video device in ACPI
namespace.

As for hotkey stuff, please take a look at 
http://bugzilla.kernel.org/show_bug.cgi?id=5749

Thanks,
Luming

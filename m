From: Feng Kan <fkan@apm.com>
Subject: Re: [PATCH V2 1/6] Documentation: add dts binding for X-Gene reboot
 dts node.
Date: Tue, 14 Jan 2014 10:35:33 -0800
Message-ID: <CAL85gmD+34VKSHsGXWTbQ2w3razo_cKukfe=dSQJi+x-Zfvtpw@mail.gmail.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
	<201401132043.52491.arnd@arndb.de>
	<CAL85gmCA4kBsRUMC_ENjGfCq5jM11iY5Jx_+A3V9XQDU0b7E0A@mail.gmail.com>
	<201401140706.13406.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from exprod5og111.obsmtp.com ([64.18.0.22]:46123 "HELO
	exprod5og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750751AbaANSfe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jan 2014 13:35:34 -0500
Received: by mail-ob0-f170.google.com with SMTP id uy5so7736204obc.1
        for <linux-acpi@vger.kernel.org>; Tue, 14 Jan 2014 10:35:33 -0800 (PST)
In-Reply-To: <201401140706.13406.arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Jan 13, 2014 at 10:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 14 January 2014, Feng Kan wrote:
>>
>> >
>> > Is this related to the standard ARM SCU that manages multiprocessor
>> > systems, or a different unit that uses the same name?
>>
>> FKAN: You mean the snoop control unit in ARM. This is different from
>> that, the main function of this unit is clk control.
>
> Hmm, if it's *mainly* used for clocks, you may actually just want to
> have a driver in drivers/clk for it that also performs a few of the
> other things on the side.
>

FKAN: there among other thing, reset controls, fuse id's and deep sleep
resume registers... I like your idea of using syscon, we can have a node
for SCU and then the specific driver to parse out the needed chunk to use.

>         Arnd

From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [Debian-eeepc-devel] 5 second boot desktop with documentation
Date: Thu, 25 Jun 2009 09:51:55 +0100
Message-ID: <9b2b86520906250151h1be909cbu2afc0cf87cf08c4@mail.gmail.com>
References: <4A40C611.3010804@powercraft.nl> <4A411732.2050902@powercraft.nl>
	 <9b2b86520906240058v6e6c96c6r6bcd2e85f7d13823@mail.gmail.com>
	 <4A41E4A2.9000103@powercraft.nl>
	 <20090624110322.69851c4d@Prem6s.lanvoc>
	 <9b2b86520906240255p48d00c27n16751ae04b1565f5@mail.gmail.com>
	 <20090624132546.1a8389f0@Prem6s.lanvoc>
	 <9b2b86520906240531l46bafd49p5e4dc1a17adad29a@mail.gmail.com>
	 <20090624145749.6506b86d@Prem6s.lanvoc>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:42647 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbZFYIvy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jun 2009 04:51:54 -0400
Received: by bwz9 with SMTP id 9so1245732bwz.37
        for <linux-acpi@vger.kernel.org>; Thu, 25 Jun 2009 01:51:56 -0700 (PDT)
In-Reply-To: <20090624145749.6506b86d@Prem6s.lanvoc>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Boiteux?= <fboiteux@calistel.com>
Cc: debian-eeepc-devel@lists.alioth.debian.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 6/24/09, Fr=E9d=E9ric Boiteux <fboiteux@calistel.com> wrote:
> Le Wed, 24 Jun 2009 13:31:39 +0100,
> Alan Jenkins <sourcejedi.lkml@googlemail.com> a =E9crit :
>
>> On 6/24/09, Fr=E9d=E9ric Boiteux <fboiteux@calistel.com> wrote:
>> > =85
>> > I've tried, but the proposed workaround doesn't work here :-(
>> > I've booted with 'initcall_debug' option to have some more message=
s,
>> > look at dmesg's file joined to this e-mail.
>>
>> Weird.  You said earlier that acpi_enforce_resources=3Dstrict solved
>> your problem on 2.6.29, so this looks like a regression in 2.6.30.
>>
>> [    0.000000] Kernel command line: root=3DLABEL=3Dracine ro vga=3D7=
88
>> acpi_enforce_resources=3Dstrict init=3D/sbin/bootchartd initcall_deb=
ug
>>
>> [   11.795501] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 19 (level,
>> low) -> IRQ 19
>>
>> The point of acpi_enforce_resources=3Dstrict was to prevent drivers =
like
>> i801_smbus binding to devices already handled by an ACPI BIOS.  It w=
as
>> this conflict that was believed to cause the delay.
>>
>> What we want to see, which you should see on 2.6.29 with the "strict=
"
>> boot option, is something like this:
>>
>> [    0.881441] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level,
>> low) -> IRQ 18
>> [    0.881441] ACPI: I/O resource 0000:00:1f.3 [0x400-0x41f]
>> conflicts with ACPI region SMRG [0x400-0x40f]
>> [    0.881441] ACPI: Device needs an ACPI driver
>> [    0.881441] i801_smbus: probe of 0000:00:1f.3 failed with error -=
16
>
> Yes, I had this kind of messages with 2.6.29 kernel, but not in 2.6.3=
0.
>
>> As a workaround / sanity check, can you avoid the delay on 2.6.30 if
>> you blacklist the i801_smbus module?
>
> I've blacklisted the 'i2c_i801' module (responsible from i801_smbus
> message), and yes, the boot delay disappeared ! :-)
>
>   If I can help to track this bug, I can do some tests.
>
> 	Many thanks,
> 		Fred.
>

Thanks for your responsiveness.  I've created a kernel bugzilla entry.

<http://bugzilla.kernel.org/show_bug.cgi?id=3D13620>

Can you please add as attachments:
 1. dmesg for 2.6.29 with acpi_enforce_resources=3Dstrict
 2. the output of acpidump (it's a debian package)

You will need to create a kernel bugzilla account if you haven't
already got one.

Thanks
Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: "Simon Depiets" <sdepiets@gmail.com>
Subject: Re: Acer Aspire One (Intel Atom's Motherboard) CPU Temp & Fan Speed
Date: Thu, 14 Aug 2008 11:48:06 +0200
Message-ID: <f4897e880808140248xc6f918dlca01b42fb9762d10@mail.gmail.com>
References: <f4897e880807240800n3c02c6bdw44c4827e098f61c2@mail.gmail.com>
	 <f4897e880807240932q33f3919et1d24cb8f98e8598e@mail.gmail.com>
	 <200807242302.04782.carlos@strangeworlds.co.uk>
	 <f4897e880807241628j4d557e91w1955044d43451247@mail.gmail.com>
	 <1216949919.1831.38.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:47856 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbYHNJsH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Aug 2008 05:48:07 -0400
Received: by rv-out-0506.google.com with SMTP id k40so322202rvb.1
        for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2008 02:48:07 -0700 (PDT)
In-Reply-To: <1216949919.1831.38.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, acpi@linux.intel.com, linux-acpi@vger.kernel.org

2008/7/25 Zhao Yakui <yakui.zhao@intel.com>:
> On Fri, 2008-07-25 at 01:28 +0200, Simon Depiets wrote:
>> 2008/7/25 Carlos Corbacho <carlos@strangeworlds.co.uk>:
>> > We'll also need the output of acpidump.
>> >
>> > -Carlos
>> Hi,
>> I've uploaded it here
>> http://www.mmo-tools.com/acpi/acpidump.txt
> >From the attached acpidump it seems that there is no defintion of
> thermal_zone, FAN device or power resource device.
> So we can't get any info about the temperature of thermal_zone or FAN
> speed through ACPI interface.
> Will you please check whether there is available bios to upgrade?
> Will you please check whether the CPU temperature can be obtained by =
the
> coretemp driver?
>
> Thanks.
Hi,
there is still no bios update available, but we did some progress on
CPU temperature, coretemp should be upgraded in 2.6.27 to support Atom
(model 0x1C), I tested the patch submitted my Rudolf Marek and it
works : http://bugzilla.kernel.org/show_bug.cgi?id=3D11161
So now sensors produces the following correct output
#sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +29.0=B0C  (crit =3D +95.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +29.0=B0C  (crit =3D +95.0=B0C)

I still don't know what to do with fancontrol/fanspeed
I've uploaded a new dsdt.dsl here : http://www.mmo-tools.com/acpi/dsdt.=
dsl.txt
and a new "tree /proc/acpi" here : http://www.mmo-tools.com/acpi/acpi_t=
ree.txt
Thanks a lot
--=20
Lliane aka Simon Depiets
Epita Promo 2011,42
http://www.lliane.com
A man is smoking with his girlfriend. She angers herself : "don't you
see the warning on the box ?!"
To which the man replies, "I am a programmer. I don't worry about
warnings. I only worry about errors."
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

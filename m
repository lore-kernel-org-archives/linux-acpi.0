From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: BUG: scheduling while atomic in acpi_ps_complete_op
Date: Thu, 27 Aug 2009 13:39:06 +0800
Message-ID: <d82e647a0908262239m769f1417j9a9cae4e4ec8a8aa@mail.gmail.com>
References: <1250873707.2168.38.camel@dhcp231-106.rdu.redhat.com>
	 <4A8EFFB2.4040100@suse.de>
	 <1250886352.2168.83.camel@dhcp231-106.rdu.redhat.com>
	 <4A8F1081.3020803@suse.de>
	 <1251124609.2359.25.camel@dhcp231-106.rdu.redhat.com>
	 <1251248426.3623.47.camel@localhost.localdomain>
	 <1251287895.2270.25.camel@dhcp231-106.rdu.redhat.com>
	 <1251295984.3623.83.camel@localhost.localdomain>
	 <1251312530.2280.1.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f192.google.com ([209.85.222.192]:37764 "EHLO
	mail-pz0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbZH0FjF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Aug 2009 01:39:05 -0400
In-Reply-To: <1251312530.2280.1.camel@dhcp231-106.rdu.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
Cc: ykzhao <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>

2009/8/27 Eric Paris <eparis@redhat.com>:
> On Wed, 2009-08-26 at 22:13 +0800, ykzhao wrote:
>> On Wed, 2009-08-26 at 19:58 +0800, Eric Paris wrote:
>> > On Wed, 2009-08-26 at 09:00 +0800, ykzhao wrote:
>> > > On Mon, 2009-08-24 at 22:36 +0800, Eric Paris wrote:
>> > > > On Sat, 2009-08-22 at 01:24 +0400, Alexey Starikovskiy wrote:
>> > > > > Eric Paris =D0=C9=DB=C5=D4:
>> >
>> > > > It does stop my slew of warnings. =9ANot sure it completely fi=
xes my
>> > > > problems though....
>> > > Will you please add the boot option of initcall_debug and attach=
 the
>> > > output of dmesg?
>> > > It will be helpful if you can attach the output of acpidump.
>> > > Thanks.
>> Hi
>> =9A =9A =9A Will you please confirm whether this issue happens on th=
e 2.6.31-rc6
>> kernel?
>
> I just went back to a -rc7 kernel (but a largely different .config) a=
nd
> it did not happen.

It may happen in -rc7 if kmemleak is enalbled,  see

         http://marc.info/?l=3Dlinux-kernel&m=3D125110822604893&w=3D2

Thanks.
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: FAN Processor and Thermap
Date: Fri, 20 Mar 2009 14:49:41 +0800
Message-ID: <1237531781.3640.161.camel@localhost.localdomain>
References: <335b7d740903190118r32d6f4d4ia9146bf2f0d9f6f@mail.gmail.com>
	 <1237510029.3640.125.camel@localhost.localdomain>
	 <335b7d740903191848i1addc5fcyf02610ee20003c91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:3085 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbZCTGsk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Mar 2009 02:48:40 -0400
In-Reply-To: <335b7d740903191848i1addc5fcyf02610ee20003c91@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ken Perl <kenperl@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2009-03-20 at 09:48 +0800, Ken Perl wrote:
> # acpidump
> ACPI tables were not found. If you know location of RSD PTR table
> (from dmesg, etc), supply it with either --addr or -a option
It seems that the RSDP can't be found between the 0xE0000 and 0xFFFFF
memory region.
If so, the ACPI can't be initialized correctly.
  =20
Will you please enable CONFIG_ACPI_DEBUG in kernel configuration and ad=
d
the boot option of "acpi=3Dht"?
    After the system is booted, please attach the output of dmesg.
Thanks.

>=20
> I have no idea from the dmesg output where the ACPI tables are.
>=20
> On Fri, Mar 20, 2009 at 8:47 AM, yakui_zhao <yakui.zhao@intel.com> wr=
ote:
> > On Thu, 2009-03-19 at 16:18 +0800, Ken Perl wrote:
> >> After I replaced my mainboard, then I can see errors related to AC=
PI
> >> during the Linux booting, I can also reproduce it with command bel=
ow,
> >>
> >> moproble fan processor thermap
> >>
> >> I got error "no such device",  I ever tried to append following li=
nes
> >> to the /etc/modprobe.d/blacklist but can not succeed, I can still =
see
> >> same error during boot, another error is "ACPI unable to load syst=
em
> >> description tables",
> > Maybe the issue is related with the following complains:
> >   >=EF=BB=BFACPI unable to load system description tables",
> >   If so, the ACPI SSDT table is not loaded correctly.
> >
> > Will you please attach the output of acpidump ?
> > Thanks.
> >>
> >> blacklist fan
> >> blacklist processor
> >> blacklist thermap
> >>
> >> Do these a big problem? Can anyone tell how I can fix the issue?
> >>
> >
> >
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

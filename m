From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Toggling VGA out on Eee 901
Date: Wed, 17 Sep 2008 13:47:03 +0800
Message-ID: <1221630423.3441.147.camel@rzhang-dt>
References: <1221601392651@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33130 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbYIQFrg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Sep 2008 01:47:36 -0400
In-Reply-To: <1221601392651@dmwebmail.dmwebmail.chezphil.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phil Endecott <phil_hmpau_endecott@chezphil.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Hi, phil,

On Tue, 2008-09-16 at 22:43 +0100, Phil Endecott wrote:
> Dear Experts,
>=20
> I'm trying to work out how to get console video out toggling working =
on=20
> my ASUS EEE 901 (running Debian).  I get the feeling that I may be th=
e=20
> first person to try to do this, and I knew almost nothing about ACPI=20
> until a couple of hours ago.  Can anyone help?
> Output toggling for X works fine, but that doesn't use ACPI.
=EF=BB=BFwell, ACPI control method for video output switching seldom wo=
rks.
And we use xrandr to switch the display in X.
I'm not sure but I'm afraid we don't have the plan to support video
output switch in console mode.

thanks,
rui

>   If the=20
> machine is booted with an external monitor connected, console VGA out=
=20
> is enabled; if the monitor is not connected it's not enabled.  Lookin=
g=20
> in /proc/acpi/video/VGA/CRTD/state I see
>=20
> state: 0x1f
> query: 0x01
>=20
> when the machine was booted with the monitor connected and
>=20
> state: 0x0d
> query: 0x00
>=20
> when the machine was booted without the monitor.  Following the advic=
e=20
> of an old ACPI HOWTO I tried to store 0x80000001 in that file:
>=20
> # /bin/echo 0x80000001 > /proc/acpi/video/VGA/CRTD/state
> /bin/echo: write error: Bad address
>=20
> I had a look at my iasl-disassembled /proc/dsdt and found this:
>=20
> Device (VGA)
> {
>      .....
>      Name (DONE, Zero)
>      .....
>=20
>      Device (CRTD)
>      {
>          .....
>          Method (_DSS, 1, NotSerialized)
>          {
>              If (And (Arg0, 0x40000000))
>              {
>                  If (And (Arg0, 0x80000000))
>                  {
>                      Store (One, DONE)
>                  }
>              }
>          }
>      }
> }
>=20
> I have never looked at this stuff before, but I don't get the=20
> impression that it's actually going to do anything to the hardware=20
> registers, is it?  Am I looking in the wrong place?  Based on that I=20
> did try to store 0xC0000000 and 0xC0000001, and in this case there wa=
s=20
> no "Bad address" error - but no output change either.
>=20
> Can someone point me in the right direction?
> I have put the complete dsdt.dsl here: http://chezphil.org/tmp/eee_90=
1_dsdt.dsl
>=20
>=20
> Many thanks,  Phil.
>=20
> (Please cc: me in any replies)
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: Re: [PATCH 0/13] ACPI / PM: Rework power resources management
Date: Fri, 26 Nov 2010 09:12:11 +0100
Message-ID: <AANLkTimcn_3DamzfWaCk6YEfSCvC78ZJGkw-f+01pj2=@mail.gmail.com>
References: <AANLkTimahUpEL3cV6pFhkN8KqrphfVMSOw8xAN2=9jPy@mail.gmail.com>
	<201011252129.02027.rjw@sisk.pl>
	<AANLkTi=QH=SNyfZEaak6pYyCJchSwDp6sdn-yOSz2MRQ@mail.gmail.com>
	<201011252145.19814.rjw@sisk.pl>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43742 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab0KZIMM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Nov 2010 03:12:12 -0500
In-Reply-To: <201011252145.19814.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Nov 25, 2010 at 9:45 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, November 25, 2010, Sedat Dilek wrote:
>> On Thu, Nov 25, 2010 at 9:29 PM, Rafael J. Wysocki <rjw@sisk.pl> wro=
te:
>> > On Thursday, November 25, 2010, Rafael J. Wysocki wrote:
>> >> On Thursday, November 25, 2010, Sedat Dilek wrote:
>> >> > On Thu, Nov 25, 2010 at 10:41 AM, Sedat Dilek
>> >> > <sedat.dilek@googlemail.com> wrote:
>> >> > > On Thu, Nov 25, 2010 at 10:11 AM, Sedat Dilek
>> >> > > <sedat.dilek@googlemail.com> wrote:
>> >> > >> Hi Rafael,
>> >> > >>
>> >> > [ ... ]
>> >> > >> # grep "error:" build_linux-next_next20101124.dileks.2.log
>> >> > >> /home/sd/src/linux-2.6/linux-2.6.37-rc3/debian/build/source_=
i386_none/drivers/platform/x86/fujitsu-laptop.c:692:
>> >> > >> error: implicit declaration of function =E2=80=98acpi_bus_ge=
t_power=E2=80=99
>> >> > [ ... ]
>> >> > >
>> >> > > Guess this is conflicting with your patch
>> >> > > "12-13-ACPI-PM-Drop-acpi_bus_get_power.patch".
>> >> > >
>> >> > > - Sedat -
>> >> > >
>> >> > > P.S.: Note to myself, add the following snippet for testing p=
urposes:
>> >> > >
>> >> > > [ debian/config/i386/none/config.686 ]
>> >> > > ...
>> >> > > ##
>> >> > > ## file: drivers/platform/x86/Kconfig
>> >> > > ##
>> >> > > # CONFIG_FUJITSU_LAPTOP is not set
>> >> > > - EOT -
>> >> > >
>> >> >
>> >> > Applied on top of linux-next (next-20101125) and running.
>> >> >
>> >> > =C2=A0 =C2=A0 =C2=A0Tested-by: Sedat Dilek <sedat.dilek@gmail.c=
om>
>> >>
>> >> Great, thanks a lot!
>> >>
>> >> I should have said the patchset is on top of the current Linus' t=
ree.
>> >
>> > Actually it also breaks with the current Linus' tree, but the appe=
nded patch
>> > should fix it.
>> >
>> > Thanks,
>> > Rafael
>> >
>> > ---
>> > From: Rafael J. Wysocki <rjw@sisk.pl>
>> > Subject: Platform / x86: Make fujitsu_laptop use acpi_bus_update_p=
ower()
>> >
>> > Use the new function acpi_bus_update_power(), which is safer than
>> > acpi_bus_get_power(), for getting device power state in
>> > acpi_fujitsu_add().
>> >
>> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>> > ---
>> > =C2=A0drivers/platform/x86/fujitsu-laptop.c | =C2=A0 =C2=A02 +-
>> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > Index: linux-2.6/drivers/platform/x86/fujitsu-laptop.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/drivers/platform/x86/fujitsu-laptop.c
>> > +++ linux-2.6/drivers/platform/x86/fujitsu-laptop.c
>> > @@ -689,7 +689,7 @@ static int acpi_fujitsu_add(struct acpi_
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (error)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_fr=
ee_input_dev;
>> >
>> > - =C2=A0 =C2=A0 =C2=A0 result =3D acpi_bus_get_power(fujitsu->acpi=
_handle, &state);
>> > + =C2=A0 =C2=A0 =C2=A0 result =3D acpi_bus_update_power(fujitsu->a=
cpi_handle, &state);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (result) {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN=
_ERR "Error reading power state\n");
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_un=
register_input_dev;
>> >
>>
>> Sorry, I crapped my own quotes.
>> Missed to catch line #860?
>
> Indeed, sorry. =C2=A0Updated patch is appended.
>
> Rafael
>
>
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: Platform / x86: Make fujitsu_laptop use acpi_bus_update_powe=
r()
>
> Use the new function acpi_bus_update_power(), which is safer than
> acpi_bus_get_power(), for getting device power state in
> acpi_fujitsu_add().
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> =C2=A0drivers/platform/x86/fujitsu-laptop.c | =C2=A0 =C2=A04 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: linux-2.6/drivers/platform/x86/fujitsu-laptop.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/platform/x86/fujitsu-laptop.c
> +++ linux-2.6/drivers/platform/x86/fujitsu-laptop.c
> @@ -689,7 +689,7 @@ static int acpi_fujitsu_add(struct acpi_
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (error)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_=
input_dev;
>
> - =C2=A0 =C2=A0 =C2=A0 result =3D acpi_bus_get_power(fujitsu->acpi_ha=
ndle, &state);
> + =C2=A0 =C2=A0 =C2=A0 result =3D acpi_bus_update_power(fujitsu->acpi=
_handle, &state);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (result) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ER=
R "Error reading power state\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_unreg=
ister_input_dev;
> @@ -857,7 +857,7 @@ static int acpi_fujitsu_hotkey_add(struc
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (error)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_=
input_dev;
>
> - =C2=A0 =C2=A0 =C2=A0 result =3D acpi_bus_get_power(fujitsu_hotkey->=
acpi_handle, &state);
> + =C2=A0 =C2=A0 =C2=A0 result =3D acpi_bus_update_power(fujitsu_hotke=
y->acpi_handle, &state);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (result) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ER=
R "Error reading power state\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_unreg=
ister_input_dev;
>

=46eel free to add for
"Platform-x86-Make-fujitsu_laptop-use-acpi_bus_update_power.patch":

     Reported-and-Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

# grep OK setup_linux-next_next20101126.dileks.1.log | grep ACPI-PM
  (+) OK   ACPI-PM/1-13-ACPI-PM-Check-device-state-before-refcounting-p=
ower-resources.patch
  (+) OK   ACPI-PM/2-13-ACPI-PM-Do-not-refcount-power-resources-that-ca=
n-t-be-turned-on.patch
  (+) OK   ACPI-PM/3-13-ACPI-PM-Prevent-acpi_power_get_inferred_state-f=
rom-making-changes.patch
  (+) OK   ACPI-PM/4-13-ACPI-PM-Add-functions-for-manipulating-lists-of=
-power-resources.patch
  (+) OK   ACPI-PM/5-13-ACPI-PM-Introduce-function-for-refcounting-devi=
ce-power-resources.patch
  (+) OK   ACPI-PM/6-13-ACPI-PM-Introduce-__acpi_bus_get_power.patch
  (+) OK   ACPI-PM/7-13-ACPI-PM-Add-function-for-device-power-state-ini=
tialization.patch
  (+) OK   ACPI-PM/8-13-ACPI-PM-Add-function-for-updating-device-power-=
state-consistently.patch
  (+) OK   ACPI-PM/9-13-ACPI-PM-Register-acpi_power_driver-early.patch
  (+) OK   ACPI-PM/10-13-ACPI-PM-Register-power-resource-devices-as-soo=
n-as-they-are-needed.patch
  (+) OK   ACPI-PM/11-13-ACPI-Fan-Rework-the-handling-of-power-resource=
s.patch
  (+) OK   ACPI-PM/12-13-ACPI-PM-Drop-acpi_bus_get_power.patch
  (+) OK   ACPI-PM/13-13-ACPI-PM-Drop-acpi_power_nocheck.patch
  (+) OK   ACPI-PM-fix/Platform-x86-Make-fujitsu_laptop-use-acpi_bus_up=
date_power.patch

# modinfo fujitsu-laptop
filename:
/lib/modules/2.6.37-rc3-686/kernel/drivers/platform/x86/fujitsu-laptop.=
ko
alias:          dmi:*:svnFUJITSU:*:pvr:rvnFUJITSU:rnFJNB19C:*:cvrS7020:=
*
alias:          dmi:*:svnFUJITSUSIEMENS:*:pvr:rvnFUJITSU:rnFJNB1E6:*:cv=
rS6420:*
alias:          dmi:*:svnFUJITSUSIEMENS:*:pvr:rvnFUJITSU:rnFJNB1D3:*:cv=
rS6410:*
license:        GPL
version:        0.6.0
description:    Fujitsu laptop extras support
author:         Jonathan Woithe, Peter Gruber, Tony Vroon
srcversion:     FFA7AB6B6C940453C0946B4
alias:          acpi*:FUJ02E3:*
alias:          pnp:dFUJ02E3*
alias:          acpi*:FUJ02B1:*
alias:          pnp:dFUJ02B1*
alias:          acpi*:FUJ02BF:*
alias:          pnp:dFUJ02bf*
depends:
vermagic:       2.6.37-rc3-686 SMP mod_unload modversions 686
parm:           use_alt_lcd_levels:Use alternative interface for
lcd_levels (needed for Lifebook s6410). (uint)
parm:           disable_brightness_adjust:Disable brightness adjustment=
 . (uint)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: Asus V1j
Date: Sat, 24 Mar 2007 14:15:04 +0100
Message-ID: <200703241415.04656.corentincj@iksaif.net>
References: <46051CEE.4030402@o2.pl>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:34996 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467AbXCXNPH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Mar 2007 09:15:07 -0400
In-Reply-To: <46051CEE.4030402@o2.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: acpi4asus-user@lists.sourceforge.net
Cc: Szymon Olko <szymonolko@o2.pl>, linux-acpi@vger.kernel.org

Mail cced to linux-acpi@vger.kernel.org, they may be able to help us =3D=
)

Le Saturday 24 March 2007 13:43:26 Szymon Olko, vous avez =E9crit :
> Dear *,
>
> Finally I found some time to play with buttons in my V1j. At first
> thanks for great work!!!
>
> I'm not acpi nor dsdt guru, but I looked into the code and this is wh=
at
> I found out.
> Module is working very good, almost all buttons are working. So I
> decided to play with my DSDT.
> I had few problems, and this is how I solved them or I think should b=
e
> solved.
>
> 1. In /proc/acpi/events few keys which looks normal in DSDT are not
> reported. I found that all of them have code bigger than 0x80. I foun=
ded
> those lines and changed them to return codes below 0x80 (to ones that
> are not used) and that solved problem. I did not have time to look in=
to
> acpi source code and maybe my solution is not the best way to do it, =
and
> maybe not solves the problem, but works for me.
> Example:
>
>     - F2 wifi button
>     //Notify (\_SB.ATKD, 0x88)
>     Notify (\_SB.ATKD, 0x56)
>
> The only exception is sleep button F1 but it is notified not to
> \_SB.ATKD but to \_SB.SLPB and is processed by buttons module.
>
> Notify (\_SB.SLPB, 0x80)
>
> Is it a bug or a feature that codes over 0x80 are not reported?
I don't know :/ So, let's ask linux-acpi@vger.kernel.org



> 2. This laptop has doubled buttons.
Thanks asus :D

> 3. Brightness  buttons (F5 ; F6). They ware generation exceptions lik=
e:
>
> ACPI Error (psargs-0355): [\_SB_.PCI0.P0P2.VGA_.LCDD] Namespace looku=
p
> failure, AE_NOT_FOUND ACPI Error (psparse-0537): Method parse/executi=
on
> failed [\_SB_.PCI0.SBRG.EC0_._Q0E] (Node c194bf40), AE_NOT_FOUND
>
> As far as I understand this problem it is a problem of DSDT which tri=
es
> to notify about an event with not defined namespace. This is this lin=
e
>     Notify (\_SB.PCI0.P0P2.VGA.LCDD, 0x87)
> I will try to solve that later, because method that process F5 also
> decrement brightness, for now the hack is as follows:
>
>             Method (_Q0F, 0, NotSerialized)            //bright F5
>             {
> /*
>                 If (LEqual (OSFG, OSVT))
>                 {
>                     Notify (\_SB.PCI0.P0P2.VGA.LCDD, 0x87)
>                 }
>                 Else
>                 {
>                     If (LGreater (LBTN, 0x00))
>                     {
>                         Decrement (LBTN)
>                     }
>
>                     If (LGreater (LBTN, 0x0F))
>                     {
>                         Store (0x0F, LBTN)
>                     }
>
>                     STBR ()
> */
>                     If (\_SB.ATKP)
>                     {
> //                        Notify (\_SB.ATKD, Add (LBTN, 0x20))
>                         Notify (\_SB.ATKD, 0x52)
>                     }
> /*
>                 }
>
>                 Return (One)
> */
>             }
>
> I commented whole code of that method and just notify about button
> pressed. As for now backlight is working with video module or with
> asus_laptop via /sys/class/backlight/asus-laptop/brightness it can be
> easily workaround with simple script. But as I said I will try to fix
> DSDT later. For F6 code is similar.
Hum, you can just remove the=20
                 If (LEqual (OSFG, OSVT))
                 {
                     Notify (\_SB.PCI0.P0P2.VGA.LCDD, 0x87)
                 }
                 Else
                 {
and it shall work .. But it's a serious issue, as this problem have bee=
n=20
reported on other laptop .... What should we do with=20
Notify (\_SB.PCI0.P0P2.VGA.LCDD, 0x87) ?
(I think OSVT is for Os Vista).

> 4. Multimedia button, the first on the left side from top buttons. On
> windows it runs full screen application to what movies, presentation =
and
> listen music. I made a change like with brightness buttons:
>
>             Method (_Q51, 0, NotSerialized)
> //multimedia (top)
>             {
> /*
>                 \_SB.PCI0.SBRG.EC0.WRAM (0x04, 0xCB, 0x09)
>                 Store (One, Local0)
>                 While (Local0)
>                 {
>                     If (\_SB.ATKP)
>                     {
>                         SPIN (0x23, 0x00)
>                         Sleep (0x32)
>                         SPIN (0x23, 0x01)
>                     }
>
>                     Store (Zero, Local2)
>                     If (\_SB.PCI0.SBRG.EC0.RPIN (0x43))
>                     {
>                         Or (Local2, 0x04, Local2)
>                     }
>
>                     If (\_SB.PCI0.SBRG.EC0.RPIN (0x43))
>                     {
>                         Or (Local2, 0x02, Local2)
>                     }
>
>                     If (\_SB.PCI0.SBRG.EC0.RPIN (0x43))
>                     {
>                         Or (Local2, 0x01, Local2)
>                     }
>
>                     If (LEqual (Local2, 0x07))
>                     {
>                         \_SB.PCI0.SBRG.EC0.WRAM (0x04, 0xCB, 0x89)
>                         Notify (\_SB.ATKD, 0x95)
>                         Store (Zero, Local0)
>                     }
>                 }
> */
>                     If (\_SB.ATKP)
>                     {
>                         Notify (\_SB.ATKD, 0x68)
>                     }
>             }
> But it notify to the /proc/acpi/event for the first time it is presse=
d.
> Next time I press it, it does do nothing. Again I need more time to l=
ook
> what this method should do but looking on the code it is strange that
> \_SB.PCI0.SBRG.EC0.RPIN (0x43) is checked few times. This is still
> pending to be solved. Maybe I commended to much, and there is no stat=
e
> wrote to memory, and that is why it is not called again.
>
> 5. The last big mystery are media control buttons (play, stop, rewind=
,
> forward). I cannot find the in DSDT. I found something that I think
> should be connected to those keys.
>             Method (_Q6E, 0, NotSerialized)            //unknown 1
>             {
>                 If (\_SB.ATKP)
>                 {
> //                    Notify (\_SB.ATKD, 0x8A)
>                     Notify (\_SB.ATKD, 0x65)
>                 }
>             }
> ////////////////////////////////////
>             Method (_Q6F, 0, NotSerialized)            //unknown 3
>             {
>                 If (\_SB.ATKP)
>                 {
> //                    Notify (\_SB.ATKD, 0x99)
>                     Notify (\_SB.ATKD, 0x67)
>                 }
>             }
> But those are two keys not four. And my values are not reported in
> /proc/acpi/events.
Does they work on the other OS ?

> ---------------
> That is all about buttons. Summarizing, all except (play, stop, rewin=
d,
> forward) are working, multimedia is working once.
> This laptop does not have TLED but DSDT says so. I don't know why it =
is
> for. From looking into DSDT WLED and BLED are handled almost the same=
 as
> MLED. Is it possible to make a change in asus_laptop to have those le=
ds
> visible in /sys/class/leds?
I didn't find a way to know if BLED and WLED will handle the device, th=
e led,=20
or both .. So I can't move them to /sys/class/leds ..

> Asus laptops in Windows notifies about plugin connector into sound
> device. I think that this code:
>         Method (_L05, 0, NotSerialized)
>         {
>             Notify (\_SB.PCI0.MC97, 0x02)
>             Notify (\_SB.PCI0.HDAC, 0x02)
>         }
> Maybe responsible for that. Are any modules that handles this? Am I w=
right?
I don't think any modules handles this .. But MC97 seems to be a modem=20
controller.

Thanks =3D)


--=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

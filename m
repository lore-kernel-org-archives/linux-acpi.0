From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: Status of ACPI on IBM T40p & D600
Date: Wed, 11 Feb 2004 09:23:34 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA03F9E687@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alexander Gran <alex-4mRm4CWMOdkHuPwBo6/EyUB+6BGkLq7r@public.gmane.org>
Cc: "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Alexander Gran [mailto:alex-4mRm4CWMOdkHuPwBo6/EyUB+6BGkLq7r@public.gmane.org]
>=20
> Am Dienstag, 10. Februar 2004 03:07 schrieben Sie Ow Mun Heng
> > Mine shows something like this
> >  C1:      promotion[C2] demotion[--] latency[000] usage[00022310]
> > *C2:      promotion[C3] demotion[C1] latency[050] usage[00248795]
> >  C3:      promotion[--] demotion[C2] latency[050] usage[00000090]
>=20
> Seems like someone is still using the busmaster feature..
> Perhaps some other driver, or load (Note that e.g. harddisk=20
> access, graphic io=20
> can also trigger the C2 state)

I did a few more experiments last night..
I booted into the usb-aware kernel and found that if I removed
usb-uhci module, bus-master activity will not show fffff anymore and
in virtual console (GDM running on console F7) I will see C3 increasing
with some variation in the bus-master activity [eg: 123aas134 sd2341 =
etc..]

however, if I then proceeded to login, I note that bus-master starts
to show fffff again until the HD access lights turn off and then it
returns to non fffff status (Again, this is seen under virtual console)
XMMS/glxgears being loaded will also see the same result.

I also noted that when logged into X (Gnome), Xterm terminal
bus-master activity will be as23asd33 etc.. but C3 will never increase
{never as in maybe just 1 or 2 counts after X mins]

If I were to switch into virtual console, then C3 will start to move =
again.
I've tried removing nearly every module I see in lsmod but C3 won't =
increase
under X. There was 1 and only 1 time during my test last night that I =
saw=20
C3 increasing under X. But I can't replicate that again. It only =
happened
once!!!

X is doing bus-mastering??
=20
> > battery life  =3D 2h26m13s	ave power drain =3D 15647mW
> > battery life2 =3D 2h28m35s	ave power drain =3D 15391mW
>=20
> That's not much, indeed.

I know and that;s why it's a pain to live with that kind of
batt life. Anyone with a D600 can tell me if my laptop's=20
or laptop's battery scrrewy?? I'll like to throw it back to DELL.

Hmm.. I wonder if anyone can post their ave power drain over
the life of the battery. I'm expecially interested in the comparison=20
with T40/T41 and centrino based laptops.

it's a very simple bash script that reads /proc/acpi/battery/BAT0/state=20
every 10 secs.

>=20
> > Another thing, should I expect the P states to change when going
> > from AC to Batt? (I seee it's still stucked in P2 which is 1.4Ghz
> > even if I run on batt.
>=20
> Ouch. No, they do not switch automagically, but you should=20
> really switch them (either manually or via cpudynd/cpufreqd which is =
even=20
> better) to the lower values if you wan't real batterylife.

Okay.. they do not switch.. maybe that's my problem..
I'm currently using cpufreqd and cpudynd to do exactly that. but when=20
I'm on battery, I will usually just disable cpudynd (as it has a =
tendency=20
to want to switch to higher freq)

I tried echo 6>/proc/acpi/processor/CPU0/performance  but the darn thing
never budges from P2 state!!

Any idea how to reach P6 state?

Thanks for any comments/suggestions.

My Aim here is simple.. Get longer battery life!! (over the measly =
2h30min=20
and this is a Centrino laptop!!)



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

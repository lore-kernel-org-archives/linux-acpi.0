From: "Wang, Zhenyu" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: kacpid problems
Date: Wed, 10 Nov 2004 23:54:55 +0800
Message-ID: <20041110155455.GA14675@zhen-devel.sh.intel.com>
References: <3ACA40606221794F80A5670F0AF15F84041AC045@pdsmsx403> <20041110133335.84968.qmail@web25309.mail.ukl.yahoo.com> <20041110154433.GA14613@zhen-devel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041110154433.GA14613-/VnEId6AORcBH7GVJk7YB9h3ngVCH38I@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: dev_zero <dev_xor-eZNTXLQAfP4@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

oops,

--- acpi-2.6/drivers/acpi/thermal.c~remove_queue_work	2004-11-10 23:38:51.6=
93022464 +0800
+++ acpi-2.6/drivers/acpi/thermal.c	2004-11-10 23:52:40.820975856 +0800
@@ -472,6 +472,8 @@ acpi_thermal_critical (
 	printk(KERN_EMERG "Critical temperature reached (%ld C), shutting down.\n=
", KELVIN_TO_CELSIUS(tz->temperature));
 	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz->trips.c=
ritical.flags.enabled);
=20
+	tz->zombie =3D 1;
+	acpi_os_wait_events_complete(NULL);
 	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);
=20
 	return_VALUE(0);

If this has no help, maybe others eat up kacpid..

On 2004.11.10 23:44:33 +0000, Wang, Zhenyu wrote:
> Pls try this patch,
>=20
> --- acpi-2.6/drivers/acpi/thermal.c~remove_queue_work   2004-11-10 23:38:=
51.693022464 +0800
> +++ acpi-2.6/drivers/acpi/thermal.c     2004-11-10 23:39:50.195128792 +08=
00
> @@ -472,6 +472,7 @@ acpi_thermal_critical (
>         printk(KERN_EMERG "Critical temperature reached (%ld C), shutting=
 down.\n", KELVIN_TO_CELSIUS(tz->temperature));
>         acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz-=
>trips.critical.flags.enabled);
>=20
> +       tz->zombie =3D 1;
>         acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);
>=20
>         return_VALUE(0);
>=20
> Is this work?
>=20
> -zhen
>=20
> On 2004.11.10 14:33:35 +0000, dev_zero wrote:
> > kacpid still runns with 99%cpu usage when the cpu gets
> > too hot. I tried the game quake 2. You can play around
> > 10 -15 minutes before the kacpid starts running on 99%
> > cpu usage. I also used quake 2 too test the kernel
> > before I applied your patch.
> >=20
> >  --- "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:=20
> > > It means there was NO event generated at that time.
> > > Do you think the symptom is gone with my debug
> > > patch?
> > > If so, I think your box need a more sane schedule
> > > for acpi_thermal_check=20
> > > And, I can come up with a patch.
> > >=20
> > > Thanks
> > > Luming=20
> > >=20
> > > >-----Original Message-----
> > > >From: dev_zero [mailto:dev_xor-eZNTXLQAfP4@public.gmane.org]=20
> > > >Sent: 2004=E5=B9=B411=E6=9C=8810=E6=97=A5 1:06
> > > >To: Yu, Luming
> > > >Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > >Subject: RE: [ACPI] kacpid problems
> > > >
> > > >When I try to output the event file I do this:
> > > >[root@balder: /proc/acpi]# cat event >
> > > /home/event.log
> > > >
> > > >But then It just stands there without doing
> > > anything.
> > > >So i tried to check what was wrong (ps ax) command:
> > > >2922 pts/0    S+     0:00 cat event
> > > >
> > > >I don't know if it is supposed to be suspended?
> > > >> I want to know what kind of events could be
> > > >> generated heavily, which could have corresponding
> > > >> pending execution of AML method issued to work
> > > queue
> > > >> handled by kacpid.  So just cat /proc/acpi/event
> > > >
> > > >> event.log
> > > >> to me when you were observing abnormal  cpu
> > > >> consumption by kacpid. =20
> > > >>=20
> > > >> Thanks
> > > >> Luming=20
> > > >>=20
> > > >> >-----Original Message-----
> > > >> >From: dev_zero [mailto:dev_xor-eZNTXLQAfP4@public.gmane.org]=20
> > > >> >Sent: 2004=C3=84=C3=AA11=C3=94=C3=8210=C3=88=C3=95 0:00
> > > >> >To: Yu, Luming
> > > >> >Subject: RE: [ACPI] kacpid problems
> > > >> >
> > > >> >Of course.. But which log files do you want to
> > > take
> > > >> a
> > > >> >look at?
> > > >> >> >How am i supppose to get an output from
> > > >> >> >/proc/acpi/event ??? I can't access the file,
> > > >> >> because
> > > >> >> >it's in use.
> > > >> >>=20
> > > >> >> Just kill acpid or the similar.
> > > >> >>=20
> > > >> >>=20
> > > >> >>
> > > >>
> > >
> > >>-------------------------------------------------------
> > > >> >> This SF.Net email is sponsored by:
> > > >> >> Sybase ASE Linux Express Edition - download
> > > now
> > > >> for
> > > >> >> FREE
> > > >> >> LinuxWorld Reader's Choice Award Winner for
> > > best
> > > >> >> database on Linux.
> > > >> >>
> > > >>
> > > http://ads.osdn.com/?ad_idU88&alloc_id=12065&op=3Dclick
> > > >> >>
> > > _______________________________________________
> > > >> >> Acpi-devel mailing list
> > > >> >> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > >> >>
> > > >>
> > >
> > >>https://lists.sourceforge.net/lists/listinfo/acpi-devel
> > > >> >> =20
> > > >> >
> > > >> =20
> > > >
> > >=20
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.Net email is sponsored by:
> > Sybase ASE Linux Express Edition - download now for FREE
> > LinuxWorld Reader's Choice Award Winner for best database on Linux.
> > http://ads.osdn.com/?ad_id=3D5588&alloc_id=3D12065&op=3Dclick
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_idU88&alloc_id=12065&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click

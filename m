From: "Wang, Zhenyu" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: kacpid problems
Date: Thu, 11 Nov 2004 09:22:28 +0800
Message-ID: <20041111012228.GA18032@zhen-devel.sh.intel.com>
References: <20041110155455.GA14675@zhen-devel.sh.intel.com> <20041110170945.38831.qmail@web25310.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041110170945.38831.qmail-uk6eOWkoXtXGRxTy+Q50vsz6deESKz/lQQ4Iyu8u01E@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

copy these from acpi_thermal_remove, does this workaround your issue?

--- acpi-2.6/drivers/acpi/thermal.c~remove_queue_work	2004-11-10 23:38:51.0=
00000000 +0800
+++ acpi-2.6/drivers/acpi/thermal.c	2004-11-11 09:19:57.365634568 +0800
@@ -472,6 +472,13 @@ acpi_thermal_critical (
 	printk(KERN_EMERG "Critical temperature reached (%ld C), shutting down.\n=
", KELVIN_TO_CELSIUS(tz->temperature));
 	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz->trips.c=
ritical.flags.enabled);
=20
+	tz->zombie =3D 1;
+	/* wait for running timer (on other CPUs) finish */
+	del_timer_sync(&(tz->timer));
+	/* synchronize deferred task */
+	acpi_os_wait_events_complete(NULL);
+	/* deferred task may reinsert timer */
+	del_timer_sync(&(tz->timer));
 	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);
=20
 	return_VALUE(0);


On 2004.11.10 18:09:45 +0000, dev_zero wrote:
> This patch actually made some difference. I could play
> much longer now. First it started lagging, then it
> stopped, then it started lagging again, then it
> stopped. It went like this for a while, but after I
> had played som more, it started lagging again but now
> it didn't stop.
>=20
>  --- "Wang, Zhenyu" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:=20
> > oops,
> >=20
> > ---
> > acpi-2.6/drivers/acpi/thermal.c~remove_queue_work
> > 2004-11-10 23:38:51.693022464 +0800
> > +++ acpi-2.6/drivers/acpi/thermal.c	2004-11-10
> > 23:52:40.820975856 +0800
> > @@ -472,6 +472,8 @@ acpi_thermal_critical (
> >  	printk(KERN_EMERG "Critical temperature reached
> > (%ld C), shutting down.\n",
> > KELVIN_TO_CELSIUS(tz->temperature));
> >  	acpi_bus_generate_event(device,
> > ACPI_THERMAL_NOTIFY_CRITICAL,
> > tz->trips.critical.flags.enabled);
> > =20
> > +	tz->zombie =3D 1;
> > +	acpi_os_wait_events_complete(NULL);
> > =20
> >
> acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);
> > =20
> >  	return_VALUE(0);
> >=20
> > If this has no help, maybe others eat up kacpid..
> >=20
> > On 2004.11.10 23:44:33 +0000, Wang, Zhenyu wrote:
> > > Pls try this patch,
> > >=20
> > > ---
> > acpi-2.6/drivers/acpi/thermal.c~remove_queue_work =20
> > 2004-11-10 23:38:51.693022464 +0800
> > > +++ acpi-2.6/drivers/acpi/thermal.c     2004-11-10
> > 23:39:50.195128792 +0800
> > > @@ -472,6 +472,7 @@ acpi_thermal_critical (
> > >         printk(KERN_EMERG "Critical temperature
> > reached (%ld C), shutting down.\n",
> > KELVIN_TO_CELSIUS(tz->temperature));
> > >         acpi_bus_generate_event(device,
> > ACPI_THERMAL_NOTIFY_CRITICAL,
> > tz->trips.critical.flags.enabled);
> > >=20
> > > +       tz->zombie =3D 1;
> > >       =20
> >
> acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);
> > >=20
> > >         return_VALUE(0);
> > >=20
> > > Is this work?
> > >=20
> > > -zhen
> > >=20
> > > On 2004.11.10 14:33:35 +0000, dev_zero wrote:
> > > > kacpid still runns with 99%cpu usage when the
> > cpu gets
> > > > too hot. I tried the game quake 2. You can play
> > around
> > > > 10 -15 minutes before the kacpid starts running
> > on 99%
> > > > cpu usage. I also used quake 2 too test the
> > kernel
> > > > before I applied your patch.
> > > >=20
> > > >  --- "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:=20
> > > > > It means there was NO event generated at that
> > time.
> > > > > Do you think the symptom is gone with my debug
> > > > > patch?
> > > > > If so, I think your box need a more sane
> > schedule
> > > > > for acpi_thermal_check=20
> > > > > And, I can come up with a patch.
> > > > >=20
> > > > > Thanks
> > > > > Luming=20
> > > > >=20
> > > > > >-----Original Message-----
> > > > > >From: dev_zero [mailto:dev_xor-eZNTXLQAfP4@public.gmane.org]=20
> > > > > >Sent: 2004=E5=B9=B411=E6=9C=8810=E6=97=A5 1:06
> > > > > >To: Yu, Luming
> > > > > >Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > > > >Subject: RE: [ACPI] kacpid problems
> > > > > >
> > > > > >When I try to output the event file I do
> > this:
> > > > > >[root@balder: /proc/acpi]# cat event >
> > > > > /home/event.log
> > > > > >
> > > > > >But then It just stands there without doing
> > > > > anything.
> > > > > >So i tried to check what was wrong (ps ax)
> > command:
> > > > > >2922 pts/0    S+     0:00 cat event
> > > > > >
> > > > > >I don't know if it is supposed to be
> > suspended?
> > > > > >> I want to know what kind of events could be
> > > > > >> generated heavily, which could have
> > corresponding
> > > > > >> pending execution of AML method issued to
> > work
> > > > > queue
> > > > > >> handled by kacpid.  So just cat
> > /proc/acpi/event
> > > > > >
> > > > > >> event.log
> > > > > >> to me when you were observing abnormal  cpu
> > > > > >> consumption by kacpid. =20
> > > > > >>=20
> > > > > >> Thanks
> > > > > >> Luming=20
> > > > > >>=20
> > > > > >> >-----Original Message-----
> > > > > >> >From: dev_zero [mailto:dev_xor-eZNTXLQAfP4@public.gmane.org]=20
> > > > > >> >Sent: 2004=C3=84=C3=AA11=C3=94=C3=8210=C3=88=C3=95 0:00
> > > > > >> >To: Yu, Luming
> > > > > >> >Subject: RE: [ACPI] kacpid problems
> > > > > >> >
> > > > > >> >Of course.. But which log files do you
> > want to
> > > > > take
> > > > > >> a
> > > > > >> >look at?
> > > > > >> >> >How am i supppose to get an output from
> > > > > >> >> >/proc/acpi/event ??? I can't access the
> > file,
> > > > > >> >> because
> > > > > >> >> >it's in use.
> > > > > >> >>=20
> > > > > >> >> Just kill acpid or the similar.
> > > > > >> >>=20
> > > > > >> >>=20
> > > > > >> >>
> > > > > >>
> > > > >
> > > >
> >
> >>-------------------------------------------------------
> > > > > >> >> This SF.Net email is sponsored by:
> > > > > >> >> Sybase ASE Linux Express Edition -
> > download
> > > > > now
> > > > > >> for
> > > > > >> >> FREE
> > > > > >> >> LinuxWorld Reader's Choice Award Winner
> > for
> > > > > best
> > > > > >> >> database on Linux.
> > > > > >> >>
> > > > > >>
> > > > >
> > http://ads.osdn.com/?ad_idU88&alloc_id=12065&op=3Dclick
> > > > > >> >>
> > > > >
> > _______________________________________________
> > > > > >> >> Acpi-devel mailing list
> > > > > >> >> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > > > >> >>
> > > > > >>
> > > > >
> > > >
> >
> >>https://lists.sourceforge.net/lists/listinfo/acpi-devel
> > > > > >> >> =20
> > > > > >> >
> > > > > >> =20
> > > > > >
> > > > >=20
> > > >=20
> > > >=20
> > > >
> >
> -------------------------------------------------------
> > > > This SF.Net email is sponsored by:
> > > > Sybase ASE Linux Express Edition - download now
> > for FREE
> > > > LinuxWorld Reader's Choice Award Winner for best
> > database on Linux.
> > > >
> >
> http://ads.osdn.com/?ad_id=3D5588&alloc_id=3D12065&op=3Dclick
> > > > _______________________________________________
> > > > Acpi-devel mailing list
> > > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > >
> >
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> > >=20
> > >=20
> > >
> >
> -------------------------------------------------------
> > > This SF.Net email is sponsored by:
> > > Sybase ASE Linux Express Edition - download now
> > for FREE
> > > LinuxWorld Reader's Choice Award Winner for best
> > database on Linux.
> > >
> > http://ads.osdn.com/?ad_idU88&alloc_id=12065&op=3Dclick
> > > _______________________________________________
> > > Acpi-devel mailing list
> > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > >
> >
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> > =20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=3D5588&alloc_id=3D12065&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click

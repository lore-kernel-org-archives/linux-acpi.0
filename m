From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: problems with acpi (sleep states) on vaio notebook z1sp
Date: Tue, 23 Dec 2003 18:30:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031223163056.GD1632@luna.mooo.com>
References: <C386328088ED7F4E9F81AFBABDDF60DA03B3664F@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C386328088ED7F4E9F81AFBABDDF60DA03B3664F-Yw6hFe9C1vnHQcBQSaPqJq0fmWJ9l57d0E9HWUfgJXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 23, 2003 at 03:43:23PM +0800, Ow Mun Heng wrote:
>=20
>=20
> > -----Original Message-----
> > From: Carlo E. Prelz [mailto:fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org]
> > Sent: Tuesday, December 23, 2003 3:27 PM
> >=20
> > Quoting Yu, Luming (luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org):
> >=20
> > > 	S3 doesn't resume for your too? So far, I found VARIO z1sp,
> > > Fujitsu Lifebook S series (6120D), ASUS M2400N cannot=20
> > resume from S3.=20
> > >=20
> > > 	It looks like a generic problem.
> >=20
> > The same happens with my Asus M3700N (centrino). After=20
> > echo 3 > /proc/acpi/sleep, some messages on the screen indicate that
> > the system is about to go to sleep, and very quickly the screen goes
> > dark and the blue on-light starts to blink. Then, if I press the on
> > button again, the on-light turns stable on again, but this is not
> > followed by a return back to life. If I keep the on-button pressed on
> > for a long time, the system goes off. But then, when trying to turn it
> > on again, it attempts to boot for 1 second, and then turns off
> > again. Only clicking the general reset button (the one you reach from
> > the bottom of the machine with a pin) brings it back to life.
>=20
> On my D600.. I can get S3 to work.. and it can also come back to life.. If
> not mistaken,
> the mouse would be all screwed up but, going to a Virtual console and back
> to the GUI fixes it.
>=20
> Only problem is my Date&Time is screwed up. It keeps the Time&Date at the
> time of sleep!!! I'm not sure if that's due to ACPI or something else..
>=20

Its probably because the system keeps its own time and on syncs it with
the hardware clock on bootup and shutdown (maybe a cron job, don't
know).
Try suspend using

acho 3 /proc/acpi/sleep && hwclock --hctosys

> =20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

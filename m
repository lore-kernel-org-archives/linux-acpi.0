From: Fedor Karpelevitch <fedor.karpelevitch-X80Pqrzrk4F8zQARNC3f2A@public.gmane.org>
Subject: RE: [LinuxPresario900] Re: DSDT fixes for Presario 900
Date: Tue, 23 Sep 2003 09:19:07 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <AA1E1F7FC9E1124F999E37BFA1DD344766DC36@iris.win.barra.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fedor Karpelevitch <fedor.karpelevitch-f8cN8pwTcO8AvxtiuMwx3w@public.gmane.org>, "'linuxpresario900-+vy+FFr6rAI3CPJRO4ggG/Z8FUJU4vz8@public.gmane.org'" <linuxpresario900-+vy+FFr6rAI3CPJRO4ggG/Z8FUJU4vz8@public.gmane.org>, 'Fedor Karpelevitch' <fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
Cc: 'acpi-devel' <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

sorry, what I sent is actually a reversed diff. you can apply it using =
-R
option.

--
fedor.

----
Nothing is more admirable than the fortitude with which millionaires
tolerate the disadvantages of their wealth.
		-- Nero Wolfe


> -----Original Message-----
> From: Fedor Karpelevitch=20
> Sent: Tuesday, September 23, 2003 9:18 AM
> To: 'linuxpresario900-+vy+FFr6rAI3CPJRO4ggG/Z8FUJU4vz8@public.gmane.org'; Fedor Karpelevitch
> Cc: acpi-devel
> Subject: RE: [LinuxPresario900] Re: [ACPI] DSDT fixes for Presario =
900
>=20
>=20
> > -----Original Message-----
> > From: S=E9rgio Monteiro Basto [mailto:sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org]
> > Sent: Monday, September 22, 2003 10:20 PM
> > To: Fedor Karpelevitch
> > Cc: LinuxPresario900-+vy+FFr6rAI3CPJRO4ggG/Z8FUJU4vz8@public.gmane.org; acpi-devel
> > Subject: [LinuxPresario900] Re: [ACPI] DSDT fixes for Presario 900
> >=20
> >=20
> > Hi!
> > I can you give a diff of your orig dsl and your corrected dsl?
> >=20
> > BTW:=20
> http://developer.intel.com/technology/iapc/acpi/downloads.htm as
> > been updated in September 19, 2003 and have some things new=20
> > for presario
> > for example mine 706EA , now compiles without any error or=20
> warning !.
> >=20
> > thanks
>=20
> see attachment. most of the differences are just additional=20
> debugging output.
>=20
>=20
> > =20
> >=20
> > On Fri, 2003-09-19 at 22:39, Fedor Karpelevitch wrote:
> > > Hi, people!
> > >=20
> > > I finally got around to fixing some of the annoying acpi=20
> problems I=20
> > > was experiencing:
> > >=20
> > > 1) lid state reported incorrectly ("open" when closed and=20
> "closed"=20
> > > when open)
> > >=20
> > > 2) lack of AC plug/unplug events
> > >=20
> > > one remaining annoying problem is double powerbutton events=20
> > (i get two=20
> > > events when I press button once). For what I understand it=20
> > cannot be=20
> > > fixed by DSDT since it is handled as fixed-feature.
> > >=20
> > > Attached are: source and compiled DSDT and a patch to=20
> > vanilla 2.4.22=20
> > > (maybe it will apply to 2.6 kernels too) to have this fixed DSDT=20
> > > override the one from ROM...
> > >=20
> > > I would be interested to hear
> > >=20
> > > 1) do other people experience same issues on presario 900=20
> > (and maybe=20
> > > Evos) in all it's permutations
> > > 2) if yes, does this patch remedy these problems?
> > >=20
> > > I would appreciate you sending me your DSDTs (cat=20
> > /proc/acpi/dsdt to a=20
> > > file) to see if they all have it identical or not...
> > >=20
> > > Thanks.
> > >=20
> > > Fedor.
> > > ----
> >=20
> > --=20
> > S=E9rgioMB
> > email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
> >=20
> > Who gives me one shell, give me everything.
> >=20
> > _______________________________________________
> > LinuxPresario900 mailing list
> > LinuxPresario900-+vy+FFr6rAI3CPJRO4ggG/Z8FUJU4vz8@public.gmane.org
> > http://videl.ics.hawaii.edu/mailman/listinfo/linuxpresario900
> >=20
>=20


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: "=?iso-8859-2?q?Zdzis=B3aw_A=2E?= Kaleta" <sanskryt-FWhLrETftxM@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Mon, 10 Jan 2005 14:51:36 +0100
Message-ID: <200501101451.36702.sanskryt@op.pl>
References: <41D56002.5060008@mega.ist.utl.pt> <41DAB539.2020605@arrakis.dhis.org> <m2oefyzplr.fsf@phoenix.squirrel.nl>
Reply-To: sanskryt-FWhLrETftxM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2oefyzplr.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dnia niedziela 09 stycznia 2005 14:41, Johan Vromans napisa=B3:
> Pedro Venda <pjvenda-pQd4kjVL+RHfqL7NgpvPWWD2FQJk+8+b@public.gmane.org> writes:
> > I actually read some of the pdf you pointed me to and implemented a
> > couple of functions on the smartbattery.c. It now gets much more
> > information from the battery. If you find it relevant, I'll clean it
> > up a bit and post a patch for you. I know it will soon be dumped,
> > but it may show useful when debugging other driver informations.
>
> The attached program produces a nice battery status display using your
> modified version of battstat. It may be temporary, but at least now I
> have decent battery info at hand.
>
> -- Johan
=46irst thank to all (especially to Bruno) for moving "smart battery proble=
m=20
ahead)
The module and smartbattery program has compiled at kernels 2.6.10 (vanilia=
=20
and with the ac8, bk7, bk11 and bk12 patches)
The effect was=20
sanskryt@kender:/usr/local/download/acpi/smartbattery$ smartbattery 1
status: charging
current:       1957 mA
time to full:  105 minutes
remain:        3020 mAh
charge state:  74%
temperature:   35.8 C
voltage:       16451 mV
So it look great.
Two problems:
=46irst the /dev/i2c-1 node can be read only by root. I think that the batt=
ery=20
status has to be readably for ordinary user.
Second: I can't execute battstat program.
after installing Tk::ProgressBar from Cpan and linking smartbattery to=20
smartbattery2 in /usr/local/bin there are two mistakes:
"Global symbol "$smbus" requires explicit package name at ./battstat.pl lin=
e=20
70." I change $smbus for "1"
and then
"Use of uninitialized value in concatenation (.) or string at ./battstat.pl=
=20
line 96.
Use of uninitialized value in numeric lt (<) at ./battstat.pl line 77.
Use of uninitialized value in numeric gt (>) at ./battstat.pl line 87.
Use of uninitialized value in numeric lt (<) at ./battstat.pl line 87."

which I don't know what to do with.
The lines after I make some editing and commenting are
70 - "my $res =3D `smartbattery2 $smbus 2>&1`;"
77 - "$tp =3D $current < 0 ? 'empty' : 'full';
87 - "if ( $current > 0 ) { # charging"
96 - "$mw->title("Battery: $time ($status%)");"
May be You can advise how to solve this before the battery can be read form=
=20
normal /proc/acpi/battery and /proc/acpi/ac-adapter ;-/
=2D-=20
z.a.kaleta (sanskryt), registered Linux User #279350


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

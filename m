From: "=?iso-8859-2?q?Zdzis=B3aw_A=2E?= Kaleta" <sanskryt-FWhLrETftxM@public.gmane.org>
Subject: Re: Smart Battery System driver
Date: Tue, 18 Jan 2005 00:58:43 +0100
Message-ID: <200501180058.44021.sanskryt@op.pl>
References: <41E81C2C.8010809@bartol.udel.edu> <200501172211.37583.sanskryt@op.pl>
Reply-To: sanskryt-FWhLrETftxM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200501172211.37583.sanskryt-FWhLrETftxM@public.gmane.org>
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

Dnia poniedzia=B3ek 17 stycznia 2005 22:11, Zdzis=B3aw A. Kaleta napisa=B3:
> Dnia pi=B1tek 14 stycznia 2005 20:23, Rich Townsend napisa=B3:
> > Accordingly, I've written a first shot at an SBS ACPI driver. This
> > driver, which can be downloaded from
> >
> > http://shayol.bartol.udel.edu/~rhdt/download/acpi_sbs-20040114.tar.gz
> >
> > ...provides access to the SBS via a new /proc/acpi/sbs interface, and
> > also provides a "legacy" /proc/acpi/battery interface that current
> > battery-monitoring tools can access. This driver depends on Bruno's
> > i2c-acpi-ec driver, which I have included with my source code since a
> > couple of bug fixes were necessary.
>
> This is realy great.
> I have:
> 1. patched the 2.6.10 kernel with Bruno patch
> 2. compiled the kernel without ac and battery modules in acpi tree;
> 3. compiled and instaled the i2c_acpi_ec and acpi_sbs moudules;
> 4. instaled acpid package from debian;
> and now I have the klaptopdaemon in Kde window manager showing when the
> laptop is on ac or on battery with the info.
> Congratulations and thanks for all persons involvd in this project.
Some more info - the laptop is Acer Travelmate 4001 VLMIwith Pentium (R) M=
=20
processor 1.50Ghz stepping 06.
Except info abourt source of power after all moves described above the=20
klaptopdaemon applet permit me to change the position throttling=20
in /proc/acpi/procesor/CPU0.
With this way I can put the throttling for 00%, 12%, 25%, 37%, 50%, 62%, 75=
%=20
and 87% which corespondent to T0 to T7 state.
Of course I can't be sure that anything is realy done for processor but I c=
an=20
inform that using mechnism from Klaptopdaemon applet I can change the info=
=20
show in the file /proc/acpi/processor/CPU0/throttling.
This mechanism didn't change the info in /proc/acpi/processor/CPU0/performa=
nce=20
file.
May be this can help You. If any other info is neccesary I can try to deliv=
er=20
it if You inform me what to do.
=2D-=20
z.a.kaleta (sanskryt), registered Linux User #279350


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

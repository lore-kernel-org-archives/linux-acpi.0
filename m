From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: acpi-20031203-2.6.0.diff brokes the battery status readings with 2.6.0 in DELL Inspiron 8500
Date: Fri, 19 Dec 2003 16:23:42 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031219142342.GB7009@luna.mooo.com>
References: <20031219010004.179b5059.XaRz69@terra.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031219010004.179b5059.XaRz69-pCzzcW6XgXY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 19, 2003 at 01:00:04AM +0100, Pere Casta?er wrote:
> I've just aplyied last patch into 2.6.0 stable release and it brokes th=
e battery monitor from acpi in /proc/acpi/battery/BAT0/status...because o=
f this gnome-battery applet don't shows any information.
>=20
> Do you need more information?
>=20
> PS:with acpi included on 2.6.0 all works fine.
>=20

Someone on the swsusp list also mentioned having similar (the same?)
problem with 2.4.23.
/proc/acpi/battery/BAT0/status stated correctly whether the battery was
present or not but didn't give any info about the charge level/state
etc.

>=20
> --=20
> "Soy una piedra, no muevo ni un m?sculo,lentamente me pongo nieve=20
> en la boca para que no vea mi aliento , me tomo mi tiempo,=20
> dejo que se acerque, s?lo tengo una bala, apunto a sus ojos, muy=20
> suavemente mi dedo presiona el gatillo,mi pulso no tiembla, no=20
> tengo miedo: ahora ya soy mayor"
> 					     Enemy at gates
> ------
> Pere Casta?er Sard?=A0 - http://xarz.no-ip.org
> GnuPG Public key available - http://xarz.no-ip.org/keys.html
> Computer Science Student on UOC - http://www.uoc.edu
> Linux Registered User #232073=20
> Debian/GNU User - http://www.debian.org
> ---------------------




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

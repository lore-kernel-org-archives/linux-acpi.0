From: Ernst Herzberg <earny-euM3SP4ZHrg@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Fri, 4 Oct 2002 00:11:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210040011.34762.earny@net4u.de>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com> <200209260406.48808.earny@net4u.de> <20020930020016.A90@toy.ucw.cz>
Reply-To: earny-euM3SP4ZHrg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020930020016.A90-muQmgwBScQHrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Montag, 30. September 2002 04:00, Pavel Machek wrote:
> Hi!
>
>   > Yupp, i can reproduce this. Heated up with burnP6 an a little 'part=
ial
>   > cooling
> >
> > preventer' to aprox. 65 to 75=B0C (the temperature display jumps betw=
een
> > this values in the thermalzone, fan is forced 'off', means running ha=
lf
> > speed). The laptop is doing his job without problems...  i type reboo=
t:
> >
> > [.... the kernel loads ....]
> > md: ... autorun DONE.
> > NET4: Linux TCP/IP 1.0 for NET4.0
> > IP Protocols ICMP, UDP, TCP, IGMP
> > Unable to handle kernel NULL pinter dereference at virtual address
> > 00000004 printing eip
> > c011fe45
> > *pde =3D 00000000
> > Oops: 0002
> > CPU:    0
> > EIP:    0010:[<c011fe45>]  Not tainted
>
> Can you ksymoops it?

------

Fixed with acpi-20021002 (doublechecked)

Thx, great work :)

<Earny>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

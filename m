From: Ernst Herzberg <earny-euM3SP4ZHrg@public.gmane.org>
Subject: Re: Re: ACPI source patches updated (20021101)
Date: Sun, 3 Nov 2002 01:29:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211030129.17514.earny@net4u.de>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A49E@orsmsx119.jf.intel.com> <m2y98ct3fm.fsf@tnuctip.rychter.com> <20021102224828.31af38a2.hanno@gmx.de>
Reply-To: earny-euM3SP4ZHrg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021102224828.31af38a2.hanno-Mmb7MZpHnFY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Cc: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Samstag, 2. November 2002 22:48, Hanno B=F6ck wrote:
> > Doesn't boot on my machine (Sharp Mebius PC-MT1-H5). The kernel start=
s
> > booting, then thousands of ACPI debug messages scroll by. All I can s=
ay
> > about them is that they are related to mutexes, they scroll way too f=
ast
> > for me to read them and I don't know of any way to stop them scrollin=
g.
>
> Had a similar problem. WHen I disabled acpi debug messages, i could boo=
t
> without problems.
>

Similar problem on a Germicom M6-T. With debug messages enabled the kerne=
l=20
will not boot, without _any_ message. With debugging disabled everything=20
works fine.

<Earny>


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en

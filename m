From: Mark Pritchard <mark.pritchard-acpi-3o+aUUpM7Xj0CCvOHzKKcA@public.gmane.org>
Subject: Re: Re: No battery information - Compaq Evo N800v, 2.4.20pre8, acpi 20021002
Date: Thu, 10 Oct 2002 21:53:59 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210102144.39692.mark.pritchard-acpi@modus.com.au>
References: <200210091825.LAA28601@ptolemy.la.asu.edu> <1034196724.1820.2.camel@p2710>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1034196724.1820.2.camel-QUVSR2uV0NY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Troy Schultz <tschultz-zzOxFVvAfJPQT0dZR+AlfA@public.gmane.org>
Cc: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hey,

Thanks for writing back Troy...I gave that a try, but no joy. I'll have a=
 poke=20
around my AML and see if I can puzzle something out.

Thanks again,

Mark

On Thu, 10 Oct 2002 06:52, Troy Schultz wrote:
> You may find that you need to power-up the notebook with the AC
> unplugged.  There seems to be a problem on many of the Compaq systems
> where the thermal and battery zones do not properly initialize if AC
> power is applied at power-up.
>
> My Compaq Presario 2710CA has this problem, and if I power-up with no A=
C
> to after the BIOS has initialized (Boot loader appears) then all is OK
> with both the battery and thermal zones.  The later BIOS updates from
> Compaq have still not resolved this issue.
>
> - Troy
>
> On Wed, 2002-10-09 at 14:25, Kevin Schmidt wrote:
> > I have a Compaq evo n1000v which is very similar (the dsdt says n800)=
=2E
> > I am running 2.4.19+xfs+acpi-20020918 with a patched dsdt.
> > The dsdt changes were:
> > 1. Deleted the leading from variables flagged by errors as suggested
> > in other messages to this list.
> > 2. Added External definitions for variables not found
> > and commented out the Alias line that caused a compiler error. This
> > allowed the dsdt to compile with some warnings about missing return
> > types. I tried adding zero returns to those, and the warnings went aw=
ay
> > but I could not detect any change in the way the machine ran.
> >
> > After the dsdt changes, the ac_adapter was detected properly and it
> > detects when it is plugged in or removed. The lid switch and the
> > power button give events and I see /proc/battery, but the battery is
> > not detected. There are still a couple of errors in dmesg from the
> > dsdt.
> >
> > I know next to nothing about what this really does, so use this at
> > your own risk. It does appear that the problems are dsdt related.
> >
> > Kevin Schmidt
> >
> > > From: Mark Pritchard <mark.pritchard-acpi-3o+aUUpM7Xj0CCvOHzKKcA@public.gmane.org>
> > > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > Date: Tue, 8 Oct 2002 11:15:21 +1000
> > > Subject: [ACPI] No battery information - Compaq Evo N800v, 2.4.20pr=
e8,
> > > acpi 20021002
> > >
> > > Hi,
> > >
> > > I'm having a problem with seeing battery status on my Compaq Evo N8=
00v.
> > > T=3D he=3D20
> > > proc filesystem has plenty of entries for everything other than the
> > > batte=3D ry=3D20
> > > (I've included a list below).=3D20
> > >
> > > I'd really appreciate some advice, and I'm more than happy to provi=
de
> > > mor=3D e=3D20
> > > info/test things.
> > >
> > > Cheers
> > >
> > > Mark Pritchard
> >
> > =3D-------------------------------------------------------------
> > Kevin Schmidt, w9cf-iy676YoZKZKAgX/H7s3LlTe48wsgrGvP@public.gmane.org, http://fermi.la.asu.edu/w9cf
> > Department of Physics and Astronomy
> > Arizona State University, Tempe, AZ 85287-1504
> > (480) 965-8240 Fax: (480) 965-7954
> >
> >
> > -------------------------------------------------------
> > This sf.net email is sponsored by:ThinkGeek
> > Welcome to geek heaven.
> > http://thinkgeek.com/sf
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: Re: [PATCH v3 0/4] Fix Win8 backlight issue
Date: Wed, 25 Sep 2013 10:29:37 +0200
Message-ID: <CADDKRnCAZ0DtBUUaMfdTF=yk6PDLpbc9jkuvWWO8hYW4TDLxKw@mail.gmail.com>
References: <1380016052-15315-1-git-send-email-aaron.lu@intel.com>
	<1380026575.3371.1.camel@ThinkPad-X230.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0364840238=="
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1380026575.3371.1.camel@ThinkPad-X230.localdomain>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Cc: James Hogan <james@albanarts.com>, Martin Steigerwald <Martin@lichtvoll.de>, Felipe Contreras <felipe.contreras@gmail.com>, dri-devel@lists.freedesktop.org, Matthew Garrett <matthew.garrett@nebula.com>, Mike Galbraith <bitbucket@online.de>, Kalle Valo <kvalo@adurom.com>, Yves-Alexis Perez <corsac@debian.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lee Chun-Yi <joeyli.kernel@gmail.com>, Ben Jencks <ben@bjencks.net>, intel-gfx <intel-gfx@lists.freedesktop.org>, Joerg Platte <jplatte@naasa.net>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, "Rafael J. Wysocki" <rjw@sisk.pl>, Seth Forshee <seth.forshee@canonical.com>, Aaron Lu <aaron.lu@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Purdie <rpurdie@rpsys.net>
List-Id: linux-acpi@vger.kernel.org

--===============0364840238==
Content-Type: multipart/alternative; boundary=047d7b33d08ccbbebe04e7310da6

--047d7b33d08ccbbebe04e7310da6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Backlight can't be modified with this patch set -  neither with function
keys nor
with the gui. It is a step backward to v3.11-rc1

Video driver: i915
FUJITSU LIFEBOOK AH532/FJNBB1C, BIOS Version 1.09 05/22/2012

acpi_backlight=3Dvideo works.

J=C3=B6rg


2013/9/24 Igor Gnatenko <i.gnatenko.brain@gmail.com>

> On Tue, 2013-09-24 at 17:47 +0800, Aaron Lu wrote:
> > v3:
> > 1 Add a new patch 4/4 to fix some problems in thinkpad-acpi module;
> > 2 Remove unnecessary function acpi_video_unregister introduced in
> >   patch 2/3 as pointed out by Jani Nikula.
> >
> > v2:
> > v1 has the subject of "Rework ACPI video driver" and is posted here:
> > http://lkml.org/lkml/2013/9/9/74
> > Since the objective is really to fix Win8 backlight issues, I changed
> > the subject in this version, sorry about that.
> >
> > This patchset has three patches, the first introduced a new API named
> > backlight_device_registered in backlight layer that can be used for
> > backlight interface provider module to check if a specific type backlig=
ht
> > interface has been registered, see changelog for patch 1/3 for details.
> > Then patch 2/3 does the cleanup to sepeate the backlight control and
> > event delivery functionality in the ACPI video module and patch 3/3
> > solves some Win8 backlight control problems by avoiding register ACPI
> > video's backlight interface if:
> > 1 Kernel cmdline option acpi_backlight=3Dvideo is not given;
> > 2 This is a Win8 system;
> > 3 Native backlight control interface exists.
> >
> > Technically, patch 2/3 is not required to fix the issue here. So if you
> > think it is not necessary, I can remove it from the series.
> >
> > Aaron Lu (4):
> >   backlight: introduce backlight_device_registered
> >   ACPI / video: seperate backlight control and event interface
> >   ACPI / video: Do not register backlight if win8 and native interface
> >     exists
> >   thinkpad-acpi: fix handle locate for video and query of _BCL
> >
> >  drivers/acpi/internal.h              |   5 +-
> >  drivers/acpi/video.c                 | 442
> ++++++++++++++++++++---------------
> >  drivers/acpi/video_detect.c          |  14 +-
> >  drivers/platform/x86/thinkpad_acpi.c |  31 ++-
> >  drivers/video/backlight/backlight.c  |  31 +++
> >  include/acpi/video.h                 |   2 +
> >  include/linux/backlight.h            |   4 +
> >  7 files changed, 324 insertions(+), 205 deletions(-)
> >
>
> Excellent! I've tested this patch-set on ThinkPad X230 and backlight
> issue is exhausted.
>
> Thanks.
>
> --
> Igor Gnatenko
> Fedora release 20 (Heisenbug)
> Linux 3.11.1-300.fc20.x86_64
>
>

--047d7b33d08ccbbebe04e7310da6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Backlight can&#39;t be modified with this patch set - =C2=
=A0neither with function keys nor<div>with the gui. It is a step backward t=
o v3.11-rc1</div><div><br></div><div>Video driver: i915<br></div><div>FUJIT=
SU LIFEBOOK AH532/FJNBB1C, BIOS Version 1.09 05/22/2012<br>
</div><div><br></div><div>acpi_backlight=3Dvideo works.</div><div><br></div=
><div>J=C3=B6rg</div></div><div class=3D"gmail_extra"><br><br><div class=3D=
"gmail_quote">2013/9/24 Igor Gnatenko <span dir=3D"ltr">&lt;<a href=3D"mail=
to:i.gnatenko.brain@gmail.com" target=3D"_blank">i.gnatenko.brain@gmail.com=
</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
ue, 2013-09-24 at 17:47 +0800, Aaron Lu wrote:<br>
&gt; v3:<br>
&gt; 1 Add a new patch 4/4 to fix some problems in thinkpad-acpi module;<br=
>
&gt; 2 Remove unnecessary function acpi_video_unregister introduced in<br>
&gt; =C2=A0 patch 2/3 as pointed out by Jani Nikula.<br>
&gt;<br>
&gt; v2:<br>
&gt; v1 has the subject of &quot;Rework ACPI video driver&quot; and is post=
ed here:<br>
&gt; <a href=3D"http://lkml.org/lkml/2013/9/9/74" target=3D"_blank">http://=
lkml.org/lkml/2013/9/9/74</a><br>
&gt; Since the objective is really to fix Win8 backlight issues, I changed<=
br>
&gt; the subject in this version, sorry about that.<br>
&gt;<br>
&gt; This patchset has three patches, the first introduced a new API named<=
br>
&gt; backlight_device_registered in backlight layer that can be used for<br=
>
&gt; backlight interface provider module to check if a specific type backli=
ght<br>
&gt; interface has been registered, see changelog for patch 1/3 for details=
.<br>
&gt; Then patch 2/3 does the cleanup to sepeate the backlight control and<b=
r>
&gt; event delivery functionality in the ACPI video module and patch 3/3<br=
>
&gt; solves some Win8 backlight control problems by avoiding register ACPI<=
br>
&gt; video&#39;s backlight interface if:<br>
&gt; 1 Kernel cmdline option acpi_backlight=3Dvideo is not given;<br>
&gt; 2 This is a Win8 system;<br>
&gt; 3 Native backlight control interface exists.<br>
&gt;<br>
&gt; Technically, patch 2/3 is not required to fix the issue here. So if yo=
u<br>
&gt; think it is not necessary, I can remove it from the series.<br>
&gt;<br>
&gt; Aaron Lu (4):<br>
&gt; =C2=A0 backlight: introduce backlight_device_registered<br>
&gt; =C2=A0 ACPI / video: seperate backlight control and event interface<br=
>
&gt; =C2=A0 ACPI / video: Do not register backlight if win8 and native inte=
rface<br>
&gt; =C2=A0 =C2=A0 exists<br>
&gt; =C2=A0 thinkpad-acpi: fix handle locate for video and query of _BCL<br=
>
&gt;<br>
&gt; =C2=A0drivers/acpi/internal.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 5 +-<br>
&gt; =C2=A0drivers/acpi/video.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 442 ++++++++++++++++++++---------------<br>
&gt; =C2=A0drivers/acpi/video_detect.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A014 +-<br>
&gt; =C2=A0drivers/platform/x86/thinkpad_acpi.c | =C2=A031 ++-<br>
&gt; =C2=A0drivers/video/backlight/backlight.c =C2=A0| =C2=A031 +++<br>
&gt; =C2=A0include/acpi/video.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 2 +<br>
&gt; =C2=A0include/linux/backlight.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 4 +<br>
&gt; =C2=A07 files changed, 324 insertions(+), 205 deletions(-)<br>
&gt;<br>
<br>
</div></div>Excellent! I&#39;ve tested this patch-set on ThinkPad X230 and =
backlight<br>
issue is exhausted.<br>
<br>
Thanks.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Igor Gnatenko<br>
Fedora release 20 (Heisenbug)<br>
Linux 3.11.1-300.fc20.x86_64<br>
<br>
</font></span></blockquote></div><br></div>

--047d7b33d08ccbbebe04e7310da6--

--===============0364840238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============0364840238==--

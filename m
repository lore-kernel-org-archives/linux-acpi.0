From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] acer-wmi: add video_vendor quirk for Acer Aspire E1-572
Date: Mon, 13 Jan 2014 15:05:50 +0800
Message-ID: <1389596750.24105.224.camel@linux-s257.site>
References: <1386248428-5767-1-git-send-email-linux@rempel-privat.de>
	 <1388116274.3539.6046.camel@linux-s257.site>
	 <1388118336.3539.6055.camel@linux-s257.site>
	 <52C42821.3020801@rempel-privat.de>
	 <1388666346.3539.6065.camel@linux-s257.site>
	 <52CAD7B3.6060508@rempel-privat.de>
	 <1389251197.24105.20.camel@linux-s257.site>
	 <52CE59CD.7070805@rempel-privat.de>
	 <1389258310.24105.82.camel@linux-s257.site>  <52D35444.4060301@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <52D35444.4060301@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>, matthew.garrett@nebula.com, platform-driver-x86@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

=E6=96=BC =E4=B8=80=EF=BC=8C2014-01-13 =E6=96=BC 10:49 +0800=EF=BC=8CAa=
ron Lu =E6=8F=90=E5=88=B0=EF=BC=9A
> On 01/09/2014 05:05 PM, joeyli wrote:
> > =E6=96=BC =E5=9B=9B=EF=BC=8C2014-01-09 =E6=96=BC 09:11 +0100=EF=BC=8C=
Oleksij Rempel =E6=8F=90=E5=88=B0=EF=BC=9A
> >> Am 09.01.2014 08:06, schrieb joeyli:
> >>> =E6=96=BC =E4=B8=80=EF=BC=8C2014-01-06 =E6=96=BC 17:20 +0100=EF=BC=
=8COleksij Rempel =E6=8F=90=E5=88=B0=EF=BC=9A
> >>>>> I think Aaron's patches can fix it on E1-572. Let's wait until =
v3.13
> >>>>> version released then look at maybe someone report issue again.
> >>>>>
> >>>>> Very appreciate for your patch.
> >>>>>
> >>>>> Joey Lee
> >>>>>
> >>>>
> >>>> Hi Joey,
> >>>>
> >>>> i have access to this hardware for next two weeks. Theoretically=
 this
> >>>> kernel should have patches you was talking about:
> >>>> http://kernel.ubuntu.com/~kernel-ppa/mainline/daily/2014-01-06-t=
rusty/
> >>>>
> >>>> it works with video.use_native_backlight=3D1.
> >>>>
> >>>> If you need more testing, you have two weeks ;)
> >>>>
> >>>> --=20
> >>>> Regards,
> >>>> Oleksij
> >>>>
> >>>
> >>> Thanks for your testing, then I think just use
> >>> video.use_native_backlight to fix issue on Aspire E1-572. Don't n=
eed add
> >>> quirk to acer-wmi driver.
> >>
> >> You mean editing grub and adding kernel option?
> >=20
> > Good point!
> >=20
> > Looks we need add Aspire E1-572 to the video_dmi_table in
> > drivers/acpi/video.c, like:
> > http://lists.freedesktop.org/archives/dri-devel/2013-November/04942=
7.html
> >=20
> > But this patch doesn't in mainline.=20
> >=20
> > Do you want send a patch to Aaron Lu for add Aspire E1-572 to list?=
 or
> > maybe we can ping Aaron to direct add it.
>=20
> Since it is shipped with Win8, I think the following patch should tak=
e
> care of it:
> [PATCH] ACPI / video: Use native backlight control interface by defau=
lt
> http://www.spinics.net/lists/linux-acpi/msg47755.html
>=20
> Last time Daniel seems to agree to merge it for test purpose, but I
> didn't see it get merged somewhere yet.
>=20
> Thanks,
> Aaron
>=20

Will we removed all video_set_use_native_backlight devices in
video_dmi_table quirk table after the above patch merged?

Just wonder what is our strategy of those issue machines? Add to quirk
table or will enable native backlight control by default?


Thanks a lot!
Joey Lee

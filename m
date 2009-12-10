From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] asus-laptop: add Lenovo SL LenovoCare LED support
Date: Thu, 10 Dec 2009 11:14:23 +0100
Message-ID: <20091210101423.GF2446@ucw.cz>
References: <1260257169-7227-1-git-send-email-ike.pan@canonical.com> <20091210100935.GB2446@ucw.cz> <71cd59b00912100238l7fe78abcrd07328c15b65971d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933721AbZLJKkC@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <71cd59b00912100238l7fe78abcrd07328c15b65971d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Ike Panhc <ike.pan@canonical.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, Alexandre Rostovtsev <tetromino@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Thu 2009-12-10 11:38:00, Corentin Chary wrote:
> On Thu, Dec 10, 2009 at 11:09 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Tue 2009-12-08 15:26:09, Ike Panhc wrote:
> >> From: Ike Panhc <ikepanhc@canonical.com>
> >>
> >> This patch is to enable the LenovoCare LED support on Lenovo SL la=
ptop. Based
> >> on the found of the control interface by Alexandre Rostovtsev
> >>
> >> Turn on the LenovoCare LED:
> >> =A0(As root privileges) echo 1 > /sys/class/leds/asus\:\:LenovoCar=
e/brightness
> >> Trun off the LenovoCare LED:
> >> =A0(As root privileges) echo 0 > /sys/class/leds/asus\:\:LenovoCar=
e/brightness
> >>
> >> The patch against current checkout of acpi4asus is below.
> >
> > Is the driver severely misnamed by now? I believe Lenovo and ASUS a=
re
> > pretty different firms...
> >
>=20
> Lenovo ship DSDT with similar ATKD interace.
> See http://git.iksaif.net/?p=3Dacpi4asus.git;a=3Dcommitdiff;h=3D31a38=
147625c283b58137db45e7507cd1e49aa05
>=20

So what? Rename the driver... having Asus::lenovocare led is just wrong=
=2E

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html

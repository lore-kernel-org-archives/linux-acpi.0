From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 00/32] acpi-video: Rewrite backlight interface
 selection logic
Date: Thu, 18 Jun 2015 14:05:47 -0700
Message-ID: <20150618210547.GA70097@vmdeb7>
References: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
 <4163515.a4pVZ0oOei@vostro.rjw.lan>
 <20150617033921.GA29788@vmdeb7>
 <CAJZ5v0hyct5tSGAAjw=Gt1H60=jsQFgA+=baQqsWi4Hjvqk4mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hyct5tSGAAjw=Gt1H60=jsQFgA+=baQqsWi4Hjvqk4mw@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 17, 2015 at 11:36:13AM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 17, 2015 at 5:39 AM, Darren Hart <dvhart@infradead.org> wrote:
> > On Tue, Jun 16, 2015 at 01:22:40AM +0200, Rafael Wysocki wrote:
> >> On Friday, June 12, 2015 01:23:19 PM Hans de Goede wrote:
> >> > Hi All,
> >> >
> >> > Here is v2 of my rewrite / cleanup of the acpi-video (and platform/x86)
> >> > backlight interface selection logic.
> >> >
> >> > The major change in v2 of this set are 2 changes to the patch titled
> >> > "acpi-video-detect: video: Make video_detect code part of the video module":
> >> >
> >> > 1) The __setup call for the acpi_backlight= handling is moved to
> >> >    acpi/util.c as __setup may only be used by code which is always builtin
> >> > 2) video.c is renamed to acpi_video.c so that it can be combined with
> >> >    video_detect.c into video.ko
> >> >
> >> > These 2 changes result in the backlight kernel commandline options after this
> >> > patch-set being 100% compatible with the old options, with the exception of
> >> > the removal of the video.use_native_backlight option as that now is folded
> >> > into acpi_backlight=[video|vendor|native|none] rather then having 2 options
> >> > which influence each other in interesting ways.
> >> >
> >> > Besides that there is a small change to the dell-laptop port to the new API
> >> > removing an unnecessary #ifdef ACPI.
> >>
> >> I tried to queue this series up for 4.2, but patch [06/32] didn't apply for me,
> >> so I decided to apply another patch I've got recently instead and which is now
> >> in my linux-next branch.
> >>
> >> Can you please rebase the series on top of linux-pm.git/linux-next and resend it?
> >
> > Rafael, do you intent to carry this entire series and submit via linux-pm?
> 
> Yes, I do.

In that case,

Acked-by: Darren Hart <dvhart@linux.intel.com>

For the platform/drivers/x86 patches.

-- 
Darren Hart
Intel Open Source Technology Center

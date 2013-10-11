From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 0/4] Fix Win8 backlight issue
Date: Sat, 12 Oct 2013 01:27:52 +0200
Message-ID: <3899323.lQYrFPeQhE@vostro.rjw.lan>
References: <1381498066-16011-1-git-send-email-aaron.lu@intel.com>
	<1712683.D4Gy4SDE7p@vostro.rjw.lan>
	<CA+5PVA4xFQ82FdQ3RfcV4aAzZZ6onfOUWb9Z+ZFBP-Ay7sEsKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <CA+5PVA4xFQ82FdQ3RfcV4aAzZZ6onfOUWb9Z+ZFBP-Ay7sEsKQ@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: James Hogan <james@albanarts.com>, Martin Steigerwald <Martin@lichtvoll.de>, Felipe Contreras <felipe.contreras@gmail.com>, DRI mailing list <dri-devel@lists.freedesktop.org>, platform-driver-x86@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <matthew.garrett@nebula.com>, Mike Galbraith <bitbucket@online.de>, Kalle Valo <kvalo@adurom.com>, Yves-Alexis Perez <corsac@debian.org>, linux-acpi@vger.kernel.org, Lee Chun-Yi <joeyli.kernel@gmail.com>, Ben Jencks <ben@bjencks.net>, =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, Joerg Platte <jplatte@naasa.net>, intel-gfx@lists.freedesktop.org, Seth Forshee <seth.forshee@canonical.com>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, Richard Purdie <rp>
List-Id: linux-acpi@vger.kernel.org

On Friday, October 11, 2013 06:01:43 PM Josh Boyer wrote:
> On Fri, Oct 11, 2013 at 6:10 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, October 11, 2013 12:42:43 PM Josh Boyer wrote:
> >> On Fri, Oct 11, 2013 at 9:27 AM, Aaron Lu <aaron.lu@intel.com> wrote:
> >> > v5:
> >> > 1 Introduce video.use_native_backlight module parameter and set its
> >> >   value to false by default as suggested by Rafael. For Win8 systems
> >> >   which have broken ACPI video backlight control, the parameter can be
> >> >   set to 1 in kernel cmdline to skip registering ACPI video's backlight
> >> >   interface. Due to this change, the acpi_video_verify_backlight_support
> >> >   is moved from video_detect.c to video.c - patch 3/4;
> >>
> >> That's a fairly untenable position for distro kernels to be in.  They
> >> now have to ask every user that reports an issue with the backlight to
> >> try setting that option on the command line.  While I appreciate the
> >> setting breaks things for some people, doesn't the Win8 issue impact
> >> far more people?  Shouldn't it be defaulted to true?
> >
> > Well, we have a rule in the kernel not to introduce regressions for users even
> > if they are minority.
> >
> >> If nothing else, can you add a config option for the default so
> >> distros can use that to decide which way to default it and then work
> >> on fixing the remaining users that have troubles?
> >
> > The current plan is to create a blacklist of systems where that option should
> > be set.  We actually already have one, but it is at the _OSI() level, which
> > is overkill in my view and may affect things beyond backlight.  Along with that
> > we will debug systems where setting that option (to true) causes problems to
> > happen, so that we'll be able to drop it going forward (hopefully).
> >
> > Of course, distro kernels may always change the default to true if they want.
> 
> They can, but they'd need to either patch the kernel to do so, or code
> it in userspace bootloader configs.  Having a config option they can
> set to change the default makes it reasonable and contained within the
> kernel.

If we are to use a Kconfig option, why don't we use one instead of rather than
in addition to a command line option?  Say, we have
CONFIG_ACPI_VIDEO_WIN8_WORKAROUND and if that is set, the code will work like
the previous version of the Aaron's patchset (the one without
video.use_native_backlight)?

Opinions?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

From: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Subject: Re: [PATCH v5 0/4] Fix Win8 backlight issue
Date: Sat, 12 Oct 2013 01:01:36 +0400
Message-ID: <1381525296.2373.1.camel@ThinkPad-X230.localdomain>
References: <1381498066-16011-1-git-send-email-aaron.lu@intel.com>
	<CA+5PVA5RfbJjLaZNDN81tvWYhm1pLuu9OpMTwMfUpC4ma4ac4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <CA+5PVA5RfbJjLaZNDN81tvWYhm1pLuu9OpMTwMfUpC4ma4ac4A@mail.gmail.com>
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
Cc: James Hogan <james@albanarts.com>, Martin Steigerwald <Martin@lichtvoll.de>, Felipe Contreras <felipe.contreras@gmail.com>, DRI mailing list <dri-devel@lists.freedesktop.org>, platform-driver-x86@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <matthew.garrett@nebula.com>, Mike Galbraith <bitbucket@online.de>, Kalle Valo <kvalo@adurom.com>, Yves-Alexis Perez <corsac@debian.org>, linux-acpi@vger.kernel.org, Lee Chun-Yi <joeyli.kernel@gmail.com>, Ben Jencks <ben@bjencks.net>, =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, intel-gfx@lists.freedesktop.org, Joerg Platte <jplatte@naasa.net>, Seth Forshee <seth.forshee@canonical.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, Richard Purdie <rpurdi>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2013-10-11 at 12:42 -0400, Josh Boyer wrote:
> On Fri, Oct 11, 2013 at 9:27 AM, Aaron Lu <aaron.lu@intel.com> wrote:
> > v5:
> > 1 Introduce video.use_native_backlight module parameter and set its
> >   value to false by default as suggested by Rafael. For Win8 systems
> >   which have broken ACPI video backlight control, the parameter can be
> >   set to 1 in kernel cmdline to skip registering ACPI video's backlight
> >   interface. Due to this change, the acpi_video_verify_backlight_support
> >   is moved from video_detect.c to video.c - patch 3/4;
> 
> That's a fairly untenable position for distro kernels to be in.  They
> now have to ask every user that reports an issue with the backlight to
> try setting that option on the command line.  While I appreciate the
> setting breaks things for some people, doesn't the Win8 issue impact
> far more people?  Shouldn't it be defaulted to true?
> 
> If nothing else, can you add a config option for the default so
> distros can use that to decide which way to default it and then work
> on fixing the remaining users that have troubles?
> 
> josh

I think more better to use this unregister as default and give option to
disable it.

-- 
Igor Gnatenko
Fedora release 20 (Heisenbug)
Linux 3.11.4-301.fc20.x86_64

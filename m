From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: [PATCH v5 0/4] Fix Win8 backlight issue
Date: Sat, 12 Oct 2013 04:47:14 -0700
Message-ID: <CA+5PVA7P2ah-qR0mKpRJ6ut60KsEL+coTb-tdRfFJp-RFeCycw@mail.gmail.com>
References: <1381498066-16011-1-git-send-email-aaron.lu@intel.com>
	<CA+5PVA5RfbJjLaZNDN81tvWYhm1pLuu9OpMTwMfUpC4ma4ac4A@mail.gmail.com>
	<1712683.D4Gy4SDE7p@vostro.rjw.lan>
	<1381557623.3261.69.camel@scapa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1381557623.3261.69.camel@scapa>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: James Hogan <james@albanarts.com>, Martin Steigerwald <Martin@lichtvoll.de>, DRI mailing list <dri-devel@lists.freedesktop.org>, platform-driver-x86@vger.kernel.org, Matthew Garrett <matthew.garrett@nebula.com>, Mike Galbraith <bitbucket@online.de>, Kalle Valo <kvalo@adurom.com>, linux-acpi@vger.kernel.org, Lee Chun-Yi <joeyli.kernel@gmail.com>, Ben Jencks <ben@bjencks.net>, =?ISO-8859-1?Q?J=F6rg_Otte?= <jrg.otte@gmail.com>, intel-gfx@lists.freedesktop.org, Joerg Platte <jplatte@naasa.net>, Seth Forshee <seth.forshee@canonical.com>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Kamal Mostafa <kamal@canonical.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, Richard Purdie <rpurdie@rpsys.net>
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 11, 2013 at 11:00 PM, Yves-Alexis Perez <corsac@debian.org> wrote:
> On sam., 2013-10-12 at 00:10 +0200, Rafael J. Wysocki wrote:
>> On Friday, October 11, 2013 12:42:43 PM Josh Boyer wrote:
>> > On Fri, Oct 11, 2013 at 9:27 AM, Aaron Lu <aaron.lu@intel.com> wrote:
>> > > v5:
>> > > 1 Introduce video.use_native_backlight module parameter and set its
>> > >   value to false by default as suggested by Rafael. For Win8 systems
>> > >   which have broken ACPI video backlight control, the parameter can be
>> > >   set to 1 in kernel cmdline to skip registering ACPI video's backlight
>> > >   interface. Due to this change, the acpi_video_verify_backlight_support
>> > >   is moved from video_detect.c to video.c - patch 3/4;
>> >
>> > That's a fairly untenable position for distro kernels to be in.  They
>> > now have to ask every user that reports an issue with the backlight to
>> > try setting that option on the command line.  While I appreciate the
>> > setting breaks things for some people, doesn't the Win8 issue impact
>> > far more people?  Shouldn't it be defaulted to true?
>>
>> Well, we have a rule in the kernel not to introduce regressions for users even
>> if they are minority.
>
> Well, for some users, the regression actually happened when support for
> Win8 OSI call was introduced.

Yes, this is true.  It's probably one of the more common bug reports
we get in this area.  Kernels prior to that have working backlight,
kernels after that don't.

josh

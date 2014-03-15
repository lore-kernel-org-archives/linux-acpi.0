From: "Stefan Lippers-Hollmann" <s.L-H@gmx.de>
Subject: Re: 3.14-rc: /proc/acpi/battery gone?
Date: Sat, 15 Mar 2014 02:17:47 +0000
Message-ID: <201403150217.50526.s.L-H@gmx.de>
References: <20140314211456.GA23213@amd.pavel.ucw.cz> <CAKb7Uvh1TaNLmi0YVBPmCD571ZU_sM1DpbYUSA8xQZnS5xUbCA@mail.gmail.com> <1677000.FsvVVRjEvo@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1677000.FsvVVRjEvo@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ilia Mirkin <imirkin@alum.mit.edu>, Lan Tianyu <tianyu.lan@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi

On Saturday 15 March 2014, Rafael J. Wysocki wrote:
> On Friday, March 14, 2014 06:14:12 PM Ilia Mirkin wrote:
> > On Fri, Mar 14, 2014 at 6:11 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > > On Fri 2014-03-14 17:29:41, Ilia Mirkin wrote:
> > >> On Fri, Mar 14, 2014 at 5:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
[...]
> > wmbattery
> > 
> > They have attempted to use the sysfs api, but apparently that
> > integration was done with an older version of that API. There's also
> > some attempt to get it to work with upower, but I couldn't figure out
> > how to make that work either on my (up-to-date gentoo) box. (TBH I
> > didn't spend more than an hour or two on it, so it may not be
> > impossible.)
> 
> Tianyu, can you please have a look at this?

Disclaimer, I've never used wmbattery so far.

The current upstream version (2.42, released in early december 2013) 
of wmbattery[1] no longer reads from /proc/acpi/ at all. Apparently
it changed to using upower by default, with non-default fall-backs for
reading from sysfs. 

The only change required for building upower with wmbattery 2.42 
appears to be a new build-dependency on libupower-glib-dev (at least 
on Debian, built from the upower source package). Given that this 
version is present in Debian testing and unstable, I'd assume that it's
supposed to work using upower, although I haven't confirmed that myself.

Judging from the Gentoo ebuild, you probably just have to add 
"sys-power/upower" to the RDEPEND variable and make sure to build
wmbattery 2.42; this is untested.

Regards
	Stefan Lippers-Hollmann

[1]	Homepage: http://kitenet.net/~joey/code/wmbattery/
	Vcs-Git: git://git.kitenet.net/wmbattery

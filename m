From: Frans Pop <elendil@planet.nl>
Subject: Re: [SOMEWHAT SOLVED] Niced processes do not raise CPU frequency with ondemand
Date: Sat, 13 Jun 2009 20:01:01 +0200
Message-ID: <200906132001.02828.elendil@planet.nl>
References: <200906121844.02004.elendil@planet.nl> <1244828508.4534.1404.camel@localhost.localdomain> <200906122005.02965.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Cpsmtpm-eml108.kpnxchange.com ([195.121.3.12]:55368 "EHLO
	CPSMTPM-EML108.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754683AbZFMSBD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 Jun 2009 14:01:03 -0400
In-Reply-To: <200906122005.02965.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Friday 12 June 2009, Frans Pop wrote:
> On Friday 12 June 2009, Pallipadi, Venkatesh wrote:
> > On Fri, 2009-06-12 at 10:25 -0700, Frans Pop wrote:
> > > On Friday 12 June 2009, Pallipadi, Venkatesh wrote:
> > > > What does ignore_nice under cpufreq/ondemand say?
> > >
> > > Right, that's 1 (was not aware that existed :-P)
> > > And changing it to 0 solves the problem.
> >
> > > Next question is: how and why does it get set?
> > > As userland has not changed (AFAIK), my first suspect remains the
> > > kernel.
> >
> > Kernel never sets this. It is initialized to 0 and provides a /sys
> > interface to user. I think it is set by some user app
> > (gnome-power-manager or some other app like that). That explains why
> > it is 0 initially after boot and gets changed later.

I think I have it figured out.

HAL has a method 'SetCPUFreqConsiderNice' which writes the file.
I use KDE's kpowersave, which has some code that calls that method through 
dbus and sets the value to the value of a function getAcAdapter().

I.e, the intention seems to be to ignore niced processes when not on AC 
(if I understand Matthew Garrett's blog posts correctly that is probably 
not even correct policy, but let's ignore that for now).
But it also looks like the whole implementation, either in kpowersave or 
in hal/dbus (or quite likely all three), is so crap that ignore_nice only 
actually does get set if the moon is in phase with Saturn or something 
like that. At least, I've tried undocking my notebook (removed AC) a few 
times without seeing any change in ignore_nice.

I've got an inotify on the file now, so I should get some info next time 
the setting does get changed. Possibly that will confirm this theory. 
After that I'll probably change the kpowersave source and remove the code 
that changes the setting.

Thanks again for the pointers!

Cheers,
FJP

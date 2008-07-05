From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: bug? acpi p-state + ondemand keeps dropping max freq
Date: Sat, 5 Jul 2008 21:49:08 +0200
Message-ID: <20080705194908.GA13149@atjola.homenet>
References: <20080606140846.GA9580@ucw.cz> <20080607213918.GC1746@elf.ucw.cz> <20080607145435.4afc9812@infradead.org> <20080616104159.GA28659@elf.ucw.cz> <20080616074337.46d6f411@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:44241 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752118AbYGETtN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Jul 2008 15:49:13 -0400
Content-Disposition: inline
In-Reply-To: <20080616074337.46d6f411@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pavel Machek <pavel@suse.cz>, auke-jan.h.kok@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com, cpufreq@lists.linux.org.uk, davej@codemonkey.org.uk

On 2008.06.16 07:43:37 -0700, Arjan van de Ven wrote:
> On Mon, 16 Jun 2008 12:42:00 +0200
> Pavel Machek <pavel@suse.cz> wrote:
>=20
> > On Sat 2008-06-07 14:54:35, Arjan van de Ven wrote:
> > > On Sat, 7 Jun 2008 23:39:18 +0200
> > > Pavel Machek <pavel@suse.cz> wrote:
> > >=20
> > > > > # echo 1866000 > scaling_max_freq ; cat scaling_max_freq
> > > > > 800000
> > > > > # echo 1866000 > scaling_max_freq ; cat scaling_max_freq
> > > > > 800000
> > > > >=20
> > > > >=20
> > > > > This renders my Dothan to utterly poor speeds. (standard T43)
> > > > >=20
> > > > > performance cpufreq governor makes no difference - I still ca=
n't
> > > > > change the frequency upper/lower values.
> > > >=20
> > > > Hmm, I have similar problem in Novell bugzilla, on very differe=
nt
> > > > hw:
> > > >=20
> > > > https://bugzilla.novell.com/show_bug.cgi?id=3D396311
> >=20
> > > are either of you running gnome-power-manager or kpowersaved ?
> > > sometimes these programs (and more likely, the patches added by a
> > > distro maintainer who doesn't fully realize how power works) tend=
 to
> > > muck with kernel settings around CPU frequency that they have
> > > absolutely no business touching...
> >=20
> > In novel bugzilla case ignore_ppc=3D1 helped, so it seems to be BIO=
S
> > problem, not userland's...
>=20
> well as long as the user doesn't use this for production use... the
> BIOS often reduces frequencies available to deal with thermal
> situations, so it's not a good idea to ignore that.

Yep, seems to be a thermal thing. I managed to find some time to play
around with it a bit, and running a cpu hog for a short period of time,
while watching temperature and scaling_max_freq showed this:

cpufreq# cat /proc/acpi/thermal_zone/THM0/temperature
temperature:             49 C
cpufreq# cat scaling_max_freq
1866000

cpufreq# cat /proc/acpi/thermal_zone/THM0/temperature
temperature:             51 C
cpufreq# cat scaling_max_freq
1866000

cpufreq# cat /proc/acpi/thermal_zone/THM0/temperature
temperature:             52 C
cpufreq# cat scaling_max_freq
1866000

cpufreq# cat /proc/acpi/thermal_zone/THM0/temperature
temperature:             53 C
cpufreq# cat scaling_max_freq
1866000

cpufreq# cat /proc/acpi/thermal_zone/THM0/temperature
temperature:             54 C
cpufreq# cat scaling_max_freq
800000

cpufreq# cat /proc/acpi/thermal_zone/THM0/temperature
temperature:             53 C
cpufreq# cat scaling_max_freq
800000

cpufreq# cat /proc/acpi/thermal_zone/THM0/temperature
temperature:             51 C
cpufreq# cat scaling_max_freq
800000

cpufreq# cat /proc/acpi/thermal_zone/THM0/temperature
temperature:             51 C
cpufreq# cat scaling_max_freq
800000

cpufreq# cat /proc/acpi/thermal_zone/THM0/temperature
temperature:             50 C
cpufreq# cat scaling_max_freq
800000

cpufreq# cat /proc/acpi/thermal_zone/THM0/temperature
temperature:             49 C
cpufreq# cat scaling_max_freq
1866000


So upon reaching 54=B0C some throttling kicks in and only when going ba=
ck
to less then 50=B0C, that limit is lifted again. Too bad that with Linu=
x,
this T43 already runs at about 47=B0C when idle, so as soon as there's =
any
load on the cpu, it will scale up for a few seconds and then get
throttled :-(

There's no userspace powersave foo involved here, just the plain
ondemand scaling governor, same happens with the performance governor.

Bj=F6rn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: bug? acpi p-state + ondemand keeps dropping max freq
Date: Sat, 5 Jul 2008 22:04:34 +0200
Message-ID: <20080705200434.GA13278@atjola.homenet>
References: <20080606140846.GA9580@ucw.cz> <20080607213918.GC1746@elf.ucw.cz> <20080607145435.4afc9812@infradead.org> <20080616104159.GA28659@elf.ucw.cz> <20080616074337.46d6f411@infradead.org> <20080705194908.GA13149@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:52114 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752463AbYGEUEi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Jul 2008 16:04:38 -0400
Content-Disposition: inline
In-Reply-To: <20080705194908.GA13149@atjola.homenet>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pavel Machek <pavel@suse.cz>, auke-jan.h.kok@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com, cpufreq@lists.linux.org.uk, davej@codemonkey.org.uk

On 2008.07.05 21:49:08 +0200, Bj=F6rn Steinbrink wrote:
> On 2008.06.16 07:43:37 -0700, Arjan van de Ven wrote:
> > On Mon, 16 Jun 2008 12:42:00 +0200
> > Pavel Machek <pavel@suse.cz> wrote:
> >=20
> > > On Sat 2008-06-07 14:54:35, Arjan van de Ven wrote:
> > > > On Sat, 7 Jun 2008 23:39:18 +0200
> > > > Pavel Machek <pavel@suse.cz> wrote:
> > > >=20
> > > > > > # echo 1866000 > scaling_max_freq ; cat scaling_max_freq
> > > > > > 800000
> > > > > > # echo 1866000 > scaling_max_freq ; cat scaling_max_freq
> > > > > > 800000
> > > > > >=20
> > > > > >=20
> > > > > > This renders my Dothan to utterly poor speeds. (standard T4=
3)
> > > > > >=20
> > > > > > performance cpufreq governor makes no difference - I still =
can't
> > > > > > change the frequency upper/lower values.
> > > > >=20
> > > > > Hmm, I have similar problem in Novell bugzilla, on very diffe=
rent
> > > > > hw:
> > > > >=20
> > > > > https://bugzilla.novell.com/show_bug.cgi?id=3D396311
> > >=20
> > > > are either of you running gnome-power-manager or kpowersaved ?
> > > > sometimes these programs (and more likely, the patches added by=
 a
> > > > distro maintainer who doesn't fully realize how power works) te=
nd to
> > > > muck with kernel settings around CPU frequency that they have
> > > > absolutely no business touching...
> > >=20
> > > In novel bugzilla case ignore_ppc=3D1 helped, so it seems to be B=
IOS
> > > problem, not userland's...
> >=20
> > well as long as the user doesn't use this for production use... the
> > BIOS often reduces frequencies available to deal with thermal
> > situations, so it's not a good idea to ignore that.
>=20
> Yep, seems to be a thermal thing. I managed to find some time to play
> around with it a bit, and running a cpu hog for a short period of tim=
e,
> while watching temperature and scaling_max_freq showed this:
>=20
[snip]
>=20
>=20
> So upon reaching 54=B0C some throttling kicks in and only when going =
back
> to less then 50=B0C, that limit is lifted again. Too bad that with Li=
nux,
> this T43 already runs at about 47=B0C when idle, so as soon as there'=
s any
> load on the cpu, it will scale up for a few seconds and then get
> throttled :-(

OK, a stop at thinkwiki[1] later, I know what's happening now. The BIOS
has a few settings regarding CPU speed on AC/battery. One is about
balancing power and noise. The above throttling does no longer kick in
if that option is set to "Maximum Power".

Bj=F6rn

[1] http://www.thinkwiki.org/wiki/How_to_make_use_of_Dynamic_Frequency_=
Scaling#Troubleshooting
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

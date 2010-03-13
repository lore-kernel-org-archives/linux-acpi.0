From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.34-rc1: lockdep warning on geode subnotebook
Date: Sat, 13 Mar 2010 12:14:03 +0100
Message-ID: <20100313111402.GA2192@elf.ucw.cz>
References: <20100313105109.GA9966@elf.ucw.cz>
 <201003131159.47768.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:51826 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759016Ab0CMLOJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 Mar 2010 06:14:09 -0500
Content-Disposition: inline
In-Reply-To: <201003131159.47768.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, ACPI mailing list <linux-acpi@vger.kernel.org>

On Sat 2010-03-13 11:59:47, Oliver Neukum wrote:
> Am Samstag, 13. M=E4rz 2010 11:51:09 schrieb Pavel Machek:
> > sysfs related? ACPI?
> >=20
> > Switching to clocksource acpi_pm
> > Switched to NOHz mode on CPU #0
> > BUG: key df3f6edc not in .data!
> > ------------[ cut here ]------------
> > WARNING: at kernel/lockdep.c:2706 lockdep_init_map+0x448/0x500()
> > Hardware name: SA Series
>=20
> I get the same warning. It is not specific to that hardware.

Yep, happens on thinkpad x60, too.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

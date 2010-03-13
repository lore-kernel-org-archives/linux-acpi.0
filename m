From: Oliver Neukum <oliver@neukum.org>
Subject: Re: 2.6.34-rc1: lockdep warning on geode subnotebook
Date: Sat, 13 Mar 2010 11:59:47 +0100
Message-ID: <201003131159.47768.oliver@neukum.org>
References: <20100313105109.GA9966@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:57336 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758969Ab0CMK7w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Mar 2010 05:59:52 -0500
In-Reply-To: <20100313105109.GA9966@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, ACPI mailing list <linux-acpi@vger.kernel.org>

Am Samstag, 13. M=E4rz 2010 11:51:09 schrieb Pavel Machek:
> sysfs related? ACPI?
>=20
> Switching to clocksource acpi_pm
> Switched to NOHz mode on CPU #0
> BUG: key df3f6edc not in .data!
> ------------[ cut here ]------------
> WARNING: at kernel/lockdep.c:2706 lockdep_init_map+0x448/0x500()
> Hardware name: SA Series

I get the same warning. It is not specific to that hardware.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

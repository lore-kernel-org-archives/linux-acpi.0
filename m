From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: Writing to the EC
Date: Mon, 5 Nov 2007 00:55:37 +0000
Message-ID: <200711050055.37904.carlos@strangeworlds.co.uk>
References: <472E23BC.2010909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:54051 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbXKEAzl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Nov 2007 19:55:41 -0500
In-Reply-To: <472E23BC.2010909@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik =?iso-8859-1?q?Andr=E9n?= <erik.andren@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sunday 04 November 2007 19:55:40 Erik Andr=E9n wrote:
> To make a long story short, I've hacked up a kernel module that dumps
> the EC

=46or acer_acpi, we have a Perl script that can do this from userspace =
(but
it should run on any other machine, since there's nothing Acer specific
about dumping the EC registers).

http://aceracpi.googlecode.com/svn/trunk/acer_ec/acer_ec.pl

=2E/acer_ec.pl regs

(ACPI throws a few warnings in dmesg, because we're stepping on it's tu=
rf
a bit here, but it's far simpler than having to write a kernel module
just to get a few registers).
=20
> My questions to you ACPI and EC gurus are:
>=20
> 1. Is it possible that the EC is read-only from the OS perspective?

=46rom the acer_acpi perspective, we've found that some EC registers ar=
e
read-only (e.g. on some laptops, there is a register to read the status
of the touchpad, but writes to it are ignored).

I imagine this is defined at the hardware level though, not by the OS.

> 3. Does anyone have a recommendation of programs to use for snooping =
I/O
> accesses in windows?

I did try playing around with writing my own simple application to acce=
ss
the I/O ports, and then dump the EC data - unfortunately, I/O port prog=
ramming
in Windows is "painful", to say the least.

-Carlos
--=20
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

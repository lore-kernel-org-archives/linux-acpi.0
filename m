From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: 2.6.19: ACPI reports AC not present after resume from STD
Date: Sun, 3 Dec 2006 15:25:55 +0300
Message-ID: <200612031526.00861.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx5.mail.ru ([194.67.23.25]:44387 "EHLO mx5.mail.ru")
	by vger.kernel.org with ESMTP id S1759633AbWLCM0E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Dec 2006 07:26:04 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I started to notice it some time ago; I can't say exactly if this was not 
present in earlier versions because recently I switched from STR (which gave 
me no end of troubles) to STD. So I may have not seen it before.

Suspend to disk while on battery. Plug in AC, resume. ACPI continues to show 
AC adapter as not present:

{pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
state:                   off-line

replugging AC correctly changes state to on-line.

The system is Toshiba Portege 4000; I am not sure which information may be 
required in this case so please tell what is needed (unfortunately I will be 
off next two weeks without access to this system).

regards

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFcsJYR6LMutpd94wRAqSeAJ4n3lHqbdvgBeXxeIc9ZUTDe/X2jgCgyfU5
w+heEYYnA3Al/U9xHovOkQ4=
=F+Zu
-----END PGP SIGNATURE-----

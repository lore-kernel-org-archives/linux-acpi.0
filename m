From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.16-rc6: known regressions
Date: Fri, 17 Mar 2006 18:29:26 +0059
Message-ID: <441AF20D.5010901@gmail.com>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <20060313200544.GG13973@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from orfeus.profiwh.com ([82.100.20.117]:61195 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S1030222AbWCQR3e
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Mar 2006 12:29:34 -0500
In-Reply-To: <20060313200544.GG13973@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Avuton Olrich <avuton@gmail.com>, xfs-masters@oss.sgi.com, linux-xfs@oss.sgi.com, Dave Jones <davej@redhat.com>, len.brown@intel.com, linux-acpi@vger.kernel.org, norsk5@xmission.com, dsp@llnl.gov, bluesmoke-devel@lists.sourceforge.net, gregkh@suse.de, linux-usb-devel@lists.sourceforge.net, pete.chapman@exgate.tek.com, Olaf Hering <olh@suse.de>, paulus@samba.org, anton@samba.org, linuxppc64-dev@ozlabs.org, Tom Seeley <redhat@tomseeley.co.uk>, Jiri Slaby <jirislaby@gmail.com>, laredo@gnu.org, v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Adrian Bunk napsal(a):
> This email lists some known regressions in 2.6.16-rc6 compared to 2.6.15.
[snip]
> Subject    : Stradis driver udev brekage
> References : http://bugzilla.kernel.org/show_bug.cgi?id=6170
>              https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181063
>              http://lkml.org/lkml/2006/2/18/204
> Submitter  : Tom Seeley <redhat@tomseeley.co.uk>
>              Dave Jones <davej@redhat.com>
> Handled-By : Jiri Slaby <jirislaby@gmail.com>
> Status     : unknown
Solved, see https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181063#c16

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEGvINMsxVwznUen4RAqW3AJ9vgpxMrf7oXzj46zxtee4J4WthmQCgqYU0
xmCArHJ8Nr3UCyt68HAdbDI=
=u8yx
-----END PGP SIGNATURE-----

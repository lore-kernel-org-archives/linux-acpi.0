From: Joerg Platte <lists@naasa.net>
Subject: Re: Thinkpad suspend-to-disk regression
Date: Fri, 4 May 2007 15:33:04 +0200
Message-ID: <200705041533.05146.lists@naasa.net>
References: <3d7cf86d0704241129i23da1b9fq93876573618e9dcd@mail.gmail.com> <200705041107.45968.rjw@sisk.pl> <3d7cf86d0705040537n7bd6dfabocf5210a2f32ddc3b@mail.gmail.com>
Reply-To: jplatte@naasa.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rosi.naasa.net ([212.8.0.13]:59001 "EHLO rosi.naasa.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755296AbXEDN4p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 May 2007 09:56:45 -0400
In-Reply-To: <3d7cf86d0705040537n7bd6dfabocf5210a2f32ddc3b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guilherme Salgado <gsalgado@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

Am Freitag, 4. Mai 2007 schrieb Guilherme Salgado:

> This is what my hibernation script does, but I did it manually hoping
> that waiting a few seconds between changing /sys/power/disk and
> /sys/power/state could solve the problem. Unfortunately, it didn't; I
> still get no sound after resuming.

I had a similar problem with a recent kernel (but not with 2.6.21-rc7) =
on my=20
T40p. Sound was lost after suspend-to-disk but could be re-activated by=
=20
suspending to RAM. I did not further debug this, because I'm using susp=
end to=20
disk regularly. You can try to suspend to RAM to see if it helps.

regards,
J=F6rg

--=20
PGP Key: send mail with subject 'SEND PGP-KEY' PGP Key-ID: FD 4E 21 1D
PGP Fingerprint: 388A872AFC5649D3 BCEC65778BE0C605
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

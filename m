From: giggz <giggzounet@gmail.com>
Subject: Re: Problem with the Fn+F3 key. acpi problem ?
Date: Sat, 12 Jan 2008 14:08:25 +0100
Message-ID: <fmae78$toa$1@ger.gmane.org>
References: <fmaaj5$jsl$1@ger.gmane.org> <20080112121714.GB15173@srcf.ucam.org> <fmac61$oc8$1@ger.gmane.org> <20080112124619.GA15578@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:39600 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759662AbYALNKN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jan 2008 08:10:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JDg7l-0000BU-2r
	for linux-acpi@vger.kernel.org; Sat, 12 Jan 2008 13:10:09 +0000
Received: from cam44-1-82-67-121-239.fbx.proxad.net ([82.67.121.239])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jan 2008 13:10:09 +0000
Received: from giggzounet by cam44-1-82-67-121-239.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jan 2008 13:10:09 +0000
In-Reply-To: <20080112124619.GA15578@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Matthew Garrett a =E9crit :
> On Sat, Jan 12, 2008 at 01:33:38PM +0100, giggz wrote:
>=20
>> What is the acpi video module ?
>=20
> If you have /proc/acpi/video, it's loaded.
>=20
>> I don't have any /var/log/acpid.log
>=20
> In that case, try catting /proc/acpi/event and hit the button.
>=20

When I try cat /proc/acpi/event under root I can't access to this file.

13:54 giggz@debian /proc/acpi/video/VGA % ll /proc/acpi/event
-r-------- 1 root root 0 2008-01-12 09:45 /proc/acpi/event

14:00 root@debian /proc/acpi # LC_ALL=3DC cat /proc/acpi/event
cat: /proc/acpi/event: Device or resource busy
zsh: exit 1     LC_ALL=3DC cat /proc/acpi/event

How can I access to thsi file ?

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

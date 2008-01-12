From: giggz <giggzounet@gmail.com>
Subject: Re: Problem with the Fn+F3 key. acpi problem ?
Date: Sat, 12 Jan 2008 16:02:53 +0100
Message-ID: <fmakts$gqs$1@ger.gmane.org>
References: <fmaaj5$jsl$1@ger.gmane.org> <20080112121714.GB15173@srcf.ucam.org> <fmac61$oc8$1@ger.gmane.org> <20080112124619.GA15578@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:44779 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758236AbYALPEp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jan 2008 10:04:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JDhuX-0005nm-Cn
	for linux-acpi@vger.kernel.org; Sat, 12 Jan 2008 15:04:37 +0000
Received: from cam44-1-82-67-121-239.fbx.proxad.net ([82.67.121.239])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jan 2008 15:04:37 +0000
Received: from giggzounet by cam44-1-82-67-121-239.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jan 2008 15:04:37 +0000
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

it seems to be normal that I don't have any /var/log/acpid.log :
according to the NEWS.debian.gz from acpid package :

" Starting with version 1.0.6 acpid uses syslog instead of its own logg=
ing
  mechanism. During the upgrade of this package the old log files and t=
he
  logrotate configuration file are backed up to
  /var/backups/acpid-cruft.tar.gz and are removed from the filesystem."

So if I understand I must look at the syslog and message...but I don't
see anything in these two file...

How can I increase the level of debugging ?

>=20
> In that case, try catting /proc/acpi/event and hit the button.
>=20

Have a nice we

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

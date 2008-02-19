From: GiGGz <giggzounet@gmail.com>
Subject: Re: Problem with the Fn+F3 key. acpi problem ?
Date: Tue, 19 Feb 2008 10:44:20 +0100
Message-ID: <fpe8dk$urt$1@ger.gmane.org>
References: <fmaaj5$jsl$1@ger.gmane.org>	 <20080112121714.GB15173@srcf.ucam.org> <fmac61$oc8$1@ger.gmane.org>	 <20080112124619.GA15578@srcf.ucam.org>  <fmakts$gqs$1@ger.gmane.org> <1203347919.6019.79.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:60300 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754280AbYBSJoc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Feb 2008 04:44:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JRP1X-0006aK-31
	for linux-acpi@vger.kernel.org; Tue, 19 Feb 2008 09:44:27 +0000
Received: from dmn19.ec-nantes.fr ([130.66.111.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 19 Feb 2008 09:44:27 +0000
Received: from giggzounet by dmn19.ec-nantes.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 19 Feb 2008 09:44:27 +0000
In-Reply-To: <1203347919.6019.79.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Thomas Renninger a =C3=A9crit :
> On Sat, 2008-01-12 at 16:02 +0100, giggz wrote:
>> Matthew Garrett a =C3=A9crit :
>>> On Sat, Jan 12, 2008 at 01:33:38PM +0100, giggz wrote:
>>>
>>>> What is the acpi video module ?
>>> If you have /proc/acpi/video, it's loaded.
>>>
>>>> I don't have any /var/log/acpid.log
>> it seems to be normal that I don't have any /var/log/acpid.log :
>> according to the NEWS.debian.gz from acpid package :
>>
>> " Starting with version 1.0.6 acpid uses syslog instead of its own l=
ogging
>>   mechanism. During the upgrade of this package the old log files an=
d the
>>   logrotate configuration file are backed up to
>>   /var/backups/acpid-cruft.tar.gz and are removed from the filesyste=
m."
>>
>> So if I understand I must look at the syslog and message...but I don=
't
>> see anything in these two file...
>>
>> How can I increase the level of debugging ?
> You can download the latest SUSE live-CD, there acpi debug is compile=
d
> in.
> Or you have to compile a kernel yourself and enable CONFIG_ACPI_DEBUG=
=3Dy
> When booted, unload polling ACPI drivers (to not pollute the logs):
> rmmod battery
> rmmod ac
>=20
> Increase ACPI debug level:
> echo 0x1F >/sys/module/acpi/parameters/debug_level
> (or even: echo 0x21F >/sys/module/acpi/parameters/debug_level)
> then hit the button and you should see some output.
> Interesting e.g. would be if a notification "notify" appears and is s=
ent
> to a vendor specific device.
>=20
>>> In that case, try catting /proc/acpi/event and hit the button.
> On SUSE, instead of stopping acpid, you can use:
> acpi_listen
> to log acpi events.
>=20

Ok Thx for the infos. I will try to test it as soon as possible with th=
e=20
SUSE live-cd

Cheers,
Guillaume

>    Thomas
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

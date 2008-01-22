From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Problem with the Fn+F3 key. acpi problem ?
Date: Tue, 22 Jan 2008 13:47:47 +0800
Message-ID: <1200980867.7424.4.camel@acpi-sony.sh.intel.com>
References: <fmaaj5$jsl$1@ger.gmane.org>
	 <20080112121714.GB15173@srcf.ucam.org> <fmac61$oc8$1@ger.gmane.org>
	 <20080112124619.GA15578@srcf.ucam.org>  <fmae78$toa$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:37279 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864AbYAVFm0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jan 2008 00:42:26 -0500
In-Reply-To: <fmae78$toa$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: giggz <giggzounet@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sat, 2008-01-12 at 14:08 +0100, giggz wrote:
> Matthew Garrett a =C3=A9crit :
> > On Sat, Jan 12, 2008 at 01:33:38PM +0100, giggz wrote:
> >=20
> >> What is the acpi video module ?
> >=20
> > If you have /proc/acpi/video, it's loaded.
> >=20
> >> I don't have any /var/log/acpid.log
> >=20
> > In that case, try catting /proc/acpi/event and hit the button.
> >=20
>=20
> When I try cat /proc/acpi/event under root I can't access to this fil=
e.
>=20
> 13:54 giggz@debian /proc/acpi/video/VGA % ll /proc/acpi/event
> -r-------- 1 root root 0 2008-01-12 09:45 /proc/acpi/event
>=20
> 14:00 root@debian /proc/acpi # LC_ALL=3DC cat /proc/acpi/event
> cat: /proc/acpi/event: Device or resource busy
> zsh: exit 1     LC_ALL=3DC cat /proc/acpi/event
>=20
> How can I access to thsi file ?
Please kill acpid first.
make sure acpi video driver is loaded. (/proc/acpi/video exists)
cat /proc/acpi/event
and press fn+f3 to see what happens.

you can file a bug report at:
http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
and attach the test result here.

Thanks,
Rui
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

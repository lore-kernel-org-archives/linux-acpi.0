From: Thomas Koch <linrunner@gmx.net>
Subject: Re: [PATCH] ACPI: Add missing Thinkpad models to OSI(Linux) white
 list
Date: Fri, 14 Jun 2013 20:15:34 +0200
Message-ID: <51BB5DC6.6070808@gmx.net>
References: <51BB4312.6060302@gmx.net> <20130614174527.GA29875@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:54458 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382Ab3FNSPm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Jun 2013 14:15:42 -0400
Received: from mailout-de.gmx.net ([10.1.76.12]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MEHXK-1UYAL704Xg-00FRbo for
 <linux-acpi@vger.kernel.org>; Fri, 14 Jun 2013 20:15:41 +0200
In-Reply-To: <20130614174527.GA29875@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On 14.06.2013 19:45, Matthew Garrett wrote:
> On Fri, Jun 14, 2013 at 06:21:38PM +0200, Thomas Koch wrote:
>> acpi_osi=3DLinux helps the mute button work properly by sending Linu=
x a
>> mute key press.
>=20
> There was a proper fix for this a while back, but it never seemed to =
go=20
> anywhere. Can you try=20
> http://comments.gmane.org/gmane.linux.drivers.platform.x86.devel/1895=
=20
> and see if it works? If so we should just merge that instead.

Hi Matthew,

I'll try to merge and test your suggestion.

My patch may be ugly but has the advantage of being well tested by quit=
e
a bunch of users of my custom kernel:
https://launchpad.net/~linrunner/+archive/thinkpad-extras

Thomas

--=20
Thomas Koch =96 linrunner@gmx.net

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

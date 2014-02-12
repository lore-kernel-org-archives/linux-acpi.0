From: Phillip Susi <psusi@ubuntu.com>
Subject: Possible workaround for buggy S5
Date: Wed, 12 Feb 2014 09:31:20 -0500
Message-ID: <52FB85B8.2000307@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:39936 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbaBLObW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Feb 2014 09:31:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

A user has reported in debian bug #694926 that their laptop battery
discharges rapidly when they shutdown, unless they disable hwclock
- --systohc in the shutdown scripts.  I am not sure why that triggers
it, but I can only assume that their acpi firmware is buggy and
remaining in standby to allow for wakeups.

Is there a way to bypass the acpi firmware S5 transition and force the
system to truly power off as a workaround?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJS+4W4AAoJEI5FoCIzSKrw4poH/0X8o18N7WLrQL6H/8VIYdhN
+rh3FuJv8Q1BAHgV/a9il8mNTAemL4DNOyfwl6LSAAM4YpV6uDzA+TAmFdY+VQdL
9UWZ33vosZheuX19lP55QDfojCagSw3C1PQzn26NzlGgSuE0wZliRh/sJYcSpP0C
6oZxRYDYpZIu5RTLIV/fgr8zx3Pw/q2a6xaSRMK5p8NP3GEg3rn5gLCTCSS6ZSl9
7ecJeHCFMdrIrhTDVNKmDkCVYU5rqjF07YzWjf5lYWtMMIrg+Lo9g5rQD3qa6BvS
XclI9OXcPF9t50I8H8F8tw1ZRG3hXc/tJ3aBHEw7lRMZAyugKqQbi3/DS2uZOWw=
=f9SH
-----END PGP SIGNATURE-----

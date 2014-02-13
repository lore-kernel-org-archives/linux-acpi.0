From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: Possible workaround for buggy S5
Date: Thu, 13 Feb 2014 10:17:07 +0800
Message-ID: <52FC2B23.1030300@intel.com>
References: <52FB85B8.2000307@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14294 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbaBMCQy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Feb 2014 21:16:54 -0500
In-Reply-To: <52FB85B8.2000307@ubuntu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, =?UTF-8?B?RnJhbsOnb2lzIEJvaXNzb24=?= <user.anti-spam@maison.homelinux.net>

On 02/12/2014 10:31 PM, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> A user has reported in debian bug #694926 that their laptop battery
> discharges rapidly when they shutdown, unless they disable hwclock
> - --systohc in the shutdown scripts.  I am not sure why that triggers
> it, but I can only assume that their acpi firmware is buggy and
> remaining in standby to allow for wakeups.
>=20
> Is there a way to bypass the acpi firmware S5 transition and force th=
e
> system to truly power off as a workaround?

No idea about this. Long time ago, Fran=C3=A7ois Boisson reported a sim=
ilar
issue on kernel bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=3D47811

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

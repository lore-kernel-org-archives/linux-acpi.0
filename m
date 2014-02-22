From: Phillip Susi <psusi@ubuntu.com>
Subject: Using intel_pstate
Date: Sat, 22 Feb 2014 17:48:46 -0500
Message-ID: <5309294E.2090706@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:57151 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbaBVWsu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Feb 2014 17:48:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

The intel_pstate driver says it should be the preferred driver on
sandy bridge systems, but my system is using the acpi p state driver
instead.  According to the cpufreq Makefile this appears to be
intended as it is placed first in the link order.  Why is this and how
can I make sure the intel_pstate driver is used instead?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJTCSlKAAoJEI5FoCIzSKrwkWEIAIn9tsNcr1n/OrOCbHwKLsY6
jgXBfYJDsW7NxH2wFbyjkKdQm2XeJNgSn2JQSxQ9idI92l4+JdfYQdvG/9CTczHI
heMBVbCLnFXRsVLzFdLLpRGqXWnBoz3WV+Rvug4RiHxx144cMtDCN/n3A9UWqs7Z
BcHrqh07t4p+am6JYkDj/oAOV+DJqHpXjQmmhmA5lxsjsOMQ5k/GGLLkaI6YPE8r
wiZIdK8PMNbsgk6g7Mwap1DOG1ucMSD4aIeR1FbxDgwo8p4OVOyoepjMX/SjCOvr
bLAuw0k9zyFPSxOR5KijvobmhyxuL/wtGIgnXGzs1LzZAW+cneg5Anp2L1HgiTo=
=Pgew
-----END PGP SIGNATURE-----

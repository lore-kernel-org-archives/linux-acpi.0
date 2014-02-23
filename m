From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Using intel_pstate
Date: Sat, 22 Feb 2014 23:11:50 -0500
Message-ID: <53097506.8020407@ubuntu.com>
References: <5309294E.2090706@ubuntu.com> <9891809.rXh9YKnm5H@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:38164 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbaBWELv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Feb 2014 23:11:51 -0500
In-Reply-To: <9891809.rXh9YKnm5H@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 02/22/2014 08:23 PM, Rafael J. Wysocki wrote:
> On Saturday, February 22, 2014 05:48:46 PM Phillip Susi wrote:
>> The intel_pstate driver says it should be the preferred driver
>> on sandy bridge systems, but my system is using the acpi p state
>> driver instead.  According to the cpufreq Makefile this appears
>> to be intended as it is placed first in the link order.  Why is
>> this and how can I make sure the intel_pstate driver is used
>> instead?
> 
> Do you have CONFIG_X86_INTEL_PSTATE=y set in your .config?

Nevermind.. turns out Ubuntu has a patch to disable it by default and
you have to explicitly pass intel_pstate=enable to turn it on.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJTCXUCAAoJEI5FoCIzSKrwqzQH/iS4frc3VZ+DjrtM7Os5Nm/w
ZbZQgq70pXYdH3LIC3cR8PUefKE/h5sIPt6uM0t+GJVVfCpVItiviGhFd0Qvp6Lv
N7yj5r4up1RQJDpWcClLpytg5B4euWTQBBC4ayqGWh3rX32sVu9uRoZznjAstEKd
c+I/gH7v3f+cnvABqpOFsk/YE/LfLmyqOS+g7N3Syf9Q43WsnRo/vu9Z1q8f3nwz
T238VZXir3ElcofH+DmtZR7pDNeNObl1nfYlPgT3NDlvvygMZ/q3su/noJzcH3JF
hKbdCBtMwyxWcVWRSf/e20ZoJIZNksDt1SKLWCI/SFN1+OlFUvpUVYQmhbSxYZQ=
=xEbX
-----END PGP SIGNATURE-----

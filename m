From: Jan Willies <jan@willies.info>
Subject: BenQ S73U - no ACPI
Date: Wed, 09 May 2007 09:50:19 +0200
Message-ID: <46417D3B.4020305@willies.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from metis.intersales.de ([213.133.99.69]:42464 "EHLO
	metis.intersales.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640AbXEIJGJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 May 2007 05:06:09 -0400
Received: from e176241165.adsl.alicedsl.de ([85.176.241.165] helo=[192.168.2.101])
	by metis.intersales.de with esmtpa (Exim 4.63)
	(envelope-from <jan@willies.info>)
	id 1HlgwZ-0001vf-26
	for linux-acpi@vger.kernel.org; Wed, 09 May 2007 09:50:39 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I got a BenQ S73U and it doesn't support ACPI very well. I got 23=20
warnings when compiling /proc/acpi/dsdt with the iasl-compiler, but no=20
errors. This is confusing, it should work well cause they are only=20
warnings, not errors!
Anyway, Sebastian Lammermann managed to turn all warnings down by=20
rewriting the DSDT, but one. Unfortunately the behavior didn't change,=20
shutdown is still not working.

The last unsolved warning:

dsdt.dsl  1164:             Method (_OSC, 5, NotSerialized)
Warning  1075 -                        ^ Reserved method has too many=20
arguments (_OSC requires 4)

If anyone please have a look at the DSDT, it would be very kind! I'm=20
really desperate to get this thing working under Linux.

original: http://openwrt.loswillios.de/dsdt.dsl
modified: http://www.hft-leipzig.de/~s03114/dsdt.dsl


I mailed BenQ about this problem, they even replied which surprised me =
a=20
bit. They promised to pass the mail to their developers, but I don't=20
think it will change something... I reckon I'm not the first one who=20
mailed them about that.



regards
Jan Willies

PS. If you want a nice office-laptop, apart from the ACPI-stuff, the=20
S73U is a good deal for 599=E2=82=AC ;-)
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

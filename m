From: Mattia Dongili <malattia@linux.it>
Subject: [RFC] sonypi acpi implementation and the future
Date: Thu, 8 Mar 2007 15:13:16 +0100
Message-ID: <20070308141316.GA4229@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:50206 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbXCHONV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Mar 2007 09:13:21 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Stelian Pop <stelian@popies.net>, Len Brown <lenb@kernel.org>

Hello,

immediately to the point (and sorry for the lenght of this mail).
[Stelian: could you help putting some light on historical sonypi
material?]

What's already there:
- enable the device using acpi tables information and methods
- input layer event reporting
- acpi event reporting
my current code is here: http://www.linux.it/~malattia/sony-pic/

What's still missing:
1- bluetooth power control
2- fan speed control
3- brightness control
4- battery status/capabilities reading
5- ac status control
6- temperature reading
7- motion eye camera support
8- /dev/sonypi and its IOCTLs for the above points (1-7)

Future:
I've not dropped the idea of merging sony-laptop and sonypi, I'm
currently implementing it as a separate driver for easier testing
only.
So the great sony-laptop would deal with both the SNY5001 (SNC) and
SNY6001 (SPIC) acpi_devices, having a parameter to disable the latter
and anyway if the older/obsoleted sonypi grabs the SNY6001 device first
sony-laptop couldn't get it anyway.

1 and 2: it makes sense to implement them as platform_device
attributes[1] together with already existing sony-laptop's attributes
once I merge the drivers.

3: is in sony-laptop already (does it work also with very old laptops?
as said I have a gr7k that dates back in 2000/2001, is a Type2 and
works. I can't tell for Type1s which are even older). Stelian, out of
curiosity is the C1 the only Type1 or are there more?

4, 5 and 6: are available through ACPI, those EC hacks were mainly for
ACPI-enabled-but-using-APM older laptops.

7: could be added as is and actually modifying it would break the meye
driver (is it really still maintained?) but sonypi and sony-laptop
can't export the same symbol.

8: this would become the compat layer for /dev/sonypi using userspace,
the only problem being the AFAICT there's no easy way to get
battery/ac/tz information from within the kernel and this is what
puzzles me most now backward compatibility-wise. I'd like to make the
compat layer a Kconfig option so probably the best approach is to
implement the EC reading in case COMPAT=y.

Comments? Anything I missed? 
Thanks

[1]: I like the ibm-acpi idea of exposing the fan through
hwmon/sysfs but currently the sony fan control is completely
undocumented and I've never seen it doing anything interesting other
than reading the current speed (I suppose in RPM).
-- 
mattia
:wq!

From: Bastien Nocera <hadess@hadess.net>
Subject: mount-matrix support, user-space "done"
Date: Fri, 02 Dec 2016 18:36:06 +0100
Message-ID: <1480700166.14634.5.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58570 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753718AbcLBRgM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Dec 2016 12:36:12 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: systemd Mailing List <systemd-devel@lists.freedesktop.org>, "Thomas H.P. Andersen" <phomes@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org, linux-acpi@vger.kernel.org

Hey accelerometer lovers,

I have, bar any bugs obviously, finished adding support for "mount-
matrix" in iio-sensor-proxy.

The code reads the "ACCEL_MOUNT_MATRIX" udev property of the device,
which it will apply to raw readings. After testing, I will provide a
patch to systemd's hwdb to gather all the quirks that were provided to
me.

Note that, for now, I expect all those quirks to be added to the hwdb
file in systemd, even if available in Device Tree or the ACPI _PLD
property.

In both of those cases, as I don't have the hardware to test with,
somebody will need to add a rule to udev to extract the mount-matrix
property attached to the iio sensor device, using the "IMPORT". Hans?

For the _PLD, this isn't currently exported by the kernel at all. Maybe
a minimal version of this patch:
http://www.spinics.net/lists/linux-acpi/msg51540.html
could be added to the IIO subsystem so that the iio core exports the
information from both sources in the same way.

I expect Thomas and Carlos (both CC:'ed) to come back to me with the
quirks for their devices, so I can finalise the systemd/udev hwdb
patch, documentation included.

Cheers

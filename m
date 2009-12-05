From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: Can't compile 2.6.32
Date: Fri, 4 Dec 2009 18:03:21 -0800 (PST)
Message-ID: <173abc14-0cbc-4340-b21f-3e8bc15f02dd@default>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet11.oracle.com ([148.87.113.123]:33685 "EHLO
	rgminet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbZLECE5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Dec 2009 21:04:57 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: neutrino8@gmail.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


A bit more info on this. It seems there's a
CONFIG_ACPI_CUSTOM_OVERRIDE_INITRAMFS in the "normal" SUSE source RPM
package (which in my config is not enabled, but there is an option for
that) and looking at the drivers/acpi/osl.c and the
include/acpi/acpiosxf.h file, there's a define for this in the header
which has acpi_load_override_tables(void); and also this is present in
the osl.c file.... see both attachments. I could not find the same
thing in the kernel-default-vanilla source RPM package also present in
the repo.

~~~~~~~~~~~~~~~~~~  reply: ~~~~~~~~~~~~~~~~~~~~~~~~

You should take this up with the OpenSUSE people, not lkml.

Thanks,
~Randy

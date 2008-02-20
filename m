From: Thomas Renninger <trenn@suse.de>
Subject: BIOS bug introduced on some ASUS machines and some Mainboards
Date: Wed, 20 Feb 2008 13:15:38 +0100
Message-ID: <1203509738.6019.151.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58590 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbYBTMPk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Feb 2008 07:15:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: acpi4asus-user <acpi4asus-user@lists.sourceforge.net>, basus@email.cz, linux-oe@eecomputer.de, "Moore, Robert" <robert.moore@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

Hi,

JFYI:

Due to a silly BIOS bug which seems to get copied to a wider range of
Asus (and friends) machines/mainboards following machines/mainboards
will show a protection fault when the thermal ACPI driver gets loaded:

Biostar TA770 ( Bios A78XA125 2008-01-28 )
Foxconn M520A ( Bios 784F1P05 2008-02-01 )

Asus M2N32-SLI Deluxe (BIOS version still working: 1201
                       Broken BIOS versions: 1302, 1503, 1603,
                       Beta 1701)

Asus M2A HDMI

A bug with additional info can be found here:
https://bugzilla.novell.com/show_bug.cgi?id=350017

According to Robert (Thanks for looking into this) this should be fixed
in ACPICA version 20071019.
The fix or say workaround and the problem are described at the end.

AFAIK current ACPICA version (if the date in include/acpi/acconfig.h is
correct) in mainline kernel still is: 20070126

So if you have one of these boards, better wait a bit with a BIOS
update.
If you have similar problems on other machines, please let us know, so
that others don't run into this. Affected people should see a stack
trace like that in dmesg when trying to load the thermal module:

RIP: 0010:[]  [] acpi_ns_map_handle_to_node+0x14/0x1d
...
 [] acpi_get_data+0x3e/0x6e
 [] acpi_bus_get_device+0x25/0x68
 [] :thermal:acpi_thermal_trip_seq_show+0x12b/0x257
 [] seq_read+0x105/0x28b
 [] vfs_read+0xcb/0x153
 [] sys_read+0x45/0x6e
 [] system_call+0x7e/0x83


The bug is, that they added dual or quad core (I expect the latter not
sure right now) support to their DSDT and renamed the CPU objects.
But they forgot to rename the reference of the passive cooling device
(which is a processor object).
When you have the kernel fix that can handle this gracefully you should
only see:
Hmm, older kernels had a warning, it seems this has been removed.
It got removed very recently (02-02-08):
git commit ce44e19701ac1de004815c225585ff617c5948b4

This message should get added again, I'll send a separate patch, you
then should see a line in dmesg:
"Invalid passive threshold"

If the kernel can handle the BIOS bug gracefully.

   Thomas


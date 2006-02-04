From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: S3 sleep regression / 2.6.16-rc1+acpi-release-20060113
Date: Sat, 04 Feb 2006 05:02:43 +0000
Message-ID: <E1F5FZL-0001sP-00@skye.ra.phy.cam.ac.uk>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946307AbWBDFCq@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The gory details are at
<http://bugzilla.kernel.org/show_bug.cgi?id=5989>, but the short
summary:

With 2.6.15, S3 sleep and wake were 98% fine (once in a while waking
would hang, but I haven't managed to reproduce it).  However, with
2.6.16-rc1 with the acpi-20060113 patch, the first sleep and wake goes
fine and the second sleep hangs at the 'Stopping tasks'.

With tons of debugging turned on, the second sleep does not hang, but
the wakeup hangs.  With 0x1F as the acpi debug_level, the second sleep
still hangs and produces some output across a serial console.  In the
second sleep (after the second 'Stopping tasks'), it endlessly repeats
a short sequence of

exregion-0182 ...
exregion-0287 ...
exregion-0182 ...

The machine is a TP 600X with the latest (1.11) BIOS and a fixed DSDT
so that it can S3 sleep at all.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.

From: Fedor Karpelevitch <fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
Subject: [2.6.0-test4][ACPI] STR, STD returns immidiately
Date: Sun, 24 Aug 2003 15:37:54 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200308241537.54494.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

when I do 
echo mem > /sys/power/state
or
echo disk > /sys/power/state

it returns in a second without any effect and in sysslog I get this:

Aug 24 15:23:39 bologoe kernel: Stopping tasks: 
===============================================================================================|
Aug 24 15:23:39 bologoe kernel: Restarting tasks... done
Aug 24 15:23:40 bologoe modprobe: FATAL: Module /dev/apm_bios not 
found.

Am I supposed to compile in APM support? I do not think so...

In -test3 this used to work in a sense - S3 was indeed putting the 
machine into sleep state ( but was unable to resume ). Swsusp was 
also working somewhat althought had huge issues...

I'll compile with ACPI debug on in case that may give me any more 
info...

Fedor.

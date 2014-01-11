From: Bradley Baetz <bbaetz@gmail.com>
Subject: Multiple video backlight devices on Dell laptop
Date: Sat, 11 Jan 2014 14:22:55 +1100
Message-ID: <CAJrk0Bv5w25vipp8vTmoZEegb-7Va+FLvek=QnTvSfHDFjvroA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:47706 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbaAKDW5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jan 2014 22:22:57 -0500
Received: by mail-we0-f174.google.com with SMTP id x55so1181106wes.5
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jan 2014 19:22:56 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have a Dell Vostro 3560 laptop, with hybrid graphics (intel + radeon).

This exposes 3 backlight devices - acpi_video0, acpi_video1, and
intel_backlight. Only the intel_backlight/brightness file actually
changes the backlight. Is this a kernel bug, or should userspace
'know' which backlight file to use based on which graphics device is
active? XFCE picks the first one it finds (acpi_video0), which doesn't
work.

I was using acpi_backlight=vendor, but some recent changes to memory
allocation seem to have exposed that that SMM method is not safe to
use with EFI... (see http://marc.info/?t=138811462300004&r=1&w=2)

I've uploaded my ACPI tables to http://members.optusnet.com.au/bbaetz1/acpi.tgz

Bradley

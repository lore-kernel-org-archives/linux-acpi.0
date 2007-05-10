From: Len Brown <lenb@kernel.org>
Subject: Re: [patch] ACPI video driver output switch sysfs support
Date: Wed, 9 May 2007 22:39:18 -0400
Message-ID: <200705092239.19015.lenb@kernel.org>
References: <3877989d0703122231v7bb04f03ydf4c1de03040085f@mail.gmail.com> <20070425083111.e8c24bd4.rdunlap@xenotime.net> <3877989d0705090607m469a6f1aof3b3703fa5bd3cd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43571 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151AbXEJCkh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2007 22:40:37 -0400
In-Reply-To: <3877989d0705090607m469a6f1aof3b3703fa5bd3cd7@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-acpi@vger.kernel.org

On Wednesday 09 May 2007 09:07, Luming Yu wrote:
> To use this patch, you need enable VIDEO_OUTPUT_CONTROL and ACPI_VIDEO.
> After loading output.ko and video.ko, you would have
> /sys/class/video_output and several device acpi_videoNum there. For
> example, I got acpi_video0, acpi_video1,acpi_video2,and acpi_video3
> under /sys/class/video_output on my T40.
> I can query the status of  output device0 by running " cat
> /sys/class/video_output/acpi_video0
> " The return value is defined in ACPI SPEC B.5.5 _DCS(Return the
> Status of Output Device).  Also you can turn off video1 and turn on
> video0  by " echo 0 > acpi_video1; echo 0x80000000 > acpi_video0".
> Please reference ACPI SPEC  B.5.7 _DSS for the parameter definition.
> Also please note that it may or may NOT works purely depending on if
> your vendor providing correct ACPI video extension support in bios.
> the driver output.ko and video.ko just works like a interface to
> invoke BIOS.

This is a step in the right direction,
but nothing in a generic sysfs location should depend on
bit encodings from the ACPI spec.

eg. from user-space they should be something simple like
0 - disabled
1 - enabled

on read, they should probably query _DCS, and decode its
bit pattern so that again the user sees:
0 - disabled
1 - enabled

I'll put this patch in the test tree now b/c
I want folks to be able to test _DSS,
so feel free to send an incremental patch
on top of this one.

thanks,
-Len

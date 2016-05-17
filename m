From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: linux-next 20160512 - ACPI issue with screen brightness
Date: Tue, 17 May 2016 22:50:11 +0200
Message-ID: <CAJZ5v0jrFoQxLY_ZQrP-HP888swZbvSJPM=xNopC5MgQgnSxNg@mail.gmail.com>
References: <4736.1463510462@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34106 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbcEQUuN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2016 16:50:13 -0400
In-Reply-To: <4736.1463510462@turing-police.cc.vt.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc: Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Tue, May 17, 2016 at 8:41 PM, Valdis Kletnieks
<Valdis.Kletnieks@vt.edu> wrote:
> next-20160512 sets the screen brightness to about 40%-ish or so, rather
> than the 100% intensity I want.
>
> Dell Latitude E6530 laptop.
>
> git bisect tells me:
>
> 059500940defe285222d3b189b366dfe7f299cae is the first bad commit
> commit 059500940defe285222d3b189b366dfe7f299cae
> Author: Aaron Lu <aaron.lu@intel.com>
> Date:   Wed Apr 27 20:45:04 2016 +0800
>
>     ACPI/video: export acpi_video_get_levels
>
>     The acpi_video_get_levels is useful for other drivers, i.e. the
>     to-be-added int3406 thermal driver, so export it.
>
>     Signed-off-by: Aaron Lu <aaron.lu@intel.com>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> :040000 040000 24f4f5abe8beda2fa219dee7549faacc2f63e29f dfbe3a3bb4f58d82d5be768263d91172276fed98 M      drivers
> :040000 040000 603ffbf36e76717fe4f4ecb0418c9dbc59c76e25 a559bcd81c949a6471ffd045866df9b4e3fa4406 M      include
>
>
> but I've stared at the code and don't see what would do this....

Please try to check out the acpi-video branch from linux-pm.git and
see if the problem is present then.  If it is, please revert all of
the top-most commits up to and including the above one and see if the
problem goes away.

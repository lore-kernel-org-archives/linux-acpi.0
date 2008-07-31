From: nokos@gmx.net
Subject: Re: Check for ACPI backlight support otherwise use vendor ACPI
	drivers - version 2
Date: Thu, 31 Jul 2008 17:32:15 +0200
Message-ID: <1217518335.12217.24.camel@earth.gruber.myown>
References: <1216205553-8486-1-git-send-email-trenn@suse.de>
	 <1217399377.23004.0.camel@hidalgo>  <200807301106.40521.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:37811 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751037AbYGaPfP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2008 11:35:15 -0400
In-Reply-To: <200807301106.40521.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, nokos@gmx.net

Hi Thomas

I didi some testing and found whats wrong with the backlight detection
in video_detect.c you should change:

--- video_detect.c 2008-07-31 17:20:59.540059897 +0200
+++ video_detect.c 2008-07-31 17:22:15.752034851 +0200
@@ -45,9 +45,9 @@
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
 				  "support\n"));
 		*cap |= ACPI_VIDEO_BACKLIGHT;
-		return 0;
+		return -ENODEV;
 	}
-	return -ENODEV;
+	return 0;
 }
 

otherwise it stops walking the subtree at the first device which does
not contain backlight (in my case GFX0 has CRT_ as first child which
does not support backlight). Its ok to stop scanning at the first
positive match since cap then already has ACPI_VIDEO_BACKLIGHT. (ENODEV
is probably not the best error code here ...)

probably you might want to change in acpi_is_video_device:

--- video_detect.c 2008-07-31 17:20:59.540059897 +0200
+++ video_detect.c 2008-07-31 17:22:15.752034851 +0200
@@ -93,8 +93,10 @@
 		video_caps |= ACPI_VIDEO_IGD;
 	}
 
-	acpi_walk_namespace(ACPI_TYPE_DEVICE, device->handle, ACPI_UINT32_MAX,
+        if (video_caps) {
+	        acpi_walk_namespace(ACPI_TYPE_DEVICE, device->handle,
ACPI_UINT32_MAX,
 			    acpi_backlight_cap_match, &video_caps, NULL);
+        }
 
 	return video_caps;
 }

otherwise the whole ACPI namespace is scanned several times and this
restricts the scanning only on those subtrees where the head might be a
video device


BTW. the DRDY detection (for IGD) works ... now I have to find the IGD
patches ... couldn't find them on the list and the version of linux-next
I tried didn't contain anything which looked like it.

Peter

Am Mittwoch, den 30.07.2008, 11:06 +0200 schrieb Thomas Renninger:
> On Wednesday 30 July 2008 08:29:37 Yves-Alexis Perez wrote:
> > On mer, 2008-07-16 at 12:52 +0200, Thomas Renninger wrote:
> > > It is highly recommended that these patches are tried out together with
> > > Matthew's/Hong's IGD driver changes.
> > > I do not know whether they are already in the dri tree or in linux-next,
> > > whether they will be accepted for .27 etc. I hope Matthew will answer on
> > > this mail and tell us.
> > > AFAIK on thinkpads they already need an additional patch to work?
> > > Chances are high that other laptop families also need a bit of a special
> > > treatment to get the very new IGD parts to work.
> > > If people test both patches together we could get a matrix like this:
> >
> > What is the status of those patches wrt. 2.6.27-rc1?
> 
> Matthew and Rui accepted or signed them off AFAIK.
> On Peter's system (nokos@gmx.de, fujitsu with IGD support) it returns that
> there is no video support which looks wrong.
> I contacted him a bit late, after getting pointed to acpidump it still looks
> odd/wrong, and I need acpi.debug_level=0x1f log_buf_len=16777216 output to 
> hopefully see what it is.
> 
> A comment from Andi/Len would be great.
> Maybe this could already be sent to linux-next to make testing easier.
> 
>       Thomas
> 
> PS: and this is version 2, I already sent version 3 which had some cleanups.


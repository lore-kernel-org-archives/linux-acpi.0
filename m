From: Len Brown <lenb@kernel.org>
Subject: Re: [patch for 2.6.35? 1/1] acpi: video: fix acpi_backlight=video
Date: Fri, 28 May 2010 16:15:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005281613450.4045@localhost.localdomain>
References: <201005241910.o4OJAwdh010716@imap1.linux-foundation.org>
 <alpine.LFD.2.00.1005242053140.4059@localhost.localdomain>
 <20100524182259.9cc66230.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:44073 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758423Ab0E1UPL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 May 2010 16:15:11 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3500AG2C96V9F5@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 28 May 2010 15:15:08 -0500 (CDT)
In-reply-to: <20100524182259.9cc66230.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, kamal@canonical.com, bjorn.helgaas@hp.com, jkosina@suse.cz, rui.zhang@intel.com, stable@kernel.org, trenn@suse.de


> > > diff -puN drivers/acpi/video_detect.c~acpi-video-fix-acpi_backlight=video drivers/acpi/video_detect.c
> > > --- a/drivers/acpi/video_detect.c~acpi-video-fix-acpi_backlight=video
> > > +++ a/drivers/acpi/video_detect.c
> > > @@ -266,7 +266,7 @@ static int __init acpi_display_output(ch
> > >  				ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VENDOR;
> > >  		if (!strcmp("video", str))
> > >  			acpi_video_support |=
> > > -				ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VIDEO;
> > > +				ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO;
> > >  	}
> > >  	return 1;


> linux-next changes acpi_backlight().  In my tree patch(1) decided to
> migrate the hunk into acpi_display_output().

I think the hunk got mis-relocated in your tree,
and that the correct patch is included in the acpi tree.

> Please check that acpi_display_output() didn't need the same change.

It looks okay.

> I'll drop the patch, thanks.

thanks,
-Len


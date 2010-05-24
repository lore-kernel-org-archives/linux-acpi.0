From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch for 2.6.35? 1/1] acpi: video: fix acpi_backlight=video
Date: Mon, 24 May 2010 18:22:59 -0400
Message-ID: <20100524182259.9cc66230.akpm@linux-foundation.org>
References: <201005241910.o4OJAwdh010716@imap1.linux-foundation.org>
	<alpine.LFD.2.00.1005242053140.4059@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43571 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758585Ab0EYBZG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 May 2010 21:25:06 -0400
In-Reply-To: <alpine.LFD.2.00.1005242053140.4059@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, kamal@canonical.com, bjorn.helgaas@hp.com, jkosina@suse.cz, rui.zhang@intel.com, stable@kernel.org, trenn@suse.de

On Mon, 24 May 2010 20:53:51 -0400 (EDT) Len Brown <lenb@kernel.org> wrote:

> 
> On Mon, 24 May 2010, akpm@linux-foundation.org wrote:
> 
> > From: Kamal Mostafa <kamal@canonical.com>
> > 
> > Make "acpi_backlight=video" param enable ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO
> > as intended, instead of incorrectly enabling video output switching.
> > 
> > Addresses http://bugs.launchpad.net/bugs/573120
> > 
> > Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > Cc: Jiri Kosina <jkosina@suse.cz>
> > Acked-by: Thomas Renninger <trenn@suse.de>
> > Cc: Thomas Renninger <trenn@suse.de>
> > Cc: <stable@kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > 
> >  drivers/acpi/video_detect.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff -puN drivers/acpi/video_detect.c~acpi-video-fix-acpi_backlight=video drivers/acpi/video_detect.c
> > --- a/drivers/acpi/video_detect.c~acpi-video-fix-acpi_backlight=video
> > +++ a/drivers/acpi/video_detect.c
> > @@ -266,7 +266,7 @@ static int __init acpi_display_output(ch
> >  				ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VENDOR;
> >  		if (!strcmp("video", str))
> >  			acpi_video_support |=
> > -				ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VIDEO;
> > +				ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO;
> >  	}
> >  	return 1;
> >  }
>
> yes, it is in acpi-test and linux-next, do you pull those into mm still?
> 

(top-posting repaired!)

linux-next changes acpi_backlight().  In my tree patch(1) decided to
migrate the hunk into acpi_display_output().

Please check that acpi_display_output() didn't need the same change.

I'll drop the patch, thanks.

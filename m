From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [-mm patch] make drivers/misc/thinkpad_acpi:fan_mutex static
Date: Sat, 28 Apr 2007 16:58:21 -0300
Message-ID: <20070428195821.GC2392@khazad-dum.debian.net>
References: <20070425225716.8e9b28ca.akpm@linux-foundation.org> <20070428191938.GO3468@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57651 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031236AbXD1T60 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Apr 2007 15:58:26 -0400
Content-Disposition: inline
In-Reply-To: <20070428191938.GO3468@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sat, 28 Apr 2007, Adrian Bunk wrote:
> On Wed, Apr 25, 2007 at 10:57:16PM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.21-rc7-mm1:
> >...
> >  git-acpi.patch
> >...
> >  git trees
> >...
> 
> 
> This patch makes the needlessly global fan_mutex static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Sorry about the oversight.

> ---
> 
> BTW: Prototypes for static versions and static variables in a header
>      file are really wrong, but the mess is bigger than what I'm
>      willing to clean up...

It is a private header file, only one file uses it and it is not supposed to
be used by any other file ever, either.  I can certainly do a cleaning up
and a lot can be removed (at least 70% of it), but the driver is not linear
(it is some infrastructure and various subdrivers) and there is a bunch of
stuff that will need forward declarations regardless.

Maybe I should just break the driver into multiple files in a subdirectory?
That would certainly make it *much* cleaner...

> --- linux-2.6.21-rc7-mm2/drivers/misc/thinkpad_acpi.h.old	2007-04-27 00:55:58.000000000 +0200
> +++ linux-2.6.21-rc7-mm2/drivers/misc/thinkpad_acpi.h	2007-04-28 01:32:54.000000000 +0200
> @@ -382,7 +382,7 @@
>  static u8 fan_control_desired_level;
>  static int fan_watchdog_maxinterval;
>  
> -struct mutex fan_mutex;
> +static struct mutex fan_mutex;
>  
>  static acpi_handle fans_handle, gfan_handle, sfan_handle;
>  

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

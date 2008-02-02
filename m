From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] Rationalise ACPI backlight implementation
Date: Sat, 2 Feb 2008 09:30:08 -0200
Message-ID: <20080202113008.GA4251@khazad-dum.debian.net>
References: <20071226020325.GA21099@srcf.ucam.org> <20080128012549.GA24166@srcf.ucam.org> <20080127211013.1ddaa6a1.akpm@linux-foundation.org> <200802012246.13162.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759107AbYBBLaa@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200802012246.13162.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 01 Feb 2008, Len Brown wrote:
> You might check if CONFIG_ACPI_VIDEO=m is set and you can load the "video" module.
> While the sony may be non-standard and not load, your thinkpad may work.

It will work except under new X.org, which disables BIOS backlight
functionality in order to do it directly, at least on Intel GPUs (and
probably also on ATI GPUs.  nVidia is no-man's-land).

And I have been told that X.org can do 256 backlight levels on Intel
hardware *including* switching the backlight off, instead of just the 16
levels Lenovo chose to export through ACPI.   Looks like someone should
add a kernel framebuffer device for those Intels :)

We really need to solve the userspace mess, though.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

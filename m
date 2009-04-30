From: Norbert Preining <preining@logic.at>
Subject: Re: 2.6.30-rc3 video/i915 build error
Date: Thu, 30 Apr 2009 20:07:30 +0200
Message-ID: <20090430180730.GB15491@gamma.logic.tuwien.ac.at>
References: <alpine.LFD.2.00.0904231231100.15830@localhost.localdomain> <20090423164642.GF495@gamma.logic.tuwien.ac.at> <alpine.LFD.2.00.0904231550020.15830@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:59672 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932135AbZD3SIS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Apr 2009 14:08:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904231550020.15830@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, rui.zhang@intel.com, Keith Packard <keithp@keithp.com>, linux-acpi@vger.kernel.org

On Do, 23 Apr 2009, Len Brown wrote:
> > > CONFIG_DRM_I915=y
> > > CONFIG_ACPI_VIDEO=m
> > > 
> > > drivers/built-in.o: In function `intel_opregion_init':
> > > (.text+0x9d540): undefined reference to `acpi_video_register'
> > 
> > For me these two patches fix the problem.
> 
> Matthew's response to those patches seems to be sufficient:
> 
> http://patchwork.kernel.org/patch/18420/

I have to disagree. 2.6.30-rc4, with that patch I get that in my config:
	CONFIG_DRM_I915=y
	# CONFIG_DRM_I915_KMS is not set
	CONFIG_ACPI_VIDEO=y
and it finishes with
  MODPOST vmlinux.o
drivers/built-in.o: In function `acpi_video_bus_put_devices': video.c:(.text+0x383a1): undefined reference to `backlight_device_unregister'
drivers/built-in.o: In function `acpi_video_bus_add': video.c:(.text+0x39c6a): undefined reference to `backlight_device_register'

So I tried to activate the backlight device to =y but calling make
config always ended with
	CONFIG_BACKLIGHT_CLASS_DEVICE=m

So still not working, which is bad. And the patches I mentioned before
do not apply anymore, so rc4 is out for testing for me.

Full .config on request.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HULL (adj.)
Descriptive of the smell of a weekend cottage.
			--- Douglas Adams, The Meaning of Liff

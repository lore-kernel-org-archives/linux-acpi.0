From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [intel/acpi] backlight
Date: Mon, 1 Dec 2008 11:27:09 -0800
Message-ID: <200812011127.09720.jbarnes@virtuousgeek.org>
References: <1227854824.3477.9.camel@hidalgo> <alpine.LFD.2.00.0811302220060.3314@localhost.localdomain> <20081201083855.GB7380@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-19.bluehost.com ([69.89.20.234]:59838 "HELO
	outbound-mail-19.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752187AbYLATdv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 14:33:51 -0500
In-Reply-To: <20081201083855.GB7380@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <lenb@kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, Yves-Alexis Perez <corsac@debian.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Monday, December 1, 2008 12:38 am Matthew Garrett wrote:
> On Sun, Nov 30, 2008 at 10:28:30PM -0500, Len Brown wrote:
>
> (Cc:ing Jesse)
>
> > in single user mode, i915 is not loaded,
> > /sys/class/backlight/acpi_video0 does NOT work
> >
> > modprobe of i915 does not change this.
>
> Jesse, are IRQs being delivered to the drm code when X isn't the
> foreground VT? If not, this would seem to need fixing.

The X driver calls into the DRM to disable IRQs when it releases the VT, but 
we could make that just affect vblank interrupts if needed (yay more 
i915_irq.c changes).

Jesse

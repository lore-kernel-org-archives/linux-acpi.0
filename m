From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [Intel-gfx] RFC] [Patch] [DRM/I915] :Check the LID device to
	decide whether the LVDS should be initialized
Date: Mon, 15 Jun 2009 15:41:10 +0800
Message-ID: <1245051670.3583.35.camel@localhost.localdomain>
References: <1244187921.3558.223.camel@localhost.localdomain>
	 <1244200261.11142.20.camel@gaiman.anholt.net>
	 <1244422347.3698.6.camel@localhost.localdomain>
	 <1244585813.4896.34.camel@gaiman.anholt.net>
	 <20090609153559.2e93479d@jbarnes-x200>
	 <1244714614.3618.10.camel@localhost.localdomain>
	 <c072ca310906122248w62683eb4waad8fd0be49b20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17073 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbZFOHj6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jun 2009 03:39:58 -0400
In-Reply-To: <c072ca310906122248w62683eb4waad8fd0be49b20@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sat, 2009-06-13 at 13:48 +0800, Alexander E. Patrakov wrote:
> 2009/6/11 yakui_zhao <yakui.zhao@intel.com>:
> > +       if (acpi_disabled) {
> > +               /*
> > +                * if ACPI is disabled, there is no ACPI device tree. And
> > +                * we don't know whether there exists the LID device.
> > +                * In such case we will return 0.
> > +                */
> > +               return 0;
> > +       }
> 
> Won't this prevent people from debugging ACPI problems on laptops by
> disabling ACPI on the kernel command line? Does this patch mean that,
> in such case, there will be no output at all? Maybe, without ACPI, we
> should initialize LVDS if and only if there are no other output
> devices connected?
No. It has no effect on LVDS output device if ACPI is disabled.
If the system is booted with acpi disabled, the function of intel_lvds_find_lid
will return zero and it will continue the current flowchart of LVDS output device.

Thanks.




 


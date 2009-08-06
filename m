From: Thomas Renninger <trenn@suse.de>
Subject: Re: a backlight issue
Date: Thu, 6 Aug 2009 15:38:38 +0200
Message-ID: <200908061538.39238.trenn@suse.de>
References: <1245895749.7266.70.camel@localhost.localdomain> <200908051450.27970.trenn@suse.de> <20090806125552.GB15867@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59307 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755870AbZHFNil (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Aug 2009 09:38:41 -0400
In-Reply-To: <20090806125552.GB15867@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: yakui_zhao <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, rpurdie@linux.intel.com, jbarnes@virtuousgeek.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

On Thursday 06 August 2009 14:55:52 Henrique de Moraes Holschuh wrote:
> On Wed, 05 Aug 2009, Thomas Renninger wrote:
> > If in KMS drivers backlight switching method is implemented
> > and can register for the generic backlight driver, it should always
> > be
> > disabled by default. Instead, KMS drivers should export a simple
> > "backlight_enable" file somewhere in sysfs. If userspace doesn't
> > find a sysfs backlight interface, it can do:
> > echo 1 >/sys/path_to_graphics_card/backlight_enable
> > and a backlight sysfs interface should pop up on success.
> 
> IMO, we already have an in-kernel selector of the backlight control
> method for mutually-exclusive backlight control strategies.
You mean the ACPI vs native driver detection?

> We should use that, and if it is complete/good enough to add the KMS
> scenario, improve it.
You mean if it is *not* complete/good enough?

KMS popping in as a third kernel backlight provider makes things really
complicated for the kernel to choose the right thing.
Getting this prio:
1. generic ---ACPI
2. platform---platform drivers
3. legacy-----i915
solved in kernel automatically you need something like Rui/Yakui 
suggested:
  - Let KMS register first as I expect it will always initialize first
  - Let ACPI or platform driver unregister KMS backlight interface
    and take over
You never know when userspace plans to load the native drivers.
This complexity for a normally not needed fallback (ACPI or native 
drivers should be available) is complicated and error-prone.
This complexity should really be put to userspace where it's easy 
(three lines in bash) to solve, like I suggested above.

Maybe someone has another, easier idea to perfectly solve this 
automatically in kernel, I do not see it.

    Thomas

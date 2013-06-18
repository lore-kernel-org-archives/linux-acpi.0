From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/3] ACPICA: Add interface for getting latest OS version requested via _OSI
Date: Tue, 18 Jun 2013 02:42:13 +0200
Message-ID: <10189900.qsvQBSpnvI@vostro.rjw.lan>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com> <2212597.t9jOQU2YXi@vostro.rjw.lan> <1371508629.523.3.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40784 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130Ab3FRAcz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Jun 2013 20:32:55 -0400
In-Reply-To: <1371508629.523.3.camel@x230>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "seth.forshee@canonical.com" <seth.forshee@canonical.com>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "lenb@kernel.org" <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>

On Monday, June 17, 2013 10:37:10 PM Matthew Garrett wrote:
> On Tue, 2013-06-18 at 00:31 +0200, Rafael J. Wysocki wrote:
> > Hi Matthew,
> > 
> > On Sunday, June 09, 2013 07:01:38 PM Matthew Garrett wrote:
> > > Drivers may need to make policy decisions based on the OS that the firmware
> > > believes it's interacting with. ACPI firmware will make a series of _OSI
> > > calls, starting from the oldest OS version they support and ending with the
> > > most recent. Add a function to return the last successful call so that
> > > drivers know what the firmware's expecting.
> > > 
> > > Based on a patch by Seth Forshee <seth.forshee@canonical.com>
> > 
> > Bob (CCed) would prefer us to access acpi_gbl_osi_data directly instead of
> > adding the wrapper to ACPICA.  He also thinks that the symbol definitions
> > should go into include/acpi/actypes.h rather than into acpixf.h.
> > 
> > Then, the only ACPICA change would be to move the symbols and we can
> > add a Linux-specific patch on top of that adding the acpi_gbl_osi_data
> > wrapper.
> 
> That sounds good to me. Do you want to respin that, or should I send an
> updated set?

That one should be fine, no need to respin [1/3] and [3/3].

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

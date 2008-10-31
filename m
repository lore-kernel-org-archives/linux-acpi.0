From: Dave Airlie <airlied@linux.ie>
Subject: Re: Build error with latest kernel
Date: Fri, 31 Oct 2008 02:58:54 +0000 (GMT)
Message-ID: <alpine.DEB.0.82.0810310258360.21357@skynet.skynet.ie>
References: <1225377756.3689.5.camel@localhost.localdomain>
 <1225421122.2665.18.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="29444707-174506833-1225421934=:21357"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gir.skynet.ie ([193.1.99.77]:51817 "EHLO gir.skynet.ie"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754386AbYJaC65 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Oct 2008 22:58:57 -0400
In-Reply-To: <1225421122.2665.18.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Steven Whitehouse <swhiteho@redhat.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, mjg@redhat.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--29444707-174506833-1225421934=:21357
Content-Type: TEXT/PLAIN; charset=iso-2022-jp


> > 
> > There is a build error with the attached config on the latest upstream
> > Linus kernel.
> > 
> >   CC [M]  drivers/gpu/drm/i915/i915_suspend.o
> > drivers/gpu/drm/i915/i915_opregion.c: In function ‘intel_opregion_init’:
> > drivers/gpu/drm/i915/i915_opregion.c:340: error: implicit declaration of
> > function ‘register_acpi_notifier’
> > drivers/gpu/drm/i915/i915_opregion.c: In function ‘intel_opregion_free’:
> > drivers/gpu/drm/i915/i915_opregion.c:361: error: implicit declaration of
> > function ‘unregister_acpi_notifier’
> > make[4]: *** [drivers/gpu/drm/i915/i915_opregion.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> > 
> > Looks like the symbols are not defined when ACPI is not configured.
> > 
> Yes, you're right.
> IGD OpeRegion depends on ACPI.
> I think we need to introduce a new kernel config option for
> IGD OpRegion support.
> 
> cc matthew.

The fix is queued for Linus already.

Dave.
--29444707-174506833-1225421934=:21357--

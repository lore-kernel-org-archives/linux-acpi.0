From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] Xen/ACPI: support sleep state entering on hardware reduced systems
Date: Mon, 11 Mar 2013 17:58:06 +0100
Message-ID: <3753630.geZXHDrzrL@vostro.rjw.lan>
References: <513DB68E02000078000C4864@nat28.tlf.novell.com> <2127236.DctbS7jp3r@vostro.rjw.lan> <513E108A02000078000C4AB3@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:51810 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815Ab3CKQvF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Mar 2013 12:51:05 -0400
In-Reply-To: <513E108A02000078000C4AB3@nat28.tlf.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Bob Moore <robert.moore@intel.com>, Gang Wei <gang.wei@intel.com>, Lv Zheng <lv.zheng@intel.com>, richard.l.maliszewski@intel.com, Shane Wang <shane.wang@intel.com>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xen.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-acpi@vger.kernel.org

On Monday, March 11, 2013 04:12:42 PM Jan Beulich wrote:
> >>> On 11.03.13 at 15:51, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > On Monday, March 11, 2013 02:06:51 PM Jan Beulich wrote:
> >> In version 3.4 acpi_os_prepare_sleep() got introduced in parallel with
> >> reduced hardware sleep support, and the two changes didn't get
> >> synchronized: The new code doesn't call the hook function (if so
> >> requested). Fix this, requiring a boolean parameter to be added to the
> >> hook function to distinguish "extended" from "legacy" sleep.
> >> 
> >> This requires adjusting TXT, but the adjustments only go as far as
> >> failing the extended mode call (since, looking at the TXT interface,
> >> there doesn't even appear to be precautions to deal with that
> >> alternative interface).
> >> 
> >> The hypervisor change underlying this is commit 62d1a69 ("ACPI: support
> >> v5 (reduced HW) sleep interface") on the master branch of
> >> git://xenbits.xen.org/xen.git.
> >> 
> >> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> >> Cc: Richard L Maliszewski <richard.l.maliszewski@intel.com>
> >> Cc: Gang Wei <gang.wei@intel.com>
> >> Cc: Shane Wang <shane.wang@intel.com>
> >> ---
> >> v2: Extend description to include reference to hypervisor side change.
> >> 
> >> ---
> >>  arch/x86/kernel/tboot.c          |    6 +++++-
> >>  drivers/acpi/acpica/hwesleep.c   |    8 ++++++++
> >>  drivers/acpi/acpica/hwsleep.c    |    2 +-
> >>  drivers/acpi/osl.c               |   16 ++++++++--------
> >>  drivers/xen/acpi.c               |   26 +++++++++++++-------------
> >>  include/linux/acpi.h             |   10 +++++-----
> >>  include/xen/acpi.h               |    4 ++--
> >>  include/xen/interface/platform.h |    7 ++++---
> >>  8 files changed, 46 insertions(+), 33 deletions(-)
> > 
> > ACPICA changes (hwesleep.c and hwsleep.c) need to go separately and through 
> > the
> > upstream ACPICA before we can take them into the kernel.  Sorry about that.
> 
> Looking at 09f98a8 (the change originally introducing the hook)
> and comparing with the rest of the changes to hwsleep.c, I would
> think this one didn't come from the ACPICA tree either.

No, it didn't, but the policy has changed since then.

> But anyway - if I really need to do that, are there any pointers as
> to where to submit this to, and how to make sure it gets picked up
> rather sooner than later?

You can submit it to linux-acpi as before, but as separate patches and please
CC me and Bob Moore on that submission.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

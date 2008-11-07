From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Fri, 7 Nov 2008 08:25:36 +0100
Message-ID: <20081107072536.GA19583@elte.hu>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com> <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1226032943.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:34871 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbYKGHZw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Nov 2008 02:25:52 -0500
Content-Disposition: inline
In-Reply-To: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1226032943.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Avi Kivity <avi@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>


(I've Cc:-ed the folks who worked on this problem area.)

* Len Brown <lenb@kernel.org> wrote:

> From: Len Brown <len.brown@intel.com>
> 
> We've run into systems which do not reboot properly
> without using the ACPI reset mechanism.  So lets
> try this in linux-next for a while and see
> how many existing machines stop rebooting
> because they can't handle ACPI reboot.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  arch/x86/kernel/reboot.c |    2 +-

> -enum reboot_type reboot_type = BOOT_KBD;
> +enum reboot_type reboot_type = BOOT_ACPI;

NAK.

Your point that the set of systems where KBD-reboot is broken is 
larger (and growing) than the set of systems where ACPI-reboot is 
broken (which set probably has a constant size) is true.

But still this change caused non-trivial regressions in v28 _worse_ 
than the inability to reboot cleanly, so this patch does not fly as-is 
as we reverted it upstream for a good reason.

| commit 8d00450d296dedec9ada38d43b83e79cca6fd5a3
| Author: Eduardo Habkost <ehabkost@redhat.com>
| Date:   Tue Nov 4 12:52:44 2008 -0200
|
|     Revert "x86: default to reboot via ACPI"

I still dont oppose ACPI-reboot on new systems, but please add a more 
intelligent and regression-free method of turning it on by default: a 
flag year ACPI-date of 2008/2007/2006 or something like that, and 
default the reboot mode to KBD reboot before that date.

Such a solution would have the desired characteristics: we'd default 
to ACPI-reboot on all new systems, but we'd default to KBD-reboot on 
all older systems. The set of systems where KBD-reboot is broken will 
thus be limited, and we have the chance to eventually DMI-map them 
all.

Also, note that the main reason why we wanted ACPI-reboot originally 
(Avi's patch) was to get the KVM-is-active reboots right. But the 
KVM/VMX reboot state will be much more standard in v2.6.29 (we'll exit 
VMX mode on all CPUs/cores), so that particular problem category is 
eliminated.

Also, the default reboot mode is an x86 patch so this should not be 
within the ACPI tree, please submit it to us.

Hm?

	Ingo

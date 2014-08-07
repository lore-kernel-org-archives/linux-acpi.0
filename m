From: Borislav Petkov <bp@alien8.de>
Subject: tip/x86/apic (was: Re: [Bugfix 1/2] x86, irq, PCI: Keep IRQ
 assignment for PCI devices during suspend/hibernation)
Date: Thu, 7 Aug 2014 13:03:32 +0200
Message-ID: <20140807110332.GB10043@pd.tnic>
References: <1407209178-18644-1-git-send-email-jiang.liu@linux.intel.com>
 <1407209178-18644-2-git-send-email-jiang.liu@linux.intel.com>
 <20140805183729.GA23068@pd.tnic>
 <53E201FC.6010102@linux.intel.com>
 <20140806170937.GA4895@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:60777 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932077AbaHGLDh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Aug 2014 07:03:37 -0400
Content-Disposition: inline
In-Reply-To: <20140806170937.GA4895@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@linaro.org>, x86@kernel.org, Len Brown <lenb@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Aug 06, 2014 at 07:09:37PM +0200, Borislav Petkov wrote:
> On Wed, Aug 06, 2014 at 06:22:52PM +0800, Jiang Liu wrote:
> > 	I have prepared a tree for you at
> > https://github.com/jiangliu/linux.git suspend2
> >=20
> > It's based on tip/master and includes:
> > 1) the patch to fix warning caused  by USB controller
> > 2) these two patches to fix failure of suspend/hibernation
> >=20
> > Could you please help to check whether suspend/hibernation works as
> > expect on your platforms?
>=20
> Seems to work - just did 10-ish successful s/r cycles. The IO page
> faults are still there though.

Ok, tip guys, so J=C3=B6rg and I talked about the IOPFs a bit and we fe=
el
that while they still need to be taken care of, they're harmless and
there's no need to hold off tip/x86/apic anymore unless there are other
problems with it.

So, from my POV, it can go in so that it doesn't miss this merge window
and we'd deal with the IOPFs later.

I'm guessing Jiang needs to give you some updated versions of patches
from this thread for the branch to be complete. Jiang, please add my

Tested-by: Borislav Petkov <bp@suse.de>

for those.

Thanks to everyone involved.

--=20
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

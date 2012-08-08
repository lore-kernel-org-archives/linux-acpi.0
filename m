From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH v3] irq_remap: disable IRQ remapping if any IOAPIC lacks
 an IOMMU
Date: Wed, 8 Aug 2012 16:33:46 -0500
Message-ID: <20120808213346.GD25294@thinkpad-t410>
References: <CAE9FiQVEsPisVUKeG0aejKzvS+Csp5Ca2KEQyy6ZJW-MR-VFUA@mail.gmail.com>
 <1344432423-26495-1-git-send-email-seth.forshee@canonical.com>
 <CAE9FiQXv7oZX=ANOEBFm7gHP2Ktvkatn+fcrjq99Pu36k-xPWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35457 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab2HHVd5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Aug 2012 17:33:57 -0400
Content-Disposition: inline
In-Reply-To: <CAE9FiQXv7oZX=ANOEBFm7gHP2Ktvkatn+fcrjq99Pu36k-xPWA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>, Suresh Siddha <suresh.b.siddha@intel.com>

On Wed, Aug 08, 2012 at 10:57:06AM -0700, Yinghai Lu wrote:
> On Wed, Aug 8, 2012 at 6:27 AM, Seth Forshee <seth.forshee@canonical.com> wrote:
> > The ACPI tables in the Macbook Air 5,1 define a single IOAPIC with id 2,
> > but the only remapping unit described in the DMAR table matches id 0.
> > Interrupt remapping fails as a result, and the kernel panics with the
> > message "timer doesn't work through Interrupt-remapped IO-APIC."
> >
> > To fix this, check each IOAPIC for a corresponding IOMMU. If an IOMMU is
> > not found, do not allow IRQ remapping to be enabled.
> >
> > v2: Move check to parse_ioapics_under_ir(), raise log level to KERN_ERR,
> >     and add FW_BUG to the log message
> > v3: Skip check if IOMMU doesn't support interrupt remapping and remove
> >     existing check that the IOMMU count equals the IOAPIC count
> >
> 
> Acked-by: Yinghai Lu <yinghai@kernel.org>

Thanks!

I'm not sure whose tree this goes through, but it occurred to me that it
might be good to get this fixed in the stable kernels as well. Whoever
applies the patch might consider adding a Cc for stable, otherwise I can
submit it after it hits Linus's tree.

Thanks,
Seth


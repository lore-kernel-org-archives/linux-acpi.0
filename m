From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v3] irq_remap: disable IRQ remapping if any IOAPIC lacks
 an IOMMU
Date: Wed, 8 Aug 2012 10:57:06 -0700
Message-ID: <CAE9FiQXv7oZX=ANOEBFm7gHP2Ktvkatn+fcrjq99Pu36k-xPWA@mail.gmail.com>
References: <CAE9FiQVEsPisVUKeG0aejKzvS+Csp5Ca2KEQyy6ZJW-MR-VFUA@mail.gmail.com>
	<1344432423-26495-1-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344432423-26495-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>, Suresh Siddha <suresh.b.siddha@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 8, 2012 at 6:27 AM, Seth Forshee <seth.forshee@canonical.com> wrote:
> The ACPI tables in the Macbook Air 5,1 define a single IOAPIC with id 2,
> but the only remapping unit described in the DMAR table matches id 0.
> Interrupt remapping fails as a result, and the kernel panics with the
> message "timer doesn't work through Interrupt-remapped IO-APIC."
>
> To fix this, check each IOAPIC for a corresponding IOMMU. If an IOMMU is
> not found, do not allow IRQ remapping to be enabled.
>
> v2: Move check to parse_ioapics_under_ir(), raise log level to KERN_ERR,
>     and add FW_BUG to the log message
> v3: Skip check if IOMMU doesn't support interrupt remapping and remove
>     existing check that the IOMMU count equals the IOAPIC count
>

Acked-by: Yinghai Lu <yinghai@kernel.org>

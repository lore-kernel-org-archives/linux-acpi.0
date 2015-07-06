From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 2/3] ACPI / ARM64: add BAD_MADT_GICC_ENTRY() macro
Date: Mon, 6 Jul 2015 11:33:55 +0100
Message-ID: <20150706103355.GC27723@e104818-lin.cambridge.arm.com>
References: <1435880916-2153-1-git-send-email-al.stone@linaro.org>
 <20150703140601.GL25907@e104818-lin.cambridge.arm.com>
 <5596E7C8.7040809@redhat.com>
 <15297999.EvgjakjXbx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <15297999.EvgjakjXbx@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Al Stone <ahs3@redhat.com>, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, Al Stone <al.stone@linaro.org>, linaro-acpi@lists.linaro.org, patches@linaro.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jul 04, 2015 at 01:54:15AM +0200, Rafael J. Wysocki wrote:
> On Friday, July 03, 2015 01:51:36 PM Al Stone wrote:
> > Perhaps the sanity checking for the MADT subtables needs to be revisited
> > and a more general solution provided -- this is not the only MADT subtable
> > with this problem and it may occur again.
> > 
> > Even the versions above are not technically compliant with the spec.  If
> > we implement what the spec currently says, it might look something like
> > this:
> > 
> > #define ACPI_MADT_GICC_LENGTH ({					\
> > 	u8 length;							\
> > 	switch (ACPI_FADT_SPEC_VERSION) {				\
> > 	case ACPI_FADT_SPEC_VERSION_5_0:				\
> > 		length = 40;						\
> > 		break;							\
> > 	case ACPI_FADT_SPEC_VERSION_5_1:				\
> > 		length = 76;						\
> > 		break;							\
> > 	default:	/* use 6.0 size */				\
> > 		length = 80;						\
> > 	}								\
> > 	length;								\
> > })
> > 
> > So it's just messy and there will be a need for change.  Let me think about
> > making this a function instead of a macro; it may make sense to really fix
> > BAD_MADT_ENTRY in general instead of just dealing with the GICC subtable,
> > but it could also be overkill.
> 
> So here's my suggestion.
> 
> First, make ARM64 boot with 4.2+ in the simplest way possible.
> 
> Second, set out to fix BAD_MADT_ENTRY() etc.  Start with fixing ACPICA to
> distinguish between the different formats depending on the spec version and
> follow up from there.

That's fine by me (as long as there is a plan to fix it properly,
ideally in 4.3).

-- 
Catalin

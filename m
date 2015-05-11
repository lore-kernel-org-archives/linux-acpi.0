From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 7/7] ACPI / processor: Introduce invalid_phys_cpuid()
Date: Mon, 11 May 2015 17:35:42 +0100
Message-ID: <20150511163542.GB2942@red-moon>
References: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org>
 <1430793998-21631-8-git-send-email-hanjun.guo@linaro.org>
 <5548A8C5.1080406@arm.com>
 <5548C219.9060100@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5548C219.9060100@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 05, 2015 at 02:14:01PM +0100, Hanjun Guo wrote:
> On 2015???05???05??? 19:25, Sudeep Holla wrote:
> >
> >
> > On 05/05/15 03:46, Hanjun Guo wrote:
> >> Introduce invalid_phys_cpuid() to identify cpu with invalid
> >> physical ID, then used it as replacement of the direct comparisons
> >> with PHYS_CPUID_INVALID.
> >>
> >> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >> ---
> >>   drivers/acpi/acpi_processor.c | 4 ++--
> >>   drivers/acpi/processor_core.c | 4 ++--
> >>   include/linux/acpi.h          | 5 +++++
> >>   3 files changed, 9 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/acpi/acpi_processor.c
> >> b/drivers/acpi/acpi_processor.c
> >> index 62c846b..92a5f73 100644
> >> --- a/drivers/acpi/acpi_processor.c
> >
> > [...]
> >
> >> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> >> index 913b49f..cc82ff3 100644
> >> --- a/include/linux/acpi.h
> >> +++ b/include/linux/acpi.h
> >> @@ -163,6 +163,11 @@ static inline bool invalid_logical_cpuid(u32 cpuid)
> >>       return (int)cpuid < 0;
> >>   }
> >>
> >> +static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
> >> +{
> >> +    return (int)phys_id < 0;
> >
> > Should this be phys_id == PHYS_CPUID_INVALID ? else I don't see why we
> > need to even define PHYS_CPUID_INVALID
> 
> I'm OK with this. For now, CPU phys_id will be valid value or
> PHYS_CPUID_INVALID in all cases for ACPI processor driver, but
> I want ask Rafael's opinion on this, is it OK to you too, Rafael?

Is your worry related to functions returning error values
other than PHYS_CPUID_INVALID (when they are expected to return a
physical id) ? Is there any in the current kernel ?

static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
{
	return phys_id == PHYS_CPUID_INVALID;
}

This should do, and if we need more mapping functions that are supposed
to return physical ids they should return PHYS_CPUID_INVALID on failure.

Lorenzo

From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] arm64: acpi: Prepare for longer MADTs
Date: Thu, 1 Nov 2018 14:22:47 +0000
Message-ID: <20181101142247.GB27913@e107155-lin>
References: <20181012192937.3819951-1-jeremy.linton@arm.com>
 <20181101113136.GA6608@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181101113136.GA6608@e107981-ln.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com, rafael.j.wysocki@intel.com, takahiro.akashi@linaro.org, Sudeep Holla <sudeep.holla@arm.com>, ahs3@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 01, 2018 at 11:31:36AM +0000, Lorenzo Pieralisi wrote:
> On Fri, Oct 12, 2018 at 02:29:37PM -0500, Jeremy Linton wrote:
> > The BAD_MADT_GICC_ENTRY check is a little too strict because
> > it rejects MADT entries that don't match the currently known
> > lengths. We should remove this restriction to avoid problems
> > if the table length changes. Future code which might depend on
> > additional fields should be written to validate those fields
> > before using them, rather than trying to globally check
> > known MADT version lengths.
> >
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > ---
> >  arch/arm64/include/asm/acpi.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Hi Jeremy,
>
> I assume there is no [PATCH 1/2] (to make sure I have not missed
> anything).
>

IIRC, it's a patch fixing module device table entry for SPE. They are
independent, just happened to be put out together.

--
Regards,
Sudeep

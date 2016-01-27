From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3] ARM64: kernel: implement ACPI parking protocol
Date: Wed, 27 Jan 2016 11:51:26 +0000
Message-ID: <20160127115126.GB9522@red-moon>
References: <1453806638-23167-1-git-send-email-lorenzo.pieralisi@arm.com>
 <CAPw-ZTk=BbXAPgWAV=3Np0qvLA+i+U5eh+nxHS=2uMjKohdUfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51975 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099AbcA0Ltg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Jan 2016 06:49:36 -0500
Content-Disposition: inline
In-Reply-To: <CAPw-ZTk=BbXAPgWAV=3Np0qvLA+i+U5eh+nxHS=2uMjKohdUfA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Loc Ho <lho@apm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-acpi@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>

On Tue, Jan 26, 2016 at 03:13:30PM -0800, Loc Ho wrote:
> Hi Lorenzo,
> 
> On Tue, Jan 26, 2016 at 3:10 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > The SBBR and ACPI specifications allow ACPI based systems that do not
> > implement PSCI (eg systems with no EL3) to boot through the ACPI parking
> > protocol specification[1].
> >
> > This patch implements the ACPI parking protocol CPU operations, and adds
> > code that eases parsing the parking protocol data structures to the
> > ARM64 SMP initializion carried out at the same time as cpus enumeration.
> >
> > To wake-up the CPUs from the parked state, this patch implements a
> > wakeup IPI for ARM64 (ie arch_send_wakeup_ipi_mask()) that mirrors the
> > ARM one, so that a specific IPI is sent for wake-up purpose in order
> > to distinguish it from other IPI sources.
> >
> > Given the current ACPI MADT parsing API, the patch implements a glue
> > layer that helps passing MADT GICC data structure from SMP initialization
> > code to the parking protocol implementation somewhat overriding the CPU
> > operations interfaces. This to avoid creating a completely trasparent
> > DT/ACPI CPU operations layer that would require creating opaque
> > structure handling for CPUs data (DT represents CPU through DT nodes, ACPI
> > through static MADT table entries), which seems overkill given that ACPI
> > on ARM64 mandates only two booting protocols (PSCI and parking protocol),
> > so there is no need for further protocol additions.
> >
> > Based on the original work by Mark Salter <msalter@redhat.com>
> >
> > [1] https://acpica.org/sites/acpica/files/MP%20Startup%20for%20ARM%20platforms.docx
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Hanjun Guo <hanjun.guo@linaro.org>
> > Cc: Loc Ho <lho@apm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Mark Salter <msalter@redhat.com>
> > Cc: Al Stone <ahs3@redhat.com>
> 
> I had tested this with X-Gene Mustang board. It applies cleanly
> against 4.5.0-rc1 and detected all CPU's. For those of you want to try
> this, you need an FW update if you are using APM Tianocore. Otherwise,
> it will stuck in very early booting stage.

We can take this as a Tested-by, right ?

Thanks,
Lorenzo

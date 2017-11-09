From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH V3 2/2] acpi: apei: call into AER handling regardless of
 severity
Date: Thu, 9 Nov 2017 18:29:37 +0100
Message-ID: <20171109172937.rc747ng6rttsxlza@pd.tnic>
References: <1510168392-30114-1-git-send-email-tbaicar@codeaurora.org>
 <1510168392-30114-3-git-send-email-tbaicar@codeaurora.org>
 <20171109094654.daymsvizctfrypbo@pd.tnic>
 <74cee7d2-dffa-0559-d529-5c86023161e3@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32775 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751003AbdKIR3n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 Nov 2017 12:29:43 -0500
Content-Disposition: inline
In-Reply-To: <74cee7d2-dffa-0559-d529-5c86023161e3@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: rjw@rjwysocki.net, tony.luck@intel.com, will.deacon@arm.com, james.morse@arm.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 09, 2017 at 10:14:35AM -0500, Tyler Baicar wrote:
> On 11/9/2017 4:46 AM, Borislav Petkov wrote:
> > On Wed, Nov 08, 2017 at 12:13:12PM -0700, Tyler Baicar wrote:
> > > Currently the GHES code only calls into the AER driver for
> > > recoverable type errors. This is incorrect because errors of
> > > other severities do not get logged by the AER driver and do not
> > > get exposed to user space via the AER trace event. So, call
> > > into the AER driver for PCIe errors regardless of the severity
> > > 
> > > Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> > > ---
> > >   drivers/acpi/apei/ghes.c | 8 +++-----
> > >   1 file changed, 3 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > > index 839c3d5..bb65fa6 100644
> > > --- a/drivers/acpi/apei/ghes.c
> > > +++ b/drivers/acpi/apei/ghes.c
> > > @@ -458,14 +458,12 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
> > >   #endif
> > >   }
> > Where did the explanatory comment go?
> > 
> > +/*
> > + * PCIe AER errors need to be sent to the AER driver for reporting and
> > + * recovery. The GHES severities map to the following AER severities and
> > + * require the following handling:
> > + *
> > + * GHES_SEV_CORRECTABLE -> AER_CORRECTABLE
> > + *     These need to be reported by the AER driver but no recovery is
> > + *     necessary.
> > + * GHES_SEV_RECOVERABLE -> AER_NONFATAL
> > + * GHES_SEV_RECOVERABLE && CPER_SEC_RESET -> AER_FATAL
> > + *     These both need to be reported and recovered from by the AER driver.
> > + * GHES_SEV_PANIC does not make it to this handling since the kernel must
> > + *     panic.
> > + */
> > 
> > <--- ???
> Updated patch including the comment:

When you decide to do the reckless thing of pasting a patch into
thunderbird on *windoze*, first send it to yourself only and try
applying it.

Because I see this:

[boris@pd: ~/kernel/linux> test-apply.sh /tmp/tbaicar.02
checking file drivers/acpi/apei/ghes.c
patch: **** malformed patch at line 64: @@ -519,7 +531,7 @@ static void ghes_do_proc(struct ghes *ghes,

Not good.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 

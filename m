From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] ACPI / APEI: Suppress message if HEST not present
Date: Wed, 30 Aug 2017 13:54:57 +0200
Message-ID: <4871557.DtPhj4UV3s@aspire.rjw.lan>
References: <20170829132020.31471-1-punit.agrawal@arm.com> <20170829150219.4gg3443phihudvbv@pd.tnic> <87d17dgx80.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55653 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751323AbdH3MDk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Aug 2017 08:03:40 -0400
In-Reply-To: <87d17dgx80.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Borislav Petkov <bp@suse.de>, linux-acpi@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>

On Wednesday, August 30, 2017 12:34:55 PM CEST Punit Agrawal wrote:
> Borislav Petkov <bp@suse.de> writes:
> 
> > On Tue, Aug 29, 2017 at 02:20:20PM +0100, Punit Agrawal wrote:
> >> According to the ACPI specification, firmware is not required to provide
> >> the Hardware Error Source Table (HEST). When HEST is not present, the
> >> following superfluous message is printed to the kernel boot log -
> >> 
> >> [    3.460067] GHES: HEST is not enabled!
> >> 
> >> Extend hest_disable variable to track whether the firmware provides this
> >> table and if it is not present skip any log output. The existing
> >> behaviour is preserved in all other cases.
> >> 
> >> Suggested-by: Borislav Petkov <bp@suse.de>
> >> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> >> Cc: Borislav Petkov <bp@suse.de>
> >> Cc: James Morse <james.morse@arm.com>
> >> ---
> >> 
> >> Changes in v3:
> >> * Grouped hest_disable status checking into a switch/case for clarity
> >> 
> >>  drivers/acpi/apei/ghes.c |  7 ++++++-
> >>  drivers/acpi/apei/hest.c | 13 +++++++------
> >>  include/acpi/apei.h      |  8 +++++++-
> >>  3 files changed, 20 insertions(+), 8 deletions(-)
> >
> > Reviewed-by: Borislav Petkov <bp@suse.de>
> 
> Thanks!
> 
> Hopefully Rafael can pick the patch for the upcoming merge window.

Applied already, should show up in linux-next tomorrow.

Thanks,
Rafael


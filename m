From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
Date: Wed, 13 Apr 2016 09:51:39 +0100
Message-ID: <20160413085139.GA15182@e104818-lin.cambridge.arm.com>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
 <20160412172315.GH8066@e104818-lin.cambridge.arm.com>
 <20160413052553.GF14664@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60810 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756983AbcDMIvp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Apr 2016 04:51:45 -0400
Content-Disposition: inline
In-Reply-To: <20160413052553.GF14664@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Graeme Gregory <graeme.gregory@linaro.org>, Will Deacon <will.deacon@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>

On Wed, Apr 13, 2016 at 06:25:53AM +0100, Mark Brown wrote:
> On Tue, Apr 12, 2016 at 06:23:15PM +0100, Catalin Marinas wrote:
> > I'm fine with dropping the EXPERT dependency (of course, not a cc
> > stable). While arm64 ACPI is not "done" yet (nor is DT; there are
> > important ongoing developments like PCIe, IORT), I think the core arm64
> > ACPI support passed the EXPERT stage. I also don't think a default y
> > would imply any maintainer endorsement; vendors targeting ACPI are
> > already doing this for various reasons (distro requirement, certain ACPI
> 
> So you're OK with the current patch?

Yes, I posted an ack in the previous reply (with a note that Will and
the arm-soc maintainers still have a right to veto this change).

-- 
Catalin

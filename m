From: Will Deacon <will.deacon@arm.com>
Subject: Re: [GIT PULL] ACPI IORT fixes for v4.10-rc8
Date: Mon, 6 Feb 2017 13:47:36 +0000
Message-ID: <20170206134735.GJ19939@arm.com>
References: <20170206133856.GA14139@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752331AbdBFNrf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Feb 2017 08:47:35 -0500
Content-Disposition: inline
In-Reply-To: <20170206133856.GA14139@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: catalin.marinas@arm.com, hanjun.guo@linaro.org, dan.carpenter@oracle.com, okaya@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org

On Mon, Feb 06, 2017 at 01:38:56PM +0000, Lorenzo Pieralisi wrote:
> Hi Will, Catalin,

Hi Lorenzo,

> please consider pulling a couple of minor ACPI IORT fixes that were
> missed in the last few -rc* cycles but should be considered for
> merging as soon as possible, hopefully before v4.10 is released.

Both of these fixes look like they fix theoretical issues, as opposed to
fixing problems actually seen on existing platforms. Given that I don't
think there's going to be an -rc8, I'll take these for 4.11 instead.

Hopefully it'll be smooth sailing now that we've got the merge path
sorted out for arm64 acpi changes.

Let me know if that's a problem.

Will

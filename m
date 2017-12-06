From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4 0/2] Restructure and fix GHES PCIe AER handling
Date: Wed, 06 Dec 2017 01:56:37 +0100
Message-ID: <2307348.MxdqBO6say@aspire.rjw.lan>
References: <1511905689-11522-1-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63704 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753380AbdLFA5M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Dec 2017 19:57:12 -0500
In-Reply-To: <1511905689-11522-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: tony.luck@intel.com, will.deacon@arm.com, james.morse@arm.com, bp@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, November 28, 2017 10:48:07 PM CET Tyler Baicar wrote:
> First, break the PCIe AER handling out into its own function to separate
> it from the standard GHES processing
> 
> Then fix the AER handling to process all errors in the AER driver rather
> than only handling recoverable errors.
> 
> V4: Rebase to 4.15-rc1 and add reviewed-by
> 
> Tyler Baicar (2):
>   acpi: apei: handle PCIe AER errors in separate function
>   acpi: apei: call into AER handling regardless of severity
> 
>  drivers/acpi/apei/ghes.c | 76 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 46 insertions(+), 30 deletions(-)

Both applied, thanks!


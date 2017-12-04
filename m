From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/15] ACPICA release 20171110
Date: Mon, 04 Dec 2017 15:43:47 +0100
Message-ID: <2049302.ItqyCUrOUY@aspire.rjw.lan>
References: <erik.schmauss@intel.com> <20171117234230.913-1-erik.schmauss@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46212 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751950AbdLDOoU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Dec 2017 09:44:20 -0500
In-Reply-To: <20171117234230.913-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik Schmauss <erik.schmauss@intel.com>
Cc: linux-acpi@vger.kernel.org

On Saturday, November 18, 2017 12:42:15 AM CET Erik Schmauss wrote:
> This series comes from the 20171110 release of ACPICA.
> This set of patches is meant to be applied on top of the 20170929
> release of ACPICA.
> 
> Bob Moore (10):
>   ACPICA: Use local 64-bit divide support for string conversions
>   ACPICA: Update output from ACPI_EXCEPTION macro
>   ACPICA: Add an additional error message for EC timeouts
>   ACPICA: Enhance error messages from namespace create/lookup operations
>   ACPICA: ACPI 6.0A: Changes to the NFIT ACPI table
>   ACPICA: Small typo fix, no functional change.
>   ACPICA: Debugger: add "background" command for method execution
>   ACPICA: Update mutex error messages, no functional change
>   ACPICA: Update linkage for get mutex name interface
>   ACPICA: Update version to 20171110
> 
> Colin Ian King (1):
>   ACPICA: Trivial fix to spelling mistake in comment
> 
> Erik Schmauss (2):
>   ACPICA: ACPICA: style edits to utility function output, no functional
>     change
>   ACPICA: Namespace: fix memory leak from building prefixed pathname
> 
> Hanjun Guo (1):
>   ACPICA: iasl: Add SMMUv3 device ID mapping index support
> 
> Jeremy Linton (1):
>   ACPICA: ACPI 6.2: Additional PPTT flags

Series applied, thanks!

Rafael


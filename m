From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/11] ACPICA release 20170929
Date: Mon, 04 Dec 2017 15:44:16 +0100
Message-ID: <4049715.FQ2OufhA00@aspire.rjw.lan>
References: <erik.schmauss@intel.com> <20171117234024.833-1-erik.schmauss@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43198 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751205AbdLDOot (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Dec 2017 09:44:49 -0500
In-Reply-To: <20171117234024.833-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik Schmauss <erik.schmauss@intel.com>
Cc: linux-acpi@vger.kernel.org

On Saturday, November 18, 2017 12:40:13 AM CET Erik Schmauss wrote:
> This series of patches are from the 20170929 release of ACPICA.
> This set is meant to be applied on top of the 20170831 ACPICA release.
> 
> Bob Moore (4):
>   ACPICA: Rename AE_AML_INFINITE_LOOP exception
>   ACPICA: Tools: Deploy -vd option (build date/time) across all tools
>   ACPICA: iASL/Tools: Add support for PDTT,SDEV,TPM2 ACPI tables
>   ACPICA: Update version to 20170929
> 
> Colin Ian King (1):
>   ACPICA: Avoid null pointer dereference on Op.
> 
> Erik Schmauss (3):
>   ACPICA: Disassembler: reset parser_state's Aml pointer when parsing
>     bad externals
>   ACPICA: disassembler: getting rid of error message
>   ACPICA: iASL: change processing of external op namespace nodes for
>     correctness
> 
> Jung-uk Kim (1):
>   ACPICA: Fix an off-by-one error in acpi_get_timer_duration().
> 
> Lv Zheng (2):
>   ACPICA: Dispatcher: Introduce timeout mechanism for infinite loop
>     detection
>   ACPICA: Utilities: Cleanup style issue for bit clearing

Series applied, thanks!

Rafael


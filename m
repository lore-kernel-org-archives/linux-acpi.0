From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA version 20120518 linuxized patches
Date: Fri, 01 Jun 2012 11:56:44 -0400
Message-ID: <4FC8E63C.9020109@kernel.org>
References: <1337676725.24434.34.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35449 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965125Ab2FAP4t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jun 2012 11:56:49 -0400
Received: by qcro28 with SMTP id o28so1202488qcr.19
        for <linux-acpi@vger.kernel.org>; Fri, 01 Jun 2012 08:56:48 -0700 (PDT)
In-Reply-To: <1337676725.24434.34.camel@minggr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On 05/22/2012 04:52 AM, Lin Ming wrote:

> Hi Len,
> 
> ACPICA version 20120518 linuxized patches attached.
> 
> [PATCH 1/6] ACPICA: Disassembler: Add support for Operation Region externals
> [PATCH 2/6] ACPICA: ACPI 5/iASL: Add support for PCC keyword
> [PATCH 3/6] ACPICA: iASL: Improved pathname support
> [PATCH 4/6] ACPICA: Remove argument of acpi_os_wait_events_complete
> [PATCH 5/6] ACPICA: Add FADT error message for GAS BitWidth overflow
> [PATCH 6/6] ACPICA: Update to version 20120518
> 
> Regards,
> Lin Ming


Applied.

I is great that the compiler and interpreter share the same code.
However, there is also the risk of building dead compiler code
into the kernel.  We should probably do an analysis of that...

thanks,
Len Brown, Intel Open Source Technology Center


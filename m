From: Andrew Morton <akpm@osdl.org>
Subject: Re: [Bugme-new] [Bug 6637] New: IRQ incorect discover on HP M2
 megaraid controler
Date: Fri, 2 Jun 2006 11:22:04 -0700
Message-ID: <20060602112204.7f71e5ad.akpm@osdl.org>
References: <200606021236.k52Ca1T6017681@fire-2.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:57569 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751441AbWFBSWR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2006 14:22:17 -0400
In-Reply-To: <200606021236.k52Ca1T6017681@fire-2.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bugme-daemon@bugzilla.kernel.org
Cc: linux-acpi@vger.kernel.org, mkowalik@flyingbytes.pl

On Fri, 2 Jun 2006 05:36:01 -0700
bugme-daemon@bugzilla.kernel.org wrote:

> ACPI: RSDP (v000 COMPAQ                                ) @ 0x000f4fd0
>   >>> ERROR: Invalid checksum
> ...
> ACPI: Subsystem revision 20050902
> ACPI: Interpreter disabled.

Looks like ACPI doesn't like your BIOS tables.  After that ACPI doen't work
and that causes your interrupts tonot get set up.

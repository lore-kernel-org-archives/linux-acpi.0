From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: ACPICA release 20101013 linuxized patches
Date: Mon, 18 Oct 2010 16:41:03 +0800
Message-ID: <1287391263.2226.7.camel@localhost>
References: <1287366571.6530.3026.camel@minggr.sh.intel.com>
	 <alpine.LFD.2.00.1010180130360.3295@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51257 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322Ab0JRIk6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Oct 2010 04:40:58 -0400
In-Reply-To: <alpine.LFD.2.00.1010180130360.3295@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Colin Ian King <colin.king@canonical.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, 2010-10-18 at 13:31 +0800, Len Brown wrote:
> patch 5 doesn't look quite right,
> because it leaves both
> 
> #define ACPI_BITMASK_PCIEXP_WAKE_STATUS         0x4000  /* ACPI 3.0 */
> and
> #define ACPI_BITMASK_PCIEXP_WAKE_DISABLE        0x4000  /* ACPI 3.0 */
> 
> in aclocal.h
> 
> If we're going to re-name what the original patch did,
> then we should finsh the job and delete the original name, yes?

No, we don't re-name anything.

#define ACPI_BITMASK_PCIEXP_WAKE_STATUS         0x4000  /* ACPI 3.0 */
#define ACPI_BITMASK_PCIEXP_WAKE_DISABLE        0x4000  /* ACPI 3.0 */

These are the bit positions for the status and enable registers.

Colin's original patch mis-used ACPI_BITMASK_PCIEXP_WAKE_DISABLE which
should be ACPI_BITMASK_PCIEXP_WAKE_STATUS, but it didn't cause any
problem because they have the same value 0x4000.

Bob has corrected it, see comment #1 at
http://www.acpica.org/bugzilla/show_bug.cgi?id=880

Lin Ming

> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 



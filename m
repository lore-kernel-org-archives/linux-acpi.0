From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 6/9] ACPI, APEI, CPER: Add UEFI 2.4 support for memory
 error
Date: Thu, 17 Oct 2013 17:53:31 +0530
Message-ID: <525FD6C3.9080207@linux.vnet.ibm.com>
References: <1381935366-11731-1-git-send-email-gong.chen@linux.intel.com> <1381935366-11731-7-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:50112 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755049Ab3JQM2c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Oct 2013 08:28:32 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Thu, 17 Oct 2013 22:28:30 +1000
In-Reply-To: <1381935366-11731-7-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, bp@alien8.de, joe@perches.com, m.chehab@samsung.com
Cc: arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/16/2013 08:26 PM, Chen, Gong wrote:
> In latest UEFI spec(by now it is 2.4) memory error definition
> for CPER (UEFI 2.4 Appendix N Common Platform Error Record)
> adds some new fields. These fields help people to locate
> memory error on actual DIMM location.
>
> Original-author: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> Reviewed-by: Borislav Petkov <bp@suse.de>
> ---
>   arch/x86/kernel/cpu/mcheck/mce-apei.c |  3 +--
>   drivers/acpi/apei/cper.c              |  7 ++++---
>   drivers/acpi/apei/ghes.c              |  4 ++--
>   drivers/edac/ghes_edac.c              |  5 ++---
>   include/linux/cper.h                  | 11 +++++++++--
>   5 files changed, 18 insertions(+), 12 deletions(-)

Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


Regards,
Naveen


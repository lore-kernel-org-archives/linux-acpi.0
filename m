From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/8] DMI: Parse memory device (type 17) in SMBIOS
Date: Wed, 16 Oct 2013 00:30:21 +0530
Message-ID: <20131015190020.GD2777@naverao1-tp.ibm.com>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-5-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:54055 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759447Ab3JOTAs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2013 15:00:48 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Wed, 16 Oct 2013 05:00:47 +1000
Content-Disposition: inline
In-Reply-To: <1381473166-29303-5-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, bp@alien8.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 2013/10/11 02:32AM, Chen Gong wrote:
> This patch adds a new interface to decode memory device (type 17)
> to help error reporting on DIMMs.
> 
> Original-author: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> ---
>  arch/ia64/kernel/setup.c    |  1 +
>  arch/x86/kernel/setup.c     |  1 +
>  drivers/firmware/dmi_scan.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dmi.h         |  5 ++++
>  4 files changed, 67 insertions(+)

Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


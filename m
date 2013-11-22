From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] New Driver for IOSF-SB MBI access on Intel SOCs
Date: Fri, 22 Nov 2013 18:18:27 +0000
Message-ID: <20131122181827.GA16998@srcf.ucam.org>
References: <1385100357-5459-1-git-send-email-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50664 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756Ab3KVSSm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 13:18:42 -0500
Content-Disposition: inline
In-Reply-To: <1385100357-5459-1-git-send-email-david.e.box@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@sisk.pl, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Nov 21, 2013 at 10:05:56PM -0800, David E. Box wrote:

> +	bool "IOSF-SB MailBox Interface access support for Intel SOC's"

Any reason this can't be modular?

> diff --git a/arch/x86/kernel/iosf_mbi.c b/arch/x86/kernel/iosf_mbi.c

This is effectively a driver, so putting it under platform/driver/x86 
might make more sense.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

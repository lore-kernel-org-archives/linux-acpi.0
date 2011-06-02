From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 7/9] PCIe, AER, add aer_recover_queue
Date: Thu, 2 Jun 2011 08:05:39 -0700
Message-ID: <20110602080539.52bb6d89@jbarnes-desktop>
References: <1305619719-7480-1-git-send-email-ying.huang@intel.com>
	<1305619719-7480-8-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from oproxy2-pub.bluehost.com ([67.222.39.55]:37149 "HELO
	oproxy2-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752111Ab1FBPMl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jun 2011 11:12:41 -0400
In-Reply-To: <1305619719-7480-8-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, Zhang Yanmin <yanmin.zhang@intel.com>

On Tue, 17 May 2011 16:08:37 +0800
Huang Ying <ying.huang@intel.com> wrote:

> In addition to native PCIe AER, now APEI (ACPI Platform Error
> Interface) GHES (Generic Hardware Error Source) can be used to report
> PCIe AER errors too.  To add support to APEI GHES PCIe AER recovery,
> aer_recover_queue is added to export the recovery function in native
> PCIe AER driver.
> 
> Recoverable PCIe AER errors are reported via NMI in APEI GHES.  Then
> APEI GHES uses irq_work to delay the error processing into an IRQ
> handler.  But PCIe AER recovery can be very time-consuming, so
> aer_recover_queue, which can be used in IRQ handler, delays the real
> recovery action into the process context, that is, work queue.

Applied to linux-next, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center

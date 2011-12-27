From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 4/4] ACPI: Do cpufreq clamping for throttling per
 package instead of per CPU
Date: Tue, 27 Dec 2011 16:43:24 +0000
Message-ID: <20111227164323.GA23245@srcf.ucam.org>
References: <1324967687-10559-1-git-send-email-andi@firstfloor.org>
 <1324967687-10559-5-git-send-email-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35657 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab1L0Qnb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Dec 2011 11:43:31 -0500
Content-Disposition: inline
In-Reply-To: <1324967687-10559-5-git-send-email-andi@firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>

On Mon, Dec 26, 2011 at 10:34:47PM -0800, Andi Kleen wrote:

> +	if (reduction_pctg(policy->cpu))
> +		printk("cpufreq notifier %ld\n", event);
> +

Needed?

-- 
Matthew Garrett | mjg59@srcf.ucam.org

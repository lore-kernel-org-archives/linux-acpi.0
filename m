From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 4/5] ACPI: Do cpufreq clamping for throttling per
 package v2
Date: Fri, 30 Mar 2012 12:46:33 +0100
Message-ID: <20120330114633.GA16502@srcf.ucam.org>
References: <1328545032-21373-1-git-send-email-andi@firstfloor.org>
 <1328545032-21373-5-git-send-email-andi@firstfloor.org>
 <4F758569.9080608@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55939 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab2C3Lqk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Mar 2012 07:46:40 -0400
Content-Disposition: inline
In-Reply-To: <4F758569.9080608@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>

On Fri, Mar 30, 2012 at 06:05:29AM -0400, Len Brown wrote:
> Andi,
> Can you re-base this on top of my release tree?
> 
> Your fix is important, but conflicted with mjg's
> more invasive percentage -> frequency change.

Sorry, I think it's probably better not to take my patch here - the spec 
uses percentages rather than frequencies. I'm not convinced that that 
makes sense, but there's some chance that some behaviour may end up 
depending on that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

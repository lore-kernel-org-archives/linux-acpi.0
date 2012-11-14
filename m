From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Patch to correct battery capacity values on Thinkpads (repost)
Date: Wed, 14 Nov 2012 07:41:13 +0000
Message-ID: <20121114074113.GA32091@srcf.ucam.org>
References: <20121112050935.GA25110@scooby.iskra.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57918 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756315Ab2KNHlT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Nov 2012 02:41:19 -0500
Content-Disposition: inline
In-Reply-To: <20121112050935.GA25110@scooby.iskra.name>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kamil Iskra <kamil@iskra.name>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Sun, Nov 11, 2012 at 11:09:35PM -0600, Kamil Iskra wrote:

> My guess is that this problem has been around ever since those machines
> have been released, but because the most common Thinkpad batteries are
> rated at 10.8V, the error (8%) is small enough that it simply hasn't been
> noticed or at least nobody could be bothered to look into it.

Yeah, the DSDT simply multiples the values by 10 when it's in this 
state. But the issue is purely cosmetic, right? I can't see any reason 
anything would be using the design voltage in calculations.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

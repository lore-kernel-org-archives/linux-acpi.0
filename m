From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: cap off P-state transition latency from buggy BIOSes
Date: Thu, 19 Mar 2009 21:47:46 +0000
Message-ID: <20090319214746.GC24898@srcf.ucam.org>
References: <20090319214140.GA28868@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47782 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757193AbZCSVrx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2009 17:47:53 -0400
Content-Disposition: inline
In-Reply-To: <20090319214140.GA28868@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, Mar 19, 2009 at 02:41:40PM -0700, Pallipadi, Venkatesh wrote:

> Fix it by capping-off the transition latency to 20uS for native MSR based
> frequency transitions.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

We've confirmed that this also helps on the X31.

Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org

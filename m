From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Wishlist: Disable C6 in intel_idle for Model 44 processors
Date: Wed, 12 Jun 2013 19:32:49 +0100
Message-ID: <20130612183249.GA20957@srcf.ucam.org>
References: <38D8523B-C50E-4D81-A9E2-526292B19AF3@usgs.gov>
 <20130612134002.GA15317@srcf.ucam.org>
 <1BD2BF18-8FAA-4633-8B6D-7CA2D6AE67AC@usgs.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57367 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756019Ab3FLScw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jun 2013 14:32:52 -0400
Content-Disposition: inline
In-Reply-To: <1BD2BF18-8FAA-4633-8B6D-7CA2D6AE67AC@usgs.gov>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Larry Baker <baker@usgs.gov>
Cc: linux-acpi@vger.kernel.org, Rob E Russell <robr@us.ibm.com>

On Wed, Jun 12, 2013 at 11:11:21AM -0700, Larry Baker wrote:

> The processor errata is operating system agnostic.  I suspect the BIOS 
> workaround they envision would be a feature in the BIOS to limit the 
> choice of C states to be used.  The IBM BIOS has such a setting, and 
> the default value is to completely disable C states.  However, 
> intel_idle ignores the BIOS setting.

No, the BIOS workaround will typically be to program the memory 
controller such that the problem isn't triggered. If you're having 
latency-related issues then the appropriate fix is to use the pm_qos 
interface that's present in RHEL 6 and the upstream kernel, and you can 
do so in RHEL using the ktune command. 

-- 
Matthew Garrett | mjg59@srcf.ucam.org

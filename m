From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/2]: the patch set to weaken the dependency between ACPI video driver and i915 driver
Date: Wed, 15 Apr 2009 17:54:09 +0100
Message-ID: <20090415165409.GB27807@srcf.ucam.org>
References: <1239678275.5564.66.camel@localhost.localdomain> <20090414193538.GB8304@srcf.ucam.org> <1239757961.5564.109.camel@localhost.localdomain> <20090415045359.GA15437@srcf.ucam.org> <9F0C1DB20AFA954FA1DA05309350433D5B2E7517@pdsmsx503.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46836 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbZDOQyR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Apr 2009 12:54:17 -0400
Content-Disposition: inline
In-Reply-To: <9F0C1DB20AFA954FA1DA05309350433D5B2E7517@pdsmsx503.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhao, Yakui" <yakui.zhao@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Apr 15, 2009 at 09:21:16PM +0800, Zhao, Yakui wrote:
> Will you please explain more clearly why ACPI video driver is required when KMS is used?

Sorry, I should have been clearer. ACPI is required if the hardware 
supports opregion. Now that I've thought about it more, I think the 
patch I've just sent should remove the need to change the #ifdefs in the 
video driver.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

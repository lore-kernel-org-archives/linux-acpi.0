From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] ACPI-Thermal: Add a 'flag' argument in thermal.c
Date: Thu, 26 Jan 2012 16:23:20 +0000
Message-ID: <20120126162320.GA15099@srcf.ucam.org>
References: <1327595749-17673-1-git-send-email-durgadoss.r@intel.com>
 <1327595749-17673-2-git-send-email-durgadoss.r@intel.com>
 <20120126134256.GA11017@srcf.ucam.org>
 <4D68720C2E767A4AA6A8796D42C8EB5902F813@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54434 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034Ab2AZQXZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jan 2012 11:23:25 -0500
Content-Disposition: inline
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB5902F813@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

On Thu, Jan 26, 2012 at 04:14:39PM +0000, R, Durgadoss wrote:

> I thought through this.. But there are few drivers in
> drivers/platform/x86/, that use these calls. In that case,
> how will we merge them ?
>
> Is it ok If I send 'one' patch which includes both ACPI and
> Platform driver(s) changes ?

Yes. Send one patch that updates the API and callers simultaneously.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

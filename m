From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch]: ACPI: Add the Pansonic CF51 box to the dmi check table
Date: Wed, 18 Mar 2009 13:41:53 +0000
Message-ID: <20090318134153.GA28461@srcf.ucam.org>
References: <1237365385.3640.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47105 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbZCRNmE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Mar 2009 09:42:04 -0400
Content-Disposition: inline
In-Reply-To: <1237365385.3640.43.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Wed, Mar 18, 2009 at 04:36:25PM +0800, yakui_zhao wrote:
> Subject: ACPI: Add the Pansonic CF51 box to the dmi check table
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> The Pansonic CF51-2L box can't be resumed if the boot option of
> "acpi_sleep=old_ordering" is not added.

Do we have any idea what's going on here, yet? Several of the machines 
on this blacklist are modern, so it's not a workaround for ancient 
hardware.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2]: ACPI: Check whether the acpi video is deferrable only when KMS is enabled
Date: Tue, 14 Apr 2009 20:36:11 +0100
Message-ID: <20090414193611.GC8304@srcf.ucam.org>
References: <1239678345.5564.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44877 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096AbZDNTgR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Apr 2009 15:36:17 -0400
Content-Disposition: inline
In-Reply-To: <1239678345.5564.69.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Tue, Apr 14, 2009 at 11:05:45AM +0800, yakui_zhao wrote:
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> weaken the dependency between the I915 driver and ACPI video driver.
> When the KMS is not enabled in kernel configuration, it will contine
> the current flowchart. 
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> cc: Matthew Garrett <mjg59@srcf.ucam.org>

Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org

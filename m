From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] ACPI-Thermal: Add a 'flag' argument in thermal.c
Date: Thu, 26 Jan 2012 13:42:56 +0000
Message-ID: <20120126134256.GA11017@srcf.ucam.org>
References: <1327595749-17673-1-git-send-email-durgadoss.r@intel.com>
 <1327595749-17673-2-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50147 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab2AZNnD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jan 2012 08:43:03 -0500
Content-Disposition: inline
In-Reply-To: <1327595749-17673-2-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com

On Thu, Jan 26, 2012 at 10:05:49PM +0530, Durgadoss R wrote:
> This patch adds a 'flag' argument to the thermal_zone_device_register
> call in thermal.c.

Functions and callers must be updated in the same patch - if someone 
bisects to between these two then their build will be broken.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 12/22] ACPI: add boot option acpi=copy_dsdt to fix
	corrupt DSDT
Date: Thu, 20 May 2010 14:07:33 +0100
Message-ID: <20100520130733.GA14895@srcf.ucam.org>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com> <aa2110cb1a7510f9b834adfb39b05d4843a35d35.1274332657.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44085 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab0ETNHm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 09:07:42 -0400
Content-Disposition: inline
In-Reply-To: <aa2110cb1a7510f9b834adfb39b05d4843a35d35.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

I *really* don't think adding a new DMI blacklist is a good idea. Either 
the hardware is doing something insane and Windows always copies the 
DSDT, or there's method to the hardware's madness and Windows copes with 
this somehow. This patch just papers over the problem and doesn't 
actually attempt to work out what's really going on.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

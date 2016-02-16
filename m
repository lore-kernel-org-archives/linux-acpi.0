From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 3/3] drivers/acpi: make pmic/intel_pmic_crc.c explicitly
 non-modular
Date: Tue, 16 Feb 2016 10:52:15 +0800
Message-ID: <56C28EDF.9010804@intel.com>
References: <1455514071-26368-1-git-send-email-paul.gortmaker@windriver.com>
 <1455514071-26368-4-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15049 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532AbcBPCwf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Feb 2016 21:52:35 -0500
In-Reply-To: <1455514071-26368-4-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On 02/15/2016 01:27 PM, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/acpi/Kconfig:config CRC_PMIC_OPREGION
> drivers/acpi/Kconfig:   bool "ACPI operation region support for CrystalCove PMIC"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the couple modular references, so that when reading
> the driver there is no doubt it is builtin-only.
> 
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Aaron Lu <aaron.lu@intel.com>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Aaron Lu <aaron.lu@intel.com>

Initially I want to make it a module, but then people told me it's not
safe to remove operation region handler during runtime, so it became
always builtin. We can change it back to module once the above problem
is solved.

From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v3 1/4] acpi: nfit: Add support for detect platform CPU
 cache flush on power loss
Date: Tue, 30 Jan 2018 17:13:40 -0700
Message-ID: <20180131001340.GB27220@linux.intel.com>
References: <151735668391.34477.11820724492631561208.stgit@djiang5-desk3.ch.intel.com>
 <151735687346.34477.4956828815153494582.stgit@djiang5-desk3.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:44778 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751606AbeAaANk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Jan 2018 19:13:40 -0500
Content-Disposition: inline
In-Reply-To: <151735687346.34477.4956828815153494582.stgit@djiang5-desk3.ch.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, ross.zwisler@linux.intel.com, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org

On Tue, Jan 30, 2018 at 05:01:13PM -0700, Dave Jiang wrote:
> In ACPI 6.2a the platform capability structure has been added to the NFIT
> tables. That provides software the ability to determine whether a system
> supports the auto flushing of CPU caches on power loss. If the capability
> is supported, we do not need to do dax_flush(). Plumbing the path to set the
> property on per region from the NFTI tables.
				  NFIT
> 
> This patch depends on the ACPI NFIT 6.2a platform capabilities support code
> in include/acpi/actbl1.h.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Looks good aside from the one nit.

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>

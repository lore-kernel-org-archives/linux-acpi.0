From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v3 4/4] nfit-test: Add platform cap support from ACPI
 6.2a to test
Date: Tue, 30 Jan 2018 17:15:55 -0700
Message-ID: <20180131001555.GC27220@linux.intel.com>
References: <151735668391.34477.11820724492631561208.stgit@djiang5-desk3.ch.intel.com>
 <151735688977.34477.282640453822790328.stgit@djiang5-desk3.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:7305 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751629AbeAaAP4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Jan 2018 19:15:56 -0500
Content-Disposition: inline
In-Reply-To: <151735688977.34477.282640453822790328.stgit@djiang5-desk3.ch.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, ross.zwisler@linux.intel.com, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org

On Tue, Jan 30, 2018 at 05:01:29PM -0700, Dave Jiang wrote:
> Adding NFIT platform capabilities sub table in nfit_test simulated ACPI
> NFIT table. Only the first NFIT table is added with the capability
> sub-table.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

This looks good to me.  You can add:

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>

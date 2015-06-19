From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/15] libnvdimm: enable iostat
Date: Fri, 19 Jun 2015 10:34:10 +0200
Message-ID: <20150619083410.GA2885@lst.de>
References: <20150617235209.12943.24419.stgit@dwillia2-desk3.amr.corp.intel.com> <20150617235551.12943.76656.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:59882 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753147AbbFSIeM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Jun 2015 04:34:12 -0400
Content-Disposition: inline
In-Reply-To: <20150617235551.12943.76656.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: axboe@kernel.dk, linux-nvdimm@lists.01.org, boaz@plexistor.com, toshi.kani@hp.com, Vishal Verma <vishal.l.verma@linux.intel.com>, linux-kernel@vger.kernel.org, hch@lst.de, linux-acpi@vger.kernel.org, linux-fsdevel@vger.kernel.org, mingo@kernel.org

On Wed, Jun 17, 2015 at 07:55:51PM -0400, Dan Williams wrote:
> This is disabled by default as the overhead is prohibitive, but if the
> user takes the action to turn it on we'll oblige.

If you care about users a compile time selection doesn't make sense,
why not always build it but require an opt-in?

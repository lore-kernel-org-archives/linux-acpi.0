From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 09/21] libnd, nd_pmem: add libnd support to the pmem
 driver
Date: Sat, 23 May 2015 07:39:35 -0700
Message-ID: <20150523143935.GA23903@infradead.org>
References: <20150520205536.32249.89779.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150520205700.32249.9798.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57704 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbbEWOjt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 May 2015 10:39:49 -0400
Content-Disposition: inline
In-Reply-To: <20150520205700.32249.9798.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: axboe@kernel.dk, linux-nvdimm@ml01.01.org, neilb@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Jens Axboe <axboe@fb.com>, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, hch@lst.de, mingo@kernel.org

On Wed, May 20, 2015 at 04:57:00PM -0400, Dan Williams wrote:
> nd_pmem attaches to persistent memory regions and namespaces emitted by
> the libnd subsystem, and, same as the original pmem driver, presents the
> system-physical-address range as a block device.
> 
> The existing e820-type-12 to pmem setup is converted to a full libnd bus
> that emits an nd_namespace_io device.

This looks completely bonkers.  If you want to pretend the legacy
e820 NVDIMMs fit into your new world do that directly in
arch/x86/kernel/pmem.c instead of splitting it over two files.

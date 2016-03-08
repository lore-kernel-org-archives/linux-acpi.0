From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2-UPDATE2 3/4] resource: Add device-managed
 insert/remove_resource()
Date: Tue, 8 Mar 2016 18:33:07 +0100
Message-ID: <20160308173307.GB3017@gmail.com>
References: <1457460530-17959-1-git-send-email-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34156 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008AbcCHRdM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2016 12:33:12 -0500
Content-Disposition: inline
In-Reply-To: <1457460530-17959-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: bp@suse.de, dan.j.williams@intel.com, rjw@rjwysocki.net, akpm@linux-foundation.org, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


* Toshi Kani <toshi.kani@hpe.com> wrote:

> insert_resource() and remove_resouce() are called by producers
> of resources, such as FW modules and bus drivers.  These modules
> may be implemented as loadable modules.
> 
> Add device-managed implementaions of insert_resource() and
> remove_resouce() functions.
> 
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

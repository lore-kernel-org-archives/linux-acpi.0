From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] libnvdimm, nfit: report multiple interface codes per-dimm
Date: Wed, 06 Apr 2016 10:22:47 +0200
Message-ID: <90956f627d907989f05b03fd4e6d826d@suse.de>
References: <20160406003515.6719.15443.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57417 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753843AbcDFIWt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Apr 2016 04:22:49 -0400
In-Reply-To: <20160406003515.6719.15443.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 2016-04-06 02:35, Dan Williams wrote:
> Starting with ACPI 6.1 an NFIT table will report multiple 'NVDIMM
> Control Region Structure' instances per-dimm, one for each supported
> format interface.  Report that code in the following format in sysfs:
> 
>     nmemX/nfit/formats
>     nmemX/nfit/format
>     nmemX/nfit/format1
>     nmemX/nfit/format2
>     ...
>     nmemX/nfit/formatN
> 
> Where format2 - formatN are theoretical as there are no known DIMMs 
> with
> support for more than two interface formats.
> 
> This layout is compatible with existing libndctl binaries that only
> expect one code per-dimm as they will ignore nmemX/nfit/formats and
> nmemX/nfit/formatN.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks OK to me
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

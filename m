From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: The Garbled screen issue on Sony laptops with two graphics (Intel and Nvidia)
Date: Wed, 11 Mar 2009 12:47:48 +0000
Message-ID: <20090311124748.GA21017@srcf.ucam.org>
References: <1236739527.2820.178.camel@rzhang-dt> <20090311024652.GA14493@srcf.ucam.org> <1236756550.2820.218.camel@rzhang-dt> <1236756625.2820.219.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56854 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbZCKMr5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Mar 2009 08:47:57 -0400
Content-Disposition: inline
In-Reply-To: <1236756625.2820.219.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, Mar 11, 2009 at 03:30:25PM +0800, Zhang Rui wrote:
> Anyway, switching between the two graphics cards is a good feature for
> users, isn't it?

Yes, but the same functionality is present on other machines which don't 
have the _DSM method that the Sonys have. Intel haven't provided any 
information about how this is supposed to work, despite the handover 
being a feature of the GM45 chipset.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

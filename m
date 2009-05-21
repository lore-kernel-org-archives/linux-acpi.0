From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH]: ACPI: Change the array size from 5 to 8 for
	acpi_bus_id
Date: Thu, 21 May 2009 20:07:15 +0100
Message-ID: <20090521190715.GA30375@srcf.ucam.org>
References: <1242894335.8523.61.camel@localhost.localdomain> <alpine.LFD.2.00.0905211425390.4390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43736 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbZEUTHU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2009 15:07:20 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0905211425390.4390@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: yakui_zhao <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org

On Thu, May 21, 2009 at 02:26:32PM -0400, Len Brown wrote:
> what bad things happen if this patch is not applied --
> do some of those strcpy()'s overflow?

Looks like there'd be issues with the change to the CPU name on systems 
with lots of CPUs in ACPI.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

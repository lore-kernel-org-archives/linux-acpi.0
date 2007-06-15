From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] [-mm]: ACPI: expose ACPI tables in sysfs
Date: Fri, 15 Jun 2007 09:09:00 +0800
Message-ID: <1181869740.5411.47.camel@localhost.localdomain>
References: <1181814187.5411.30.camel@localhost.localdomain>
	 <20070614113124.GB13329@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23359 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873AbXFOBHp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jun 2007 21:07:45 -0400
In-Reply-To: <20070614113124.GB13329@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, lenb@kernel.org

On Thu, 2007-06-14 at 08:31 -0300, Henrique de Moraes Holschuh wrote:
> Will we get the dynamic tables exported in a later patch?
> 
Yes. I send the patch for static tables first in hopes of
it can hit 2.6.23.
The patch for dynamic tables needs some hooks in ACPICA code.
And it may take some time, maybe a couple of weeks.

Thanks,
Rui

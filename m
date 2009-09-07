From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH] acpi: make ACPI_DOCK a tristate option again (v2)
Date: Mon, 7 Sep 2009 16:04:13 +0800
Message-ID: <20090907080413.GA29001@sli10-desk.sh.intel.com>
References: <4AA4D99D0200007800013B7C@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14718 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357AbZIGIEX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Sep 2009 04:04:23 -0400
Content-Disposition: inline
In-Reply-To: <4AA4D99D0200007800013B7C@vpn.id2.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@novell.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Sep 07, 2009 at 03:59:57PM +0800, Jan Beulich wrote:
> I cannot follow the explanation in commit
> 898b054f3eec5921320ae8614b5bdd7b07ea5b43: If other drivers require the
> dock module to be loaded before them, they sould simply have a
> dependency on dock.ko. In the particular case mentioned (libata), this
> already is the case.
it has dependence with libata. Looks libata isn't module, right?

Thanks,
Shaohua 

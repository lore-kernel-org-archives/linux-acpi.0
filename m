From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 2/5] eeepc-wmi: Use acpi_dev_present
Date: Mon, 23 Nov 2015 11:04:13 -0800
Message-ID: <20151123190413.GU7413@malice.jf.intel.com>
References: <cover.1448282995.git.lukas@wunner.de>
 <bdff67293ead344ccec77f55437085561b1ad88d.1448282995.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:58958 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbbKWTET (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2015 14:04:19 -0500
Content-Disposition: inline
In-Reply-To: <bdff67293ead344ccec77f55437085561b1ad88d.1448282995.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, platform-driver-x86@vger.kernel.org, Corentin Chary <corentin.chary@gmail.com>

On Mon, Nov 23, 2015 at 03:34:55PM +0100, Lukas Wunner wrote:
> Use shiny new acpi_dev_present and remove all the boilerplate to search
> for a particular ACPI device. No functional change.

You did add a pr_warn, which is technically a functional change. Did you intend
to leave that in?

I have no objection for platform-drivers-x86, but please include all maintainers
listed by get_maintainer.pl for the fastest response.

+Rafael

Rafael, I assume you will pick this up along with the acpi_dev_present ACPI
change if you take that. Pleaes let me know if not.

Otherwise,

Acked-by: Darren Hart <dvhart@linux.intel.com>

-- 
Darren Hart
Intel Open Source Technology Center

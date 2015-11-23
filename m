From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/5] eeepc-wmi: Use acpi_dev_present
Date: Mon, 23 Nov 2015 23:35:55 +0100
Message-ID: <1776557.hOTai0RnF7@vostro.rjw.lan>
References: <cover.1448282995.git.lukas@wunner.de> <bdff67293ead344ccec77f55437085561b1ad88d.1448282995.git.lukas@wunner.de> <20151123190413.GU7413@malice.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44633 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751400AbbKWWGR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2015 17:06:17 -0500
In-Reply-To: <20151123190413.GU7413@malice.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org, devel@acpica.org, platform-driver-x86@vger.kernel.org, Corentin Chary <corentin.chary@gmail.com>

On Monday, November 23, 2015 11:04:13 AM Darren Hart wrote:
> On Mon, Nov 23, 2015 at 03:34:55PM +0100, Lukas Wunner wrote:
> > Use shiny new acpi_dev_present and remove all the boilerplate to search
> > for a particular ACPI device. No functional change.
> 
> You did add a pr_warn, which is technically a functional change. Did you intend
> to leave that in?
> 
> I have no objection for platform-drivers-x86, but please include all maintainers
> listed by get_maintainer.pl for the fastest response.
> 
> +Rafael
> 
> Rafael, I assume you will pick this up along with the acpi_dev_present ACPI
> change if you take that. Pleaes let me know if not.
> 
> Otherwise,
> 
> Acked-by: Darren Hart <dvhart@linux.intel.com>

In fact, patch [1/5] as is needs to go in through upstream ACPICA, so I'm not
taking this series and please don't take it too.

Thanks,
Rafael


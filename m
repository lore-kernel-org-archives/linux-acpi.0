From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/2] ACPI, APEI: Memory leaks
Date: Fri, 11 Mar 2016 00:17 +0100
Message-ID: <3056028.anPd1DlP10@vostro.rjw.lan>
References: <1457452332-2673-1-git-send-email-johunt@akamai.com> <3605684.qBtSSaxB6s@vostro.rjw.lan> <3908561D78D1C84285E8C5FCA982C28F3A005573@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43806 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751973AbcCJXPH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 18:15:07 -0500
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F3A005573@ORSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Joshua Hunt <johunt@akamai.com>, Borislav Petkov <bp@suse.de>, "Chen, Gong" <gong.chen@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thursday, March 10, 2016 10:55:56 PM Luck, Tony wrote:
> >>  drivers/acpi/apei/apei-base.c |    6 ++++--
> >>  drivers/acpi/apei/erst.c      |    3 +++
> >>  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > Tony, Boris, should I apply these?
> 
> Rafael,
> 
> Yes please.

OK, applied.

Thanks,
Rafael


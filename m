From: Mario <rety@poczta.onet.pl>
Subject: Re: Is acpi_ec_ecdt_probe() broken? (was: Re: ACPI locks hardware devices when it doesn't detect vista)
Date: Sun, 30 Aug 2009 08:59:29 +0200
Message-ID: <200908300859.29494.rety@poczta.onet.pl>
References: <1250945310.14167.150.camel@maxim-laptop> <200908300037.45412.rjw@sisk.pl> <1251588634.15582.0.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1m5.poczta.onet.pl ([213.180.138.32]:52578 "EHLO
	smtp1m5.poczta.onet.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbZH3G7U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 30 Aug 2009 02:59:20 -0400
Received: from ciq202.neoplus.adsl.tpnet.pl ([83.31.40.202]:42508 "EHLO
	[192.168.1.2]" rhost-flags-OK-OK-OK-FAIL) by ps1.mod5.onet
	with ESMTPSA id S50334772AbZH3G7U2hy6l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org> + 1 other);
	Sun, 30 Aug 2009 08:59:20 +0200
In-Reply-To: <1251588634.15582.0.camel@maxim-laptop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

Maxim, 

I did the test regarding last coment from Alexey Starikovskiy on the bugzilla.

>What happens if acpi_ec_ecdt_probe() is not called at all? Do you have same
>hang as with changed order?

That did it. System starts and MIR works ok without setpci solution.

Regards
Mario

Sunday 30 of August 2009 01:30:34 Maxim Levitsky wrote:
> On Sun, 2009-08-30 at 00:37 +0200, Rafael J. Wysocki wrote:
> > On Saturday 29 August 2009, Mario wrote:
> > > Exact model is Compal JFL92.
> > > I've attached a dmidecode output.
> >
> > OK
> >
> > Maxim, Mario, can you create a bug entry in the kernel Bugzilla for this
> > issue and put my address into the CC list in there?
>
> Done,
>
> http://bugzilla.kernel.org/show_bug.cgi?id=14086
>
>
> Best regards,
> 	Maxim Levitsky



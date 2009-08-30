From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Is acpi_ec_ecdt_probe() broken? (was: Re: ACPI locks hardware devices when it doesn't detect vista)
Date: Sun, 30 Aug 2009 15:20:40 +0200
Message-ID: <200908301520.40897.rjw@sisk.pl>
References: <1250945310.14167.150.camel@maxim-laptop> <1251588634.15582.0.camel@maxim-laptop> <200908300859.29494.rety@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48822 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485AbZH3NTn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Aug 2009 09:19:43 -0400
In-Reply-To: <200908300859.29494.rety@poczta.onet.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario <rety@poczta.onet.pl>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Len Brown <lenb@kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Sunday 30 August 2009, Mario wrote:
> Maxim, 
> 
> I did the test regarding last coment from Alexey Starikovskiy on the bugzilla.
> 
> >What happens if acpi_ec_ecdt_probe() is not called at all? Do you have same
> >hang as with changed order?
> 
> That did it. System starts and MIR works ok without setpci solution.

Could you please put that information into the Bugzilla entry at
http://bugzilla.kernel.org/show_bug.cgi?id=14086 (you'll need to create a
Bugzilla account for yourself for this purpose, sorry for the inconvenience)?

The ACPI people generally use the Bugzilla rather than e-mail for tracking
bugs.

Best,
Rafael

From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: EC: fix compilation warning
Date: Sun, 30 Nov 2008 00:11:36 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811300010570.3239@localhost.localdomain>
References: <49318541.0aec660a.0efb.3436@mx.google.com>
 <493199A4.5020203@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:42313 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYK3FLn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 30 Nov 2008 00:11:43 -0500
In-reply-to: <493199A4.5020203@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Hannes Eder <hannes@hanneseder.net>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org



On Sat, 29 Nov 2008, Alexey Starikovskiy wrote:

> Hannes Eder wrote:
> > Fix the warning introduced in commit
> > c5279dee26c0e8d7c4200993bfc4b540d2469598,
> > and give the dummy variable a more verbose name.
> Thanks!
> > 
> >   drivers/acpi/ec.c: In function 'acpi_ec_ecdt_probe':
> >   drivers/acpi/ec.c:1015: warning: ISO C90 forbids mixed declarations and
> > code
> > 
> > Signed-off-by: Hannes Eder <hannes@hanneseder.net>
> Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>

applied on top of 11880 fix in acpi-test.

thanks,
-len


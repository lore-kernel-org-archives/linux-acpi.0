From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 15:49:30 +0100
Message-ID: <20081021144930.GA30301@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de> <200810211625.47889.rjw@sisk.pl> <20081021142956.GA29837@srcf.ucam.org> <200810211645.45945.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41584 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbYJUOtg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Oct 2008 10:49:36 -0400
Content-Disposition: inline
In-Reply-To: <200810211645.45945.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, Oct 21, 2008 at 04:45:44PM +0200, Thomas Renninger wrote:
> On Tuesday 21 October 2008 16:29:56 Matthew Garrett wrote:
> > How? We *know* we're deviating from the behaviour of Windows here.
> Matthew, there is no solution to stick to the Windows behaviour.
> Even if hundreds of machines are affected, you have still not yet come up with 
> a generic solution, but try to block the fix.

You're the one asserting that Windows behaves in a certain way. I'm 
asking you to justify that assertion. The information from that test 
allows us to determine whether a static table is the best we can do or 
not.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

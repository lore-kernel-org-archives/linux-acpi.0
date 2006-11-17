From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: acpiphp makes noise on every lid close/open
Date: Fri, 17 Nov 2006 15:13:41 +0000
Message-ID: <20061117151341.GA1162@srcf.ucam.org>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz> <20061107204409.GA37488@vasa.acc.umu.se> <20061107134439.1d54dc66.kristen.c.accardi@intel.com> <20061117102237.GS14886@vasa.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:19384 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S933654AbWKQPOG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Nov 2006 10:14:06 -0500
Content-Disposition: inline
In-Reply-To: <20061117102237.GS14886@vasa.acc.umu.se>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>

On Fri, Nov 17, 2006 at 11:22:38AM +0100, David Weinehall wrote:

> That was with 2.6.17; with 2.7.19-pre? (don't remember right now),
> docking seems to work without acpiphp.  It still would be nice to be
> able to undock when the laptop is sleeping though; how do I achieve
> that?

My experience of most laptops is that they'll fire off a bus check 
notification when you resume, so as long as nothing actually tries to 
access the hardware before that's handled, everything should be fine. 
What currently breaks when you undock while asleep?

-- 
Matthew Garrett | mjg59@srcf.ucam.org

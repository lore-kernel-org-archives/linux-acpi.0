From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: 8 cstates but only 4 to use?
Date: Sat, 4 Mar 2006 13:44:13 +0100
Message-ID: <20060304124413.GA13950@isilmar.linta.de>
References: <20060304055423.GC26099@isc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:1690 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751368AbWCDMoP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Mar 2006 07:44:15 -0500
Content-Disposition: inline
In-Reply-To: <20060304055423.GC26099@isc.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "David W. Hankins" <David_Hankins@isc.org>
Cc: linux-acpi@vger.kernel.org

Hi,

On Sat, Mar 04, 2006 at 05:54:23AM +0000, David W. Hankins wrote:
> The 'power' procfile lists a max_cstate of C8, but only lists C1-C4 as
> usable states to enter...I notice it is also this way in the example
> file output provided in Mr. Ariel's howto, so this must not be uncommon
> or new.

max_cstate is the maximum the kernel would make use of if they were provided
by the hardware and by the BIOS. However,

> But, if 8 states are avaialble, why are only 4 in use?

it is quite common that only one, two, three or -- at most! -- four of these
states are actually available on a system. The ACPI core allows for eight to
be ready for future systems which might have more than these four available.

	Dominik

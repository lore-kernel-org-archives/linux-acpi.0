From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: 20000+ wake-ups/second in 2.6.24.   Bug?
Date: Sat, 1 Dec 2007 15:46:46 -0800
Message-ID: <20071201154646.5a288c9e@laptopd505.fenrus.org>
References: <200711302153.lAULrZ7n026255@imap1.linux-foundation.org>
	<924EFEDD5F540B4284297C4DC59F3DEE2FAE6A@orsmsx423.amr.corp.intel.com>
	<20071130142058.816d1693.akpm@linux-foundation.org>
	<924EFEDD5F540B4284297C4DC59F3DEE2FAEAF@orsmsx423.amr.corp.intel.com>
	<4750CC78.9070105@rtr.ca>
	<20071130190227.1976e682@laptopd505.fenrus.org>
	<4750D180.6080001@rtr.ca>
	<20071130191816.3e744205@laptopd505.fenrus.org>
	<4750D585.1030200@rtr.ca>
	<4750D899.4020905@rtr.ca>
	<4751F1AB.2060801@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:55866 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbXLAXsY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Dec 2007 18:48:24 -0500
In-Reply-To: <4751F1AB.2060801@rtr.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, abelay@novell.com, lenb@kernel.org, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sat, 01 Dec 2007 18:43:39 -0500
Mark Lord <lkml@rtr.ca> wrote:

> 
> Dagnabbit.. it's done it again.. went from 100-200 wakeups/sec
> back up to 20000+ wakeups/sec.  This time *with* the powertop patches
> in place.
> 
> Somethings broken in there, but I don't know what.
> Or how to make it happen on demand.. it's fine after rebooting again.
> 
> ???
> 
> At least now I know to look when I hear the fan turning on
> when the system is otherwise supposed to be idle..
> 
> 2.6.23 did not have this problem.

actually we have reports of 2.6.23 having the exact same problem.
The thing is, "something" is causing the system to go into a state
where the cpu throws us right out of the C-state the kernel asks for.

Some people have seen that not loading yenta at all will just make this
not happen at all...


-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org

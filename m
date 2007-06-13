From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [1/3] 2.6.22-rc4: known regressions v2
Date: Wed, 13 Jun 2007 07:51:10 -0700
Message-ID: <20070613075110.0a9f54c2.akpm@linux-foundation.org>
References: <466AE606.7020704@googlemail.com>
	<20070612150221.GB5986@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60082 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757642AbXFMOxc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jun 2007 10:53:32 -0400
In-Reply-To: <20070612150221.GB5986@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@elte.hu>, "Darrick J. Wong" <djwong@us.ibm.com>, Andi Kleen <ak@suse.de>, Rodrigo Luiz <troops.of.doom@gmail.com>, "Siddha, Suresh B" <suresh.b.siddha@intel.com>, Maximilian Engelhardt <maxi@daemonizer.de>, Gary Zambrano <zambrano@broadcom.com>, Michael Buesch <mb@bu3sch.de>, Thomas Gleixner <tglx@linutronix.de>, Stephen Hemminger <shemminger@linux-foundation.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tue, 12 Jun 2007 15:02:22 +0000 Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> Can we add 'writing to /proc/acpi/thermal/*/trip_points' no longer
> works to the list?

I thought we had.

> Len did it intentionally but that does not make it
> right. People are using it and we did not go through deprecation
> period. Plus there's no reasonable alternative.

Was that writeability causing any actual problems in 2.6.21?

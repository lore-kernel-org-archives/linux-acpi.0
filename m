From: Christoph Lameter <clameter@sgi.com>
Subject: Re: 2.6.24-rc3-mm1 - Kernel Panic on IO-APIC
Date: Mon, 26 Nov 2007 12:56:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0711261254560.25688@schroedinger.engr.sgi.com>
References: <20071120204525.ff27ac98.akpm@linux-foundation.org>
 <4743CC0B.9000508@linux.vnet.ibm.com> <20071120221839.faab108e.akpm@linux-foundation.org>
 <20071126143943.0a01665b@cuia.boston.redhat.com>
 <20071126123319.7483e57f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756879AbXKZU4V@vger.kernel.org>
In-Reply-To: <20071126123319.7483e57f.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, kamalesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, apw@shadowen.org, balbir@linux.vnet.ibm.com, linux-acpi@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu
List-Id: linux-acpi@vger.kernel.org

On Mon, 26 Nov 2007, Andrew Morton wrote:

> hm.  This smells like a startup ordering problem, but everything which
> refresh_zone_stat_thresholds() should be set up by the time we run
> initcalls.  Maybe the zone lists are bad?

refresh_zone_stat_thresholds goes through each zone and updates
the stat threshold for every per cpu structure in each zone.

So this could be a processor marked online where the pcp structures have 
not been allocated or a zone NULL pointer.

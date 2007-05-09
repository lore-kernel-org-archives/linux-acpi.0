From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Wed, 09 May 2007 22:45:50 +0200
Message-ID: <1178743550.3042.541.camel@localhost.localdomain>
References: <20070430102837.748238000@linutronix.de>
	 <200705091909.25443.rjw@sisk.pl>
	 <1178730950.3042.533.camel@localhost.localdomain>
	 <200705092036.20953.rjw@sisk.pl>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:40927 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754839AbXEIUm6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2007 16:42:58 -0400
In-Reply-To: <200705092036.20953.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Wed, 2007-05-09 at 20:36 +0200, Rafael J. Wysocki wrote:
> Well, apparently, not in -mm2:
> 
> rafael@albercik:~/src/mm/linux-2.6.21-mm2> grep -r -I -l 'timekeeping_resume' *
> kernel/time/timekeeping.c
> rafael@albercik:~/src/mm/linux-2.6.21-mm2> grep clocksource_resume kernel/time/timekeeping.c
> rafael@albercik:~/src/mm/linux-2.6.21-mm2>

Andrew dropped the patch because it did not work on his jinxed VAIO, but
he debugged with the patch applied.

	tglx



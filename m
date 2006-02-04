From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: why no duration[00000000000000000000] for C1 state?
Date: Sat, 4 Feb 2006 22:32:58 +0100
Message-ID: <20060204213258.GA21284@isilmar.linta.de>
References: <20060129100722.1359.0.NOFFLE@localhost.localdomain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:24804 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932577AbWBDVc7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Feb 2006 16:32:59 -0500
Content-Disposition: inline
In-Reply-To: <20060129100722.1359.0.NOFFLE@localhost.localdomain.local>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miernik <miernik@ffii.org>
Cc: linux-acpi@vger.kernel.org

Hi,

On Sun, Jan 29, 2006 at 11:07:22AM +0100, Miernik wrote:
> On
> http://ck.kolivas.org/patches/dyn-ticks/split-out/C-States-3_accounting_of_sleep_times.patch
> it says: "Also track the actual time spent in C-States (C2 upwards, we
> can't determine this for C1), not only the number of invocations." Why
> we cannot have time spent in C1?

Once an interrupt awakes the CPU, the interrupt is handled immediately if
the CPU was in C1, while on C2 or C3, the idle handler is executed at first,
allowing to measure the "stop" time.

> Would it also be possible to have time
> spent in C0 and/or total time of the statistics? And/or % of time spent
> in each state?

That can be done in userspace.

	Dominik

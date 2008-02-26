From: "Daniel J Blueman" <daniel.blueman@gmail.com>
Subject: Re: [2.6.25-rc3] ACPI _PPC limiting processor speed...
Date: Tue, 26 Feb 2008 08:28:18 +0000
Message-ID: <6278d2220802260028y7a4a7ac5o568fd1029ef9fd82@mail.gmail.com>
References: <6278d2220802251329x75b6d4c5lc3fab6fe6e75363f@mail.gmail.com>
	 <20080225154845.2b71c200.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:59220 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbYBZI2S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Feb 2008 03:28:18 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2396512wah.23
        for <linux-acpi@vger.kernel.org>; Tue, 26 Feb 2008 00:28:18 -0800 (PST)
In-Reply-To: <20080225154845.2b71c200.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

On Mon, Feb 25, 2008 at 11:48 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 25 Feb 2008 21:29:24 +0000 "Daniel J Blueman" <daniel.blueman@gmail.com> wrote:
>  > My 2.2GHz [1] Thinkpad T61 is unable to get past 1.2GHz, seemingly
>  > because of the _PPC ACPI objects [2].
>  >
>  > Given that the _PPC object is different for both cores, is this more
>  > of a BIOS bug or an ACPI interpreter problem? The problem was present
>  > in 2.6.24-rc, 2.6.24 final and since.
>  >
>  > BIOS is 7LETA9WW/2.09, so current - would any further information be
>  > useful for debugging this problem, and would dumping the ACPI tables
>  > be useful?
>  >
>  > Thanks,
>  >   Daniel
>  >
>  > --- [1]
>  >
>  > freq-table: table entry 0: 2201000 kHz, 0 index
>  > freq-table: table entry 1: 2200000 kHz, 1 index
>  > freq-table: table entry 2: 1600000 kHz, 2 index
>  > freq-table: table entry 3: 1200000 kHz, 3 index
>  > freq-table: table entry 4: 800000 kHz, 4 index
>  >
>  > --- [2]
>  >
>  > cpufreq-core: CPU 0: _PPC is 3 - frequency  limited
>  > cpufreq-core: CPU 1: _PPC is 0 - frequency not limited
>
>  (cc linux-acpi)
>
>  If nothing happens, please raise a report at bugzilla.kernel.org, thanks.

I've raised this into a Bugzilla entry for tracking and history, and
dumped ACPI tables in binary and hex formats:

http://bugzilla.kernel.org/show_bug.cgi?id=10110

Let me know of anything else useful. If I get time in the next days,
I'll try find a previous working kernel and start bisecting for the
regression.

Thanks,
  Daniel
-- 
Daniel J Blueman

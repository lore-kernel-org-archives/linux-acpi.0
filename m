From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [2.6.25-rc3] ACPI _PPC limiting processor speed...
Date: Mon, 25 Feb 2008 15:48:45 -0800
Message-ID: <20080225154845.2b71c200.akpm@linux-foundation.org>
References: <6278d2220802251329x75b6d4c5lc3fab6fe6e75363f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:41623 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756822AbYBYXuG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Feb 2008 18:50:06 -0500
In-Reply-To: <6278d2220802251329x75b6d4c5lc3fab6fe6e75363f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Mon, 25 Feb 2008 21:29:24 +0000 "Daniel J Blueman" <daniel.blueman@gmail.com> wrote:

> My 2.2GHz [1] Thinkpad T61 is unable to get past 1.2GHz, seemingly
> because of the _PPC ACPI objects [2].
> 
> Given that the _PPC object is different for both cores, is this more
> of a BIOS bug or an ACPI interpreter problem? The problem was present
> in 2.6.24-rc, 2.6.24 final and since.
> 
> BIOS is 7LETA9WW/2.09, so current - would any further information be
> useful for debugging this problem, and would dumping the ACPI tables
> be useful?
> 
> Thanks,
>   Daniel
> 
> --- [1]
> 
> freq-table: table entry 0: 2201000 kHz, 0 index
> freq-table: table entry 1: 2200000 kHz, 1 index
> freq-table: table entry 2: 1600000 kHz, 2 index
> freq-table: table entry 3: 1200000 kHz, 3 index
> freq-table: table entry 4: 800000 kHz, 4 index
> 
> --- [2]
> 
> cpufreq-core: CPU 0: _PPC is 3 - frequency  limited
> cpufreq-core: CPU 1: _PPC is 0 - frequency not limited

(cc linux-acpi)

If nothing happens, please raise a report at bugzilla.kernel.org, thanks.

From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Date: Wed, 1 Mar 2006 19:55:25 -0500
Message-ID: <200603011957_MC3-1-B99B-8FFE@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain;
	 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:4789 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750981AbWCBA5p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Mar 2006 19:57:45 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Andi Kleen <ak@suse.de>

In-Reply-To: <20060301230317.GF1440@redhat.com>

On Wed, 1 Mar 2006 18:03:17, Dave Jones wrote:

> (17:59:38:davej@nemesis:~)$ cat /sys/devices/system/cpu/cpu0/topology/core_siblings
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001
> (17:59:47:davej@nemesis:~)$ cat /sys/devices/system/cpu/cpu1/topology/core_siblings
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000002
> 
> Neither of these CPUs are HT / dual-core, so shouldn't these be the same ?

Those are bitmaps. 1 => only bit 0 is set => CPU 0 is all alone.

Did you really build a 256-CPU SMP kernel or is ACPI ignoring CONFIG_NR_CPUS
or something?


-- 
Chuck
"The sleet in Crete falls neatly in the street."


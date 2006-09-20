From: Len Brown <len.brown@intel.com>
Subject: Re: A bug or not? No C states on Turion64 ML-34
Date: Tue, 19 Sep 2006 23:16:25 -0400
Message-ID: <200609192316.26355.len.brown@intel.com>
References: <200609171646.46064.tvrtko@ursulin.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:8366 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750895AbWITDOc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Sep 2006 23:14:32 -0400
In-Reply-To: <200609171646.46064.tvrtko@ursulin.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Cc: linux-acpi@vger.kernel.org

On Sunday 17 September 2006 11:46, Tvrtko A. Ursulin wrote:

> On my new HP Pavilion s7510 PC I seem to be missing C states
...
> tvrtko@astrid:~> cat /proc/acpi/processor/CPU0/power
> active state:            C1
> max_cstate:              C8
> bus master activity:     00000000
> states:
>    *C1:                  type[C1] promotion[--] demotion[--] latency[000] 
> usage[00000000]

Don't be bothered by the 0 usage, C1 always works.

Dunno if this processor and BIOS support more C-states or not.
Maybe somebody else who has one has checked it out?

I have seen an ML-28 which support C1 and C3 -- though maybe
an ML-28 is different from an ML-34...

It is possible that an additional C-state will appear when you switch to battery mode.
If you post the output from acpidump it will be easy to tell.

cheers,
-Len

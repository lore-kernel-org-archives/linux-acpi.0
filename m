From: Len Brown <lenb@kernel.org>
Subject: Re: [Mactel-linux-users] C4 state problem
Date: Sat, 28 Apr 2007 02:10:23 -0400
Message-ID: <200704280210.23848.lenb@kernel.org>
References: <4616D602.2090706@anduras.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36161 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754750AbXD1GZR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Apr 2007 02:25:17 -0400
In-Reply-To: <4616D602.2090706@anduras.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mactel-linux-users@lists.sourceforge.net, linux-acpi@vger.kernel.org
Cc: Sven Anders <anders@anduras.de>, mactel <mactel-linux-devel@lists.sourceforge.net>, Nicolas Boichat <nicolas@boichat.ch>

On Friday 06 April 2007 19:21, Sven Anders wrote:
> Hello!
> 
> I spend my day analysing why the Linux could not use the C4 state(s).
> Here my results...
> 
> For a start we take a look at the current available c-states:
> 
> #> cat /proc/acpi/processor/CPU?/power
> 
> active state:            C3
> max_cstate:              C8
> bus master activity:     00000000
> maximum allowed latency: 8000 usec
> states:
>     C1:                  type[C1] promotion[C2] demotion[--] latency[001]
> usage[00002590] duration[00000000000000000000]
>     C2:                  type[C2] promotion[C3] demotion[C1] latency[001]
> usage[00002086] duration[00000000000006795863]
>    *C3:                  type[C3] promotion[--] demotion[C2] latency[055]
> usage[00003633] duration[00000000000009200376]

First note that there are "hardware C-states", and "ACPI C-states".
The table above shows the ACPI C-states that the BIOS makes visible to the OS.

The BIOS (via the FADT or _CST) can map any hardware C-state it wants
to ACPI C3.  It is likely that you are already getting hardware C4
and simply skipping over hardware C3.

If you provide the complete raw output from acpidump, then it should be
possible to tell.

cheers,
-Len

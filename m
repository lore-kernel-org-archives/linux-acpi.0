From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: [PATCH -mm] ACPI: re-add important comment about P_LVLx register
Date: Wed, 28 Jun 2006 09:54:29 +0200
Message-ID: <20060628075429.GA8832@rhlx01.fht-esslingen.de>
References: <CFF307C98FEABE47A452B27C06B85BB6DCECEC@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:63653 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1030471AbWF1Hya (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Jun 2006 03:54:30 -0400
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6DCECEC@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org

Hi,

On Wed, Jun 28, 2006 at 03:27:00AM -0400, Brown, Len wrote:
> applied.
> thanks,
> -Len 

Very fast, thanks!

However I was not looking at it for nothing: I've come up with an idea
to optimize away this dummy wait I/O access (one I/O access results
in a timer increase of 2 or 3 ticks on my systems, i.e. about 1us and thus
about 700 wasted CPU cycles on my P3/700).

The theory is as follows:
I'm looking at the value read directly after asserting STPCLK#, and if this
value is only slightly (e.g. up to 5 * C2_OVERHEAD) different from the
t1 value, then I'm assuming that I may have caught a pre-sleep value
and in this case read the I/O port again to make sure I managed to read
a value *after* resuming.
Thus in many cases I'm saving the dummy read since I'm taking into account
an incorrectly small (pre-sleep) value due to delayed STPCLK# operation
and only re-read the I/O port if this happens.

HOWEVER, this means that I have to rely on a correct readout
of the timer value, no matter whether it was being read pre-freeze,
mid-freeze or post-freeze. And I'm not sure whether this is always true
on all chipsets (i.e. whether the read operation is fully atomic and *always*
returns valid tick values with a fully valid 32-bit word).

Benefits: a nice chunk of better wakeup latency (700 CPU cycles, minus some
decision logic cycles loss of about 100 cycles, so about 600 cycles).

The usual pattern of tick values is:

t1	t2	t3

x	x+4000	x+4000+3	(no activity: extremely long sleeps)
x	x+300	x+300+3		(medium activity, mid-range sleeps)
x	x+8	x+8+3		(the ultra-short sleep wasn't really worth it)

Thus I would double-read the I/O value in the third case only, since the
difference (8) is less than 5 * C2_OVERHEAD.

This would mean that with my method overhead is larger for systems in an 80%
busy state (which thus touch ACPI C2 just marginally) and provides real
wakeup latency benefits for quite idle systems only, but OTOH the overhead
would vanish for entirely busy systems (due to no ACPI C2 activity at all),
so I think it's no problem.

...PROVIDED that the tick value read *anywhere* during STPCLK# freeze
*is* reliable!!
(I don't see a tick value problem on my Intel 815 P3/700 and my
VIA Athlon @1200, but haven't tested other systems yet).

Comments?

(I've got a preliminary patch ready for this)

Andreas Mohr

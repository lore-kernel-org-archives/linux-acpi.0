From: "Jason Dagit" <dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was:
 Re: Resume from Suspend to RAM))
Date: Sun, 12 Jun 2005 14:48:21 -0700
Message-ID: <87slzni6vu.fsf@www.codersbase.com>
References: <200506061531.41132.stefandoesinger@gmx.at>
	<1118125410.3828.12.camel@linux-hp.sh.intel.com>
	<200506071732.23095.hugelmopf@web.de>
	<1118193341.3857.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1118193341.3857.4.camel-ECwVeV2eNyQD0+JXs3kMbRL4W9x8LtSr@public.gmane.org> (Shaohua Li's
 message of "Wed, 08 Jun 2005 09:15:41 +0800")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>, acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:

> I think any kernel version should be ok, but please try latest kernel.
> Please note, this isn't a fix but a test case.
> If the test failed, then suspend/resume code path or drivers are broken.
> If the test succeeded, then
> 	1. Linux forgot doing something BIOS lets it do
> 	or 2. BIOS is broken.

Shaohua, my BIOS is available from the following link (my computer is
the AV3250HX-01):
http://bugme.osdl.org/show_bug.cgi?id=3691

Could you (or someone else) take a look and see if my bios is broken?
I've tried to decompile/recompile the bios, but I don't know enough
about it to know if it is broken or if the warnings are harmless.

If it is (1), how can we begin to find this "forgotten" thing?  I have
windows on this machine if it would help to do comparisons between S3
in windows vs. linux.

Thanks,
Jason


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20

From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was: Re: Resume from Suspend to RAM))
Date: Mon, 13 Jun 2005 19:47:38 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305750243EAF7@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jason Dagit <dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org>
Cc: Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>, acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
>> I think any kernel version should be ok, but please try latest
kernel.
>> Please note, this isn't a fix but a test case.
>> If the test failed, then suspend/resume code path or drivers are
broken.
>> If the test succeeded, then
>> 	1. Linux forgot doing something BIOS lets it do
>> 	or 2. BIOS is broken.
>
>Shaohua, my BIOS is available from the following link (my computer is
>the AV3250HX-01):
>http://bugme.osdl.org/show_bug.cgi?id=3D3691
>
>Could you (or someone else) take a look and see if my bios is broken?
>I've tried to decompile/recompile the bios, but I don't know enough
>about it to know if it is broken or if the warnings are harmless.
>
>If it is (1), how can we begin to find this "forgotten" thing?  I have
>windows on this machine if it would help to do comparisons between S3
>in windows vs. linux.
No, I have no idea. If the test failed, we have something to do. But it
seems all systems work with the patch, so it's useless now.

Thanks,
Shaohua


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20

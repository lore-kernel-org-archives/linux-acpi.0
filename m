From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Subject: Re: Re: Re: various problems with Acer TM654, suspend, ACAD, radeon
Date: Wed, 25 Aug 2004 15:11:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040825131109.GD6119@gamma.logic.tuwien.ac.at>
References: <20040820161911.GA24510@gamma.logic.tuwien.ac.at> <20040823070534.GD24853@message-id.gmane0305.slipkontur.de> <20040823103515.GH8635@gamma.logic.tuwien.ac.at> <20040824233153.GA15474@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040824233153.GA15474-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Stefan, hi list!

On Die, 24 Aug 2004, Stefan Seyfried wrote:
> > > cat /sys/power/disk ??

Oops, I ment
	standby mem disk
(typing error)

> Documentation/power/ and start testing with a minimal configuration. But
> yes, the b44 made trouble for me, too. Unloading it before and reloading
> after suspen worked around these.

I found that the b44 is the culprit (see other posting). Unloading it
make ssuspend/resume (to/from disk) work even with full system running.

But: I cannot load b44 module, I always get this treadfull error, see
other thread about 
	b44: Error, poll already scheduled

> > Thanks to the previous posters I fixed this and posted a fixed dsdt
> > table to acpi.sf.net. See also www.logic.at/people/preining/acer
> 
> Ok, i have to try this out on the new acer prototype i have, maybe we
> can kick their BIOS engineers' butts to finally ship a non-broken BIOS.

Well, the dsdt stuff is not too bad I would say. There have been only
three small problems. When I think back to the dsdt I had on an old dell
inspiron it was much worse AFAIR.

AND: If you are in kicking the engenieers: Could you please ask them WHY
ON EARTH did they set the latency limit of the C2 state to 101, effectively
disabling the usage of C2?

I am running my laptop since long time with a patch to disable the limit
check for C2 and have NO problems till now (see
www.logic.at/people/preining/acer/ for the C2 hack and the DSDT fix).


Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HUMBER (vb.)
To move like the cheeks of a very fat person as their car goes over a
cattle grid.
			--- Douglas Adams, The Meaning of Liff


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285

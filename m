From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Linux ACPI processor driver patch: user-definable
	power state limit
Date: 05 Nov 2004 19:44:59 -0500
Message-ID: <1099701898.13840.1773.camel@d845pe>
References: <F7DC2337C7631D4386A2DF6E8FB22B3001A193B6@hdsmsx401.amr.corp.intel.com>
	 <200410112335.19159.jos.delbar@ugent.be>
	 <1099683907.13837.1353.camel@d845pe>
	 <20041105225438.GA8262@dominikbrodowski.de>
	 <1099696293.13834.1639.camel@d845pe>
	 <20041105234120.GA20761@dominikbrodowski.de>
	 <1099700714.13834.1717.camel@d845pe>
	 <20041106002935.GA30467@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041106002935.GA30467-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, James P Ketrenos <james.p.ketrenos-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-11-05 at 19:29, Dominik Brodowski wrote:
> On Fri, Nov 05, 2004 at 07:25:14PM -0500, Len Brown wrote:

> > my understanding is that when the ipw2100 detects the error,
> > that it will disable C3 and leave it disabled as long as ipw2100 is
> > loaded.  James can clarify if he's got other ideas.
> 
> If that is the case, my patch is "overkill". If there's a chance to do
> more fine-tuned disabling of C3, my patch seems to be better.

I agree, and you produced it so quickly!

---- begin editorial on workarounds-----
My ongoing concern is that we can spend a huge amount of time and
complexity maintaining code for workarounds when we'd be better off
focusing on more important functionality.  So I hesitate to add the
world's most feature-rich workaround code unless we reeeeeeeeealy need
it.  Indeed, the ultimate goal should be to find out how to delete the
workaround code entirely.
---- end editorial ----

So I'd rather go with the simpler patch until it is proven to be too
simple;-)

thanks,
-Len





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click

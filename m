From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH 5/5] processor: jiffies-based bm_check
Date: Fri, 21 Jan 2005 17:23:36 +0100
Message-ID: <20050121162336.GA8435@dominikbrodowski.de>
References: <20041223140849.GE7973@dominikbrodowski.de> <1103832683.4376.24.camel@d845pe> <1106280485.2397.135.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1106280485.2397.135.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 20, 2005 at 11:08:06PM -0500, Len Brown wrote:
> On Thu, 2004-12-23 at 15:11, Len Brown wrote:
> 
> > Didn't apply the jiffies part yet.
> 
> I've applied it now. (attached as jiffy.patch)
> 
> However, "threshold.bm = 0xF" was written when
> HZ = 100 yielding 40ms, but this
> becomes 4ms for HZ = 1000.
> 
> While I don't know what the optimal value is for
> the bus master history threshold, it seemed like
> a good idea for it to default to about 40ms per
> the original code until we know better.
> 
> So I've also applied the attached bm_history.patch
> to default this to 0xFFFFFFFF for HZ = 1000 (32ms)
> and it is tunable via /sys/module/processor/parameters/bm_history
> 
> what do you think?

This sounds sensible to do. Note that the "diff" measured in idle() will
become problematic once "tickless" systems are implemented -- we'll sleep
for multiple jiffies then, and there was _no_ bm activiy in between. We need
to sort that out somehow...

	Dominik


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl

From: ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org (Adam Belay)
Subject: Re: [PATCH] add "pnpacpi=off", print info during discovery
Date: Thu, 13 Jan 2005 13:13:34 -0500
Message-ID: <20050113181333.GS6069@neo.rr.com>
References: <1105489541.31942.81.camel@eeyore> <1105491763.29370.5.camel@sli10-desk.sh.intel.com> <1105632437.3818.5.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1105632437.3818.5.camel@eeyore>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 13, 2005 at 09:07:17AM -0700, Bjorn Helgaas wrote:
> On Wed, 2005-01-12 at 09:02 +0800, Li Shaohua wrote:
> > On Wed, 2005-01-12 at 08:25, Bjorn Helgaas wrote:
> > I just sent a similar patch to Len, but your patch is great.
> 
> I didn't see your patch, did it go to the list?  I wouldn't
> have bothered if I'd known somebody else did it.
> 
> > Some drivers use lower case pnp id.
> 
> Such as?  "grep -r PNP0 drivers/" shows 2 out of 38 matches
> use lower case.
> 
> > I somehow think PNPBIOS should be enabled if PNPACPI is disabled. Users
> > should get at least one PNP driver any way.

Yeah, I agree.

> 
> Did your patch do this?  I won't bother with this since you
> seem to be working on it.
> 

Hi Li,
 
Could you send me a copy of your patch.  I'm curious.

Thanks,
Adam


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

From: Vasileios Gkanis <gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Subject: Re: tg3 ethernet not coming back properly after S3 suspendon Dell M70
Date: Fri, 10 Jun 2005 14:18:58 -0500
Message-ID: <200506101418.59154.gkanis@cems.umn.edu>
References: <C7AB9DA4D0B1F344BF2489FA165E502408E22FB6@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E502408E22FB6-sBd4vmA9Se464kNsxIetb7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Nguyen, Tom L" <tom.l.nguyen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vladimir Vukicevic <vladimirv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I do not have a Dell and when I resume from suspend the monitor does not come 
on. I applied the patch, but it did not help. I also have a PCIE card and I 
have the CONFIG_PCIEBUSPORT enabled.
Do I need to unload the tg3 module, before I suspend the system?

Vasilis


On Friday 10 June 2005 01:17 pm, Nguyen, Tom L wrote:
> On Thursday, June 09, 2005 7:00 PM Shaohua Li wrote:
> > Long, is this patch ok to you? PCIE bridge itself requires to
> > save/restore config space.
>
> Great! Would you please also add saving/restoring MSI capability
> structure if supported?
>
> Thanks,
> Long
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you
> shotput a projector? How fast can you ride your desk chair down the office
> luge track? If you want to score the big prize, get to know the little guy.
> Play to win an NEC 61" plasma display: http://www.necitguy.com/?r
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20

From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [tony-4v6yS6AI5Vouz6v9ZCXmdjM8Nr7U3kwL@public.gmane.org x86_64 VIA chipset IOAPIC fix]
Date: Thu, 25 Mar 2004 21:26:16 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040326052616.GH8058@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Here's a forwarded message from the LKML as requested by Len Brown.
The acpi mailing list on the thread is wrong, should be acpi-devel,
not acpi-devel-request.

It's regarding processor and thermal ACPI modules on m6805 laptop.

Tony

----- Forwarded message from Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> -----

Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] x86_64 VIA chipset IOAPIC fix
Date:	Thu, 25 Mar 2004 21:02:44 -0800
Message-ID: <20040326050244.GF8058-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
User-Agent: Mutt/1.5.6i
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Chris Cheney <ccheney-4Ww5XsWutDyeZLLa646FqQ@public.gmane.org>, linux-kernel@vger.kernel.org,
	acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, patches@x86-64.org,
	Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, pavel@ucw.cz
X-Mailing-List:	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

* Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> [040325 20:22]:
> 
> where does it hang when processor and thermal are compiled-in?

It hangs early after saying the processor supports c1 and c2 states + few
more lines.

It does not hang if loading processor and thermal as modules.

Tony
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


----- End forwarded message -----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: hotkey/video framework [was: ibm-acpi-0.2]
Date: Tue, 17 Aug 2004 23:55:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040817215505.GB15957@hell.org.pl>
References: <3ACA40606221794F80A5670F0AF15F840533AE98@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840533AE98@pdsmsx403>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>, julien.lerouge-GANU6spQydw@public.gmane.org, John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, letsnote-tech-eXqGM+LsbTTAqL8d+zIrHngSJqDPrsil@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Yu, Luming:
> >One possibility is to just agree on the proc file format and ACPI
> >events for the common features, then have each driver implement them
> >separately. This would probably be simpler than trying to come up with
> >some sort of a wrapper framework as the code involved is fairly simple
> >and there probably isn't much we can share. Then again, there might
> >be, I haven't looked.
> I think the proposaled framework/abstraction layer is NOT just for 
> code sharing. We need to dynamically load the proper hotkey/video driver

While binding all HIDs in one place should be fairly easy, I don't think I
see an advantage to that as opposed to a modrobe *_acpi solution,
especially now that the fix to acpi_bus_register_driver() is in place.

As for the video, if a certain API was agreed on, the generic driver could
provide an abstraction that vendor-specific drivers could bind on. What I'm
afraid of is that the components and AML code used are so diverse that the
management of such a layer becomes a nightmare.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285

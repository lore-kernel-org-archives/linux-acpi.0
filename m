From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Wed, 11 Aug 2004 21:08:24 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040811190824.GF1120@openzaurus.ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB60028F9AC3@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60028F9AC3-exJ48ZlmiLpQxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ole.rohne-vJEk5272eHo@public.gmane.org, Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, anib-La3J9u0raUk@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > I"ve been hesitant to propose a generic VGAPOST, but it could be good
> > to have a way of resuming without using a driver. Would it be cleaner
> > to put the call in pci_default_resume?
> 
> Yes. If this patch works for tohers, then we can move it into
> pci_default_resume during the cleanup.


I'd rather not do that. Some cards are already posted after
S3, some even preserve state over S3. It is okay to do VGAPOST
for radeon and any card that needs it, but I'd rather not do it generically.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285

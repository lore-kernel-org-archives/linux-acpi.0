From: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Date: Fri, 11 Feb 2005 10:16:46 +0100
Message-ID: <20050211091645.GD3263@crusoe.alcove-fr>
References: <20050210161809.GK3493@crusoe.alcove-fr> <20050210193937.GH1145@poupinou.org>
Reply-To: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050210193937.GH1145-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 10, 2005 at 08:39:37PM +0100, Bruno Ducrot wrote:

> On Thu, Feb 10, 2005 at 05:18:10PM +0100, Stelian Pop wrote:
> > Hi,
> > 
> > +ACPI Sony Notebook Control Driver (SNC) Readme
> > +----------------------------------------------
> > +	Copyright (C) 2004 Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
> > +
> > +This mini-driver drives the ACPI SNC device present in the 
> > +ACPI BIOS of the Sony Vaio laptops.
> > +
> > +It gives access to some extra laptop functionalities. In 
> > +its current form, the only thing this driver does is letting
> > +the user set or query the screen brightness.
> 
> Does those laptops support acpi_video?

No. I double checked for a few AML dumps I have here, and except
for _DOS/_DOD present in some of them no other acpi_video method is
supported.

Newer Vaio laptops may eventualy support acpi_video, but all
current (to the best of my knowledge) Vaios do support the SNC device.

Stelian.
-- 
Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

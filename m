From: Sebastian <sebastian_ml-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: DSDT properly fixed?
Date: Fri, 08 Apr 2005 20:19:15 +0200
Message-ID: <4256CB23.8080204@gmx.net>
References: <971FCB6690CD0E4898387DBF7552B90E01199754@orsmsx403.amr.corp.intel.com>
Reply-To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E01199754-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

Moore, Robert schrieb:
> Neither problem will make any difference on current versions of ACPI CA
> 
> 1) We don't look at the value returned by _WAK, if any.
> 2) The AML interpreter just ignores things like "Store (Local0,
> Local0)", which seems to be used as some form of twisted NOOP.
> 
> However, if your goal is to eliminate all warnings/errors, your fix for
> 1) is OK, but for 2) I think you can simply delete the offending line of
> code.
> 
> Bob

Hello Bob,

thanks for clearing that up. So it seems it isn't necessary to "fix" the
dsdt after all :) Well, maybe I was a little too eager then ;-)

Thanks!

Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

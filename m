From: Mark Eaton <meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org>
Subject: Re: DSDT errors
Date: Wed, 16 Feb 2005 11:45:50 +1000
Message-ID: <200502161145.50388.meaton@vasco.com>
References: <971FCB6690CD0E4898387DBF7552B90E96D4F8@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="windows-1255"
Content-Transfer-Encoding: 7bit
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E96D4F8-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

Ok so the problem probably isn't the dsdt.
Thanks.

On Wed, 16 Feb 2005 11:36 am, you wrote:
> But actually, we don't look at the return value anyway (yet)
>
>     Status = AcpiEvaluateObject (NULL, METHOD_NAME__WAK, &ArgList, NULL);
>     if (ACPI_FAILURE (Status) && Status != AE_NOT_FOUND)
>     {
>         ACPI_REPORT_ERROR (("Method _WAK failed, %s\n", AcpiFormatException
> (Status))); }
>     /* TBD: _WAK "sometimes" returns stuff - do we want to look at it? */
>
> <snip>


-- 
Mark Eaton
meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

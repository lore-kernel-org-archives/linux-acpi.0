From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: WARN: please read if you applyied 00_thinkpad_workaround.diff (Re: IBM Thinkpad A31 | News)
Date: Sat, 18 Jan 2003 18:08:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030118170844.GE12516@poup.poupinou.org>
References: <200301171947.54174.dom@wahuu.at> <200301172111.15037.dom@wahuu.at> <20030117210321.GC12516@poup.poupinou.org> <200301172204.52963.dom@wahuu.at> <20030118164525.GD12516@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030118164525.GD12516-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Bartenstein <dom-K271P2BsTd0@public.gmane.org>
Cc: ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jan 18, 2003 at 05:45:25PM +0100, Ducrot Bruno wrote:
Hi Dom,
> > >
> > > Cheers,
> > 
> 
> Here is then.
> 
> This patch is against acpi-20030109.  It override the

..

Ouch.  Just realize that the portion:

> +acpi_status
> +acpi_os_table_override(struct acpi_table_header * existing_table,
> +		       struct acpi_table_header ** new_table)
> +{
> +	if (!existing_table || !new_table)
> +		return AE_BAD_PARAMETER;
> +
> +	if (!memcmp(existing_table->signature, "ECDT", 4)) {
> +		struct acpi_table_ecdt *old = (struct acpi_table_ecdt *) existing_table;
> +		struct acpi_table_ecdt **new = (struct acpi_table_ecdt **) new_table;
> +
> +		if (!memcmp(old->header.oem_id, "IBM", 3))
> +			return (verify_ibm_ecdt(old, new));
> +	}
> +	return AE_OK;
> +}

That can let *new_table to be not NULL if we do not enter
the if statement.

It should be:

acpi_status
acpi_os_table_override(struct acpi_table_header * existing_table,
		       struct acpi_table_header ** new_table)
{
	if (!existing_table || !new_table)
		return AE_BAD_PARAMETER;

	*new_table = NULL;

	if (!memcmp(existing_table->signature, "ECDT", 4)) {
		struct acpi_table_ecdt *old = (struct acpi_table_ecdt *) existing_table;
		struct acpi_table_ecdt **new = (struct acpi_table_ecdt **) new_table;

		if (!memcmp(old->header.oem_id, "IBM", 3))
			return (verify_ibm_ecdt(old, new));
	}
	return AE_OK;
}

Or else you will have a kernel oops at acpi init stage.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en

From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: 2.4.19 & latest acpi & patched dsdt (tosh3k)
Date: Fri, 9 Aug 2002 12:33:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020809103313.GC24541@poup.poupinou.org>
References: <E17cwVi-000HKK-00@f16.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E17cwVi-000HKK-00-Fua/sgysUDkox3rIn2DAYQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Huw H <hrhawk-JGs/UdohzUI@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Aug 09, 2002 at 03:16:06AM +0400, Huw H wrote:
> Heya,
>    I've managed to upgrade to the latest 2.4.19 kernel without too many
> problems by applying the acpi patch to the 2.4.18 source, then patch-2.4.19.
> There are about 5 rejected blocks, of which 2 are documentation and the
> remaining not too difficult to kludge together (its my first look at the code,
> so someone familiar with it can release a patch). 
> 
> Now, problems I've had with the newest ACPI patch:
> 
>    Using the newest acpi, I am no longer able to override the dsdt with the
> patch from ftp://ftp.poupinou.org/ without getting errors about an   "invalid
> signature where the RSDP indicates RSDT/XSDT should be"  then failure messages
> for unable to load RSDT.
> 
>  This is also a problem when using the latest patch against 2.4.18.
> 
>  I was using the tosh3k-514.hex dsdt from ftp.poupinou.org, as I am lead to
> believe my satellite 3000-302A is equivalent to this model. If anyone wants to
> check my dsdt the raw dump is here: 
> 
>          http://johan.dhs.org/tosh3k-302a.dsdt.bz2
> 
> With an unpatched dsdt, I have access to battery (no discharge rate info),
> processor, button information. Thermal, fan and ac zones don't work, and I've
> never tried suspending.

There is some difference between tosh3k-302a.dsdt and the one for the
toshiba 514.  I will give you soon a correct version for your model.

Note also that I didn't try yet the latest release of acpi.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI Battery status on Acer TravelMate a-550XV
Date: Sat, 16 Nov 2002 14:47:43 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021116134743.GB691@poup.poupinou.org>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B907@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19B907-LkGsggTGxVmSsB6bSF6DdVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "'lestat-oqfuaKpTAUt/+UGKtYOvpA@public.gmane.org'" <lestat-oqfuaKpTAUt/+UGKtYOvpA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Robert,

On Fri, Nov 15, 2002 at 10:45:38AM -0800, Moore, Robert wrote:
> >From looking at your disassembled dsdt, I think that there is a problem with
> the _BIF method:
> 
>                     Method (_BIF, 0, NotSerialized)
>                     {
>                         Name (STAT, Package (0x0D)
>                         {
>                             0x01, 
>                             0x1194, 
>                             0x1194, 
>                             0x01, 
>                             0x39D0, 
>                             0x01A4, 
>                             0x9C, 
>                             0x0108, 
>                             0x0EC4, 
>                             "PXBAS008", 
>                             "3658Q", 
>                             "NiMH ", 
>                             Zero, 
>                             "PANASONIC"
>                         })
>                         ...
> 
>                             Sleep (0x64)
>                         ...
> 
>                         Return (STAT)
>                     }
> 
> 1) The sleep within the method will allow another thread to begin execution
> of the same method -- because the method is declared "NotSerialized"
> 
> 2) The declaration of the "STAT" package in the namespace will fail with
> AE_ALREADY_EXISTS if a second thread reenters the method (exactly the
> problem you are seeing when you pop the battery back in.)
> 
> My suggested fix:
> Disassemble the dsdt (iasl -d dsdt.dat)
> Change "NotSerialized" to "Serialized" in the declaration of _BIF.
> Recompile and install the new dsdt (Override the BIOS dsdt)
> 

Just for your info.  You should look at 
http://marc.theaimsgroup.com/?l=acpi4linux&m=101586220402069&w=2

with also this s/must be declared/should be declared/
BTW, I think that it is more likely an ACPI spec issue, and it should be
clarified in other release of the spec.


-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html

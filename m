From: "Huw H" <hrhawk-JGs/UdohzUI@public.gmane.org>
Subject: Re[2]: 2.4.19 & latest acpi & patched dsdt (tosh3k)
Date: Sat, 10 Aug 2002 21:04:32 +0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E17dZfE-000OaB-00@f19.mail.ru>
References: <20020809105436.GD24541@poup.poupinou.org>
Reply-To: "Huw H" <hrhawk-JGs/UdohzUI@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020809105436.GD24541-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hey Bruno,
   I've tried the new patched dsdt, but it is still rejected by the latest
kernel patch. The excerpt from the kernel log is:


  tbget-0272: *** Info: Table [DSDT] replaced by host OS
  tbrsdt-0210: *** Error: Invalid signature where RSDP indicates RSDT/XSDT
should be located
RSDT/XSDT signature at FEF99C1 (0fef99c1) is invalid
 tbxface-0086: *** Error: Acpi_load_tables: Could not load RSDT:
AE_BAD_SIGNATURE
 tbxface-0116: *** Error: Acpi_load_tables: Could not load tables:
AE_BAD_SIGNATURE
ACPI: Unable to load the System Description Tables


   I'll give the patched dsdt a try with an older kernel version and let you
know the outcome. Thanks.

Huw H.


-----Original Message-----
From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
To: Huw H <hrhawk-JGs/UdohzUI@public.gmane.org>
Date: Fri, 9 Aug 2002 12:54:36 +0200
Subject: Re: [ACPI] 2.4.19 & latest acpi & patched dsdt (tosh3k)

> 
> Could you please try this one:
> 
> ftp://ftp.poupinou.org/tosh_3000/acpi/tosh3k-302a.hex.bz2
> 
> and report me if it work ?
> 
> Thank,
> 
> -- 
> Ducrot Bruno
> http://www.poupinou.org        Page profaissionelle
> http://toto.tu-me-saoules.com  Haume page



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

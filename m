From: Nate Grey <nate-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>
Subject: Re: Acer Aspire 1601LC tempertature & ACPI
Date: Fri, 2 Apr 2004 21:01:54 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404022101.54233@asda>
References: <200404021654.00101.nate@paranoici.org> <004501c418e3$994b2ca0$7ce9fea9@SHERKA>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <004501c418e3$994b2ca0$7ce9fea9-UdiLdEXzXlE@public.gmane.org>
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

On Friday 02 April 2004 18:52, Ois=EDn Mac Fheara=ED wrote:
> With my Acer Aspire 1705SMi, thermal zone would report temperature as 255C
> repeatedly during bootup and reboot.
> I disabled the thermal zone module, as the BIOS will supposedly shut down
> the laptop if the temperature is really too high.
>
> Ois=EDn

It's a solution... Are you sure that the cpu will not reach an high=20
temperature due to a not perfect cooling management?
Is it safe disable the thermal module so that there's not a temperature che=
ck?

(I also don't have "sleep" in /proc/acpi, any hints)

Cheers,
Nate


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

From: Thomas Geiger <geiger-Cb7RZHV19h45EzxeNYqZ9w@public.gmane.org>
Subject: Re: Re: IBM Thinkpad A31 | ACPI problems
Date: Thu, 2 Jan 2003 21:27:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301022127.25055.geiger@solution2u.net>
References: <000301c2b284$8a15d8f0$232202d3@sayonara>
Reply-To: geiger-Cb7RZHV19h45EzxeNYqZ9w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <000301c2b284$8a15d8f0$232202d3-F8JvWDuGsZU@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

i'm also encountering the same problems with my (beloved ;) ) A31. So if there 
is a possible workaround - is anyone already working on it/how difficult 
would it be to implement such that hack?

Tom

On Thursday 02 January 2003 18:29, Adachi, Kenichi wrote:
> > I browsed the mailing list archives (December 2002, November 2002) and
> >
> > encountered several postings from Sandro (PSI-Systems
>
> <psi-systems-8XqT/MH+8ao@public.gmane.org>)
>
> > who is having the same problem with his Thinkpad A31 laptop:
> > ACPI: Found ECDT
> > ACPI: Could not use ECDT
> > evxfevnt-0119 [06] Acpi_disable          : ACPI mode disabled
> >
> > ACPI is completely disabled for IBM Thinkpad A31. Is there a
> > solution for that
> > problem available? How can I be of any help to the ACPI developers?
>
> Did you also read Andy Grover's reply to Sandro?
>
> Subject:  RE: [ACPI] ACPI does not work since
> acpi-20021022-2.4.20-pre11.di
> From:     "Grover, Andrew" <andrew.grover () intel ! com>
> Date:     2002-11-04 18:19:30
> http://marc.theaimsgroup.com/?l=acpi4linux&m=103643408113691&w=2
>
> In short, ECDT -> EC_ID is supposed to be the full path name of your EC
> device in ACPI Namespace like "\_SB.PCI0.LPC.EC", but __NOT__ in your
> BIOS.
> You can work around your problem by adding hack code, but it makes OS
> code dirty to save broken BIOSes and it allows BIOS vendor not to fix
> their problem.
>
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-- 
thomas geiger
solution2u.net gmbh * am hof 4 * a-6861 alberschwende
fon +43 5579 85777-0 * fax +43 5574 54445-20 * mobil +43 664 38 12 645
http://solution2u.net/ * geiger-Cb7RZHV19h45EzxeNYqZ9w@public.gmane.org

have a nice day


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

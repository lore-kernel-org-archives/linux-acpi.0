From: Sebastian Thias <post-OXl1b/uZKHizQB+pC5nmwQ@public.gmane.org>
Subject: Re: gpe-handler / acpi on ASUSL2400D
Date: Thu, 27 Mar 2003 15:17:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303271517.41501.post@sthias.de>
References: <F760B14C9561B941B89469F59BA3A847E96D73@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96D73-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
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

Sorry, I don't know what I've done to my kernel-source
last night :-)
Now it builds fine and the patch fixes my problem.

Thank you for your help!
     Sebastian

Am Donnerstag 27 März 2003 01:40 schrieb Grover, Andrew:
> > From: Sebastian Thias [mailto:post-OXl1b/uZKHizQB+pC5nmwQ@public.gmane.org]
> >
> > > Have you tried the patch against 2.5.65 at sf.net/projects/acpi ?
> > >
> > > I'm thinking this is another symptom of our ignoring of
> >
> > GPE1, which that
> >
> > > patch fixes.
> >
> > I don't know if I'm too stupid, but:
> > It didn't compile, seemed that there was one slash missing at
> > the front
> > of a comment.
> > Then it compiled, but didn't link. It was "scan.o" where the
> > missing symbols
> > were located. I changed drivers/acpi/Makefile to link scan.o,
> > too. Then my
> > kernel was built ok, but upon rebooting I got a
> > null-pointer-dereference-oops, "Attempting to kill init".
> >
> > *?*
>
> Can anyone else duplicate this? I can't.
>
> -- Andy
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by:
> The Definitive IT and Networking Event. Be There!
> NetWorld+Interop Las Vegas 2003 -- Register today!
> http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

-- 
PGP PublicKey: http://www.sthias.de/pubkey.asc


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en

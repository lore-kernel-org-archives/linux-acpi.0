From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Acer Aspire 1601LC tempertature & ACPI
Date: Mon, 5 Apr 2004 11:50:56 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040405114950.E22024@root.org>
References: <200404021654.00101.nate@paranoici.org> <004501c418e3$994b2ca0$7ce9fea9@SHERKA>
 <200404022101.54233@asda>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200404022101.54233-Ulv+RfhiHhw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Grey <nate-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2 Apr 2004, Nate Grey wrote:
> On Friday 02 April 2004 18:52, Ois=EDn Mac Fheara=ED wrote:
> > With my Acer Aspire 1705SMi, thermal zone would report temperature as 2=
55C
> > repeatedly during bootup and reboot.
> > I disabled the thermal zone module, as the BIOS will supposedly shut do=
wn
> > the laptop if the temperature is really too high.
> >
> > Ois=EDn
>
> It's a solution... Are you sure that the cpu will not reach an high
> temperature due to a not perfect cooling management?
> Is it safe disable the thermal module so that there's not a temperature c=
heck?

CPU shutdown is hardware-controlled, so yes.  There are ways on both
FreeBSD and Linux to "smooth" out the 255C reported temps so they don't
cause a shutdown.

-Nate


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

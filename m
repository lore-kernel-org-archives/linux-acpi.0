From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI/ECDT on gateway 200x notebook
Date: Tue, 6 Jan 2004 19:34:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040106183426.GJ14031@poupinou.org>
References: <3FF773E5.5070102@rochester.rr.com> <Pine.LNX.4.44.0401032005180.7785-100000@data.upl.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401032005180.7785-100000-j0XSImJ06nG869pVMd/zofZ8FUJU4vz8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Casey Harkins <charkins-TFaeeA7fOO6Gwcnyzrk3/w@public.gmane.org>
Cc: Rich Ibbotson <richibb-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jan 03, 2004 at 08:07:26PM -0600, Casey Harkins wrote:
> 
> I think its now been determined that the problem is not from a missing
> ECDT. Check out the bugzilla entry where work is being done to solve this
> problem. I'm hoping to test the patch on one of our 400VTX's this week.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=1744

The patch initiazile EC(s) as the really first device(s) (but I am 
perhaps wrong, since I read it really quickly though), which break
acpi "spirit" imnsho.  The EC is a child of other devices and you
have to be sure that those devices are initialized before EC (even
though that is done by BIOS at POST already, due to legacy access
in some laptops).

> On Sat, 3 Jan 2004, Rich Ibbotson wrote:
> > Dear ACPI Gurus,
> >

[...]

> > I do see an entry for "\_SB_.PCI0.LPCB.H_EC._REG" in the DSDT, though:
> >
> > 000028c5:         Method _REG (\_SB_.PCI0.LPCB.H_EC._REG)
> > 000028cb:           ArgCount 2; NotSerialized
> > 000028cc:           If
> > 000028ce:             LAnd
> > 000028cf:               LEqual
> > 000028d0:                 Arg0
> > 000028d1:                 0x03
> > 000028d3:               LEqual
> > 000028d4:                 Arg1
> > 000028d5:                 0x01
> > 000028d7:             Store
> > 000028d8:               0x01
> > 000028da:               ECON (0000024e)
> > 000028de:             Store
> > 000028df:               \_SB_.PCI0.LPCB.H_EC.ACEX (00002844)
> > 000028f6:               \PWRS (00000160)
> >

Please do not use acpidmp, but iasl instead, or send a raw dsdt.

Look at http://acpi.sf.net/ for how to get iasl.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

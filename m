From: Jochen Reinwand <jbr.1-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [TRIVIAL] Re: [PATCH] ACPI update (20030122)
Date: Fri, 24 Jan 2003 19:21:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301241921.35945.jbr.1@gmx.net>
References: <F760B14C9561B941B89469F59BA3A84725A131@orsmsx401.jf.intel.com> <20030124032222.A9061@piffio.homelinux.org> <20030124155101.GZ18109@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030124155101.GZ18109-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Friday 24 January 2003 16:51, Ducrot Bruno wrote:
> On Fri, Jan 24, 2003 at 03:22:22AM +0100, Sergio Visinoni wrote:
> > * Grover, Andrew (andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) wrote:
> > > (2.4) S4BIOS support (Ducrot Bruno)
> >
> > Attached is the missing s4bios portion (the
> > acpi_enter_sleep_state_s4bios function ) + fixes to make it
> > build correctly on a 2.4.20 tree.
> >
> > It should apply correctly on 2.4.21-pre3 as well (not tested).
>
> It should be OK (I think..)

I would really like to test it on a 2.4.20, but the new acpi patch does not 
apply cleanly on a vanilla 2.4.20. Is there a special backport patch 
available or do I have to figure it out on my own?

regards,
Jochen


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com

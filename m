From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: Re: ACPI: Battery information?
Date: Mon, 14 Jun 2004 16:06:24 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040614140624.GM1095@poupinou.org>
References: <40C4FD27.7000805@users.xeroprj.org> <20040608092045.72e15c4c@tethys.solarsys.org> <20040608094707.GM13782@poupinou.org> <40C58F45.2040108@users.xeroprj.org> <20040608113456.GN13782@poupinou.org> <40C6319A.7080707@users.xeroprj.org> <20040609075401.GT13782@poupinou.org> <20040610164324.GA6919@message-id.gmane0305.slipkontur.de> <20040610211644.GF13782@poupinou.org> <20040611051031.GA5237@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040611051031.GA5237-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 11, 2004 at 05:10:31AM -0000, Stefan Seyfried wrote:
> On Thu, Jun 10, 2004 at 11:16:44PM +0200, Bruno Ducrot wrote:
> > On Thu, Jun 10, 2004 at 04:43:24PM -0000, Stefan Seyfried wrote:
> > 
> > > Well, this works fine for me on a hp compaq nx5000 with 2 batteries.
> > > So i suspect the quality of your BIOS / DSDT is to blame.
> > 
> > It work for me since 2 or 3 years at least.
> 
> Ok, qouted wrong: Binary Xerroz's BIOS may be to blame.

Ok.

> 
> > > > So it's more likely a trouble somewhere in your DSDT, or a bug under linux.
> > > 
> > > As written above, it works for me under Linux.
> > 
> > Fine.  And you assume then if it work for you, but not for others, then the
> > AML is faulty?  Why?
> 
> No, what i wanted to say was: it works for my small sample of about
> 5 Machines with multiple batteries. If there was this general bug which
> would prevent multiple batteries from working all the time i think i
> would have hit it, too.
> Of course there also can be a bug which is only triggered by some
> special machine.

In fact, as I already stated, I think the root of the trouble is that
there is a device from which there is no driver, which is problably a
kind of mediabay.  I think (but I may be wrong) that unless a special
driver is written for this device, the second battery will not work as
expected.  So, AFAIK, it's not a bug in the DSDT, nor even a bug in
linux since this driver have to be written...  Note that I don't have a
clue on how to start for developing this driver.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504

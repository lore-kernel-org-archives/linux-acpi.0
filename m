From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Is this safe?  Re: Dell DSDT corrected
Date: 30 Jan 2003 10:45:50 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1043941550.2039.6.camel@sirius.strandboge.cxm>
References: <200301281120.15917.jan.slezak@centrum.cz>
	 <20030129180444.GB10601@homerelay.wiesner-net.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030129180444.GB10601-aCYJ90g6FbN3mO1V46hDx7oZL2q1Rlic@public.gmane.org>
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

On Wed, 2003-01-29 at 13:04, Markus Wiesner wrote:
> Jan Slezak schrieb:
> > I modified my Dell Latitude C640 DSDT table and values in /proc/acpi what were 
> > previously constantly zero (or something equivalent) where brought to life. 
> > This is:
> > 
> > - temperature in thermal zone
> > - processor frequency in performance in processor (processor consumption is 
> > still zero, but I belive it is not exposed to ACPI)
> > - all information in battery (except presence/absence what was already working 
> > before)
> > 
> > The DSDT patch and original DSDT are enclosed I hope it helps someone.
> 
> Yes, it does! The patch works without modification for my Inspiron 8200,
> too. Great work!
> 

Well, on my i8200 I had to play with it some.  First I got the dsdt from
/proc/acpi/dsdt:

iasl -d /proc/acpi/dsdt

Then I applied the patch from Jan Slezak.

Then I did:

iasl -tc ./dsdt.dsl

and had errors.  A couple were warning about not returning a value, so I
just had those return (0x0).  What was troubling was I had errors about
a Field accessing outside of the region (don't remember off hand the
exact wording, so I changed:

OperationRegion (FDIS, PCI_Config, 0xF2, 0x02)

to:
OperationRegion (FDIS, PCI_Config, 0xF2, 0x04)

I did this based on info found at:
http://www.cpqlinux.com/acpi-howto.html#fix_broken_dsdt

Everything compiled without errors, and I am trying it out now, but is
this really safe?  I am the first to admit that I don't know what I am
doing with this code.  I don't want to break anything, but desperately
want acpi to work.

Jamie

PS-- Sorry you got this twice Markus-- didn't reply to list the first
time.

-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com

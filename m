From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI in kernel 2.5.68 works better (for me) than 2.5.69
Date: Tue, 6 May 2003 14:36:50 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030506123650.GR2954@poup.poupinou.org>
References: <1052180986.1005.3.camel@chevrolet.hybel> <20030506112053.GO2954@poup.poupinou.org> <1052222508.5614.5.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1052222508.5614.5.camel-rd0e0RNjLLRX8BKYUJ5quQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, May 06, 2003 at 02:01:48PM +0200, Stian Jordet wrote:
> tir, 06.05.2003 kl. 13.20 skrev Ducrot Bruno:
> > On Tue, May 06, 2003 at 02:29:46AM +0200, Stian Jordet wrote:
> > > Hi,
> > > 
> > > Since kernel 2.5.69, usb no longer work with acpi on my computer. With
> > > 2.5.68 it did. Do you know what changes you have done might cause this?
> > > 
> > > I get this error, but this one is with both .68 and .69.
> > > 
> > > ACPI-0109: *** Error: No object was returned from
> > > [\_SB_.PCI0.PX40.IRDA._STA] (Node dff5cc80), AE_NOT_EXIST
> > 
> > A pointer to your DSDT will be appreciate...
> 
> I'm probably just stupid, but I have been searching a bit, and I can't
> seem to find information about how to find it anywhere.. With 2.4 it was
> under /proc/acpi, but not in 2.5.. Hmm..

Ok.  I must admit I don't know for 2.5.  Then just grab acpidump
from sf'cvs :

cvs -d:pserver:anonymous-CZy7tVeV0kv+F7Cq6hUZDNHuzzzSOjJt@public.gmane.org:/cvsroot/acpi login
cvs -z3 -d:pserver:anonymous-CZy7tVeV0kv+F7Cq6hUZDNHuzzzSOjJt@public.gmane.org:/cvsroot/acpi co acpidump

then, in acpidump directory, do a make and a
./acpidump -b DSDT > dsdt
then send me a gzipped version to this one (or place a pointer in www,
ftp, etc.).

> 
> > > This is a Asus CUV266-DLS smp motherboard, and thus I need acpi to power
> > > it off, and it would have been very, very much apprpeciated if this
> > > somehow could be fixed before 2.6, atleast. I don't want to be running
> > > 2.5.68 for ever :)
> > > 
> > 
> > 
> > Stupid question: does USB work without ACPI?
> 
> It does indeed (with MPS1.4 disabled). But it has worked with at least
> the 15 last 2.5.x kernels...

IMHO, it is likely to be a problem with IRQ and IO-APIC.  Andy should
answer more on this than me.  But I guess that at first a
cat /proc/interrupts
may help (with and without acpi), and with attached dmesgs.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

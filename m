From: =?iso-8859-1?q?Praveen=20C?= <cpravn-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi on r40e
Date: Tue, 17 Feb 2004 16:36:49 +0000 (GMT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040217163649.87862.qmail@web14526.mail.yahoo.com>
References: <3ACA40606221794F80A5670F0AF15F8401CBB6CD@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB6CD-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello,
I have put all the required files here

http://www.flatface.net/~praveen/tp/tables

The complete output of running acpidmp is in acpidmp.out
I have also put the individual tables.
The dsdt from /proc/acpi/dsdt is in dsdt_from_proc.dat

Thanks
praveen

 --- "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote: > > Before a keypress
> >   9:          1          XT-PIC  acpi
> 
> > After a key press
> >   9:          1          XT-PIC  acpi
> 
> Thanks for your information, Obviously, Hot key doesn't trigger any
> SCI# .And most likely, No SMI# too. This is a real bug.
> output of acpidmp and /proc/acpi/dsdt are wanted!
> 
> --Luming 

=====
http://www.cpraveen.tk/

________________________________________________________________________
Yahoo! India Insurance Special: Be informed on the best policies, services, tools and more. 
Go to: http://in.insurance.yahoo.com/licspecial/index.html


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

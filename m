From: =?iso-8859-1?q?Praveen=20C?= <cpravn-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: acpi on r40e
Date: Thu, 12 Feb 2004 16:57:44 +0000 (GMT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040212165744.446.qmail@web14521.mail.yahoo.com>
References: <1076387688.4110.576.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1076387688.4110.576.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I removed all HKEY related stuff and assembled dsdt.dsl using iasl.
Then I used the DSDT initrd patch together with the new DSDT table. I
STILL cant get the volume and brightness buttons to work.
praveen

 --- Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote: > On Sat, 2004-02-07 at
11:20, Praveen C wrote:
> 
> > Another problem with acpi which I forgot to mention is that it
> makes
> > the special buttons for volume and brightness control ineffective.
> If I
> > boot the same kernel with acpi=off those buttons work fine.
> 
> Interesting.
> If you boot, say with "acpi=off", your volume and brightness buttons
> work, but if you boot with ACPI enabled they have no effect?
> 
> you DSDT has an IBM defined device:
> 
>                     Device (HKEY)
>                     {
>                         Name (_HID, EisaId ("IBM0068"))
> 
> which sure sounds like it might be a hot-key device;-)
> However, not immediately clear to me how ACPI w/o vendor-specific
> extensions would talk to it.  Even more unclear is how and why these
> buttons work when ACPI is disabled, and how ACPI interferes with
> their
> proper operation when it is enabled.
> 
> -Len

=====
Praveen C
http://www.cpraveen.tk/

________________________________________________________________________
Yahoo! India Education Special: Study in the UK now.
Go to http://in.specials.yahoo.com/index1.html


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

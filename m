From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: No network after S3
Date: 15 Feb 2004 00:36:49 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076823407.25351.73.camel@dhcppc4>
References: <1076768932.402e30a460d2e@webmail.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1076768932.402e30a460d2e-2RFepEojUI3OpE1Re6/EDRvVK+yQ3ZXh@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Peter.Zeipelt-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Peter,
Same NIC works with pci=noacpi or acpi=off?
If yes, then this is an ACPI bug.  If no, then the problem lies
elsewhere.

I'd defer dealing with the suspend/resume issues until more basic
functionality is working properly.

thanks,
-Len


On Sat, 2004-02-14 at 09:39, Peter.Zeipelt-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org wrote:
> Hello list
> 
> I hope this is the right place for my question.
> Using an ABIT KT7-RAID with SuSE 8.2prof and the kernel 2.6.1 or 2.6.2
> STR seems to work fine.
> But trying to use network nothing really happens.
> I tried out several NICs (3c905c, 100PRO/S and one with a 8139b).
> When i try to ping another  host in the local net, all get is an
> Destination Host unreachable.
> The 8139b says "no buffer space available" .
> A dmesg with the 3c905 says "IRQ blocked by another device?"
> But there isn't any other device on this IRQ.
> Un- and reloading the module doesn't help.
> Trying the STR on an ASUS A7N8X with driver for the nforce NIC in the
> kernel brings the same result.
> Another strange thing to me is, that S3 and S4 are working better on
> the old ABIT  board with Via KT133
> chipset then on my newer nforce boards.
> The ASUS didn't fall in S4 mode, cause it seems that the disks are
> powered down before writing the RAM
> on it.
> An Enmic 8RDA+ doesn't boot after S3.
> But for now my main problem is to bring the network to work after the
> S3.
> Any hints?
> 
> Thanks
> Peter
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

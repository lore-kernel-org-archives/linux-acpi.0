From: Sergey Vlasov <vsu-u2l5PoMzF/Uox3rIn2DAYQ@public.gmane.org>
Subject: Re: Hang on booting 2.6.3 at "Edge set to Level Trigger"
Date: Fri, 19 Mar 2004 18:15:25 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040319181525.3bb8ec96.vsu@altlinux.ru>
References: <200403181845.46394.philipp.buechel@gmx.li>
	<1079689606.5242.11.camel@rh10.fe.up.pt>
	<200403191532.53941.philipp.buechel@gmx.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 19 Mar 2004 15:32:53 +0100 Philipp wrote:

> Am Freitag, 19. M_rz 2004 10:46 schrieb S_rgio "M. Basto":
> > easy one, disable SMP and APIC in kernel configuration or boot with
> > something like this: noloapic
> 
> Unfortunately, booting with noapic or noloapic takes no effect. dmesg always 
> shows something like
> 
> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!
> 
> And if I boot with "noapic acpi=on" or "noloapic acpi=on" the boot process 
> hangs on the "Edge set to Level Trigger"-Point.

There was a typo here - the correct option is "nolapic".



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

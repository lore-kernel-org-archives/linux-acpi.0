From: Arnaud de Lorbeau <adelorbeau-GANU6spQydw@public.gmane.org>
Subject: Re: 2.6.3-rc3 + D600 + battery status missing sometimes..
Date: Mon, 16 Feb 2004 11:30:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402161130.45137.adelorbeau@free.fr>
References: <C386328088ED7F4E9F81AFBABDDF60DA045C66CA@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C386328088ED7F4E9F81AFBABDDF60DA045C66CA-Yw6hFe9C1vnHQcBQSaPqJq0fmWJ9l57d0E9HWUfgJXw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 16 February 2004 09:50, Ow Mun Heng wrote:
> Just filled a bug or rather, added my own info on the bug id#2066
>
> Kernel 2.6.3-rc3
> Distro : RH9
>
> Battery status comes and goes suddenly. I've tried it with 2.6.2,
> 2.6.2-rc2, 2.6.3-rc3.
>
> ACPI-0279: *** Error: Looking up [BST0] in namespace, AE_ALREADY_EXISTS
> ACPI-1120: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node
> dff9ca60), AE_ALREADY_EXISTS


I have a very similar BUG on toshiba 2435 (Phoenix BIOS) with
Kernel: 2.6.2
Distro: MandrakeLinux Cooker (10.0 in development)

ACPI-0279: *** Error: Looking up [PBST] in namespace, AE_ALREADY_EXISTS
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC0.BAT1._BST] 
(Node c15893a0), AE_ALREADY_EXISTS

And like you, the acpi works a few minutes/secondes, and then it goes blank 
and I have this messages each 20 seconds in /var/log/messages.

Regards.
-- 
Arnaud de Lorbeau


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

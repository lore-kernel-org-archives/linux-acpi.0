From: Jan De Luyck <lkml-gY0FE6dpLprYtjvyW6yDsg@public.gmane.org>
Subject: Re: [2.6.6] Synaptics driver is 'jumpy' -- FIXED
Date: Tue, 18 May 2004 12:49:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405181249.41787.lkml@kcore.org>
References: <A6974D8E5F98D511BB910002A50A6647615FBC01@hdsmsx403.hd.intel.com> <1084821553.12352.358.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1084821553.12352.358.camel-D2Zvc0uNKG8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Alexander Bruder <anib-IUH8PdohV+QGVwEePk/RpQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 17 May 2004 21:19, Len Brown wrote:
> On Mon, 2004-05-17 at 03:04, Jan De Luyck wrote:
> 2.6.6 dmesg:
>
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 11 12) *10
> ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 12
>
> Detected ipw2100 PCI device at 0000:02:04.0, dev: eth1, mem:
> 0xD0206000-0xD0206FFF -> e19e8000, irq: 12
>
> You need this patch:
> http://bugme.osdl.org/show_bug.cgi?id=2665

Thanks Len, this does the trick. 

Jan

-- 
His life was formal; his actions seemed ruled with a ruler.


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click

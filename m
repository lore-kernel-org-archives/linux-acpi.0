From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: acpi-20040715: functional regression on ASUS M2N
Date: Tue, 31 Aug 2004 15:38:30 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3zn4bbf6x.fsf@brain.gnuhh.org>
References: <B44D37711ED29844BEA67908EAF36F03AC6ACF@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F03AC6ACF-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
	(Shaohua Li's message of "Tue, 31 Aug 2004 16:45:04 +0800")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=

 || On Tue, 31 Aug 2004 16:45:04 +0800
 || "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote: 

 ls> I guess it's the problem I encountered (the dmesg is the same as
 ls> mine).  Attached email includes two workarounds for this issue,
 ls> but no final solution yet.

Thanks a lot for the pointer, it indeed appears to be the same
problem.


 ls> Currently there are two workarounds:

 ls> 1. comment one line in pci_link.c:acpi_pci_link_allocate, like
 ls> [...]
 ls> This disables rebalance IRQ, which fixes my problem.

This makes the problematic behaviour disappear, but not the messages
about the problem. I still see the syslog messages, although things
seem to work fine.


 ls> 2. change 'device_initcall(i8259A_init_sysfs);' to
 ls> 'late_initcall(i8259A_init_sysfs);'

This makes both the problematic behaviour and the messages disappear.

Also, it saves me the weird graphical behaviour upon resume, blocky
primitive graphics patterns, changing in one or two steps. 

Now I only have the "inu" close to the upper left corner for a second
or two as I had before the functional regression occured to me. 

All in all, #1 looks like a pretty brutal workaround to me, #2 looks
more like a fix.


 ls> It seems that if OS changed BIOS IRQ router setting (like ACPI
 ls> change Link device setting), IRQ router should resume before
 ls> PIC. This possibly proves what Venki said.

Well, it seems that my experience supports that.

If swsusp2 would also work now, things would be pretty nice.

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBNH9ZbvivwoZXSsoRAuZ7AKCN27jfukW0JVfRClXhOwDGcDrjFACfTpgZ
iY+uvCR/FAMIbi1DQMYWvEk=
=bDWO
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click

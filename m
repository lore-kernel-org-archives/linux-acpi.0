From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: IBM A31 ACPI with 2.4.20-pre11 + ACPI20021022
Date: Thu, 24 Oct 2002 09:17:03 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DF75@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'PSI-Systems' <psi-systems-hi6Y0CQ0nG0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: PSI-Systems [mailto:psi-systems-hi6Y0CQ0nG0@public.gmane.org] 
> Why in newest ACPI-code my A31 doesn't support ACPI anymore?
> 
> at boot this appears and after that apm loads:
> 
> ACPI: RSDP (v002 IBM                        ) @ 0x000f7060
> ACPI: XSDT (v001 IBM    TP-1G    00000.04160) @ 0x1ff6ee48
> ACPI: FADT (v001 IBM    TP-1G    00000.04160) @ 0x1ff6ee8c
> ACPI: SSDT (v001 IBM    TP-1G    00000.04160) @ 0x1ff6ef40
> ACPI: ECDT (v001 IBM    TP-1G    00000.04160) @ 0x1ff79f87
> ACPI: BOOT (v001 IBM    TP-1G    00000.04160) @ 0x1ff79fd8
> ACPI: DSDT (v001 IBM    TP-1G    00000.04160) @ 0x00000000
> ACPI: BIOS passes blacklist
> ACPI: MADT not present

Do you see: "ACPI: Could not use ECDT", or do you not have full ACPI
compiled into the kernel?

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4729346;7592162;s?http://www.sun.com/javavote

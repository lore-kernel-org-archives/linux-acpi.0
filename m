From: "Gareth Wheelton" <gareth-1LCzNYzl4/K5rx9LGsG9jg@public.gmane.org>
Subject: RE: ACPI can't perform S5 soft off
Date: Fri, 04 Jun 2004 12:28:08 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E1BWCmD-0008SF-3U@sc8-sf-mx2.sourceforge.net>
References: <6E0C289723A0564F9A8279E236E8565F0787DF15@pdsmsx402.pd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6E0C289723A0564F9A8279E236E8565F0787DF15-4yWAQGcml64divtuJNk2fFDQ4js95KgL@public.gmane.org>
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

After taking the osl.c patch from the bottom of
http://acpi.sourceforge.net/wiki/index.php/HowToOverrideTable.

I get the following barf :-(

$ patch --verbose -p1 -i  ~/tmp/osl.diff 
Hmm...  Looks like a unified diff to me...
The text leading up to this was:
--------------------------
|--- linux/drivers/acpi/osl.c.orig
|+++ linux/drivers/acpi/osl.c
--------------------------
Patching file drivers/acpi/osl.c using Plan A...
patch: **** malformed patch at line 21: }

does this still apply to kernel version 2.4.26?


cheers gareth

-----Original Message-----
From: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: "Gareth Wheelton" <gareth-1LCzNYzl4/K5rx9LGsG9jg@public.gmane.org>
Date: Fri, 4 Jun 2004 11:37:57 +0800
Subject: RE: [ACPI] ACPI can't perform S5 soft off

> Check info at
> http://acpi.sourceforge.net/wiki/index.php 
> 
> -zhen
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Gareth
> Wheelton
> Sent: 2004”N6ŒŽ4“ú 0:47
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] ACPI can't perform S5 soft off
> 
> Hi
> 
> Are there any instructions on getting a 2.4.26 kernel to use a
> customized
> DSDT.
> 
> I think I've followed all of the instructions from the HOWTO
> (http://www.cpqlinux.com/acpi-howto.html), that is all but applying the
> patches as they are for a prior kernel version.
> 
> I've copied the acpi_dsdt.c to the kernel tree, seen it compiled and
> linked but am not receiving any dmesg to say the customized DSDT table
> is
> being loaded...?
> 
> 
> Cheers Gareth
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the new InstallShield X.
> From Windows to Linux, servers to mobile, InstallShield X is the one
> installation-authoring solution that does it all. Learn more and
> evaluate today! http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the new InstallShield X.
> From Windows to Linux, servers to mobile, InstallShield X is the one
> installation-authoring solution that does it all. Learn more and
> evaluate today! http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504

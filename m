From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI status in 2.4 tree
Date: Wed, 19 Nov 2003 15:29:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031119142918.GF32464@poupinou.org>
References: <20031119135203.373043b0.subscript@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031119135203.373043b0.subscript-GANU6spQydw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: wwp <subscript-GANU6spQydw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 19, 2003 at 01:52:03PM +0100, wwp wrote:
> Hi ACPI guyz,
> 
> 
> are 2.4's release candidates sync'ed w/ ACPI?
> IOW, if I get 2.4.23-rc2, will it include the latest ACPI code from acpi.sf.net
> (except the test patches) or will I have to get'n'apply a patch?
> 

Why not just looking in the log? at ?
>From ftp.kernel.org:/pub/linux/kernel/v2.4/testing/patch-2.4.23.log

Summary of changes from v2.4.23-rc1 to v2.4.23-rc2 
============================================

<atul.mukker:lsil.com>:
  o [scsi megaraid2] fix DMA sync to use correct S/G list pointer

...
...

<len.brown:intel.com>:
  o [ACPI] fix CONFIG_HOTPLUG_PCI_ACPI config (Xose Vazquez Perez)
  o [ACPI] If ACPI is disabled by DMI BIOS date, then turn it off completely, including table parsing for HT.
  o [ACPI] In ACPI mode, delay print_IO_APIC() to make its output valid
...
...


Cheers,


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

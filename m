From: Jacek Blizinski <azidog-SDTLKeebBdLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Please Help!
Date: Mon, 12 Jan 2004 23:11:00 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401122311.00158.azidog@nyc.rr.com>
References: <3ACA40606221794F80A5670F0AF15F8401720CBD@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CBD-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

On Monday 12 January 2004 21:46, you wrote:
> All this features seems to need support from
> other module like asus_acpi.c.

There is a kernel driver written for the P2120 which works for the most part 
except the volume control. This is because it relies on a GVOL And SVOL in 
the P2120 dsdt that is not included in the P5010D. They are located in 
DEVICE(FJEX) and the method names are Method(RVOL), Method(GVOL), 
Method(SVOL,1) and I need help integrating them into the P5010D DSDT.

Here is the volume code from the kernel module:
http://www.openjacek.org/dsdt/volumesnip

Here is the P2120 DSDT
http://www.openjacek.org/dsdt/fuji2120.dsl

Here is the P5010D DSDT
http://www.openjacek.org/dsdt/fujidsdt.dsl

Again thank you for any time you may spare.

--Jacek Blizinski


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html

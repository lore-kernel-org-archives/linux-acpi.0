From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: RE: [PATCH] 2.4/2.6 use xdsdt to print table header
Date: Tue, 13 Jan 2004 08:28:46 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074007725.6494.11.camel@patsy.fc.hp.com>
References: <3ACA40606221794F80A5670F0AF15F8401720CC2@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CC2-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-01-13 at 00:38, Yu, Luming wrote:
> >    I'm resending this patch to get it into the main ACPI source.  This
> > fixes a problem where the DSDT pointer in the FADT is NULL because it
> > uses the 64bit XDSDT instead.  The current code is happy to map a NULL
> > address and return success to the caller.  This can crash the 
> > system or
> > printout garbage headers to the console.  It's a simple 
> > matter to check
> > table revision and use the XDSDT in favor of the DSDT.  This has been
> > living happily in both the 2.4 and 2.6 ia64 tree for some 
> > time.  Please
> > accept.  Thanks,
> 
> I just checked with http://lia64.bkbits.net:8080/linux-ia64-2.4 .
> The patch has been merged. Please take a look at

   Right, it's in the ia64 trees, but understandably the ia64 arch
maintainers don't want to carry this non-ia64 specific patch
indefinitely.  This is a generic ACPI issue for an system that chooses
to use the xdsdt in place of the dsdt.  It should be included in the
ACPI tree and pushed up from there.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html

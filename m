From: Charles Duffy <charlesduffy-doANK8/0m3qakBO8gow8eQ@public.gmane.org>
Subject: Re: 2.6.5: Hitachi HA8000/70 panic, missing devices
Date: Tue, 6 Apr 2004 08:02:00 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040406130200.GA29614@login.isgenesis.com>
References: <571ACEFD467F7749BC50E0A98C17CDD803B1208C@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <571ACEFD467F7749BC50E0A98C17CDD803B1208C-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 06, 2004 at 01:54:53PM +0800, Li, Shaohua wrote:
> Hi,
> For the PCI devices missing problem, it's because your DSDT has error.
> All _BBN of root PCI bridge return 0. We have a track (Bug 1662) about
> this issue.
> For panic, I'm a little curious. Since you deselect ACPI, ACPI
> interpreter should be disabled. So how can you get 'ACPI: Interpreter
> enabled'

Hrm -- that one must have been with ACPI enabled but pci=noacpi.

I can get another one with ACPI deselected (but ACPI_BOOT enabled), if
that would be useful; from what I recall from eyeballing them, though,
I'm fairly sure that the tracebacks are the same.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

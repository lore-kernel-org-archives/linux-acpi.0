From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: SSDT on Sony VAIO
Date: Thu, 16 Jan 2003 20:24:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030116192406.GA2825@brodo.de>
References: <20030116165128.GA13608@bungled.net> <000f01c2bd83$e0c50950$134425db@sayonara>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000f01c2bd83$e0c50950$134425db-F8JvWDuGsZU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Cc: 'Nathan Conrad' <conrad-aYgNHrD+FxfR7s880joybQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Fri, Jan 17, 2003 at 02:22:42AM +0900, Adachi, Kenichi wrote:
> Incidentally I didn't know the existence of CpuFreq project when I made
> the above statement. Dominik, if BIOS tells OS via ACPI _PCT to access
> FFH to initiate FID/VID change (in AMD PowerNow!), how current code
> coordinates it? I'm going to look into code soon, but I'd appreciate
> very much if you give me some insight in advance.

Currently, it fails with this error message. If you add your patch,
frequency transitions will still fail - the ACPI processor driver doesn't
know anything about the PowerNow internals. So loading of teh ACPI cpufreq
driver will be aborted at latest in acpi_cpufreq_init, if not earlier.

So, actually I can't think of any way to use the ACPI processr driver for
CPU frequency transitions in these cases - you need to use the "legacy" 
powernow-k7.c driver instead (which is currently developed by Dave Jones).

	Dominik


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en

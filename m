From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: 2.5.51: sleep broken
Date: Fri, 13 Dec 2002 01:11:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212130111.32710.p_christ@hol.gr>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A591@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A591-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > From: P. Christeas [mailto:p_christ-U04EIuiosng@public.gmane.org]
> >
> > > However, /proc/acpi/sleep has all S0 S1 S2 S3 S4 S5
> > > When I 'echo 1 >/proc/acpi/sleep', nothing happens.
> > > ... It's a procfs bug.
>
> Look for a msg on 11/30 by Pavel Machek. Apparently the proc code got
> broken by the seq_file stuff... supposedly they were going to fix it, but
> maybe it would be easier if we all did.
>
> -		entry->write_proc = acpi_system_write_sleep;
> +		entry->proc_fops->write = acpi_system_write_sleep;
>
> Regards -- Andy

Sorry, I was quite lazy debugging that. Seems though that 20021205 doesn't 
have that. I'll let you know if it should be pushed into 2.5.52..



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

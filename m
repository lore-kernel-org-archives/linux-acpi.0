From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [BK PATCH] ACPI fixes
Date: Sat, 2 Nov 2002 17:52:02 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021102165202.GB1983@elf.ucw.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A49A@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A49A-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> 	bk pull http://linux-acpi.bkbits.net/linux-acpi
> 
> Bug fixes, mostly for bugs introduced recently ;-)

Could you generate diff -u, and mail it to the list? 
								Pavel

> <agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/31 1.844.13.1)
>    ACPI:
>    - Clean up debug-only code
>    - Fix typo
>    - Correct walking of namespace, to prevent disappearance of processor and
>      thermal zone objects
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I *need* thermal managment. (Broken fan on cpu... Without ACPI thermal
managment it is hard to keep it running. With ACPI thermal managment I
still can't watch films, but otherwise its usable).
								Pavel
-- 
When do you have heart between your knees?


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en

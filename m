From: Ionut Georgescu <george-cKfDX2Cm9aJzjjYyZSa4kQ4jNU5vUVPG@public.gmane.org>
Subject: incomplete power off on sony z1rmp
Date: Wed, 31 Mar 2004 23:39:59 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040331213958.GD23349@physik.tu-cottbus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello,

reading the archives I saw that it is common that Sony VAIO laptops
don't shutdown properly. My Z1RMP hangs at
drivers/acpi/hardware/hwsleep.c:338 in  acpi_hw_register_write(), right
after ACPI_FLUSH_CPU_CACHE() .

Is there anything I can do to solve this ? I'd be more than happy to
start dealing with it, but I have no idea about kernel programming. I
can do C, but only for myself :) Is there a recommended way to learn
more about this stuff ?

The kernel is debian patched 2.6.4 + acpi-20040311-2.6.4.diff + swsusp2
+ kdb.

Thanks a lot.
Ionu≈

-- 
***************
* Ionut Georgescu
* http://www.physik.tu-cottbus.de/~george/
* Registered Linux User #244479
*
* "In Windows you can do everything Microsoft wants you to do; in Unix you
*                can do anything the computer is able to do."



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

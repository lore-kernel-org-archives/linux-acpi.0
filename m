From: "Adam J. Richter" <adam-7x81iamSd18S+FvcfC7Uqw@public.gmane.org>
Subject: 2.5.64-bk4: Is CONFIG_ACPI_NUMA for IA64 only?
Date: Sun, 9 Mar 2003 11:51:22 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303091951.LAA02649@adam.yggdrasil.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

	linux-2.5.64-bk4 adds a CONFIG_ACPI_NUMA option, which causes
some code to be compiled in that references acpi_numa_slit_init, which
is apparently only defined for ia64.  For the URL given in the comment
above acpi_numa_slit_init in arch/ia64/kernel/acpi.c, it looks like
the facility may be ia64 specific, but maybe it is just a standard
that originated with ia64 but is not ia64-specific:

/*
 * ACPI 2.0 SLIT (System Locality Information Table)
 * http://devresource.hp.com/devresource/Docs/TechPapers/IA64/slit.pdf
 */
void __init
acpi_numa_slit_init (struct acpi_table_slit *slit)


	Anyhow, I'm not sure if the call to acpi_numa_slit should be
commented out for non-ia64 architectures or if CONFIG_ACPI_NUMA should
be changed to depend on CONFIG_IA64, or if something else should be
done.

Adam J. Richter     __     ______________   575 Oroville Road
adam-7x81iamSd18S+FvcfC7Uqw@public.gmane.org     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com

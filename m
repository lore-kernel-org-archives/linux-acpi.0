From: Manish Prasad <mprasad-EX0cT3Az47bauI2f2gSDlQ@public.gmane.org>
Subject: Battery Status Query
Date: Thu, 15 May 2003 07:30:48 -0400 (EDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GSO.4.53.0305150633560.16641@compserv2>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi

I'm working with a DELL Inspiron 2600, 2.4.20 kernel, acpi patch 20021212.
I need to poll the battery constantly to catch any changes in the remaining
capacity. After a certain number of queries (typically of the order of
32000), the _BST method execution fails.

I don't go through /proc, since earlier I found that the namespace lookup
fails after a while. So I do the lookup once and cache the method_node
within the kernel, which I use to repeat the query. The code breaks after
a certain number of queries spewing out the foll error message:

 psargs-0334: *** Error: Looking up [STAT] in namespace, AE_NOT_FOUND
psparse-1103: *** Error: Method execution failed
[\_SB_.PCI0.LPCB.BAT1._BST] (Node c12eed88), AE_NOT_FOUND

Call stack (after entering the interpreter), AFAIK from the acpi source
code:
acpi_ps_get_next_namepath() - parser/psargs.c
acpi_ps_parse_loop() - parser/psparse.c
acpi_ps_parse_aml() - parser/psparse.c
acpi_psx_execute() - parser/psxface.c

My DSDT : www.cs.sunysb.edu/~mprasad/DSDT

Any pointers on how this could possibly be fixed would be greatly
appreciated. I'm not familiar with the interpreter .... would it be
possible at all to interpret just once and cache the interpreted code for
later execution directly. Also, since my goal is basically to catch
battery state changes as and when they occur, is there a better way to do
that ? The battery state notify interrupt occurs very infrequently,
probably only for changes in charging/discharging state and not for
reserve capacity changes.

Thanks,
--Manish



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

From: =?iso-8859-1?q?J=F6rg=20H=E4nsel?= <joerg.haensel-S0/GAf8tV78@public.gmane.org>
Subject: empty directories under /proc
Date: Sun, 15 Dec 2002 13:15:48 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212151315.48470.joerg.haensel@web.de>
References: <200212142221.15212.hogenberg11@zonnet.nl> <3DFB9888.2050803@gmx.net> <200212151447.06379.hogenberg11@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200212151447.06379.hogenberg11-RSh1/+X/PmFmR6Xm/wNWPw@public.gmane.org>
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

Hello,
I have a IBM R32 notebook and compiled a (clean) 2.4.20 kernel patched wi=
th=20
the acpi patch from 12122002.
When I load the modules ac.o  battery.o  button.o  fan.o  processor.o =20
thermal.o nothing is complaining. But when I look into /proc there is no=20
subdirectory acpi, but subdirs from the ospm modules are directly under /=
proc

1     1359  1647  224  ac_adapter   fb           locks       stat
1285  1361  1655  225  battery      filesystems  meminfo     swaps
1286  1362  1663  226  bus          fs           misc        sys
1292  1364  172   227  button       ide          modules     sysvipc
1317  1372  175   228  cmdline      interrupts   mounts      thermal_zone
1333  1374  193   229  cpuinfo      iomem        mtrr        tty
1336  1378  2     3    devices      ioports      net         uptime
1339  1379  200   4    dma          irq          partitions  version
1341  1382  205   5    dri          kcore        pci
1346  1393  210   6    driver       kmsg         processor
1352  160   213   9    execdomains  ksyms        self
1358  163   219   99   fan          loadavg      slabinfo

When I boot the kernel there is a message:
ACPI: Found ECDT
ACPI: Could not use ECDT

Can this be a reason for the problems.
Is there a Kernel config dependency I have overseen, an option that must =
be=20
enabled for ACPI ?

please help,
Joerg



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

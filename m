From: Christian Vogel <vogel-ohJTLb+lN0D2l3tELKL2klGCwAZxyiatZ+vKCSbpVNE@public.gmane.org>
Subject: linux-2.4.20-ac1-acpi: Is Alan compatible with ACPI?
Date: Fri, 6 Dec 2002 05:30:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021206053054.A26735@skunk.physik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi,

has someone here successfully tested the ACPI patch for 2.4 vanilla
with -ac-kernels? I've tried the patch for 2.4.20-rc?[1] on -ac1
and so far it seems to work quite well but I'm interested if there
are known issues[2] (I don't want to have my fan fail when I'm away
for example...)

        Chris

[1]
  acpi-20021126-2.4.20-rc3.diff.gz from sourceforge

  I had to fix two #includes<> and arch/i386/kernel uses target_cpus()
  which is not here, I did substitute __target_cpus() and defined
  inline int __target_cpus(void){ return 0x01; } when it's not defined
  (depends on CONFIG_MULTIQUAD).

[2]
  I have the following in my syslog:
    ACPI: Embedded Controller [EC0] (gpe 9)
    schedule_task(): keventd has not started
  should I be worried?

-- 
Top ten reasons to procrastinate:
 1.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

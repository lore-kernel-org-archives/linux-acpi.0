From: Ondrej Zary <linux@rainbow-software.org>
Subject: 2.6.31 regression: hangs on Compaq Evo N800c with ACPI enabled - bisected
Date: Mon, 21 Sep 2009 15:03:19 +0200
Message-ID: <200909211503.22661.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756073AbZIUND0@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: venkatesh.pallipadi@intel.com
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hello,
kernel 2.6.31 hangs during boot on Compaq Evo N800c laptop. 2.6.30 works fine.
See https://bugzilla.redhat.com/show_bug.cgi?id=522057

Bisection resulted in commit ee1ca48fae7e575d5e399d4fdcfe0afc1212a64c:

$ git bisect bad
ee1ca48fae7e575d5e399d4fdcfe0afc1212a64c is first bad commit
commit ee1ca48fae7e575d5e399d4fdcfe0afc1212a64c
Author: Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>
Date:   Thu May 21 17:09:10 2009 -0700

    ACPI: Disable ARB_DISABLE on platforms where it is not needed

    ARB_DISABLE is a NOP on all of the recent Intel platforms.

    For such platforms, reduce contention on c3_lock
    by skipping the fake ARB_DISABLE.

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

:040000 040000 f05492fbba2c068f22d7aefca36896f07ff8611b 47e784478de3c386591a92181e7784f5d224a989 M      arch
:040000 040000 a379b031d617def0094cca3f56c2eda510a0604b cc00f83544238d1757fdf2a5e62206d1a49de2de M      drivers

Reverting this commit fixes the regression.

CPU is Mobile Pentium 4-M:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Mobile Intel(R) Pentium(R) 4 - M CPU 2.20GHz
stepping	: 7
cpu MHz		: 2200.000
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe up pebs bts cid
bogomips	: 4395.79
clflush size	: 64
power management:

-- 
Ondrej Zary

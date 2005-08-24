From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.13-rc: ACPI_INTERPRETER=y, PCI=n compile error
Date: Wed, 24 Aug 2005 16:44:11 +0200
Message-ID: <20050824144411.GA4851@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751032AbVHXOoN@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: David Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

I got the following compile error in 2.6.13-rc6-mm2, but it seems to be 
a problem coming from Linus' tree introduced by the
  [ACPI] S3 resume: avoid kmalloc() might_sleep oops symptom
patch:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `acpi_os_allocate':
: undefined reference to `acpi_in_resume'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.13-rc: ACPI_INTERPRETER=y, PCI=n compile error
Date: Wed, 24 Aug 2005 11:13:05 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30046956FE@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751051AbVHXPOY@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>, "Li, Shaohua" <shaohua.li@intel.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


>Subject: 2.6.13-rc: ACPI_INTERPRETER=y, PCI=n compile error
>
>I got the following compile error in 2.6.13-rc6-mm2, but it 
>seems to be 
>a problem coming from Linus' tree introduced by the
>  [ACPI] S3 resume: avoid kmalloc() might_sleep oops symptom
>patch:
>
><--  snip  -->
>
>...
>  LD      .tmp_vmlinux1
>drivers/built-in.o: In function `acpi_os_allocate':
>: undefined reference to `acpi_in_resume'
>make: *** [.tmp_vmlinux1] Error 1
>
><--  snip  -->

Do you have an ACPI-enabled machine that has no PCI?
I'm not aware of any, and would be interested to know
if one exists.

We've had problems with this theoretical build config
for some time:
http://bugzilla.kernel.org/show_bug.cgi?id=1364
because nobody, including me, tests it.

Indeed, one possible fix would be to make CONFIG_ACPI
depend on CONFIG_PCI -- which brings me back to
my origianl question.

-Len

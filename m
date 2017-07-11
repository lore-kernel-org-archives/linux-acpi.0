From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: A question about acpi_early_init(), and want to invoke
 acpi_early_init() earlier
Date: Tue, 11 Jul 2017 21:26:35 +0800
Message-ID: <b94f8c2e-394f-108b-155b-17fb3f9c4772@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:23922 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752619AbdGKN0j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jul 2017 09:26:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi, Rafael

Recently, I worked for unify the interrupt delivery mode and do its 
setup earlier[1]. And I met a bug about ACPI[2].

When I investigated it, I got your commit c4e1acbb35e4 (ACPI / init:
Run acpi_early_init() before timekeeping_init()).  And I reproduced the
problem you said.

Question:
--------

In the changelog of commit:

 > Commit 73f7d1ca3263 (ACPI / init: Run acpi_early_init() before
 > timekeeping_init()) optimistically moved the early ACPI initialization
 > before timekeeping_init(), but that didn't work, because it broke fast
 > TSC calibration for Julian Wollrath on Thinkpad x121e (and most likely

Here, does the fast TSC calibration means *quick_pit_calibrate()* ?

 > for others too).  The reason is that acpi_early_init() enables the SCI
 > and that interferes with the fast TSC calibration mechanism.

I reproduced it by the following command line:
     ...noapic acpi_sci=level...

the original dmesg is:

[    0.000000] tsc: Fast TSC calibration using PIT

the broken dmesg is:

[    0.001000] tsc: PIT calibration matches HPET. 1 loops

Is it right? If it is wrong, please give the right process for
reproducing.

 >
 > Thus follow the original idea to execute acpi_early_init() before
 > efi_enter_virtual_mode() to help the EFI people for now and we can
 > revisit the other problem that commit 73f7d1ca3263 attempted to
 > address in the future (if really necessary).

If the result which I reproduced was right, I think we can do what
the commit 73f7d1ca3263 attempted to do now. And it also can fix the
bug[2].

Because my patchset[1] will setup the interrupt delivery mode earlier
than TSC initialization. So, in Fast TSC calibration, kernel is in its
final interrupt mode, not just PIC mode. The change of trigger type
will never break the Fast TSC calibration(I have tested in my box).


[1] https://lkml.org/lkml/2017/6/30/17
[2] https://lists.gt.net/xen/devel/483350


Thanks,

	dou.




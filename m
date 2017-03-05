From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: fan doesn't work on HP Elitebook 2540p Laptop
Date: Sun, 05 Mar 2017 09:09:25 +0800
Message-ID: <1488676165.2355.5.camel@intel.com>
References: <CAOiveY9H2t_izTyfugw=iJUYSJEL17CLrwhP0icj04BwC6qYfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:30330 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756217AbdCGXYy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Mar 2017 18:24:54 -0500
In-Reply-To: <CAOiveY9H2t_izTyfugw=iJUYSJEL17CLrwhP0icj04BwC6qYfQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vincent Louviaux <vlouviaux@gmail.com>
Cc: linux-acpi@vger.kernel.org

please file a bug report at bugzilla.kernel.org, together with the
acpidump output and dmesg after boot.

On Sat, 2017-03-04 at 11:49 +0100, Vincent Louviaux wrote:
> [1.] One line summary of the problem:
> fan doesn't work on HP Elitebook 2540p Laptop
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1669864
> [2.] Full description of the problem/report:
> The fan is running in the boot until it passes the relay to the linux
> kernel.
> [4.] Kernel version (from /proc/version):
> Linux version 4.10.1-041001-generic (kernel@gomeisa) (gcc version
> 6.2.0 20161005 (Ubuntu 6.2.0-5ubuntu12) ) #201702260735 SMP Sun Feb
> 26
> 12:36:48 UTC 2017

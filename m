From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 0/3] pm: device parallel resume mechanism
Date: Fri, 19 Dec 2008 14:34:08 +0800
Message-ID: <1229668448.562.88.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, "Barnes, Jesse" <jesse.barnes@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

=EF=BB=BFHi, all,

=EF=BB=BFThe resume process can be split into 3 parts, BIOS resume time=
, kernel
resume time and X/application resume time.
And device resume takes most of the kernel resume time.
this patch set introduces a new mechanism to resume device in parallel
which can reduce the device resume time a lot.

In this proposal, some devices can create its own workqueue for
parallel resume. And for all the other devices that depends on this
device, their resume methods are queued in the same workqueue.
And we flush all the workqueues before resuming X/applications.

As the devices vary from different platforms. it's hard to give an exac=
t
number of how much time it can reduce.
Here are some of my test results:
1. eeepc901, kernel resume time can be reduced from about 2.1 seconds t=
o
1.6 seconds.
2. a SantaRosa testbox, kernel resume time can be reduced from about
3.5s to 2s.

please review this patch. Any comments are welcome. :)

thanks,
rui

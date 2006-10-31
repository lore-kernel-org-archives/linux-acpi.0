From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: udev broken by recent ACPI git commits
Date: Wed, 1 Nov 2006 00:04:27 +0100
Message-ID: <200611010004.28483.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59305 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1946124AbWJaXGJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Oct 2006 18:06:09 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Andrew Morton <akpm@osdl.org>

Hi,

One of the following commits out of the git-acpi tree breaks udev on my box
(HPC nx6325 w/ 64-bit SUSE 10.1):

47636d8f011b8e709d4c10c4fbd66e0226380544
88c108e4c156cdf77d551368ecc84280e59d5681
3adafe97513e6e53283002b07f16c8b6666f5699
2d23bd8bec6ce95b20cd175d450943d13c21db1f
55dda781f6788411ed629e205c74f173959ceaf2
ddc4d66d74f18a6695ee0f425a104aa5adc3f7ae

Namely, if I boot the kernel with these patches applied, udev is unable to
create the device special files for /dev/sda and its partitions, so I can't
even mount the root fs.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

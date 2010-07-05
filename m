From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [patch 0/5] iASL patches in Debian
Date: Mon, 05 Jul 2010 09:01:39 +0800
Message-ID: <1278291699.9540.7.camel@minggr.sh.intel.com>
References: <20100704044332.573836359@linux.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35346 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab0GEBBO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 4 Jul 2010 21:01:14 -0400
In-Reply-To: <20100704044332.573836359@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "malattia@linux.it" <malattia@linux.it>, devel@acpica.org
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, 2010-07-04 at 12:43 +0800, malattia@linux.it wrote:
> Hi Robert,
> 
> Here is a series of patches that I've been carrying in the iasl Debian
> package for some time. They are all refreshed and reworked to apply
> cleanly on top of acpica-unix-20100528.
> The series consists a couple of trivial patches to fix building on the
> FreeBSD and Hurd kernel flavours of Debian and some larger ones to enable
> compiling ASL on big endian architectures.
> It would be great if you could apply the patches to your source tree and
> ship new release with this work included.
> Let me know if you want me to run more tests or change something in the
> patches.
> 
> I tested building tests/misc/grammar.asl (plus a number or other DSDTs I
> have here) with the whole set applied and the results were identical on
> BE and LE machines as well as being identical to what a clean iasl
> produces on x86[1].
> You can see build logs for all the architectures supported here:
> https://buildd.debian.org/status/package.php?p=acpica-unix

Hi,

Thanks for the patches.

(linux-acpi@vger.kernel.org is for linux-specific acpi dicussion. Better
to post these patches to ACPICA maillist devel@acpica.org)

I read these patches but not clear what the problem they solved.
Could you add info in the log of each patch?

Thanks,
Lin Ming


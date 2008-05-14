From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI regression test.
Date: Tue, 13 May 2008 20:51:14 -0400
Message-ID: <200805132051.14285.lenb@kernel.org>
References: <1210311086.5227.27.camel@rzhang-crestline.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47355 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757078AbYENAzj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 May 2008 20:55:39 -0400
In-Reply-To: <1210311086.5227.27.camel@rzhang-crestline.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

On Friday 09 May 2008, Zhang Rui wrote:
> Hi, all,
> 
> In order to reduce the ACPI regressions for each release,
> we plan to do an ACPI regression test every time before/after there is
> an import push to linus's tree from len, i.e. before/after ACPI patches
> for Linux-2.6.xx-rc1 are merged.
> 
> As this is the first step, we only do some basic tests for the problems
> which are usually seen in bugzilla and do the tests manually.
> 
> test case 1: Sytem boot. Check if it can boot with no errors.
> test case 2: s3 test. Try suspend to memory 5 times in a row.
> test case 3: cpu p-state c-state. Poke the cpu c/p-state sysfs I/F and
> 	     see if it work well.
> test case 4: battery/ac. Check if the state is update correctly.
> test case 5: fan/thermal. Try to heat the system and see if the
> 	     fan/processor state is changed upon trip point.
> test case 6: video/backlight. For the laptops that follow the ACPI video
> 	     extension, check if hotkey and backlight sysfs I/F is
> 	     working correctly.
> test case 7: Event. Try to trigger AC/Battery/Button/Processor/Thermal
> 	     events and see if they are tiggered/exported to userspace.
> test case 8: shutdown. Check if shutdown works,
> 	     including before and after S3 test.
> 
> If you think something else is worth testing or have question on the
> test result, please let us know, any comments are appreciated.

Do all of these pass with 2.6.25.stable?

How are these test related to ABAT?
http://www.lesswatts.org/projects/acpi/validation.php

Perhaps we should archive the test results on the validation page above?

thanks,
-len

From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI regression test.
Date: Wed, 14 May 2008 11:36:38 +0800
Message-ID: <1210736198.2865.7.camel@rzhang-crestline.sh.intel.com>
References: <1210311086.5227.27.camel@rzhang-crestline.sh.intel.com>
	 <200805132051.14285.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64939 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755549AbYENDft (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 May 2008 23:35:49 -0400
In-Reply-To: <200805132051.14285.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>


On Wed, 2008-05-14 at 08:51 +0800, Len Brown wrote:
> On Friday 09 May 2008, Zhang Rui wrote:
> > Hi, all,
> >
> > In order to reduce the ACPI regressions for each release,
> > we plan to do an ACPI regression test every time before/after there
> is
> > an import push to linus's tree from len, i.e. before/after ACPI
> patches
> > for Linux-2.6.xx-rc1 are merged.
> >
> > As this is the first step, we only do some basic tests for the
> problems
> > which are usually seen in bugzilla and do the tests manually.
> >
> > test case 1: Sytem boot. Check if it can boot with no errors.
> > test case 2: s3 test. Try suspend to memory 5 times in a row.
> > test case 3: cpu p-state c-state. Poke the cpu c/p-state sysfs I/F
> and
> >            see if it work well.
> > test case 4: battery/ac. Check if the state is update correctly.
> > test case 5: fan/thermal. Try to heat the system and see if the
> >            fan/processor state is changed upon trip point.
> > test case 6: video/backlight. For the laptops that follow the ACPI
> video
> >            extension, check if hotkey and backlight sysfs I/F is
> >            working correctly.
> > test case 7: Event. Try to trigger
> AC/Battery/Button/Processor/Thermal
> >            events and see if they are tiggered/exported to
> userspace.
> > test case 8: shutdown. Check if shutdown works,
> >            including before and after S3 test.
> >
> > If you think something else is worth testing or have question on the
> > test result, please let us know, any comments are appreciated.
> 
> Do all of these pass with 2.6.25.stable?
Yes.
The sata problem is a 2.6.26-rc1 regression. And it's fixed in
2.6.26-rc2.

> 
> How are these test related to ABAT?
> http://www.lesswatts.org/projects/acpi/validation.php
We didn't test with ABAT. Will try later.

> 
> Perhaps we should archive the test results on the validation page
> above?
> 
Agree.
The first step is to do the tests by scripts rather than manually. :)
I'll work on this later.

thanks,
rui


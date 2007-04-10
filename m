From: Mattia Dongili <malattia@linux.it>
Subject: Re: [patch 0/9] [RFC] sonypi ACPI reimplementation (resend 3)
Date: Wed, 11 Apr 2007 00:04:23 +0200
Message-ID: <20070410220423.GA4041@inferi.kami.home>
References: <20070409081903.057292676@linux.it> <200704101613.43751.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:50800 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbXDJWFq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Apr 2007 18:05:46 -0400
Content-Disposition: inline
In-Reply-To: <200704101613.43751.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, stelian@popies.net

On Tue, Apr 10, 2007 at 04:13:43PM -0400, Len Brown wrote:
> On Monday 09 April 2007 04:19, malattia@linux.it wrote:
...
> >SONY_LAPTOP_OLD 
> 
> There is probably a better name for this -- like SONY_PI_COMPATIBILITY or something.

ok, will change asap, I have a couple more patches here that I'll send
in soon.

> What about CONFIG_SONYPI? -- should it now depend on this driver not being included?

So, all in all I'd like to obsolete sonypi as soon as possible to get more feedback
but the 2 drivers can still live together for a while.

When you try to load both 2 things can happen:
- if you load sonypi first it will steal part of sony-laptop
  functionalities (the rewrite stuff for the SPIC acpi device)
- if you load sony-laptop first sonypi will bomb out with   
	kobject_add failed for sonypi with -EEXIST
  on misc_register(). sony-laptop also offers a no_spic option to not
  drive the SPIC device.

The only function that sony-laptop doesn't offer is the motion eye
camera stuff, which the meye driver also depend on and which makes
sonypi useful at least for a couple of vaio models.  I can add it to
sony-laptop[1] but I can't test.
I should probably add some printks in sonypi to suggest moving towards
sony-laptop and try to detect if the known ioports are being used by
sony-laptop to better handle the sonypi load failure (see below).

[1]: there are some bits in the patches I submitted but I'll remove them
with the next submission.

> SONYPI depends on !64BIT -- is that invalid, or perhaps you only need the compatibility
> stuff only in 32-bit mode?

it's invalid. I'd rather avoid changing sonypi to work also on 64bit,
for 64bit vaios the new sony-laptop should be good enough.

> applied to acpi-test.

Thanks!

> It would be great if you can get some test feedback for the sonypi-era features
> to make sure that the code moved into the new driver works as well as the old sonypi.

I already asked a couple of users to try it and it seems to work well
for them (and for their purposes). I guess obsoleting sonypi may
increase the reports number ;)

-- 
mattia
:wq!

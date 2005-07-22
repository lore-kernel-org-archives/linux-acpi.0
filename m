From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Linux v2.6.13-rc3
Date: Fri, 22 Jul 2005 01:28:24 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30041F358A@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261832AbVGVFgZ@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@osdl.org>, acpi-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>, "Yu, Luming" <luming.yu@intel.com>, Greg KH <greg@kroah.com>
List-Id: linux-acpi@vger.kernel.org


>Still it would be nice to let people know what to do if they 
>have problems with
>these changes.  Many people don't run -rc kernels and even more people
>don't run -mm, so they have no idea that there are known 
>regressions  ...

I hope the broader exposure will break the EC patch on
another machine (besides your rare Asus) so that we
can figure it out and get it fixed for everybody.

Re: the S3 interrupt resume issue.  We're hoping to fix
the most common drivers before the release ships; and
we'd like to have a method to detect when drivers
do not release their interrupt so that we can at
least have a warning to the user to unload the
offending module until it gets fixed.

thanks for your support,
-Len

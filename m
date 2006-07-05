From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPI 20060623 patches do not apply cleanly to 2.6.17
Date: Wed, 5 Jul 2006 14:06:11 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6E59120@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43965 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S964952AbWGESHO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2006 14:07:14 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@debian.org>, linux-acpi@vger.kernel.org

>The 20060623 patches available at:
>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches
>/release/2.6.17/
>
>Do not apply cleanly on a 2.6.17 mainline tree.  Both bz2 and gz-packed
>patchsets tested.
>
>On top of which tree should they be applied?   20060608 
>applies just fine on top of 2.6.17.

They don't apply because they're already in 2.6.17-git*,
which is where you should go to get the latest upstream.
(or apply -mm to get even later than that)

Linus' upstream tree continues to be named 2.6.17 for the period
after 2.6.18 integration is opened, but before 2.6.18-rc1 is declared.
We go through this naming issue every release.
We asked Linus to change the name in the Makefile during this period,
but he declined.  I'm open to suggestions.

But in any case, these patches are not really for the purpose of
"gee, I'm running old rlease X, so lets look for the latest patch
that is named X-acpi".  These patches are snapshots of the release
and test patches vs. Linus tree of that name on the date the patch
was published.

Back in the bk-days I used to simultaneously publish patches against the
latest stable release and then forward port them.  (eg publish vs 2.6.17
and 2.6.18-dev simultaneously) But git isn't so good at merging, and
there
have been a lot of dependent changes lately, which makes this
impractical.)
So if you want the latest patch in something
other than the latest tree, you need to back-port it.

-Len

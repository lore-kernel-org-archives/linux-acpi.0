From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: State of the ACPI tree
Date: Fri, 5 Sep 2008 09:07:58 +0800
Message-ID: <76780B19A496DC4B80439008DAD7076C01803B89C7@PDSMSX501.ccr.corp.intel.com>
References: <20080904193011.GA23256@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13473 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbYIEBID convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2008 21:08:03 -0400
In-Reply-To: <20080904193011.GA23256@basil.nowhere.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

>
>
>Latest state of the ACPI tree
>
>I have everthing merged up that was on my backlog (sorry for being
>a little slow last week; I was also busy with other projects)
>
>The latest merge with bug fixes to Linus just went out as
>can be seen on the mailing list.
>
>git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6 release-
>2.6.27
>
>Everything else I had pending I merged into the test tree
>targetted for 2.6.28
>
>git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6 test
>
>I don't have anything pending anymore.
>
>The plan is to pass the tree back over to Len Brown on Friday.
>
>If you have any patches submitted to me that you think should
>be in test, but aren't, then please resubmitted them
>to Len.
>
>Some more testing of the test tree would be appreciated. One
>concern is that there's quite a lot of stuff in there that's
>not well tested.
Can you add my dock patches to the test tree please? I already refreshed them per your suggestion.

Thanks,
Shaohua

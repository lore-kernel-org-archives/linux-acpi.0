From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [NAK] Re: [PATCH -v2 9/9] ACPI, APEI, Generic Hardware Error
 Source POLL/IRQ/NMI notification type support
Date: Mon, 25 Oct 2010 10:14:52 -0700
Message-ID: <AANLkTi=2SVT1M+nDZUB7EB05jh+tsuKcew_t66QORrwb@mail.gmail.com>
References: <1287992610-14996-1-git-send-email-ying.huang@intel.com>
	<1287992610-14996-10-git-send-email-ying.huang@intel.com>
	<20101025084553.GA27119@elte.hu>
	<1287997112.2862.322.camel@yhuang-dev>
	<20101025092557.GA11544@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45977 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108Ab0JYROy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 13:14:54 -0400
In-Reply-To: <20101025092557.GA11544@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Borislav Petkov <petkovbb@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@redhat.com>

On Mon, Oct 25, 2010 at 2:25 AM, Ingo Molnar <mingo@elte.hu> wrote:

> drivers/acpi/apei/ overlaps and duplicates drivers/edac/. We dont want two
> facilities, two ABIs, two sets of behavior. erst-dbg even defines a /dev node with
> two ioctls, and a debugfs file to read/write records ...

As mentioned above these 4-letter names from from the ACPI specification. ERST
is perhaps the dumbest name of them all - "Error Record Serialization Table" is
ACPI-speak for platform level non-volatile memory.  This code simply provides
a mechanism for Linux to stash some information in nvram before the system is
reset, and to retrieve it after the reboot.

The naming could be better - but I don't see any overlap with EDAC here.

-Tony

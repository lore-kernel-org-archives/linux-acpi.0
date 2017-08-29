From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH] ACPI / sysfs: Extend ACPI sysfs to provide access to
 boot error region
Date: Tue, 29 Aug 2017 08:55:56 -0700
Message-ID: <20170829155554.fukyxs2x3b5evw37@intel.com>
References: <CAJZ5v0gML6bX2QW65Kv+huJtM4ZUjhw6PC=52hh8NiK-9Uqpzg@mail.gmail.com>
 <20170817213946.16939-1-tony.luck@intel.com>
 <20170818013047.427e38b7@alans-desktop>
 <3908561D78D1C84285E8C5FCA982C28F61349912@ORSMSX114.amr.corp.intel.com>
 <CAGXu5jLXGwbzxMEfbe-aaRos_kxnpnhOuErJx1j2qNwZvZZTag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28697 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751299AbdH2Pz5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Aug 2017 11:55:57 -0400
Content-Disposition: inline
In-Reply-To: <CAGXu5jLXGwbzxMEfbe-aaRos_kxnpnhOuErJx1j2qNwZvZZTag@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kees Cook <keescook@google.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Boris Petkov <bp@suse.de>, Tyler Baicar <tbaicar@codeaurora.org>, Punit Agrawal <punit.agrawal@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Aug 28, 2017 at 05:10:33PM -0700, Kees Cook wrote:
> On Wed, Aug 23, 2017 at 7:56 AM, Luck, Tony <tony.luck@intel.com> wrote:
> >>> Should this not also have a capability check. Assuming file permissions
> >>> are sufficient for grabbing a chunk of system memory holding error
> >>> info doesn't seem too scary but it's at odds with a lot of other cases ?
> >>
> >> At least one of those other cases (pstore) added a capability check and now regret
> >> it.  There's a thread on reverting it. Look for:
> >>
> >>   Revert "pstore: Honor dmesg_restrict sysctl on dmesg dumps"
> >
> > Here's at least part of that thread:
> >
> > https://marc.info/?l=linux-kernel&m=150301241114262&w=2
> >
> > Kees: you were OK with removing the capability check from pstore, right?
> 
> Yeah, as long as there is comparable protections.

File system permission protection is "0400":

	# ls -al /sys/firmware/acpi/tables/data
	total 0
	drwxr-xr-x. 2 root root     0 Aug 28 14:13 .
	drwxr-xr-x. 4 root root     0 Aug 28 14:10 ..
	-r--------. 1 root root 32768 Aug 28 14:13 BERT

-Tony

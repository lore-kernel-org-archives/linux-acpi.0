From: Len Brown <lenb@kernel.org>
Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
Date: Wed, 15 Oct 2008 18:20:37 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810151801290.3026@localhost.localdomain>
References: <1223885404.2735.183.camel@rzhang-dt>
 <4911F71203A09E4D9981D27F9D83085803194DE3@orsmsx503.amr.corp.intel.com>
 <1223947180.2735.228.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172069pub.verizon.net ([206.46.172.69]:50198 "EHLO
	vms172069pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbYJOWUv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Oct 2008 18:20:51 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172069.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8S00BTLWQEXLC0@vms172069.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 15 Oct 2008 17:20:39 -0500 (CDT)
In-reply-to: <1223947180.2735.228.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>


Bob,
note that we already changed acpidump to get the inactive static 
tables.  We did this back when we were running into bugs with "invalid" 
XSDT's and found some machines needed to revert back to using the RSDTs.

Indeed, while I think we nailed some of the major offenders,
But I suspect we still have some bug compatibility detective work 
to do in that area.

So what Rui is doing here in exposing inactive tables it to get
/sys/firmware/acpi/tables to have the equal capability
of the existing acpidump kvm reader.

One potential glitch I see with this is that the current acpidump
puts the table address in the text file, so if there is any confusion
about what tag is at what address, it is easy to refer back to
the ascii acpidump.out file.
when we expose the binary tables in user-space, this information is
no longer present.  dunno if that is important or not.

The other thing Rui is doing is exposing the dynamic tables --
and that is totally new.
We could get at those in the past by looking at the AML,
or more recently, the dmesg, and asking the bug submitter
to run acpidump with parameters to dump magic addresses.
What we'd like to do is automate that so they can just
send us the acpidump output once and that will pull
in the dynamic tables with the static tables.
I think this will be valuable.

Unfortunately, dynamic tables will not be exposed in
cases where we take a path through the AML such that
they're not loaded -- so we'll still need the manual
kvm reader method when that happens.

Also, for the cases where we can't boot in ACPI mode at all,
we'll still need the kvm reader to extract the static
tables then.

> >  will now get both the "active" and "inactive" tables?
> yes.

Rui,
Rather than augmenting the names, such as SSDT_dynamic
and MADT_inactive, maybe it would make more sense to
use the original tags, but put them outside

say, in:
/sys/firmware/acpi/tables/inactive/
/sys/firmware/acpi/tables/dynamic/

what do you think?

> > 2) In the FACS firmware waking vector case, we set the vector in both the "active" FACS and the "inactive" FACS.
> Right.
> > 
> > Again, please note that we have changed the ACPICA interface to set the firmware wake vector - splitting into two.
> hmm, when will this change be shipped to Linux?
> BTW: Rafael has already proposed a patch which always clears 64 bit wake
> vector and uses the 32 bit one.
> http://marc.info/?l=linux-acpi&m=122370808622832&w=2

BTW, Rafael's patch above is staged for 2.6.28.

thanks,
-Len

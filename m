From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [patch 05/10] acpi: use __init* oneverythingintables/tbfadt.c
Date: Tue, 13 May 2008 08:06:49 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B353E60E@orsmsx415.amr.corp.intel.com>
References: <481B7CDA020000780004B921@vpn.id2.novell.com> <9D39833986E69849A2A8E74C1078B6B34FAE8D@orsmsx415.amr.corp.intel.com> <482957DF.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61048 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555AbYEMPGv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 May 2008 11:06:51 -0400
Content-class: urn:content-classes:message
In-Reply-To: <482957DF.76E4.0078.0@novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <jbeulich@novell.com>
Cc: lenb@kernel.org, akpm@linux-foundation.org, trenn@suse.de, linux-acpi@vger.kernel.org

devel@acpica.org



>-----Original Message-----
>From: Jan Beulich [mailto:jbeulich@novell.com]
>Sent: Monday, May 12, 2008 11:57 PM
>To: Moore, Robert
>Cc: lenb@kernel.org; akpm@linux-foundation.org; trenn@suse.de; linux-
>acpi@vger.kernel.org
>Subject: RE: [patch 05/10] acpi: use __init*
oneverythingintables/tbfadt.c
>
>Thanks, Robert! So for future changes like this (if any) I suppose they
>would
>be preferred to be directly against acpica? What mailing list would
they go
>to? Jan
>
>>>> "Moore, Robert" <robert.moore@intel.com> 09.05.08 22:04 >>>
>Jan,
>
>I've integrated your const and macro changes into the acpica source.
>
>Thanks for your help,
>Bob
>
>
>>-----Original Message-----
>>From: Jan Beulich [mailto:jbeulich@novell.com]
>>Sent: Friday, May 02, 2008 12:43 PM
>>To: trenn@suse.de
>>Cc: Moore, Robert; lenb@kernel.org; akpm@linux-foundation.org; linux-
>>acpi@vger.kernel.org
>>Subject: Re: [patch 05/10] acpi: use __init* on
>everythingintables/tbfadt.c
>>
>>>>> Thomas Renninger <trenn@suse.de> 05/01/08 8:55 PM >>>
>>>Andrew, IMO you can drop this and the const cleanups from -mm tree.
>>>
>>>Jan, nearly all code in:
>>>drivers/acpi/*/*.[hc]
>>>is part of ACPICA. This currently still is (may change) an Intel
>>>internal repository which gets synced to several OS implementations,
>>>also Linux. __init does not exist there (yet).
>>
>>I'm fairly sure I saw __init used elsewhere in ACPI CA code, so I
>>didn't think adding mode stuff like this would cause problems (as
>>long as the changes were correct of course).
>>
>>>Also the const changes may be a bit of a pain -> this is what Robert
>>>meant with as long as it won't end in a chain of const cleanups :)
>>
>>Of course they're a pain now. But see below.
>>
>>>The whole code gets style cleaned up through Lindent and manually to
>>>half way fit to the Linux kernel style when things get merged.
>>>
>>>Currently Robert has to readjust this to ACPICA coding style by hand
>>>and merge it into the internal Intel repository. Len has to pick it
up
>>>somewhat later and merge it back to the Linux kernel...
>>>
>>>Therefore I expect for cleanup patches (this one is on the edge, but
I
>>>could understand Intel if they hold it off) the best is to wait until
>>>Intel publishs ACPICA as CVS or whatever repository on their
>>>lesswatts.org site.
>>
>>That's brave to say - I've been seeing this kind of significant
cleanup
>>potential about seven years ago (when I wasn't dealing with ACPI CA
>>on Linux, yet), so I have to admit I find it a little odd (at least)
to
>>defer
>>this even further - the code should have been written const-correct
>>and __init-ready (iirc Windows also has a concept of init code) from
>>the beginning in my opinion. ANyway, the purpose of both patches
>>was to try and get this cleanup started in Linux or at least turn
>>attention to this on the ACPI CA side.
>>
>>Jan


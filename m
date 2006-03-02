From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 12:30:42 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30063F8D66@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:15570 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932255AbWCBRa7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Mar 2006 12:30:59 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Dave Jones <davej@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Mochel, Patrick" <patrick.mochel@intel.com>


>On Thursday 02 March 2006 06:49, Brown, Len wrote:
>
>> I'm afraid that even after we get this stuff out of /proc
>> and into sysfs where it belongs, we'll have to leave 
>/proc/acpi around
>> for a while b/c unfortunately people are under the impression
>> that the path names there actually mean something and
>> they can actually count on them -- which they can't.
>
>But they should. Once you provide an interface here you 
>have to provide it essentially forever. Or at least if you really
>change it use a very long deprecation period, but even that 
>is a bad thing to do to users.

The 4-character strings in the path names (eg "CPU0") are _arbitrary_.
They come _directly_ from the BIOS source code and depend
on whatever mood the BIOS writer was in that day.
For this reason, users _can't_ count on these strings
and these path-names being consistent across platforms.

Yes, this is a horrible design.
Yes, I want to delete it in favor of sysfs as soon as possible,
Patrick has a big patch set in development to get that ball rolling.
Yes, users kick and scream whenever you change something they can see
and thus it takes a long time.

-Len

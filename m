From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 0/2] Deliver ACPI events upon subscription and implement multiple readers for /proc/acpi/event
Date: Wed, 25 Jan 2006 00:09:53 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005D2A09E@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr13.intel.com ([192.55.52.67]:6287 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751015AbWAYFKG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2006 00:10:06 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

 
>On Tuesday 24 January 2006 20:17, Brown, Len wrote:
>> What's the problem with opening a socket to the user-space acpid --
>> the way multiple readers work today?
>>
>
>- one does not want to use current implementation of acpid?

What is better?

>- one does not want to depend on having acpid running before
>  starting snooping acpi events?

For example?

>- because allowing multiple readers is a "right thing to do"?

This is not self-evident, can you give some examples?

The argument against, I suppose, is simply why to add code
to the kernel when the same feature is already working
in user-space?

The other argument against is why enhance an interface when
perhaps we should instead consider replacing it altogether...

>> Dmitry, I don't know how to apply the signed-off thing correctly here,

If Dmitry is the original author, then the proper format is to put

From: Dmitry Torokhov <dtor_core@ameritech.net>

at start of the body of the message where it can over-ride the e-mail author.
This is documented in Documentation/SubmittingPatches.

thanks,
-Len

ps. I'm not trying to be difficult about this, but would like to
give this (recurring) proposal the attention it deserves and either
accept it or reject it once and for all.


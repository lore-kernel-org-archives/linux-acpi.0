From: Thomas Renninger <acpi@renninger.de>
Subject: Re: [PATCH 0/2] Deliver ACPI events upon subscription and      implement
 multiple readers for /proc/acpi/event
Date: Thu, 26 Jan 2006 18:38:20 +0100
Message-ID: <43D9090C.1030306@renninger.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D2A09E@hdsmsx401.amr.corp.intel.com>    <200601250023.01359.dtor_core@ameritech.net> <10537.83.103.117.254.1138182891.squirrel@picard.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:64985 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932376AbWAZRis (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jan 2006 12:38:48 -0500
In-Reply-To: <10537.83.103.117.254.1138182891.squirrel@picard.linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Robert Love <rml@novell.com>, kasievers@suse.de

Mattia Dongili wrote:
> On Wed, January 25, 2006 6:23 am, Dmitry Torokhov said:
>> On Wednesday 25 January 2006 00:09, Brown, Len wrote:
> [...]
 > I have no problem changing the implementation to avoid useless stuff if
> the patch is going to be considered for acceptance.
> 
>>> The other argument against is why enhance an interface when
>>> perhaps we should instead consider replacing it altogether...
> 
> The same thing has been said at Dmitry's submission (08/2004) and
> /proc/acpi/event is still there. :)
> Also, removing /proc/acpi/event will take a very long time.
> Anyway what would you suggest (if you have already some plan)? I'd like to
> try implementing it.

What about the dbus-kernel interface?
Acpi events are probably one of the things that should
make use of this one sooner or later?

However I have no idea in which state dbus is on kernel side.

   Thomas

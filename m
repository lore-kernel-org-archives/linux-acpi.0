From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Tue, 26 Feb 2008 00:03:03 +0100
Message-ID: <47C34927.7030803@dbservice.com>
References: <20080225093914.GB4375@ics.muni.cz> <200802251247.30605.rjw@sisk.pl> <20080225200354.GE16513@khazad-dum.debian.net> <20080225204951.GB4432@ics.muni.cz> <20080225210113.GF16513@khazad-dum.debian.net> <20080225220720.GA4523@ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dbservice.com ([213.239.204.14]:34697 "EHLO
	matterhorn.dbservice.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758791AbYBYXCX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Feb 2008 18:02:23 -0500
In-Reply-To: <20080225220720.GA4523@ics.muni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Lukas Hejtmanek wrote:
> On Mon, Feb 25, 2008 at 06:01:13PM -0300, Henrique de Moraes Holschuh wrote:
>> Not even over the new netlink socket?  Or the thinkpad-acpi input device?
> 
> how can I check this?

A while ago I worked on a new acpi daemon that could receive events from 
both netlink and /dev/input devices. Right now it's more like a testing 
tool then a real replacement for the current acpid. I haven't had time 
to work on it.

http://git.dbservice.com/?p=acpid;a=summary
$ git clone git://dbservice.com/acpid

You'll need dbus and lua to compile it. There's also a readme that 
describes how to get it running and how it works. In its default 
configuration it will print the events into stdout.

tom


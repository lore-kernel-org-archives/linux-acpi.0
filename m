From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 4/5] ACPI: disable SBS by default
Date: Thu, 13 Jul 2006 20:20:53 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6F76DCB@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:27784 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161158AbWGNAZo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jul 2006 20:25:44 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org, linux-acpi@vger.kernel.org, dtor@insightbb.com, dtor@mail.ru


>> >Default is 'n' when omitted...
>> 
>> This default stuff seems to be make-work
>> without any real value.
>> 
>> At one time we had default =m to try to show
>> what a reasonable usable configuration was.
>> These got globally replaced to =y because
>> apparently it is taboo to have default =m.
>> 
>> But =y defaults don't make much sense either,
>> particularly if you use =m like most people do.
>> 
>> The last time we discussed this, Roman suggested
>> deleting all the defaults that require human interaction.
>> 
>> As the concept appears to be meaningless, I'm inclined to agree.
>
>The problem with using defaults is, if something should be 
>enabled, maybe it shouldn't be a config option at all or at least be
hidden.
>In the future this should all be part of an autoconfiguration process, 
>where a base configuration is generated from different sources (e.g. a 
>script which looks at the current kernel or machine specific default 
>config).  The point is that the defaults can depend on a lot of 
>parameters, one of which is the user himself and every user likes
>different defaults. So until we have a better autoconfiguration it's
better to avoid 
>abusing the defaults. The current configuration system is not ready for
aunt Tilly 
>yet, it would be far better to provide useful help texts to 
>allow the user to make reasonable a decision and the majority of the
defaults 
>should come from a different source anyway (the current kernel 
>configuration) and for any new configuration option which can cause a
kernel to be unbootable 
>should maybe not an option.

Lets take a concrete example.

CONFIG_ACPI_BUTTON

It is totally nuts to to to the trouble of includeing CONFIG_ACPI
and not including the few lines of code necessary to handle
your power button.  But at the same time, most people use =m
for this because on a non-ACPI system they want as much out
as possible. so we have

default y
	conflicts with most popular use of =m
default m
	taboo
default n, no no default
	makes no sense, give that we get here only if CONFIG_ACPI...


Seems the choices are to make the default to =m if modules are enabled,
and default to y otherwise, or to simply grow the kernel and
have it hard-wired to y with no choice.

What do you recommend?

thanks,
-Len

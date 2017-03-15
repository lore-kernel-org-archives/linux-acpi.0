From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 00/17] Move firmware specific code to firmware specific locations
Date: Wed, 15 Mar 2017 15:23:41 +0100
Message-ID: <CAJZ5v0i5o+2FksW+NmYQugD6qL-1QmREd2isATifu9n0g69Q+w@mail.gmail.com>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
 <2385585.K4ms5H7miQ@aspire.rjw.lan> <20170315141918.GF10701@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33233 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751642AbdCOOXn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Mar 2017 10:23:43 -0400
In-Reply-To: <20170315141918.GF10701@valkosipuli.retiisi.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Wed, Mar 15, 2017 at 3:19 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> On Mon, Mar 13, 2017 at 11:27:40PM +0100, Rafael J. Wysocki wrote:
>> On Monday, March 06, 2017 05:42:46 PM Sakari Ailus wrote:
>> > Hi,
>> >
>> > This set moves firmware specific implementations of the device / fwnode
>> > property API to locations that are specific to firmware implementation,
>> > still leaving property set (which isn't really firmware) implementation in
>> > drivers/base/property.c.
>> >
>> > The set depends on the ACPI graph support v4 patches I posted a moment
>> > ago.
>> >
>> > The patches may be found with dependencies here:
>> >
>> > <URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph-cleaned>
>> >
>> > since v1:
>> >
>> > - Move the three bugfixes in front of the set into a separate patchset.
>> >   There are no dependencies to those from the rest of the patches.
>> >
>> > - Rebase on current ACPI graph support patches (themselves on PM tree
>> >   4.11-rc1 merge).
>>
>> To me, all material from patches [1-11/17] can easily go into one patch which
>> would also help to review it quite a bit.
>>
>> Analogously, all material in patches [12-16/17] can go into one patch too.
>>
>> The split as is appears quite artificial, honestly.
>
> I believe it's easier to review the way it is. Each patch is simple and it's
> easy to see where a particular piece of code is moved. I'm happy to fold
> them, too, but I'd prefer keep "[PATCH v2 07/17] device property: Read
> strings using string array reading functions" separate, as it changes the
> implementation of reading single strings.
>
> How about that?

That's fine too.

Thanks,
Rafael

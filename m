From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 00/16] ACPI graph support
Date: Tue, 7 Mar 2017 14:23:33 +0100
Message-ID: <CAJZ5v0iNqTb55xrq21Byn5q6XUeFYSa2mMLj+Jnu1_d0DyMvxQ@mail.gmail.com>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com> <20170307074948.GE3220@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33595 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752573AbdCGNYG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2017 08:24:06 -0500
In-Reply-To: <20170307074948.GE3220@valkosipuli.retiisi.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Tue, Mar 7, 2017 at 8:49 AM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> Hi Rafael,
>
> On Mon, Mar 06, 2017 at 04:19:14PM +0200, Sakari Ailus wrote:
>> This set contains patches written by Mika Westerberg and by myself. The
>> patchset brings support for graphs to ACPI. The functionality achieved by
>> these patches is very similar to what the Device tree provides: the port
>> and the endpoint concept are being employed. The patches make use of the
>> _DSD property and data extensions to achieve this. The fwnode interface is
>> extended by graph functionality; this way graph information originating
>> from both OF and ACPI may be accessed using the same interface, without
>> being aware of the underlying firmware interface.
>
> I've tested the patches again on ARM (OF) and x86-64 (ACPI).

OK

> I have V4L2 patches depending on the ACPI graph patchset that I'd like to
> have in during the same merge window. Would you either accept a pull
> request, or could I have a branch on top of v4.11-rc1 containing these
> patches only (for media tree)?
>
> The patchset "Move firmware specific code to firmware specific locations"
> depends on "Fwnode property API fixes for OF, pset". Would you prefer to
> send the bugfixes as fixes to v4.11 or just put it all to v4.12?

I'll put it all into v4.12 if that's not a problem.

Also I don't really have the time to take care of that this week due
to other work.  I'll get to it next week, most likely.

Thanks,
Rafael

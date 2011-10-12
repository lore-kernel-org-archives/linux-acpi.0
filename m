From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFH] Power Management mini-summit during the Kernel Summit 2011
Date: Wed, 12 Oct 2011 22:33:23 +0200
Message-ID: <CAORVsuX_4SzKFZme1343KOtnjoYNTU9L9sC9BYOaS+SqWpXGRA@mail.gmail.com>
References: <201110122211.21638.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33179 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab1JLUdY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Oct 2011 16:33:24 -0400
In-Reply-To: <201110122211.21638.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, mark gross <markgross@thegnar.org>, Greg Kroah-Hartman <gregkh@suse.de>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Len Brown (Intel)" <len.brown@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Arjan van de Ven <arjan@infradead.org>, Tejun Heo <tj@kernel.org>, Kevin Hilman <khilman@ti.com>, Daniel Drake <dsd@laptop.org>, ming.lei@canonical.com, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@sirena.org.uk>, John Stultz <john.stultz@linaro.org>

Hi!

On Wed, Oct 12, 2011 at 10:11 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote=
:
> Hi All,
>
> There was a plan to organize a PM mini-summit during the KS 2011 in P=
rague,
> but then I didn't follow up (which obviously is my fault) and lost tr=
ack of
> things when kernel.org and the KS servers went offline. =A0So, appare=
ntly,
> the KS organizers concluded that the PM mini-summit wasn't going to h=
appen
> after all and didn't add it to the schedule.
>
> Still, it appears to be possible to arrange a room for a PM meeting o=
n
> Sunday, Oct 23, if there are people wanting to attend. =A0So, if you'=
d like
> to take part in such a meeting, please let me know ASAP.
I still do not know if I will be attendind, for various reasons. I
will let you know asap.

>
> The topics I, personally, would like to discuss include:
> - Per-device PM QoS
Since the discussion about the PM QoS user space interface(s) are
still going on I think this needs to be discussed.

I would also add the following items:
- PM QoS throughput constraints. How to handle a complex clock tree?
What should the API (kernel, user) look like?
- SmartReflex driver conversion. The current OMAP-only implementation
needs to be converted to a generic driver, possibly in drivers/power.

> - Propagation of wakeup events to user space vs system suspend
> - Possibility of representing dependencies between devices through
> =A0"device links" (i.e. objects representing master-slave links betwe=
en
> =A0devices)
> - Idea of common "platform" bus type that may cover ACPI devices (lik=
e
> =A0battery, fans etc.), PNP devices and current platform devices in a
> =A0consistent way
> - Freezer improvements
>
> Thanks,
> Rafael
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

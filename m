From: Daniel Drake <dsd@laptop.org>
Subject: Re: [RFH] Power Management mini-summit during the Kernel Summit 2011
Date: Thu, 13 Oct 2011 15:55:05 +0100
Message-ID: <CAMLZHHTpZvJVWwqTxsNH1Gqx0111xXnr_Y6sp9xKL01wMO1oiw@mail.gmail.com>
References: <201110122211.21638.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49282 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339Ab1JMOzG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Oct 2011 10:55:06 -0400
In-Reply-To: <201110122211.21638.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, mark gross <markgross@thegnar.org>, Greg Kroah-Hartman <gregkh@suse.de>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Len Brown (Intel)" <len.brown@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Arjan van de Ven <arjan@infradead.org>, Tejun Heo <tj@kernel.org>, jean.pihet@newoldbits.com, Kevin Hilman <khilman@ti.com>, ming.lei@canonical.com, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@sirena.org.uk>, John Stultz <john.stultz@linaro.org>, Chris Ball <cjb@laptop.org>

On Wed, Oct 12, 2011 at 9:11 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
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

Sorry - I won't be at the event, otherwise I'd definitely attend.
However, I think my colleague Chris Ball will be there, so I have CC'd
him. He has a long history of power management work at OLPC.

Anyway, I think you have an understanding of the issues facing OLPC's
power management model at the moment. We'd like to move to your wakeup
events architecture and really nail our opportunistic suspend model,
but upstreaming the support needed at the architectural level has been
a challenge that I've been working on for over a year, and still isn't
done. I think I see some influence of our remaining issues in the list
of topics you wrote below, so that's great.

> The topics I, personally, would like to discuss include:
> - Per-device PM QoS
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

cheers,
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

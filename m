From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [RFC PATCH v3 1/5] ACPI: button: Add indication of BIOS
 notification and faked events
Date: Mon, 29 May 2017 18:04:00 +0200
Message-ID: <20170529160400.GA28287@mail.corp.redhat.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
 <f3109abbd3294b63a00437e5d86d13caee84320b.1495804411.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbdE2QEI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 May 2017 12:04:08 -0400
Content-Disposition: inline
In-Reply-To: <f3109abbd3294b63a00437e5d86d13caee84320b.1495804411.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, systemd-devel@lists.freedesktop.org, Peter Hutterer <peter.hutterer@who-t.net>

Hi Lv,

On May 27 2017 or thereabouts, Lv Zheng wrote:
> This patch adds a parameter to acpi_lid_notify_state() so that it can act
> differently against BIOS notification and kernel faked events.
> 
> Cc: <systemd-devel@lists.freedesktop.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Peter Hutterer <peter.hutterer@who-t.net>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---

Answering to this one for the entire series:
last week was a mix of public holidays and PTO from me. I was only
able to review this series today, so sorry for the delay.

I still have a feeling this driver is far too engineered for a simple
input node. There are internal states, defers, mangle of events and too
many kernel parameters.

I still need to get my head around it, but the more I think of it, the
more I think the solution provided by Lennart in
https://github.com/systemd/systemd/issues/2807 is the simplest one:
when we are not sure about the state of the LID switch because _LID
might be wrong, we shouldn't export a LID input node.
Which means that all broken cases would be fixed by just a quirk
"unreliable lid switch".

Give me a day or two to get this in a better shape.

Cheers,
Benjamin


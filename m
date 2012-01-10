From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: 3.1 Panic on power event
Date: Tue, 10 Jan 2012 16:12:36 -0700
Message-ID: <CAErSpo49rG6GFgXk+4JOsBr20QpOOrPGYZhyVsCcYVvuGCY6KA@mail.gmail.com>
References: <20120110165850.GA3015@zod.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56507 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756901Ab2AJXM6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Jan 2012 18:12:58 -0500
Received: by lahd3 with SMTP id d3so60592lah.19
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jan 2012 15:12:57 -0800 (PST)
In-Reply-To: <20120110165850.GA3015@zod.bos.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Josh Boyer <jwboyer@redhat.com>
Cc: linux-acpi@vger.kernel.org, kernel-team@fedoraproject.org, Zhang Rui <rui.zhang@intel.com>, Mark Langsdorf <mark.langsdorf@amd.com>

On Tue, Jan 10, 2012 at 9:59 AM, Josh Boyer <jwboyer@redhat.com> wrote:
> We've had a report [1] from a user that the 3.1.6 kernel panics if th=
ey
> plug or unplug their machine. =A0The oops seems to come from an issue
> somewhere in the acpi notification stack. =A0The relevant backtrace
> functions are (transcribed from a jpeg):
>
> acpi_ac_notify
> acpi_device_notify
> acpi_ev_notify_dispatch
> acpi_os_execute_deferred

Images 1 & 2 from the bugzilla also show kobject_uevent(), so my guess
is the problem is in the ACPI ac driver, e.g., maybe
ac->charger.dev->kobj isn't being initialized correctly, so we blow up
when acpi_ac_notify() calls kobject_uevent().  Added cc: for recent ac
changes.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

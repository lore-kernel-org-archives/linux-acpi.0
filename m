From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Fri, 28 Jul 2006 01:56:03 +0300
Message-ID: <41840b750607271556n1901af3by2e4d046d68abcb94@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <20060727221632.GE3797@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:7413 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751409AbWG0W4F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jul 2006 18:56:05 -0400
Received: by ug-out-1314.google.com with SMTP id m3so519127ugc
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jul 2006 15:56:03 -0700 (PDT)
In-Reply-To: <20060727221632.GE3797@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org, Greg KH <greg@kroah.com>

On 7/28/06, Pavel Machek <pavel@suse.cz> wrote:

> Event interface suits PC world where BIOS already does the
> polling...

The BIOS does polling only for its internal tasks. It doesn't generate
events when readouts change unless something important happened. So if
you want readouts you need to poll the SMBIOS or hardware, like on the
Zaurus.


> + perhaps it would not need explicit maintainer, just assign names
>         carefully

We also need to decide on clear convention about units. Are they in
the output and/or filename? Filename is best, I think, since it's
impossible to miss and works nicely for input attributes too.


> - does not suit PC-style batteries which trigger events when data
>         change (can be fixed by /sys/XXX/anything-new, which gives one
>         byte when something changes)

Changed since last poll? That doesn't work with multiple clients.
Changed for the last X seconds? That requires everybody to poll that
frequenty, and risks missing events due to system load.

Wild thought: how about adding a generic "event source" mechanism into
sysfs, at the same level as attributes? Maybe even make them textual,
in keeping with sysfs philosophy:

while read TYPE PARAM  < /sys/class/battery/BAT0/criticl_events; do
  echo "battery 0 generated ctitical event $TYPE with parameters $PARAM"
done

The simpler solution is to convert events into state (e.g.,
critical=0/1) and present them as normal attributes which userspace
can poll, as Greg KH suggested (did I get that right?). I'm not sure
it's always easy, e.g., does ACPI genereate an explicit
no-longer-critical event?


> - you are not getting atomic snapshot of battery state. For example
>         you could read battery status okay, voltage 9.5V; while real
>         states were (okay, 10.5V), (critical, 9.5V) and update
>         happened between you reading status and voltage. (Is it
>         problem?)

I can't think of a realistic scenario where it's a problem. The latest
readout is always the best one to look at.


> - hard to handle obscure features
>         (do_not_charge_battery_for_X_minutes)

So where does that go in the /dev scheme?


  Shem

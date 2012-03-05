From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [3.0? -> 3.1.6 regression] Inspiron 1090: Panic on power event
 (Doubled AC adapter)
Date: Sun, 4 Mar 2012 19:11:21 -0600
Message-ID: <20120305011120.GA29786@burratino>
References: <20120110165850.GA3015@zod.bos.redhat.com>
 <CAErSpo49rG6GFgXk+4JOsBr20QpOOrPGYZhyVsCcYVvuGCY6KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50867 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260Ab2CEBLc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Mar 2012 20:11:32 -0500
Received: by mail-iy0-f174.google.com with SMTP id z16so4890651iag.19
        for <linux-acpi@vger.kernel.org>; Sun, 04 Mar 2012 17:11:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAErSpo49rG6GFgXk+4JOsBr20QpOOrPGYZhyVsCcYVvuGCY6KA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Josh Boyer <jwboyer@redhat.com>, linux-acpi@vger.kernel.org, kernel-team@fedoraproject.org, Zhang Rui <rui.zhang@intel.com>, Mark Langsdorf <mark.langsdorf@amd.com>, Giovanni Biscuolo <g@xelera.eu>

Hi ACPI folks,

Bjorn Helgaas wrote:
> On Tue, Jan 10, 2012 at 9:59 AM, Josh Boyer <jwboyer@redhat.com> wrot=
e:

>> We've had a report [1] from a user that the 3.1.6 kernel panics if t=
hey
>> plug or unplug their machine. =C2=A0The oops seems to come from an i=
ssue
>> somewhere in the acpi notification stack. =C2=A0The relevant backtra=
ce
>> functions are (transcribed from a jpeg):
>>
>> acpi_ac_notify
>> acpi_device_notify
>> acpi_ev_notify_dispatch
>> acpi_os_execute_deferred
>
> Images 1 & 2 from the bugzilla also show kobject_uevent(), so my gues=
s
> is the problem is in the ACPI ac driver, e.g., maybe
> ac->charger.dev->kobj isn't being initialized correctly, so we blow u=
p
> when acpi_ac_notify() calls kobject_uevent().  Added cc: for recent a=
c
> changes.
[...]
>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D772730

More reports:

 https://bugzilla.kernel.org/show_bug.cgi?id=3D38782 (includes DSDT fix=
)
 http://bugs.debian.org/661995
 https://bugs.launchpad.net/ubuntu/+source/linux/+bug/414541

Dell doesn't take emailed reports re the Inspiron 1090 BIOS so
Giovanni Biscuolo (cc-ed) reported it to

 http://en.community.dell.com/support-forums/laptop/f/3518/t/19439525.a=
spx

I wonder:

 - could Linux diagnose the duplicate ACAD in a more helpful way?
 - is it possible to work around, for example by letting the last AC
   adaptor win on the Inspiron 1090?
 - what does Windows do?

Hope that helps,
Jonathan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

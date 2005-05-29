From: Len Brown <len.brown@intel.com>
Subject: Re: ACPI fan problems on HP pavilion desktop
Date: Sun, 29 May 2005 08:45:17 -0400
Message-ID: <20050529124517.GA25934@toshiba.hsd1.ma.comcast.net>
References: <4298CC82.9010901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261261AbVE2MkW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4298CC82.9010901@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keenan Pepper <keenanpepper@gmail.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Sat, May 28, 2005 at 03:54:42PM -0400, Keenan Pepper wrote:
> I'm trying to set up cpu clock modulation and ACPI fan support on my HP 
> pavilion  a302x, so it runs quieter when it's not doing anything
> (the fan is pretty loud).
> The cpufreq driver works great, but the ACPI fan driver not so good:
> it can turn the fan off but not back on again.
> 
> I changed these lines in drivers/acpi/power.c:
> 
> -       if (resource->state != ACPI_POWER_RESOURCE_STATE_OFF)
> -               return_VALUE(-ENOEXEC);
> +       if (resource->state != ACPI_POWER_RESOURCE_STATE_OFF) {
> +               ACPI_DEBUG_PRINT((ACPI_DB_WARN,
> +                       "Device [%s] says it's still on", resource->name));
> +               resource->state = ACPI_POWER_RESOURCE_STATE_OFF;
> +       }
> 
> and now I can turn the fan off and on again, so it works for me,
> but I want to figure out what's actually wrong so other people trying to
> run linux on this machine can have it Just Work(tm) for them.
> Is it just buggy hardware that
> doesn't comply with the ACPI spec? If so, is there some place where all the
> workarounds for hardware quirks are collected?

This does look like a platform BIOS bug, but
that doesn't mean Linux shouldn't be able to
handle it.

Apparently the initial _OFF disabled the fan,
but the platform did not update _STA 
to say so.
The subsequent acpi_power_on() sees this state
is still on and bails out with
"Resource [%s] already on"...

But it would be good to examine the ASL before
leaping to conclusions.  Please open a bug here
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
Component: Power-fan

and attach the output from acpidmp, available in /usr/sbin
or in pmtools here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

Also, it will be interesting to see the console output
when you enable debugging for this component
and tickle the fan:

# echo 0x00800000 > /proc/acpi/debug_layer
# echo 0xFFFFFFFF > /proc/acpi/debug_level

in case there an anything unexpected in the debug output.

We found an analogous issue with PCI Interrupt Link Devices
a while ago where Linux checked what it did actually took effect.
However, some platforms never updated _STA -- presumably
because a popular proprietary OS never checked it.
We ended up changing Linux to ignore that the spec
said the platform should do and instead be bug compatible
with "common industry practice".  Wasn't worth
bothering with a platform specific quirk.

Likely we should always let requests to _ON and _OFF
proceed, not matter what current state -- even if
we think it would be redundant.
The question then becomes if we should then update
resource->state and device->power.sate based
on what _STA returns, or based on what we just ran.
(like you did above in the _OFF case)

thanks,
-Len

ps. please include acpi-devel@lists.sourceforge.net on 
this type of topic.

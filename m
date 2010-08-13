From: Ike Panhc <ike.pan@canonical.com>
Subject: Re: [PATCH] ideapad-laptop: add new driver
Date: Fri, 13 Aug 2010 17:27:23 +0800
Message-ID: <4C650FFB.7090602@canonical.com>
References: <1281672482-10909-1-git-send-email-ike.pan@canonical.com> <1281690893.23680.475.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1281690893.23680.475.camel@localhost>
Sender: platform-driver-x86-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>, Corentin Chary <corentincj@iksaif.net>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 08/13/2010 05:14 PM, David Woodhouse wrote:
> 
> Hm, interesting. What model (and BIOS version) are you testing with?
I have two machine, B550 and S10-3, the BIOS date/version of S10-3 is the
same with you.

> 
> On my S10-3, (DMI BIOS version 2ACN23WW, date 03/12/2010), I get these
> keys through the normal keyboard controller -- and we can tell the
> brightness up/down apart, too.
> 
> http://git.kernel.org/?p=linux/hotplug/udev.git;a=commitdiff;h=9cd075e3
> 
> Do you see those keycodes too... and do they *stop* arriving through the
> keyboard controller when you load your driver?
> 
Yes, IIRC EC will send i8042 keycode when you booting with QS button, not
with power button. atkbd.c reports unknown key after booting with QS button.

From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] ideapad-laptop: add new driver
Date: Fri, 13 Aug 2010 10:34:38 +0100
Message-ID: <1281692078.23680.487.camel@localhost>
References: <1281672482-10909-1-git-send-email-ike.pan@canonical.com>
	 <1281690893.23680.475.camel@localhost>  <4C650FFB.7090602@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4C650FFB.7090602@canonical.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Ike Panhc <ike.pan@canonical.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>, Corentin Chary <corentincj@iksaif.net>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2010-08-13 at 17:27 +0800, Ike Panhc wrote:
> Yes, IIRC EC will send i8042 keycode when you booting with QS button, not
> with power button. atkbd.c reports unknown key after booting with QS button. 

That's interesting. I don't *ever* boot with the QS button; I get the
keycodes when I boot normally. I tried the QS button precisely once, but
only *after* I blew away the original contents of the hard drive with my
MeeGo installation, so it didn't boot.

Do you know how to restore it? Or do you have a copy of the 'lenovo-ec'
module that it apparently contains?

I did keep the Windows restore partition, just in case I needed to go
back to it to get wireless working. But when I tried to recover, it told
me it didn't like my partition table -- so I fixed that and next time I
booted into the OS recovery, it just dumped me at a command prompt and
didn't even manage to start the graphical recovery tool.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

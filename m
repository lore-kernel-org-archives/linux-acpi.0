From: bert hubert <ahu-yMKkj5jtC+M@public.gmane.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Date: Mon, 3 Mar 2003 12:31:53 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030303113153.GA18563@outpost.ds9a.nl>
References: <20030226211347.GA14903@elf.ucw.cz> <20030302133138.GA27031@outpost.ds9a.nl> <1046630641.3610.13.camel@laptop-linux.cunninghams> <20030302202118.GA2201@outpost.ds9a.nl> <20030303003940.GA13036@k3.hellgate.ch> <1046657290.8668.33.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1046657290.8668.33.camel-udXHSmD1qAz9bBlWBkG5g4WQyAnV0byH@public.gmane.org>
To: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Cc: Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 03, 2003 at 03:08:11PM +1300, Nigel Cunningham wrote:

> > The only thing that came up at the time was a suggestion to replace BUG_ON
> > with while (which I didn't try because I'd like to keep my data).
> 
> I'll see if I can find a solution.

A data point may be that at one point, swsusp did work just fine for me.
This was around 2.5.53, 2.5.54:

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&threadm=20021227142032.GA6945%40outpost.ds9a.nl&rnum=1&prev=/groups%3Fq%3Dswsusp%2Bbert%2Bhubert%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3DUTF-8%26selm%3D20021227142032.GA6945%2540outpost.ds9a.nl%26rnum%3D1

I now use gcc 3.2.2 for compiling though. I've tried suspending a few times
with 2.5.63bk5 and I get the BUG every time, so it appears to be
deterministic and not racey.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting

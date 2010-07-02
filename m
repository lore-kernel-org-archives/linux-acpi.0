From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/6] X86 platform drivers: Remove EC dump from
 thinkpad_acpi
Date: Fri, 2 Jul 2010 12:58:52 -0300
Message-ID: <20100702155852.GA11697@khazad-dum.debian.net>
References: <1277996570-2686-1-git-send-email-trenn@suse.de>
 <20100701162741.GC4789@khazad-dum.debian.net>
 <201007012131.20031.trenn@suse.de>
 <201007021114.00982.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201007021114.00982.trenn@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, astarikovskiy@suse.de, ibm-acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Fri, 02 Jul 2010, Thomas Renninger wrote:
> On Thursday 01 July 2010 21:31:18 Thomas Renninger wrote:
> > On Thursday 01 July 2010 06:27:41 pm Henrique de Moraes Holschuh wrote:
> > > On Thu, 01 Jul 2010, Thomas Renninger wrote:
> > ...
> > > I'd prefer if the above text gets replaced by something that adds a pointer
> > > to the new facility, instead of being just outright removed.  Also, the
> > > text about how to use the facility to detect tachometers and thermometers
> > > should be retained, if at all possible.
> > I agree. I'll repost this one in some days.
> Hmm, I take that back.
> This still should get removed completely from:
> Documentation/laptops/thinkpad-acpi.txt
> 
> These problems apply to all laptops and instead of adding pointers to all
> Documentation/laptop/${vendor} files,
> a separate file should be added. This should then be more about thermal
> management problems in general and pointers to:
> Documentation/acpi/ec_sysfs
> and
> Documentation/acpi/debug.txt
> Documentation/acpi/*
> added there looks like the appropriate solution to me.

And a pointer to the new docs added to thinkpad-acpi.txt in place of the
text you're removing, please.

> If people agree:
>   - This patch is still fine and should get applied as it is
>   - I will send another patch adding some more documentation
>     in some days

I'm ok with this, as long as you add a pointer in thinkpad-acpi.txt to the
new docs in the future documentation patch.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

From: Alex Williamson <alex.williamson@hp.com>
Subject: Re: [PATCH/RFC] exposing ACPI objects in sysfs
Date: Tue, 21 Sep 2004 12:00:14 -0600
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1095789614.24751.31.camel@tdi>
References: <1095716476.5360.61.camel@tdi>
	 <20040921122428.GB2383@elf.ucw.cz> <1095785315.6307.6.camel@tdi>
	 <20040921172625.GA30425@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267903AbUIUR7x@vger.kernel.org>
In-Reply-To: <20040921172625.GA30425@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: acpi-devel <acpi-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-09-21 at 19:26 +0200, Pavel Machek wrote:
> > +   Commands are issued by writing the following data structure to the ACPI
> > +object file:
> > +
> > +struct special_cmd {
> > +        u32                     magic;
> > +        unsigned int            cmd;
> > +        char                    *args;
> > +};
> 
> Talk to Andi Kleen; passing such structures using read/write is evil,
> because (unlike ioctl) there's no place to put 32/64bit
> translation. Imagine i386 application running on x86-64 system.
> 

   Yes, good point.  I had prototyped an ioctl interface (google
"dev_acpi").  In some ways it was more powerful, and the ioctl solved
this particular issue.  However, the data structures passed around on
read still use the data sizes as defined by the kernel.  I intended the
VERSION interface to help address this issue by returning an acpi_object
size buffer.  On an LP64 system, this is 24 bytes, on an ILP32 system,
it's 16.  Unfortunately, the ioctl interface also moved the
implementation out of sysfs and wasted the perfectly good directory
hierarchy already available there.

   So, I think the library wrapper will need to deal with the 32/64 bit
problem or we'll have to translate data structures to strictly defined
sizes.  Any other thoughts on how this could be done?  I'm concerned
about alignment issues too, so this is definitely an area that could use
some work.

> > +   NOTE: ACPI methods have a purpose.  Randomly calling methods without
> > +knowing their side-effects will undoubtedly cause problems.  ACPI objects
> > +like _HID, _CID, _ADR, _SUN, _UID, _STA, _BBN should always be safe to
> > +evaluate.  These simply return data about the object.  Methods like
> > +_ON_, _OFF_, _S5_, etc... are meant to cause a change in the system and
> > +can cause problems.  The ACPI sysfs module makes an attempt to hide some
> > +of the more dangerous interfaces, but it not fool-proof.  DO NOT randomly
> > +read files in the ACPI namespace unless you know what they do.
> 
> Hmm, reading file causing side-effects is not nice, either. I can see
> some backup tools doing that by mistake. Heh, even I might want to
> backup my system with tar, and it should not screw my system too badly
> if I forgot --exclude /sys...

   We could move the side-effect to the write operation, but that feels
far less intuitive and makes it more difficult to handle multiple write
operations.  Others have strong opinions one way or the other?  I know
Willy had the same opinion at one point (make the operation occur on the
write), I'm not sure if I've convinced him otherwise.

> Perhaps ioctl is really right thing to use here? read() should not
> have side effects and it solves 32/64 bit problem.

   If it solved the entire 32/64 bit problem, an ioctl would probably be
the right choice.  But it doesn't AFAICT.  I also like how this
implementation fits into the existing ACPI sysfs tree and that you can
get useful info simply by cat'ing a file.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

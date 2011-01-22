From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Occasional (too common) suspend problem
Date: Sat, 22 Jan 2011 11:10:17 +0100
Message-ID: <201101221110.17786.rjw@sisk.pl>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com> <AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com> <AANLkTikv55eQfNaCGLm-2pA3Ndyi9ZEzb4xn64D3u0ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41816 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605Ab1AVKKt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Jan 2011 05:10:49 -0500
In-Reply-To: <AANLkTikv55eQfNaCGLm-2pA3Ndyi9ZEzb4xn64D3u0ww@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Saturday, January 22, 2011, Linus Torvalds wrote:
> On Fri, Jan 21, 2011 at 4:23 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Or - and perhaps more likely - it's connected to the lid event, and
> > how that interacts with user space and then eventually triggers the
> > sleep event (which is quite likely - as mentioned, I think I've only
> > ever seen the problem when I'm physically at the machine).
> 
> .. but with the 'test' suspend (echo core ..), the lid event is all
> good too. And going back to non-testing (echo none ..), it works too.
> 
> Which really does seem to get me back to the whole "if it fails, it
> seems to fail on the first suspend" thing. Don't ask me why. I have no
> idea. But I just suspended that machine 100+ times using the test
> thing (60 times at the gdm prompt, 60 times while logged in and with
> glxgears running to verify dri/thermal interfaces), and then a couple
> of times with the lid, and it all worked.
> 
> But I bet that if I rebooted the machine a few times, it would
> eventually fail on the first suspend.
> 
> Some initialization issue, perhaps?

Very likely.

I have a theory, which is that on failing runs your system doesn't even try
to enter S3 and it's trying to enter a bogus S1 instead.

The reason why I think so is that the "Back to C!" message is not present in
the failing log and there's nothing in particular that can really fail in
acpi_enter_sleep_state() (I don't really expect register writes or reads to
fail, which is about the only thing that might cause this function to return
an error code).  Moreover, I'd expect the system to come back from S1 after a
key press.

A couple of things may be done to verify this.  First, before suspending for
the first time after a reboot, you can check if there's "standby" in
/sys/power/state (it shouldn't be there, because your "good" dmesg says S1
isn't supported).  Second, after a failing run that was revived by a key press
you can check if there's S1 instead of S3 in the "ACPI: Preparing to enter
system sleep state ..." message.  Finally, which I suspect is the case, it is
possible that we don't even try to enter S1, but something confuses the BIOS
which thinks it should go into S1 although it's told to go into S3.

Now, if the BIOS is confused, I have no idea what may be the reason, but I
think it would be good to rule out the change from ioremap() to
ioremap_cache() in ACPI (as I said before, it's sufficient to modify
include/linux/acpi_io.h for this purpose so that ioremap() is called by
acpi_os_ioremap() - unless you have done that already in which case sorry for
the noise).

Rafael

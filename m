From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and hibernation
 callbacks (rev. 8)
Date: Mon, 14 Apr 2008 10:49:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804141043001.2236-100000@iolanthe.rowland.org>
References: <1208143380.6958.105.camel@pasglop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758579AbYDNOt6@vger.kernel.org>
In-Reply-To: <1208143380.6958.105.camel@pasglop>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oliver@neukum.org>, Nigel Cunningham <ncunningham@crca.org.au>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 14 Apr 2008, Benjamin Herrenschmidt wrote:

> 
> > To avoid breaking things (from the functional point of view) unnecessarily.
> > 
> > In short, I don't really see the difference between moving ->prepare() before
> > the freezer and droppig the freezer, which I'm not going to do right now.
> 
> I believe the use of prepare for things like request_firmware etc... is
> worth the effort of fixing the known breakage of not having the freezer
> while preventing insertion of new devices (mostly USB).

I used USB as an example simply because that's what I'm familiar with.  
Don't be so quick to assume the rest of the kernel is trouble-free.

> In fact, it
> won't be such a big issue as the core should/will return an error from
> attempting to add the device in that case.

But it _would_ be a regression -- and everyone knows how much Linus and 
Andrew dislike regressions.  :-)

Now, I don't see what the big deal is here.  We all agree that it would 
be nice and appropriate if drivers could do things like 
request_firmware() during prepare().  But for the moment they can't.  
It's not like this is some tremendous hardship -- you aren't going to 
have to rip out all the existing prepare() implementations and rewrite 
them, because they don't exist yet!

All it means is that the full conversion to the new interface will be a 
multi-step process.  Right now we add the new callbacks.  Later on we 
make it safe to move the freezer after prepare.  Later still we 
eliminate the freezer altogether from suspend.  (Hibernation is a 
separate matter...)

Alan Stern

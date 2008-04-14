From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 22:56:01 +0200
Message-ID: <200804142256.03514.rjw@sisk.pl>
References: <200804040111.15255.rjw@sisk.pl> <20080414105522.GA4716@ucw.cz> <1208205952.6958.174.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761999AbYDNU42@vger.kernel.org>
In-Reply-To: <1208205952.6958.174.camel@pasglop>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>, Nigel Cunningham <ncunningham@crca.org.au>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Monday, 14 of April 2008, Benjamin Herrenschmidt wrote:
> 
> On Mon, 2008-04-14 at 12:55 +0200, Pavel Machek wrote:
> > On Mon 2008-04-14 08:47:02, Benjamin Herrenschmidt wrote:
> > > 
> > > > Well, I'm not sure and I'm not going to introduce the change right now, after
> > > > the paches have been included in -mm.
> > > > 
> > > > That would require quite some changes in the core code that I'd prefer to
> > > > avoid for now.  We can do something like this in a separate patch series after
> > > > the present one settles down a bit.
> > > 
> > > I disagree.
> > > 
> > > Doing it later would introduce yet another major semantic change.
> > 
> > 'allow load_firmware from prepare that was not allowed before' is not 'major'.
> 
> Having user space fully operating is major.

Please tell me what exactly is wrong with doing things that depend on the
user space being available from notifiers.

Thanks,
Rafael

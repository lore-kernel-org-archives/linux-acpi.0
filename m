From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] acpi ec_sys: Export fields of all regions from the EC to debugfs readable
Date: Sun, 1 Aug 2010 02:36:29 +0200
Message-ID: <201008010236.30739.trenn@suse.de>
References: <1280504824-8134-1-git-send-email-trenn@suse.de> <20100730163053.bff43f26.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20100730163053.bff43f26.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mjg59@srcf.ucam.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de
List-Id: linux-acpi@vger.kernel.org

On Saturday 31 July 2010 01:30:53 am Andrew Morton wrote:
> On Fri, 30 Jul 2010 17:47:04 +0200
>
> Thomas Renninger <trenn@suse.de> wrote:
> > -static int acpi_ec_open_io(struct inode *i, struct file *f)
> > +static int acpi_ec_open(struct inode *i, struct file *f)
> >  {
> >  	f->private_data = i->i_private;
> > +	if (mutex_trylock(&ec_fs_lock))
> > +		return 0;
> > +	else
> > +		return -EBUSY;
> > +}
>
> Well that sucks - a userspace interface which is _designed_ to randomly
> and rarely fail?

> An application tries to open the thing and gets -EBUSY, what's it
> supposed to do?  Sleep and try again?  Crash and dump core?
This is  a debug interface nobody should rely on or use in real applications.
There should only exist one app which dumps the EC or write modify single
bytes/fields and this one shouldn't be called twice in parallel.
My idea was: if someone accesses this file simultaneously, something is
wrong in userspace and it's even safer...

On the other hand side, the ec.c code should already parallelize register 
accesses  and the whole lock should not be needed at all.
Someone might want to check whether the locks
in ec.c really do what they should and could use this as a stress test if the 
lock is simply removed.

> Also the code's uncommented,
/* Only allow one user to access any EC io/field file at a time */
static DEFINE_MUTEX(ec_fs_lock);
> so the reader has no clue why a trylock 
> was used.  There are very few circumstances where any trylock can
> acceptably be left uncommented.
>
> afacit we can use mutex_lock() here and the implementation would be
> heaps better.
Not sure it really matters. But removing it altogether might be even better.
Waiting for some more comments...

       Thomas

From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V2 0/4] introduce device async actions mechanism
Date: Tue, 11 Aug 2009 11:53:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908111148060.2562-100000@iolanthe.rowland.org>
References: <200908111734.58949.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753961AbZHKPx6@vger.kernel.org>
In-Reply-To: <200908111734.58949.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, "dtor@mail.ru" <dtor@mail.ru>
List-Id: linux-acpi@vger.kernel.org

On Tue, 11 Aug 2009, Rafael J. Wysocki wrote:

> In fact, we don't need the layers at all.  The only thing we have to assure is
> that, during resume, the devices given device depends on will be handled
> before we start to handle this particular device (inversely during suspend).
> 
> Please note that we're not even allowed to start executing the device's
> resume callback before the callbacks of the devices it depends on have
> returned (the same applies to the suspend callbacks, but the other way around).

The general algorithm for maximum parallelism goes as follows: Start by
resuming (in parallel) all the devices which don't depend on anything
else.  Each time a resume finishes, you go on to resume (in parallel)
all the devices which depend only on resumed devices and which haven't
yet started to resume.

As described, this can require a large number of threads.  It also
requires detailed knowledge of which devices depend on others, which we
don't have.

Alan Stern

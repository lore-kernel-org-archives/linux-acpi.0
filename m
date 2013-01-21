From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][Update 2][PATCH 2/4] ACPI / PM: Expose reference count values of ACPI power resources
Date: Mon, 21 Jan 2013 23:35:51 +0100
Message-ID: <9864072.snIRhummIS@vostro.rjw.lan>
References: <3307415.pdOY6ovZLa@vostro.rjw.lan> <1618594.EyAyXTlIBb@vostro.rjw.lan> <20130121205357.GB17006@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130121205357.GB17006@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Kristen C. Accardi" <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Monday, January 21, 2013 12:53:57 PM Greg Kroah-Hartman wrote:
> On Mon, Jan 21, 2013 at 02:05:47PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Since ACPI power resources are going to be used more extensively on
> > new hardware platforms, it becomes necessary for user space (powertop
> > in particular) to observe some properties of those resources for
> > diagnostics purposes.
> > 
> > For this reason, export the reference counts of ACPI power resources
> > to user space by adding a new reference_count attribute to the sysfs
> > directory representing each power resource.  The value read from
> > that attribute represents the number of devices using the power
> > resource at the given time.  If that value is 0, it meas that the
> > power resource is not used and therefore it has been turned off.
> 
> Why does userspace need to know a reference count?  Is it so that if it
> is not 0, it can work to try to lower it to 0?  Or something else?

Yes, this information is needed to say if (1) the power resource is in use
and (2) how many users there are at the moment, so that we can go and look
if it really has to be in use.

Perhaps I can just expose the "in use"/"not in use" information.  I don't
think it will be much less convenient, because we should scan all of the
possible users anyway in case they are coming and going frequently.

So should I do that and rename the attribute to "resource_in_use" (or something
similar)?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

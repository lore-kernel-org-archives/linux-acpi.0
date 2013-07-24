From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 3.11-rc2 (acpi backlight)
Date: Wed, 24 Jul 2013 14:06:01 +0200
Message-ID: <1473791.TcyyldNxDN@vostro.rjw.lan>
References: <CA+55aFy330bSRjK5HT1n0wXioPykL3RquHXyBPjm5GpTz_Y=DQ@mail.gmail.com> <CAAG0J98G64DGvtA3HtY7B2-rvOordrzam+jjy=kjgLTW0WPgew@mail.gmail.com> <1374650350.1824.2.camel@ThinkPad-X230.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374650350.1824.2.camel@ThinkPad-X230.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Cc: James Hogan <james@albanarts.com>, Kamal Mostafa <kamal@canonical.com>, Steven Newbury <steve@snewbury.org.uk>, Martin Steigerwald <Martin@lichtvoll.de>, =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lwe@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, July 24, 2013 11:19:10 AM Igor Gnatenko wrote:
> On Wed, 2013-07-24 at 07:49 +0100, James Hogan wrote:
> > On 24 July 2013 01:05, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > I'd like to collect some information on the systems having problems with those
> > > two commits (to see if they are similar somehow).
> > >
> > > It seems that one common symptom is that brightness cannot be controlled
> > > through function keys.  Is that correct for all of you?  If so, did you try
> > > any other way to control brightness, like a GUI-based?
> > 
> > For me both the Fn keys and the gui slider (kde) now control
> > /sys/class/backlight/intel_backlight/brightness (which has no effect).
> > Previously they both controlled the acpi one (that on -rc2 doesn't
> > exist).
> I think this problem in i915 drivers.
> Rafael, Mathew, Aaron, fix me please

Yes, it is my impression too.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

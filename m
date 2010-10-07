From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Read TSC upon resume
Date: Thu, 7 Oct 2010 23:44:21 +0200
Message-ID: <201010072344.22166.rjw@sisk.pl>
References: <1286406919-6236-1-git-send-email-snanda@chromium.org> <AANLkTik=imw5XRpXSkboyB6txXio6Y65bLV+EdfvRXg3@mail.gmail.com> <20101007181536.GA24811@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101007181536.GA24811@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Sameer Nanda <snanda@chromium.org>, lenb@kernel.org, stefan.bader@canonical.com, brad.figg@canonical.com, apw@canonical.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, October 07, 2010, Greg KH wrote:
> On Thu, Oct 07, 2010 at 11:05:21AM -0700, Sameer Nanda wrote:
> > On Thu, Oct 7, 2010 at 10:46 AM, Greg KH <gregkh@suse.de> wrote:
> > > On Thu, Oct 07, 2010 at 10:43:34AM -0700, Sameer Nanda wrote:
> > >> On Wed, Oct 6, 2010 at 7:19 PM, Greg KH <gregkh@suse.de> wrote:
> > >> > And are you always going to be printing this out?  Why do we want to
> > >> > know this every time?
> > >> >
> > >>
> > >> Yes, every time.  This helps track variance in BIOS resume times within a
> > >> single boot.
> > >
> > > Is that really something that users can do something about?
> > 
> > Aside from complaining to the BIOS vendors, no :)
> 
> Then I would not recommend adding this patch, as it is irrelevant for
> 99.9999% of all Linux users.

It may be somewhat useful, but the rdtscll() call seems to be x86-specific, in
which case it shouldn't be used at this place.

Thanks,
Rafael

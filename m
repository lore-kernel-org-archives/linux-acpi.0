From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/3] device property: add spaces to PROPERTY_ENTRY_STRING macro
Date: Wed, 30 Dec 2015 03:06:23 +0100
Message-ID: <1850926.j60LlceTNY@vostro.rjw.lan>
References: <1450877684-76316-1-git-send-email-andriy.shevchenko@linux.intel.com> <1627434.AfSeGfofYv@vostro.rjw.lan> <20151229172453.b8bf71ef.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20151229172453.b8bf71ef.akpm@linux-foundation.org>
Sender: linux-next-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, December 29, 2015 05:24:53 PM Andrew Morton wrote:
> On Wed, 30 Dec 2015 02:49:26 +0100 "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
> > On Monday, December 28, 2015 01:24:13 PM Andy Shevchenko wrote:
> > > On Mon, 2015-12-28 at 02:12 +0100, Rafael J. Wysocki wrote:
> > > > On Wednesday, December 23, 2015 03:34:42 PM Andy Shevchenko wrote:
> > > > > Just a style fix, no functional changes.
> > > > > 
> > > > > To be folded to Andrew's patch.
> > > > 
> > > > What patch?
> > > 
> > > In linux-next from Andrew:
> > > 
> > > e39ece7 include-linux-propertyh-fix-build-issues-with-gcc-444-fix
> > > 40bb8a1 include/linux/property.h: fix build issues with gcc-4.4.4
> > 
> > Any pointers to the original patch submission(s)?
> 
> I think it was discussed in some followup to something else, I forget.
> 
> This:
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: include/linux/property.h: fix build issues with gcc-4.4.4

OK, thanks!

I'll apply it to my tree if you don't mind with the Andy's [1/3] on top
so we have all of that in one place.

Thanks,
Rafael

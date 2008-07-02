From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -next] acpi utmisc: use WARN_ON() instead of
 warn_on_slowpath()
Date: Wed, 2 Jul 2008 14:02:16 -0700
Message-ID: <20080702140216.334011a4.akpm@linux-foundation.org>
References: <20080701103339.b5acc1f3.randy.dunlap@oracle.com>
	<20080701131714.5093fa49.akpm@linux-foundation.org>
	<23433248.1214943818230.JavaMail.oracle@acsmt302.oracle.com>
	<20080701133535.f92a673c.akpm@linux-foundation.org>
	<20080702112852.05f30950.randy.dunlap@oracle.com>
	<486BCDDC.1000709@firstfloor.org>
	<20080702121424.a3451eae.akpm@linux-foundation.org>
	<486BD785.5050207@firstfloor.org>
	<20080702124316.61cc76e9.akpm@linux-foundation.org>
	<486BE0DA.2090108@firstfloor.org>
	<20080702133540.20d578cd.akpm@linux-foundation.org>
	<486BEA68.7000801@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <486BEA68.7000801@firstfloor.org>
Sender: linux-next-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: randy.dunlap@oracle.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 02 Jul 2008 22:51:52 +0200
Andi Kleen <andi@firstfloor.org> wrote:

> > 
> > If you really want to do it this way (and it sounds reasonable) then
> > can we please do it in a less-than-totally-hacky-and-broken way?
> > 
> > 
> > 
> > For example, define a new, always-available helper function in (say)
> > kernel/panic.c along the lines of
> > 
> > void emit_warning_message(?)(const char *msg, int line)
> 
> 
> Ok we can just rename warn_on_slow_path() which is already there to that new name.

Sure, that'd work.  But we should pull it outside any ifdefs so that it
is always available (IMO).

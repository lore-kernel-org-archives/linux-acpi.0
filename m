From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] acpi: update win8 OSI blacklist
Date: Sun, 6 Oct 2013 21:54:14 -0400
Message-ID: <20131007015414.GI6284@thunk.org>
References: <CAMP44s33CByGsRz7vsNAoOLnbEMY+fz73NzHJq07BzSuCEGJUg@mail.gmail.com>
 <20131006233106.GA21562@srcf.ucam.org>
 <CAMP44s1-vCgOkE_h1ZEmCA2WiQyLTOvnis2MOjdu8kdDB39kFg@mail.gmail.com>
 <20131006235702.GA21738@srcf.ucam.org>
 <CAMP44s3+GdeN6ZFxi6dKZ_1kyTgmgjTf4ET=pJnkSwoirZQMjw@mail.gmail.com>
 <20131007003247.GA21999@srcf.ucam.org>
 <CAMP44s1knbxW5C_tRSqopRLd+b2fXfuH=E3_L4EdOAUG4RMVhg@mail.gmail.com>
 <20131007005355.GA22211@srcf.ucam.org>
 <CAMP44s0jCvzrBDuiGe=q=tJyQGSGt47aAeJJyPgEtrQB_qXq1Q@mail.gmail.com>
 <20131007012704.GA22371@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131007012704.GA22371@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-acpi@vger.kernel.org

On Mon, Oct 07, 2013 at 02:27:04AM +0100, Matthew Garrett wrote:
> > > Having a per-entry comment is significantly clearer.
> > 
> > That is your opinion, it's not a demonstrable fact.
> 
> Say one of the machines turns out to need the quirk for two different 
> reasons. How do we document that? Look, how about you add the comments 
> and I'll do a patch that adds documentation to the existing entries? I'm 
> not asking you to make up for other people's past mistakes, I'm asking 
> you not to perpetuate them.

Felipe,

I have to agree with Matthew here.  Lists have a way of getting messed
up.  If not in the upstream kernel, can we be sure that none of the
distribution maintainers might not respect the ordering?

How about doing something like this:

/*
 * [1] Busted brightness controls
 * [2] Attempted compatibility with ancient enterprise Linux kernel causes
 *        20% performance regression on upstream kernels
 * [3] Disables video card functionaity to be bug-for-bug compatible with
 *      Windows after attempted hobbling in the propietary driver
 *	was wored around, etc.
 * etc.
 */

Then individual entries can be annotated with comments indicating
[1][2], etc.

That way, if someone clever decides that they want to alphabetize the
entries, or we have so many exceptions due to incompetent BIOS
programmers, and some future developers decides that he or she needs
to implement a binary search to speedup lookups, or some such, we
won't need to worry about ordering-specific semantics getting smashed.

Cheers,

					- Ted

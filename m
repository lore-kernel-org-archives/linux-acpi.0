From: Len Brown <lenb@kernel.org>
Subject: RE: [PATCH] ACPI suspend: Blacklist HP xw4600 Workstation for old code
 ordering
Date: Thu, 16 Oct 2008 15:31:38 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810161525450.3026@localhost.localdomain>
References: <200810142254.07024.rjw@sisk.pl>
 <C075D3D77BA5EF4FBB0939047B182ABF25C79AD3EE@GVW1144EXB.americas.hpqcorp.net>
 <alpine.LFD.1.10.0810151746460.3026@localhost.localdomain>
 <200810160001.00053.rjw@sisk.pl>
 <C075D3D77BA5EF4FBB0939047B182ABF25C79ADA45@GVW1144EXB.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758221AbYJPTcA@vger.kernel.org>
In-reply-to: <C075D3D77BA5EF4FBB0939047B182ABF25C79ADA45@GVW1144EXB.americas.hpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Brown, John M (WGBU R&D)" <john.brown3@hp.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

> I also noted that acpidump printed this message to stderr:
> Wrong checksum for FADT!

The RSDT has a pointer to an FACP at DEFC2014 (aka FADT),
and that FACP has a bad checksum.

But this system has an XSDT, which the OS prefers
over the RSDT.  The XSDT points to an FACP at DEFC2088
and its checksum is fine.

This difference is moot here,
because both FACP's point to the same DSDT at DEFC2647,
and it is the DSDT that has the AML related to ordering.

The reason you see this error message from acpidump
and not from Linux is that the kernel only uses the 'active' 
tables, while acpidump snags both the active and insactive tables
for debugging.

cheers,
-Len

> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> Sent: Wednesday, October 15, 2008 4:01 PM
> To: Len Brown
> Cc: Brown, John M (WGBU R&D); Matthew Garrett; ACPI Devel Maling List; Andrew Morton; LKML
> Subject: Re: [PATCH] ACPI suspend: Blacklist HP xw4600 Workstation for old code ordering
> 
> On Wednesday, 15 of October 2008, Len Brown wrote:
> > Matthew,
> > You are right, of course, we're not doing something right if a new
> > machine needs this workaround.
> 
> Isn't that possible, however, that the BIOS of this new machine is based on an older one that used to have this problem?
> 
> > However, we don't yet know what we're not doing right:-)
> 
> Well, John, can you please post the output of acpidump from this machine?
> 
> Thanks,
> Rafael
> 

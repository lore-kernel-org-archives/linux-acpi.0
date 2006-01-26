From: "Suietov, Fiodor F" <fiodor.f.suietov@intel.com>
Subject: RE: reality check: dsdt.dsl -> compile -> DSDT.aml -> decompile ->DSDT.dsl but dsdt.dsl neq DSDT.dsl
Date: Thu, 26 Jan 2006 13:22:45 +0300
Message-ID: <E124AAE027DA384D8B919F93E4D8C708011433AD@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from petasus.ims.intel.com ([62.118.80.130]:11991 "EHLO
	petasus.ims.intel.com") by vger.kernel.org with ESMTP
	id S932273AbWAZKXC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jan 2006 05:23:02 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Simon Bridge <corwin@ihug.co.nz>, Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org

Wednesday, January 25 Moore, Robert wrote:
> Any disassembler is not *guaranteed* to generate the exact source
code.
> I would be interested in a bit more explanation, however.
> 
There are at least three points in iASL "compile" phase which
result in mentioned difference between dsdt.dsl and DSDT.dsl:
 - updating of the table header fields (Creator ID, Creator Revision,
   Length);
 - the hex constant leading zeroes excision (like 0x02 instead 0x0002
   substitution);
 - default iASL compiler optimization (named reference optimization,
   integer optimization to constants, folding on "normal" expressions).

So, to minimize the difference between dsdt.dsl and DSDT.dsl the iASL
compiler should be called with -oa flag (when compiling dsdt.dsl to
DSDT.aml) disabling in such a way all optimizations (and of course apply
-f flag, if any Errors are detected).

Fiodor

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Moore, Robert
> Sent: Wednesday, January 25, 2006 8:55 PM
> To: Simon Bridge
> Cc: Thomas Renninger; linux-acpi@vger.kernel.org
> Subject: RE: reality check: dsdt.dsl -> compile -> DSDT.aml ->
decompile -
> >DSDT.dsl but dsdt.dsl neq DSDT.dsl
> 
> Well, yes, if the external cannot be resolved at runtime, it will
> generate an error -- Unless you have the update to ACPICA that allows
> unresolved references within packages, AND you enable the interpreter
> slack mode.
> 
> > I got the DSDT.aml (the result of successfully compiling dsdt.dsl
> > remember) and decompiled it - the result is expected to be the same
as
> > dsdt.dsl... but it wasn't! There were substantial differences. When
> this
> > new version was compiled, it produced errors.
> 
> Any disassembler is not *guaranteed* to generate the exact source
code.
> I would be interested in a bit more explanation, however.
> 
> Bob
> 
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Simon Bridge
> > Sent: Tuesday, January 24, 2006 7:42 PM
> > To: Moore, Robert
> > Cc: Thomas Renninger; linux-acpi@vger.kernel.org
> > Subject: RE: reality check: dsdt.dsl -> compile -> DSDT.aml ->
> decompile -
> > >DSDT.dsl but dsdt.dsl neq DSDT.dsl
> >
> > On Tue, 2006-01-24 at 14:39 -0800, Moore, Robert wrote:
> > > The change to ACPICA to "support" such non-existent names was
> > > implemented in the run-time interpreter but not the compiler.
> > >
> > > The iASL compiler will still emit an error in this case, and I
feel
> this
> > > is correct since we want the compiler to catch these kinds of
> errors.
> > > The "-f" flag will override this and any other errors, however.
> > >
> > > Another very simple fix to this kind of error is to add an
> "External"
> > > statement to the ASL code (for the missing symbol), same as any
> other
> > > symbol which is defined in another table.
> > >
> > > Bob
> > >
> > >
> > Cool - thanks guys. (Robert and Thomas)
> >
> > I should note, in responce here, that Z007 is not in the code.
> > "Externalling" it produces the same kernel messages.
> >
> > The CPU0 symbol is different - neither of you seemed to have spotted
> > that (correct me).
> >
> > The firmware dsdt was decompiled to dsdt.dsl and this edited. It
> > compiled *without error* to DSDT.aml and was acepted by the kernel.
> >
> > There were kernel messages (explained by Thomas - thanks) which I
> > thought I'd got rid of. So I decided to check that the aml code was
> what
> > I thought it was.
> >
> > I got the DSDT.aml (the result of successfully compiling dsdt.dsl
> > remember) and decompiled it - the result is expected to be the same
as
> > dsdt.dsl... but it wasn't! There were substantial differences. When
> this
> > new version was compiled, it produced errors.
> >
> > I was hoping this was a known problem with iasl or something. Has
> nobody
> > seen this before - it happens every time on this machine. Perhaps
it's
> > just me. But if I cannot trust the compiler to render the code
> properly
> > where am I?
> >
> > Thomas: I'll try the patches ... isn't the patch you posted for the
> > 2.6.16 kernel? (Hmmm... to self: isn't that what he said?)
> >
> > It has already occurred to me to test this all out with a vanilla
> kernel
> > - done it before - only I'm going to have to support this distro to
> > others so I'd rather do what's possible with the distro kernel as
> well.
> >
> > (I'd normally do this sort of fiddling in Fedora. I hoped to keep
the
> > Ubuntu box standard as possible so I can anticipate what users are
> > experiencing.)
> >
> > If you think I'll really need to upgrade the kernel, you're probably
> > right. My old problem of the DSDT not being taken into the kernel
was
> > solved by a kernel upgrade :)
> >
> > Hopefully the ubuntu folk will add the next big ACPI patch to their
> > repos in good time.
> >
> > >
> > >
> > > > -----Original Message-----
> > > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > > owner@vger.kernel.org] On Behalf Of Thomas Renninger
> > > > Sent: Tuesday, January 24, 2006 1:11 AM
> > > > To: Simon Bridge
> > > > Cc: linux-acpi@vger.kernel.org
> > > > Subject: Re: reality check: dsdt.dsl -> compile -> DSDT.aml ->
> > > decompile -
> > > > > DSDT.dsl but dsdt.dsl neq DSDT.dsl
> > > >
> > > > Simon Bridge wrote:
> > > > > # iasl -ta dsdt.dsl
> > > > >
> > > > > Intel ACPI Component Architecture
> > > > > ASL Optimizing Compiler version 20050930 [Nov 20 2005]
> > > > > Copyright (C) 2000 - 2005 Intel Corporation
> > > > > Supports ACPI Specification Revision 3.0
> > > > >
> > > > > ASL Input:  dsdt.dsl - 3471 lines, 121247 bytes, 1565 keywords
> > > > > AML Output: DSDT.aml - 13975 bytes 377 named objects 1188
> executable
> > > > > opcodes
> > > > >
> > > > > Compilation complete. 0 Errors, 0 Warnings, 0 Remarks, 542
> > > Optimizations
> > > > >
> > > > > ... which seems fine so far.
> > > > >
> > > > > # cp DSDT.amp /etc/mkinitramfs/DSDT.aml
> > > > >
> > > > > reboot.
> > > > > I see a syslog saying that this DSDT.aml is detected and
loaded.
> > > > > However, I get errors as follows:
> > > > >
> > > > > ACPI-0508: *** Error: Method execution failed
[\_SB_.BAT1._BST]
> > > (Node
> > > > > cbed7be0), AE_NOT_FOUND
> > > > > ACPI-0362: *** Error: Looking up [Z007] in namespace,
> AE_NOT_FOUND
> > > > >
> > > > > ... ad infinitum.
> > > > Those Z00X objects should get fixed as soon as the next big ACPI
> patch
> > > > from
> > > > Len goes mainline.
> > > >
> > > > This should be interesting for a lot people here, currently
> patching
> > > > there DSDTs because of this error.
> > > >
> > > > See: http://bugzilla.kernel.org/show_bug.cgi?id=5322
> > > > I expect you used an iasl compiler newer than 20051216 that
> already
> > > > includes
> > > > the fix and therefore does not complain about the missing Z007
> object.
> > > > Your kernel is probably still missing this fix and constantly
> > > complains.
> > > >
> > > > You may want to patch 2.6.16-rc1 with Len's latest patches:
> > > >
> > >
>
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6
> > > .1
> > > > 6/
> > > > If you try this out, I'd be glad if you could report back
whether
> the
> > > > Z00X issue is really finally solved for you.
> > > >
> > > > >
> > > > > Puzzled - especially since Z007 does not appear in dsdt.dsl
> > > (replaced by
> > > > > "ones" on advice from this forum - a la acer laptops and Z007
> being
> > > > > nonexistant anywhere.)
> > > > ...
> > > >
> > > > > which provides the following error:
> > > > > Error 1061 - Object does not exist (\_PR.CPU0._PPC)
> > > > The object is probably declared in SSDT.
> > > > acpidmp >/tmp/acpidmp
> > > > acpixtract ssdt acpidmp >ssdt
> > > > iasl -d ssdt
> > > >
> > > > To get rid of the compiler error just declare it:
> > > > External (\_PR.CPU0._PPC)
> > > > So that the compiler knows it is declared in some
> > > > other, later loaded ACPI table.
> > > > >
> > > > > This appears six times overall, across methods:
> > > > > _Q8A, _Q8D, _Q8D ... which seem unhelpful.
> > > > >
> > > > > I see /proc/acpi/processor/CPU0 contains files;
> > > > > info  limit  power  throttling
> > > > >
> > > > > I see that _PPC is a reserved method name:
> > > > > _PPC    Method with 0 arguments, must return a value
> > > > It is probably because of the above missing external().
> > > >
> > > > If the Z00x is your only problem, don't waste time by trying
> > > > to rewrite your DSDT, better try out Len's patches
> > > > and let us know if you still see anything bad.
> > > >
> > > >        Thomas

From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: reality check: dsdt.dsl -> compile -> DSDT.aml -> decompile -> DSDT.dsl but dsdt.dsl neq DSDT.dsl
Date: Tue, 24 Jan 2006 14:39:51 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E041E65C5@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:12187 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750799AbWAXWkB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2006 17:40:01 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, Simon Bridge <corwin@ihug.co.nz>
Cc: linux-acpi@vger.kernel.org

The change to ACPICA to "support" such non-existent names was
implemented in the run-time interpreter but not the compiler.

The iASL compiler will still emit an error in this case, and I feel this
is correct since we want the compiler to catch these kinds of errors.
The "-f" flag will override this and any other errors, however.

Another very simple fix to this kind of error is to add an "External"
statement to the ASL code (for the missing symbol), same as any other
symbol which is defined in another table.

Bob




> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Thomas Renninger
> Sent: Tuesday, January 24, 2006 1:11 AM
> To: Simon Bridge
> Cc: linux-acpi@vger.kernel.org
> Subject: Re: reality check: dsdt.dsl -> compile -> DSDT.aml ->
decompile -
> > DSDT.dsl but dsdt.dsl neq DSDT.dsl
> 
> Simon Bridge wrote:
> > # iasl -ta dsdt.dsl
> >
> > Intel ACPI Component Architecture
> > ASL Optimizing Compiler version 20050930 [Nov 20 2005]
> > Copyright (C) 2000 - 2005 Intel Corporation
> > Supports ACPI Specification Revision 3.0
> >
> > ASL Input:  dsdt.dsl - 3471 lines, 121247 bytes, 1565 keywords
> > AML Output: DSDT.aml - 13975 bytes 377 named objects 1188 executable
> > opcodes
> >
> > Compilation complete. 0 Errors, 0 Warnings, 0 Remarks, 542
Optimizations
> >
> > ... which seems fine so far.
> >
> > # cp DSDT.amp /etc/mkinitramfs/DSDT.aml
> >
> > reboot.
> > I see a syslog saying that this DSDT.aml is detected and loaded.
> > However, I get errors as follows:
> >
> > ACPI-0508: *** Error: Method execution failed [\_SB_.BAT1._BST]
(Node
> > cbed7be0), AE_NOT_FOUND
> > ACPI-0362: *** Error: Looking up [Z007] in namespace, AE_NOT_FOUND
> >
> > ... ad infinitum.
> Those Z00X objects should get fixed as soon as the next big ACPI patch
> from
> Len goes mainline.
> 
> This should be interesting for a lot people here, currently patching
> there DSDTs because of this error.
> 
> See: http://bugzilla.kernel.org/show_bug.cgi?id=5322
> I expect you used an iasl compiler newer than 20051216 that already
> includes
> the fix and therefore does not complain about the missing Z007 object.
> Your kernel is probably still missing this fix and constantly
complains.
> 
> You may want to patch 2.6.16-rc1 with Len's latest patches:
>
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6
.1
> 6/
> If you try this out, I'd be glad if you could report back whether the
> Z00X issue is really finally solved for you.
> 
> >
> > Puzzled - especially since Z007 does not appear in dsdt.dsl
(replaced by
> > "ones" on advice from this forum - a la acer laptops and Z007 being
> > nonexistant anywhere.)
> ...
> 
> > which provides the following error:
> > Error 1061 - Object does not exist (\_PR.CPU0._PPC)
> The object is probably declared in SSDT.
> acpidmp >/tmp/acpidmp
> acpixtract ssdt acpidmp >ssdt
> iasl -d ssdt
> 
> To get rid of the compiler error just declare it:
> External (\_PR.CPU0._PPC)
> So that the compiler knows it is declared in some
> other, later loaded ACPI table.
> >
> > This appears six times overall, across methods:
> > _Q8A, _Q8D, _Q8D ... which seem unhelpful.
> >
> > I see /proc/acpi/processor/CPU0 contains files;
> > info  limit  power  throttling
> >
> > I see that _PPC is a reserved method name:
> > _PPC    Method with 0 arguments, must return a value
> It is probably because of the above missing external().
> 
> If the Z00x is your only problem, don't waste time by trying
> to rewrite your DSDT, better try out Len's patches
> and let us know if you still see anything bad.
> 
>        Thomas
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

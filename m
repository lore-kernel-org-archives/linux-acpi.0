From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: new pmtools available for testing
Date: Mon, 27 Nov 2006 10:13:44 -0800
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A401671EDA@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:49308 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1757328AbWK0SRn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Nov 2006 13:17:43 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, trenn@suse.de
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

I don't know what's going on here.

I wrote acpixtract in C in order to get away from Perl and Perl issues.

I certainly hope that we don't have yet another version of acpixtract. I
don't mind changing things such as the interface, if everyone agrees
it's for the better. But it seems like an incredible waste of energy to
keep rewriting these kinds of utilities.



> -----Original Message-----
> From: Alexey Starikovskiy
[mailto:alexey.y.starikovskiy@linux.intel.com]
> Sent: Wednesday, November 22, 2006 8:41 AM
> To: trenn@suse.de
> Cc: Brown, Len; linux-acpi@vger.kernel.org; Moore, Robert
> Subject: Re: new pmtools available for testing
> 
> Thomas Renninger wrote:
> > On Wed, 2006-11-22 at 17:36 +0300, Alexey Starikovskiy wrote:
> >
> >> Thomas Renninger wrote:
> >>
> >>> On Tue, 2006-11-21 at 21:24 +0300, Alexey Starikovskiy wrote:
> >>>
> >>>
> >>>> Hi,
> >>>>
> >>>> acpixtract perl-script is being replaced by C xtract utility.
Please
> test.
> >>>> Advances are:
> >>>>     - Perl not required :)
> >>>>     - no 64k output limit of perl-script
> >>>>     - --list option shows all tables in the file
> >>>>     - unified interface with acpidump
> >>>>     - faster(?)
> >>>>
> >>>> Thanks in advance,
> >>>>
> >>>>
> >>> Is this acpixtract that already existed in ACPICA since some time
and
> >>> now moved to pmtools?
> >>>
> >>>
> >> Nope, it's duplicated effort.
> >>
> >
> > Hmm, you should talk to (I think acpixtract C prog came from) Bob?
> > Someone should decide which should be the final one everybody should
> > use...
> > If one distri or application starts to package and use the one,
others
> > start to use the other, we might have compatibility problems in some
> > scripts in future.
> >
> >
> New utility is names 'xtract' so it does not clash with 'acpixtract'
> either perl-script or ACPICA utility.
> If are used to acpixtract, no need to change your habits. If you
somehow
> tired of crippled interface, you could try new utility.
> > The linuxfirmwarekit makes use of ACPICA's acpixtract AFAIK
(hardcoded
> > by something like system("acpixtract acpidump");).
> > I also packaged this one into SUSE pmtools package (since SUSE
10.1?).
> > -> I'd prefer to stick to the ACPICA's acpixtract..
> >
> no problem at all.
> 
> Regards,
>     Alex

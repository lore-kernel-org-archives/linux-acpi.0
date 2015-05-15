From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Registering a device driver before _INI?
Date: Sat, 16 May 2015 01:29:32 +0200
Message-ID: <1561889.PJaloTxz2Q@vostro.rjw.lan>
References: <CAOf41NnAjRG-2H=h8pUDBPQs2pePH4GNY0+XNnC+iXiRf30srA@mail.gmail.com> <110147854.JIgBgdndc5@vostro.rjw.lan> <55567A33.10606@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41617 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1422770AbbEOXES (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2015 19:04:18 -0400
In-Reply-To: <55567A33.10606@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: Adam Goode <agoode@google.com>, linux-acpi@vger.kernel.org

On Friday, May 15, 2015 04:58:59 PM Al Stone wrote:
> On 05/15/2015 04:50 PM, Rafael J. Wysocki wrote:
> > On Friday, May 15, 2015 05:55:17 PM Adam Goode wrote:
> >> On Thu, May 14, 2015 at 6:47 PM, Al Stone <ahs3@redhat.com> wrote:
> >>> On 05/14/2015 06:36 AM, Adam Goode wrote:
> >>>> On Wed, May 13, 2015 at 11:14 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>>>> On Wednesday, May 13, 2015 01:07:36 PM Al Stone wrote:
> >>>>>> On 05/13/2015 10:25 AM, Adam Goode wrote:
> >>>>>>> The Macmini7,1 addresses SystemCMOS memory in _INI methods. Currently,
> >>>>>>> this fails since _INI is called before the acpi_cmos_rtc_space_handler
> >>>>>>> is registered.
> >>>>>>>
> >>>>>>> I proposed registering a default handler on the ACPICA list, but was
> >>>>>>> told that because the device has a _HID it should require a device
> >>>>>>> driver.
> >>>>>>>
> >>>>>>> So, is it possible to register a device driver before _INI is called?
> >>>>>>> Otherwise, Thunderbolt doesn't get initialized properly on this
> >>>>>>> hardware.
> >>>>>>
> >>>>>> I take it from the question that the _INI methods are using the predefined
> >>>>>> SystemCMOS OperationRegion, correct?  Are the _INI methods invoking _REG
> >>>>>> before trying to access that region?  Looking at the spec, the _INI methods
> >>>>>> must first call _REG to see if SystemCMOS is available for use (see section
> >>>>>> 6.5.1), and there is no requirement that SystemCMOS must be available for
> >>>>>> use by _INI (see 6.5.4).  So, if I think about this from the spec point of
> >>>>>> view, it sounds like the _INI methods are non-compliant.  From the kernel
> >>>>>> perspective, the SystemCMOS region is created at a reasonable time and is
> >>>>>> available when it is required to be.
> >>>>
> >>>> My reading of the ACPI spec is that the OS calls _REG when it updates
> >>>> region availability. It's not the AML that calls _REG at all. There
> >>>> are no _REG methods defined for this, so nothing to do. Further
> >>>> reading of the spec seems to indicate that the OS should be doing a
> >>>> kind of dependency analysis and registering region handlers before
> >>>> failing here. I'm not seeing anything really out of spec with the AML
> >>>> code in this case.
> >>>
> >>> Ah, my bad.  I misread the _REG part.  The OS does call _REG, not the AML.
> >>> Just the same, that section does say that "control methods must assume all
> >>> operation regions inaccessible until the _REG(RegionSpace, 1) method is
> >>> executed."  I would take that to mean that _INI cannot assume SystemCMOS
> >>> is ready to use, unless _REG has been defined in an enclosing scope so the
> >>> OS knows it is to be executed.
> >>>
> >>> Could you point out where the dependency analysis is indicated?  I am
> >>> not seeing that at all; that would seem to require a priori knowledge
> >>> of all of the regions all of the devices could ever possibly use, and
> >>> it's not clear to me that can even be conveyed to the OS using the
> >>> current version of the spec.  As someone involved in writing the spec,
> >>> I want to make sure we're being unambiguous in what is required.
> >>
> >> I think you can relax, I believe I read too far into section 6.5.8
> >> _DEP (Operation Region Dependencies). It points out that _DEP is
> >> optional, but goes on to say that you need _REG callbacks to be called
> >> anyway.
> 
> Ah.  Okey dokey.  I will take a look at these sections again, though,
> just to see if there's a way to make them clearer.
> 
> >> What is a little confusing to me here is that _REG is per
> >> address-space, not per address. I guess that makes some sense for some
> >> kinds of regions.
> >>
> >>
> >>>
> >>>> I'm guessing that some kind of refactoring of _HID driver attachment
> >>>> would be a way forward here. But I haven't looked deeply into this
> >>>> yet.
> >>>
> >>> Perhaps; as long as _INI is executed before _HID as required (6.5.1, again).
> >>>
> >>
> >> Hmm, this looks like it's the problem, and does strongly suggest to me
> >> that the firmware is busted.
> > 
> > Still, if Windows has no problems working with it, so should we.
> 
> Yeah, agreed.  It's interesting (well, to me, at least :) that this has not
> shown up before as other _INI functions depending on unregistered regions.
> Or maybe I just haven't been aware of them before...

I've never heard of anything like that till now.

> >> But the spec is confusing to me here, it
> >> says _INI is run before _HID is "run". What does it mean for _HID to
> >> run? It's not a method in the traditional sense. I think it is
> >> implying OS device enumeration?
> > 
> > _HID may be implemented as a method in which case it will be run.  But it is
> > better to say "evaluated" in any case. :-)
> 
> Ain't English fun?  Yup, it's an object that gets evaluated.  I'll try to watch
> out for that in the future :).
> 
> > Windows appears to install the CMOS region handler upfront, probably with the
> > assumption that firmware accessing operation regions in it should know that
> > the CMOS device is actually present.
> 
> So would it make sense to reconsider where Linux registers regions, and maybe
> move them earlier?  I can't really tell how prevalent this sort of situation
> might be in firmware out in the wild; it may be more practical to just handle
> each region when it becomes an issue like this one.

I think this is an exceptional one and as I said, it looks like Windows simply
assumes the target device to exist in this case.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

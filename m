From: Thomas Renninger <trenn@suse.de>
Subject: RE: ACPICA regression checker
Date: Wed, 12 Jul 2006 09:16:04 +0200
Message-ID: <1152688564.3570.270.camel@queen.suse.de>
References: <CFF307C98FEABE47A452B27C06B85BB6F317ED@hdsmsx411.amr.corp.intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:55183 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750775AbWGLHOi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jul 2006 03:14:38 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6F317ED@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Yu, Ling L" <ling.l.yu@intel.com>, linux-acpi@vger.kernel.org

On Tue, 2006-07-11 at 22:01 -0400, Brown, Len wrote:
> [adding linux-acpi@vger.kernel.org]
> 
> Thomas,
> I like the way you think.
> 
> my reply is below your message...
> 
> -----Original Message-----
> From: Thomas Renninger [mailto:trenn@suse.de] 
> Sent: Monday, July 10, 2006 10:23 AM
> To: Brown, Len
> Cc: Moore, Robert; intel-linux-acpi@linux.intel.com; Yu, Ling L
> Subject: ACPICA regression checker
> 
> Hi,
> 
> I like to build up a pool of ACPI BIOSes to automatically check them
> with new versions of iasl compiler/disassembler.
> 
> Therefore I am asking for some ideas whether my approach is OK, or maybe
> someone can give some enhancements or just has a good idea.
> 
> First I thought about a new mailing list people can send their acpidump
> to and I extract needed info, put it in a directory on my ftp where
> everybody can see some statistics or can run the validations on his own.
> 
> Then the already existing html/php front-end on acpi.sf.net came into my
> mind. If this is OK with you, I'll try to write some kind of wget
> wrapper to upload/download DSDTs more or less automatically (hmm, just
> thought about: do people load their whole acpidump up there or just
> DSDT? In second case we have a problem). I like to add some dozens
> (hundreds?) of BIOSes which are not meant to get fixed (as the current
> main purpose there ATM?), but as a playground for ACPI developers to see
> some weird/huge IA64 DSDTs, check whether modifications still
> compile/disassemble correctly on all BIOSes and so on.
> 
> The only test is to disassemble and compile with iasl, parse
> warning/error messages and display some statistics (compared to previous
> versions, ..) of the results.
> 
> So a final run could show something like:
> 
>             iasl ver 01012006   |  iasl ver 0x0y2007 | diff ver1/ver2?
>           -------------------------------------------------------------
> Warnings                        |                    |
> ------------------------------------------------------------------------
> Errors                          |                    |
> 
> Additional errors/warnings in xy DSDTs
> Fixed xy   errors/warnings in xy different DSDTs
> ... ??? ...
> 
> I got at least two bugs that are regressions (or better missing
> workarounds). I expect that with above checking those could have find at
> implementation time.
> 
> 
> To make this work properly I would first try to implement what Robert
> suggested to avoid compile/disassemble errors with additional SSDTs:
> http://rudin.suse.de:8888/show_bug.cgi?id=179702 (comment #21):
> -------------
> The only real solution (that I can think of) to the disassembly problem
> (external methods) is probably something like allowing the specification
> of
> additional tables in order to resolve the methods. 
> 
> Something like:
> 
> iasl -e dsdt.aml -d ssdt.aml
> --------------
> Not sure whether someone already started with this one, if not I'll give
> it a try...
> 
> What do you think about all this?
> Better use a separate mailing list or web server?
> 
> Thanks,
> 
>         Thomas
> ------------
> 
> This is a good line of thought.
> But first, There are a couple of things going on
> that maybe not everybody is aware of.
> 
> 1.
> the functional tests that Yu-Ling has published under Validation
> on acpi.sourcforge.net.  These are feature-level tests intended
> to test the end product.  eg. a release of SuSE Linux.
> We run these internally, and I've heard that some distros
> are interested in running them too.  These tests need additional
> work to automate and to cover more cases.
I already have an internal package for this.
Still I also like to add a "disassemble and recompile and report
errors/warnings tool" for ACPI validation. My experience is that most
(at least a lot) potential (unfortunately only syntactical) bugs are
found by that.
> 
> 2.
> Over the last year, Intel has developed an ASL Test Suite consisting
> of over 1700 tests.   These are AML tests that run on top the ACPICA
> interpreter used by Linux, but compiled as a standalone application.
> This found over 230 issues -- about 60 are still
> unresolved.  All remaining open issues are filed in bugzilla.
> You may have seen about 30 of these in the AML-Interpreter
> subcategory under ACPI in bugzilla.kernel.org.  You may have
> noticed in my latest check-ins for ACPICA that Bob's notes refer
> to BZ 300 or so -- these are additional bug reports we filed
> in an internal bugzilla for bugs that didn't look easy to
> describe as Linux kernel bugs -- which is all that bugzilla.kernel.org
> allows.
> 
> We'll be publishing this test suite along with ACPICA very soon --
> indeed, the paperwork is already in the pipeline.
Great.
> 
> We now run this test suite before every ACPICA release.
> I'd like to move to running it between every ACPICA check-in,
> which I'd like to check-into Linux individually.
But these are some generated corner cases, not real BIOS parts?
This sounds similar to what I like to do, but with (hopefully all :) )
real BIOSes out there. Especially some weird Windows/vendor workarounds
could be outlined by that.
> 
> 3.
> Platform ACPI compliance Test
> This is sorely needed by the community to replace WHQL as the test
> that vendors run to make sure they got their ACPI implementation right.
(WHQL? Windows Head Quarters L..?)
> It would be a turn-key test that runs on a platform and gives
> a yes/no on compliance, and diagnostics on failures.
> 
> This would be a voluntary thing for vendors to run, but I expect
> that many of them would run it if somebody else wrote the tests
> for them.
I doubt that many vendors will run it. Say some vendors on some of their
servers they like to Linux certificate.
> 
> Some folks at Intel have given this some thought, but it isn't
> currently a committed/funded project, so I can't promise anything.
> 
> My expectation that a reasonable implementation would be a loadable
> Linux device driver that could use any/all kernel hooks and talk to
> the real hardware via ACPI.
A Windows/Linux/Other OS compliance test? Probably hard to implement?
> 
> ---
> That brings me to your idea.
> I think it works for testing the ASL compiler.
> However, the problem with using DSDT images to test the interpreter
> is that unless they are running on the real hardware,
> you can't really see if they work.
In the past you often got a clue that something is bogus with your
tables. You can at least say: "This one is critical, something probably
won't work" or "This error is harmless" or "This might cause problems".
Of course there might be hidden things...

> You really
> need to do #3 to get where you want to be -- run the test
> and the firmware on the HW it was written for.
But this is not possible for all hardware (including already sold one).
Even new hardware will only be tested by vendors for some percent of
machines (the servers they like to linux certificate). Most
workstations/laptops we will still be on our own.
In the end it would be the user himself who needs to run this if he
experience problems in ACPI parts.
> 
> The other problem with DSDTs is that it is taboo for Intel
> to traffic in firmware images that are products of its customers --
> -- this could potentially piss off some of our customers.
> I've never posted a DSDT to sourceforge.net, and I'm really
> not permitted to.
As mentioned, this is not intended to fix DSDTs, but:
 a) to find compatibility problems and regressions early. The whole
    ACPI thing is a huge, complicated struct of code with lots of
    workarounds and so on. Fixing one thing might break old BIOSes.
 b) a playground for ACPI developers. We could see some vendor/windows
    specific functions on some hardware (especially laptops, I am
    thinking about hotkey, bluetooth/wlan/display control, ...).
    This won't be enough to implement their functionality, but maybe
    at least find a concept how to get this running in future or 
    whatever...

What hangs in my mind all the time is some kind of function/exec tracker
that logs all ACPI kernel activity at runtime. The output should be some
debug file which acpiexec can be filled with and regenerate the ACPI
paths that were executed.
Like that you can tell a person to switch on ACPI debug. Then send
acpidump and debug file. Then you can "offline debug" what was executed
and even know what hardware accesses returned.
But this is probably not easy to implement. I really like to invest some
time here, not sure how far I could come...
The last step then would be another debug module that allows calling of
arbitrary ACPI functions (e.g. that special hotkey/fan/.. stuff that
normally is not used). I wrote a small module to export EC variables to
sysfs. That was easy and could be done for all ACPI funcs. Of course
only for debug purposes.
These are only ideas yet...
> 
> thanks,
> -Len
> 
> ps. please point me to the two bugs -- maybe they show a hole
> in our ASL test suite.

http://rudin.suse.de:8888/show_bug.cgi?id=189488
-> Bogus _PSS package, customer says that already worked. Maybe with PSB
fallback to use legacy AMD tables, don't know... If that already worked
(with ACPI) we should have seen the regression by simple
disassembling/recompiling.

http://rudin.suse.de:8888/show_bug.cgi?id=160671
-> Ok, this one would not have been found by simple
disassembling/recompiling.

Nothing critical, not really worth looking at.

Thanks,

      Thomas


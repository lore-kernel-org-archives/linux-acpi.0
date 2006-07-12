From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPICA regression checker
Date: Wed, 12 Jul 2006 15:31:14 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6F76161@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59231 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750884AbWGLTbi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2006 15:31:38 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: "Moore, Robert" <robert.moore@intel.com>, "Yu, Ling L" <ling.l.yu@intel.com>, linux-acpi@vger.kernel.org


>> 1.
>> the functional tests that Yu-Ling has published under Validation
>> on acpi.sourcforge.net.  These are feature-level tests intended
>> to test the end product.  eg. a release of SuSE Linux.
>> We run these internally, and I've heard that some distros
>> are interested in running them too.  These tests need additional
>> work to automate and to cover more cases.

>I already have an internal package for this.

>Still I also like to add a "disassemble and recompile and report
>errors/warnings tool" for ACPI validation. My experience is that most
>(at least a lot) potential (unfortunately only syntactical) bugs are
>found by that.

DSDT disassemble/re-compile is a great test of the BIOS.
Indeed, we recommend to BIOS vendors that even if they us the MS
compiler for production, that they use ours for static error checking.

However, the compiler isn't directly related to how the interpreter
will handle a DSDT.  For example, the compiler will ERROR out on
implicit return, but the interpreter has a work-around to handle that.

But that doesn't mean the end of your idea.  It may be that we
want to cook up a special test version of the compiler that can
be used to behave like the interpreter to look for issues that
will crop-up when the interpreter is faced with the DSDT.


>> 2.
>> Over the last year, Intel has developed an ASL Test Suite consisting
>> of over 1700 tests.   These are AML tests that run on top the ACPICA
>> interpreter used by Linux, but compiled as a standalone application.
>> This found over 230 issues -- about 60 are still
>> unresolved.  All remaining open issues are filed in bugzilla.
>> You may have seen about 30 of these in the AML-Interpreter
>> subcategory under ACPI in bugzilla.kernel.org.  You may have
>> noticed in my latest check-ins for ACPICA that Bob's notes refer
>> to BZ 300 or so -- these are additional bug reports we filed
>> in an internal bugzilla for bugs that didn't look easy to
>> describe as Linux kernel bugs -- which is all that 
>> bugzilla.kernel.org allows.
>> 
>> We'll be publishing this test suite along with ACPICA very soon --
>> indeed, the paperwork is already in the pipeline.

>Great.
 
>> We now run this test suite before every ACPICA release.
>> I'd like to move to running it between every ACPICA check-in,
>> which I'd like to check-into Linux individually.

>But these are some generated corner cases, not real BIOS parts?
>This sounds similar to what I like to do, but with (hopefully all :) )
>real BIOSes out there. Especially some weird Windows/vendor workarounds
>could be outlined by that.

Right, this is testing against the language specification itself
using a large list of small synthetic tests.  I think it has helped
enormously over the past year in reducing regressions at the AML
level.  However, it doesn't look for strange things that programmers
might do in a production DSDT.  BTW. the strange things are generally
BIOS programmer mistakes that are simply not caught by the MS compiler
and by chance happen to not break the MS interpreter.  It doesn't break,
and the BIOS writer declares victory and moveds on to the next
project...

>> 3.
>> Platform ACPI compliance Test
>> This is sorely needed by the community to replace WHQL as the test
>> that vendors run to make sure they got their ACPI 
>> implementation right.

>(WHQL? Windows Head Quarters L..?)

WHQL is the test that HW vendors must pass to get a Windows Logo
on their box.  Without a Windows Logo, they basically have no product.
I think it stands for Windows HW Quality Lab.

>> It would be a turn-key test that runs on a platform and gives
>> a yes/no on compliance, and diagnostics on failures.
>> 
>> This would be a voluntary thing for vendors to run, but I expect
>> that many of them would run it if somebody else wrote the tests
>> for them.

>I doubt that many vendors will run it. Say some vendors on 
>some of their servers they like to Linux certificate.

"If you build it, they will come":-)
Yes, I agree,vendors who care only about Windows will not bother.
However, it is critical that those vendors that _do_ care
about Linux have the tests to run -- and there are
some significant vendors that do care very much about Linux...

>> Some folks at Intel have given this some thought, but it isn't
>> currently a committed/funded project, so I can't promise anything.
>> 
>> My expectation that a reasonable implementation would be a loadable
>> Linux device driver that could use any/all kernel hooks and talk to
>> the real hardware via ACPI.

>A Windows/Linux/Other OS compliance test? Probably hard to implement?

No, it is an ACPI specification platform compliance test --
it would test how the hardware+firmware platform implements
the ACPI specification.

It doesn't say anything about Windows or Linux, but it will
happen to be implemented using Linux b/c that is both open,
and the tool we have on hand.

>> That brings me to your idea.
>> I think it works for testing the ASL compiler.
>> However, the problem with using DSDT images to test the interpreter
>> is that unless they are running on the real hardware,
>> you can't really see if they work.

>In the past you often got a clue that something is bogus with your
>tables. You can at least say: "This one is critical, something probably
>won't work" or "This error is harmless" or "This might cause problems".
>Of course there might be hidden things...

Yes, per above, I think it would be reasonable to customize the
compiler so that it could have a mode where it would be focused
on its job as a static AML checker looking for incompatibilities
with our interpreter.  I think it happens to do some of this now,
but it will complain about stuff that the interpreter has workarounds
for.  (and these workarounds must stay forever for the installed base).



>> You really
>> need to do #3 to get where you want to be -- run the test
>> and the firmware on the HW it was written for.

>But this is not possible for all hardware (including already sold one).
>Even new hardware will only be tested by vendors for some percent of
>machines (the servers they like to linux certificate). Most
>workstations/laptops we will still be on our own.
>In the end it would be the user himself who needs to run this if he
>experience problems in ACPI parts.

I think both would have value.  Running on the HW can check more things
(including everything that examining the DSDT off the hardware can do).
I agree that checking the DSDT off the hardware is more practical.

>> The other problem with DSDTs is that it is taboo for Intel
>> to traffic in firmware images that are products of its customers --
>> -- this could potentially piss off some of our customers.
>> I've never posted a DSDT to sourceforge.net, and I'm really
>> not permitted to.

>As mentioned, this is not intended to fix DSDTs, but:
> a) to find compatibility problems and regressions early. The whole
>    ACPI thing is a huge, complicated struct of code with lots of
>    workarounds and so on. Fixing one thing might break old BIOSes.
> b) a playground for ACPI developers. We could see some vendor/windows
>    specific functions on some hardware (especially laptops, I am
>    thinking about hotkey, bluetooth/wlan/display control, ...).
>    This won't be enough to implement their functionality, but maybe
>    at least find a concept how to get this running in future or 
>    whatever...

Again, this is very close to a line that I'm not permitted to cross
as an Intel employee.

>What hangs in my mind all the time is some kind of 
>function/exec tracker that logs all ACPI kernel activity at runtime.
>The output should be some
>debug file which acpiexec can be filled with and regenerate the ACPI
>paths that were executed.
>
>Like that you can tell a person to switch on ACPI debug. Then send
>acpidump and debug file. Then you can "offline debug" what was executed
>and even know what hardware accesses returned.
>But this is probably not easy to implement. I really like to 
>invest some time here, not sure how far I could come...

Interesting idea.  Bob should comment on this.
Today we basically we do this with a very large text log
and a very smart human reading.

We actually don't have to use that debugging method too often --
it is sort of the last resort, buy yes, automating it would
be pretty cool if that is possible.

>The last step then would be another debug module that allows calling of
>arbitrary ACPI functions (e.g. that special hotkey/fan/.. stuff that
>normally is not used). I wrote a small module to export EC variables to
>sysfs. That was easy and could be done for all ACPI funcs. Of course
>only for debug purposes.

These linux-hosted tests, that may use a debug device driver, that
run on the real hardware is exactly what I was referring to in #3.
Luming is thinking about this.


>http://rudin.suse.de:8888/show_bug.cgi?id=189488
>-> Bogus _PSS package, customer says that already worked. 
>Maybe with PSB
>fallback to use legacy AMD tables, don't know... If that already worked
>(with ACPI) we should have seen the regression by simple
>disassembling/recompiling.

https://bugzilla.novell.com/show_bug.cgi?id=189488

I'll look at this.

thanks,
-Len

>http://rudin.suse.de:8888/show_bug.cgi?id=160671
>-> Ok, this one would not have been found by simple
>disassembling/recompiling.
>
>Nothing critical, not really worth looking at.
>
>Thanks,
>
>      Thomas
>

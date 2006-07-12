From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPICA regression checker
Date: Tue, 11 Jul 2006 22:01:30 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6F317ED@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59201 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932343AbWGLCB7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jul 2006 22:01:59 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: "Moore, Robert" <robert.moore@intel.com>, "Yu, Ling L" <ling.l.yu@intel.com>, linux-acpi@vger.kernel.org

[adding linux-acpi@vger.kernel.org]

Thomas,
I like the way you think.

my reply is below your message...

-----Original Message-----
From: Thomas Renninger [mailto:trenn@suse.de] 
Sent: Monday, July 10, 2006 10:23 AM
To: Brown, Len
Cc: Moore, Robert; intel-linux-acpi@linux.intel.com; Yu, Ling L
Subject: ACPICA regression checker

Hi,

I like to build up a pool of ACPI BIOSes to automatically check them
with new versions of iasl compiler/disassembler.

Therefore I am asking for some ideas whether my approach is OK, or maybe
someone can give some enhancements or just has a good idea.

First I thought about a new mailing list people can send their acpidump
to and I extract needed info, put it in a directory on my ftp where
everybody can see some statistics or can run the validations on his own.

Then the already existing html/php front-end on acpi.sf.net came into my
mind. If this is OK with you, I'll try to write some kind of wget
wrapper to upload/download DSDTs more or less automatically (hmm, just
thought about: do people load their whole acpidump up there or just
DSDT? In second case we have a problem). I like to add some dozens
(hundreds?) of BIOSes which are not meant to get fixed (as the current
main purpose there ATM?), but as a playground for ACPI developers to see
some weird/huge IA64 DSDTs, check whether modifications still
compile/disassemble correctly on all BIOSes and so on.

The only test is to disassemble and compile with iasl, parse
warning/error messages and display some statistics (compared to previous
versions, ..) of the results.

So a final run could show something like:

            iasl ver 01012006   |  iasl ver 0x0y2007 | diff ver1/ver2?
          -------------------------------------------------------------
Warnings                        |                    |
------------------------------------------------------------------------
Errors                          |                    |

Additional errors/warnings in xy DSDTs
Fixed xy   errors/warnings in xy different DSDTs
... ??? ...

I got at least two bugs that are regressions (or better missing
workarounds). I expect that with above checking those could have find at
implementation time.


To make this work properly I would first try to implement what Robert
suggested to avoid compile/disassemble errors with additional SSDTs:
http://rudin.suse.de:8888/show_bug.cgi?id=179702 (comment #21):
-------------
The only real solution (that I can think of) to the disassembly problem
(external methods) is probably something like allowing the specification
of
additional tables in order to resolve the methods. 

Something like:

iasl -e dsdt.aml -d ssdt.aml
--------------
Not sure whether someone already started with this one, if not I'll give
it a try...

What do you think about all this?
Better use a separate mailing list or web server?

Thanks,

        Thomas
------------

This is a good line of thought.
But first, There are a couple of things going on
that maybe not everybody is aware of.

1.
the functional tests that Yu-Ling has published under Validation
on acpi.sourcforge.net.  These are feature-level tests intended
to test the end product.  eg. a release of SuSE Linux.
We run these internally, and I've heard that some distros
are interested in running them too.  These tests need additional
work to automate and to cover more cases.

2.
Over the last year, Intel has developed an ASL Test Suite consisting
of over 1700 tests.   These are AML tests that run on top the ACPICA
interpreter used by Linux, but compiled as a standalone application.
This found over 230 issues -- about 60 are still
unresolved.  All remaining open issues are filed in bugzilla.
You may have seen about 30 of these in the AML-Interpreter
subcategory under ACPI in bugzilla.kernel.org.  You may have
noticed in my latest check-ins for ACPICA that Bob's notes refer
to BZ 300 or so -- these are additional bug reports we filed
in an internal bugzilla for bugs that didn't look easy to
describe as Linux kernel bugs -- which is all that bugzilla.kernel.org
allows.

We'll be publishing this test suite along with ACPICA very soon --
indeed, the paperwork is already in the pipeline.

We now run this test suite before every ACPICA release.
I'd like to move to running it between every ACPICA check-in,
which I'd like to check-into Linux individually.

3.
Platform ACPI compliance Test
This is sorely needed by the community to replace WHQL as the test
that vendors run to make sure they got their ACPI implementation right.
It would be a turn-key test that runs on a platform and gives
a yes/no on compliance, and diagnostics on failures.

This would be a voluntary thing for vendors to run, but I expect
that many of them would run it if somebody else wrote the tests
for them.

Some folks at Intel have given this some thought, but it isn't
currently a committed/funded project, so I can't promise anything.

My expectation that a reasonable implementation would be a loadable
Linux device driver that could use any/all kernel hooks and talk to
the real hardware via ACPI.

---
That brings me to your idea.
I think it works for testing the ASL compiler.
However, the problem with using DSDT images to test the interpreter
is that unless they are running on the real hardware,
you can't really see if they work.  You really
need to do #3 to get where you want to be -- run the test
and the firmware on the HW it was written for.

The other problem with DSDTs is that it is taboo for Intel
to traffic in firmware images that are products of its customers --
-- this could potentially piss off some of our customers.
I've never posted a DSDT to sourceforge.net, and I'm really
not permitted to.

thanks,
-Len

ps. please point me to the two bugs -- maybe they show a hole
in our ASL test suite.

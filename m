From: Len Brown <lenb@kernel.org>
Subject: latest ACPI develpment FAQ
Date: Thu, 8 Feb 2007 17:03:53 -0500
Message-ID: <200702081703.53338.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44897 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945927AbXBHWFL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Feb 2007 17:05:11 -0500
Received: from d975xbx2.site (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.7) with ESMTP id l18M3wPI017863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Thu, 8 Feb 2007 22:05:08 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Developing ACPI for Linux - FAQ
-------------------------------
Len Brown <lenb@kernel.org> (Intel Open Source Technology Center)
February 8, 2007


This file attempts to document how you can be most effective
in developing and improving Linux ACPI support.

Latest version:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/README.ACPI

Linux/ACPI home page:
http://acpi.sourceforge.net/

Mailing Lists
-------------
Inventory of lists: http://acpi.sourceforge.net/mailinglists.html

The main list is linux-acpi@vger.kernel.org.
Subscribe here: http://vger.kernel.org/vger-lists.html#linux-acpi
Note the 100KB message limit size and bugzilla availability below.

Which e-mail address to use?
----------------------------
For issues, discussion, RFC's, debugging etc:
to: linux-acpi@vger.kernel.org

To request an ACPI patch be applied to Linux:
to: lenb@kernel.org
cc: linux-acpi@vger.kernel.org

Feedback to (only) Intel on Intel's ACPICA,
or ACPI-related issues with NDA pre-production systems:
to: acpi@linux.intel.com

Len is on both of these lists, and he also sees traffic to
LKML, cpufreq, pci, and ia64 lists when the word ACPI appears in it.

Note that Len signs-off using "len.brown@intel.com" to make it clear
that he is employed by Intel.  While that address is functional,
lenb@kernel.org is preferred for public Linux work.

asus_acpi or asus-laptop specific e-mail:
to: acpi4asus-user@lists.sourceforge.net

ibm_acpi specific e-mail:
ibm-acpi-devel@lists.sourceforge.net

Bugzilla
--------
The Linux/ACPI community makes active use of bugzilla.
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
Note that this database is for kernel.org kernels only.

If an issue is specific to a distribution, it should
be filed in their database.

In both cases, please cc: acpi-bugzilla@lists.sourceforge.net
on the bug report.  You can subscribe to this list to see
all ACPI bugzilla updates:
https://lists.sourceforge.net/lists/listinfo/acpi-bugzilla
Note that this list is intended for bugzilla machine-generated
messages only.

If the distribution bug report is private due to being
on pre-production hardware and you want Intel's ACPI team
to know about it, then cc: acpi@linux.intel.com

Sometimes you'll see check-in comments including reference
to small bugzilla numbers, eg. (BZ 123), these refer to a
bugzilla database inside Intel where ACPICA issues
are tracked that don't apply directly to the Linux kernel
and thus would not fit within the charter of bugzilla.kernel.org.

While discussion-oriented issues are best dealt with
on the list, bugzilla has two useful properties:

1. you can attach a whole bunch of stuff there
   without irritating everybody on the list --
   including items > 100KB.
2. bugzilla never forgets -- so your issue
   will not get lost in the shuffle of e-mail overload.

Please be encouraged to file the supporting debug output
for your issue in bugzilla and refer to it
on the linux-acpi@vger.kernel.org list.

Patch Flow
----------
1. The community develops, reviews, and tests patches
2. Len checks them into the "acpi-test" tree
3. Andrew Morton incorporates acpi-test into mm as git-acpi.patch
4. Len moves mature patches from acpi-test to a release branch,
   and requests Linus pull it into the upstream kernel.
5. Distributors re-base their products onto Linus' kernel

If you send a patch, read and follow Documentation/SubmittingPatches

Proposed patches to the Linux/ACPI kernel sub-system should be
e-mailed to linux-acpi@vger.kernel.org
for review, comment, and testing by the community.
Many patches also are cc'd to linux-kernel@vger.kernel.org.
If the patch touches code outside drivers/acpi, that
is mandatory.

It is important to describe your expectations of the patch
in the e-mail.  If it is an experiment, or a debug patch,
please say so.  If you think it is well tested, broadly reviewed
and ready to integrate into the upstream kernel, say that
using the words "please apply", adding lenb@kernel.org the
"to: list" to make sure he sees your request.

Note that Len prefers patches in plain text, but if you need
to use attachments to deal with your mail client, that is okay too.

Len also takes patches directly from bugzilla entries.
Indeed, he tries to give priority to bugzilla fixes
because bugzilla does such a good job remembering the
details of the issue, and the people involved have taken
the trouble to carefully enter the data in bugzilla.

If you send a patch as an attachment, or attach it to bugzilla,
it is helpful if you format the patch according to SubmittingPatches,
ie. include a From:, Subject: and check-in comments before the patch body.

Len also integrates updates from ACPICA, the "ACPI
Component Architecture" -- the core interpreter that Intel
develops for the benefit of all ACPI operating systems.
(okay, all but Windows -- MS uses their own interpreter)
Intel publishes ACPICA under a dual source license so that
FreeBSD etc. can use it w/o GPL tainting.  Linux gets huge
benefits from sharing this core, and so preventing divergence
between Linux and the shared ACPICA code is why Len hates
to accept GPL patches to some files.  Note that the ACPICA
files are the ones in the sub-directories under drivers/acpi/*
plus a bunch of include/acpi/ headers.  All the other kernel files
in drivers/acpi/* and elsewhere are straight GPL -- as indicated
in their header copyright comments.

git
---
Len follows Tony Luck's method of using GIT branches, documented in
git/Documentation/howto/using-topic-branches.txt

The latest patches intended for Linus are here:
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

The latest patches intended for community testing are here:
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test

Andrew Morton periodically pulls the test branch and creates
a consolidated git-acpi.patch and applies it to his mm release.

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git acpica
Is a topic-specific branch containing the latest ACPICA interpreter.
It will get pulled into the test branch above when ready.
There may be other topic-specific branches from time to time.

Fetching code via git is the easiest way to stay up to date,
so get git and get going:

git pull git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test

Git startup instructions: http://linux.yyz.us/git-howto.html

Beware that Len takes the liberty of occasionally re-writing the history
of the test branch.  So you may have conflicts if you re-pull
into an "untouched" repo.  Sorry about that.  This is because
1. Andrew doesn't care about history, he makes it into 1 patch anyway.
2. Linux wants "clean history"
3. Len wants Linus to get exactly what was tested, merges and all.

So beware if you base a git tree on the acpi test branch.
If you do, it means Len will unlikely be able to pull your tree.
It is generally better to base your work off of Linus' tree, when possible.
Len will generally have to apply your work vs. Linus' tree anyway.

patches
-------
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release

includes patches from the Linux/ACPI git release branch.
Len publishes these when he sends a pull request to Linus.
If Linus doesn't pull for a while, this patch tells you what
is in the queue.  As soon as Linus pulls, however, this patch
becomes a duplicate of what is in Linus' tree and will thus
no longer apply.

The patches are named like so:
acpi-release-20050902-2.6.15-rc5.diff.gz
was created on the "release" branch,
some time after 2.6.15-rc5,
and includes ACPICA up through 20050902.

ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test

includes patches from the Linux/ACPI test branch,
as well as other topic branches such as acpica:
acpi-test-20050916-2.6.15-rc5.diff.gz
acpi-acpica-20051202-2.6.15-rc5.diff.gz

Len rarely publishes individual test patches here, since they can
now be pulled from the GUI using gitweb:
http://www.kernel.org/git/?p=linux/kernel/git/lenb/linux-acpi-2.6.git

patch signing
-------------
files on ftp.kernel.org compressed and signed per
http://www.kernel.org/signature.html

If you'd like to verify the signature, import key by:
gpg --keyserver wwwkeys.pgp.net --recv-keys 0x517D0F0E

verify integrity by:
gpg --verify <sigfile> <signed-file>

you can skip <signed-file> if it is in the same directory as <sigfile>.

applying patches
----------------
Both Test and Release patches have a header at the top of the patch
including the commit comments to describe what is included
in the patch.  Note you can test if a patch will apply cleanly
before you apply it for real:

$ cd my-src/linux/
To test
$ patch --dry-run -Np1 < acpi.patch
For real:
$ patch -Np1 < acpi.patch

Where do I get acpidump for capturing my systems ACPI tables?
-------------------------------------------------------------:w
Previously spelled acpidmp -- it is included in most distros.
If not, you can get the latest version from the latest
pmtools package here:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
See the README in the package for how to use it.

Where do I get iasl for dis-assembling and compiling tables?
------------------------------------------------------------
http://www.intel.com/technology/iapc/acpi/downloads.htm

Note that "iasl -d" can now not only dis-assemble a DSDT
and SSDT, but also most other ACPI table images.

Building a custom DSDT into the kernel
--------------------------------------
Get original DSDT:
# cp /proc/acpi/dsdt DSDT
or
# acpidump > acpidump.out
$ acpixtract DSDT acpidump > DSDT

Disassemble it
$ iasl -d DSDT
Make your changes:
$ vi DSDT.dsl
Build it:
$ iasl -tc DSDT.dsl
Put it where the kernel build can include it:
$ cp DSDT.hex $SRC/include/

Add this to the kernel .config:

CONFIG_STANDALONE=n
CONFIG_ACPI_CUSTOM_DSDT=y
CONFIG_ACPI_CUSTOM_DSDT_FILE="DSDT.hex"

Make the kernel and off you go!
You should see in dmesg:
Table [DSDT] replaced by host OS

Note that with
CONFIG_ACPI_DEBUG=y
then ASL stores to the special object "Debug" will
come out in the dmesg.  eg

Store("hello world!", Debug)
Store(Local0, Debug)

[ACPI Debug]  String: [0x0C] "hello world!"
[ACPI Debug]  Integer: 0x00000042

ACPI: Looking for DSDT ... not found!
-------------------------------------
This is a message from a patch that SuSE and Ubuntu
integrate into their distributions so that you can
over-ride the DSDT without re-compiling the kernel.

If you don't like the message, contact your distributor.

Len will not apply that patch upstream because he believes:
1. Modified firmware has no place on supported systems.
2. If Windows can handle un-modified firmware, Linux should too.
3. Linux distributors can not support systems running modified firmware.
4. If somebody is unable to re-build the kernel,
   then they have no business running modified platform firmware.


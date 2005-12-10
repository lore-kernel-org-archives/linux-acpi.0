From: Len Brown <lenb-Dj75qbTlC0E76Z2rM5mHXA@public.gmane.org>
Subject: How the Linux/ACPI patch flow works
Date: Fri, 9 Dec 2005 23:27:57 -0800
Message-ID: <200512100727.jBA7RvfW005872@hera.kernel.org>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

How the Linux/ACPI patch flow works
Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Dec 10, 2005

The latest version of this file lives here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/README.ACPI

This file describes how the Linux/ACPI patch flow works,
and where you can get Linux/ACPI kernel paches:
1. mailing lists
2. bugzilla
3. the Linux/ACPI git tree
4. plain patches on kernel.org

Mailing Lists
-------------
Issues with Linux/ACPI should be discussed on
acpi-devel-5NWGOfrQmneRv+LV9MX5uti2KpX7p8Fi@public.gmane.org

Note that acpi-devel has an 80KB message size limit,
which reminds people that big debug logs are
best filed in bugzilla...

Bugzilla
--------
The Linux/ACPI community makes active use of bugzilla.
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

While discussion-oriented issues are best dealt with
on the list.  Specific issues which require lots
of backing data, such as debug logs for specific
failing machines are best dealt with in bugzilla.

Many issues can use both simultaneously -- getting
attention to the issue on the list and storing
the backing data in bugzilla.

Patch Flow
----------
Len Brown (the author) is the maintainer for the
Linux Kernel ACPI sub-system.
He's responsible for the "smooth" flow of patches from
the community to Andrew's mm testing tree and to
Linus's kernel - quotes intentional:-)

Proposed patches to the Linux/ACPI kernel sub-system should be
e-mailed to acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org for
review, comment, and testing by the community.

It is important to describe your expectations of the patch
in the e-mail.  If it is an experiment, or a debug patch,
please say so.  If you think it is well tested, broadly reviewed
and ready to integrate into the upstream kernel, say that
using the words "please apply", adding len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org the
"to: list" to make sure he sees your request.

Note that Len is okay with patches in e-mail attachments
as well as in plain text.

If the patch touches code outside the ACPI sub-system,
then the same message should be cross-posted to
linux-kernel-u79uwXL29TaiAVqoAR/hOA@public.gmane.org

Len also takes patches directly from bugzilla entries.
Indeed, he usually gives priority to bugzilla fixes
because bugzilla does such a good job remembering the
details of the issue, and the people involved have taken
the trouble to carefully enter the data in bugzilla.

Len also incorporates updates from ACPICA, the "ACPI
Component Architecture" -- the core interpreter that Intel
develops for the benefit of all ACPI operating systems.
(okay, all but Windows -- MS uses their own interpreter)
Intel publishes ACPICA under a dual source license so that
FreeBSD etc. can use it w/o GPL tainting.  Linux gets huge
benefits from sharing this core, and so preventing divergence
between Linux and the shared ACPICA code is why Len hates
to accept GPL patches to some files.  Note that the ACPICA
files are the ones in the sub-directories drivers/acpi/* plus
a bunch of include/acpi/ headers.  All the other kernel files
in drivers/acpi/* and elsewhere are straight GPL -- as indicated
in their header comments.

git
---
Len follows Tony Luck's method of using GIT branches, documented in
git/Documentation/howto/using-topic-branches.txt

The latest patches intended for Linus are here:
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

The latest patches intended for community testing are here:
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test

This test branch is always a proper super-set of the release branch above.
Note that Andrew Morton routinely pulls this test branch into the mm tree
as git-acpi.patch.

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git acpica
Is a topic-specific branch containing the latest ACPICA interpreter.
It will get pulled into the test branch above when ready.
There may be other topic-specific branches from time to time.

Fetching code via git is the easiest way to stay up to date,
so get git and get going:

git pull git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test

Git startup instructions: http://linux.yyz.us/git-howto.html

patches
-------
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release

includes patches from the Linux/ACPI git release branch.
Len publishes these when he sends a pull request to Linus.
If Linus doesn't pull for a while, this patch tells you what
is in the queue.  As soon as Linus pulls, however, this patch
becomes a duplicate of what is in Linu's tree and will thus
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

Len rarely public individual test patches here, since they can
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

---
Questsion, comments, suggestions to len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org

Thanks,
-Len Brown
Intel Open Source Technology Center



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

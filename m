From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: How to help Len be a more effective maintainer...
Date: 19 Oct 2004 16:47:27 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098218847.26595.3764.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

As I chew on my patch backlog and e-mail backlog, I realize
that we can I can work together more effectively if the following
tips are more broadly known...

These are the best-known-methods right now.  I do seek
continuous improvement, and I'm open to your suggestions
if you have some.

thanks,
-Len

---

Sending Len e-mail.

  Don't send in HTML -- chances are high it will never be read.

  cc: linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org if you'd like others at Intel working on
  Linux/ACPI to see it too.  In general this is a good idea because
  that group is very effective at pestering me to not forget things,
  and I may end up asking somebody on that list to look into your
  issue anyway.

  cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org if you'd like Everybody On
  Earth working on Linux/ACPI to see it too.  Perfect for patches
  you'd like to get broad review.  Note that the linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
  folks are on this list too.

  cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org if non-ACPI-specific linux kernel
  aspects are included.

When sending a patch...

  Put me (len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) on the "to" line.  If you put others too,
  say who you're expecting to apply the patch.

  Include "[PATCH]" in "subject" line.

  cc as above, except almost always acpi-devel is the right cc
  for patches.

  In the e-mail text, describe the quality of the patch.  I.e. what
  tests did you run?  Is this an experiment and you're looking for
  feedback, or do you think it is ready to apply to the upstream
  kernel "please apply"?  If there is a bug open that the patch fixes,
  please mention the URL -- okay if kernel.org or a distro's bugzilla,
  as long as it can be seen by the public.  Include diffstat output
  for extra style points.

  Len works faster if you send patches as attachments, but others
  review patches only if plain text.  So unless the patch is huge,
  it doesn't hurt to do both.

  Patches should be created against Linus's tree, preferably the
  latest stable or newer.  Note that I generally apply patches to
  the "latest stable+ACPI_patch tree" (26-stable-test) and then use
  BK to pull the patch forward to the 26-latest-test tree to send
  to Linus.  If the patch will apply to the newer release only,
  I may skip applying to to the stable release patch.

  Patches should be created from "/usr/src"  eg.

  $ bk diffs -u drivers/acpi/my_file > my_file.patch
  $ diff -Naur old-tree new-tree > my.patch
  $ Documentation/BK-usage/gcapatch > my.patch
  $ bkexport -r+ > my.patch

  or whatever those encumbered with CVS do...

  So I can apply it with
  $ cd src; patch -Np1 < your.patch
  $ bk import -tpatch your.patch /usr/src
  or
  $ bkimport < your.patch

Working with -mm

  Andrew Morton pulls our ACPI patch from here
  http://linux-acpi.bkbits.net/linux-acpi-test-mm and includes it
  as bk-acpi.patch for every -mm release.

  This tree includes patches that are in the Linux pipeline from
  26-latest-test, as well as more experimental patches that may
  not be in the Linus pipeline yet.

  If you send the patch to Andrew and me, then if I apply it Andrew
  will realize that it is a duplicate when he tries to apply it on
  top of bk-acpi.patch.  In general, ACPI patches should come through
  me on the way to Andrew, but when I'm behind and not getting test
  patches out there, Andrew is a patch applying dynamo and you're
  welcome to see if something works in -mm before asking that I
  apply it to the ACPI tree and to it to Linus.

Working with bugzilla

  We take bugzilla entries seriously, and have found that this
  is the only practical way to address issues that can't be
  handled immediately on the mailing list.

  More than one accomplished kernel developer dislikes our
  use of bugzilla because they feel that it hides a lot
  of activity that should be exposed on the mailing list.
  If you want to see what is going on with a bug,
  add yourself to the CC: on the bug report, or join
  http://lists.sourceforge.net/lists/listinfo/acpi-bugzilla
  to see all that activity.

  File bugs here
  http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
  If the component isn't obvious to you, just pick "Other".

  Note that when a patch exists for a bug, it goes into
  the RESOLVED state.  It is CLOSED only after the bug
  fix is in Linus' tree.

Patch Acknowledgement

  I will reply-all via e-mail whenever I apply a patch.  So if you
  didn't get a reply yet, it isn't applied yet.  Feel free to send a
  reminder directly to me if I haven't replied within 10-days or so
  and you think I should have.




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

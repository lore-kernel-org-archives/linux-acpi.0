From: Al Stone <ahs3@redhat.com>
Subject: [PATCH v2 0/3] Correct errors in acpi_parse_entries_array()
Date: Fri, 19 Aug 2016 18:48:10 -0600
Message-ID: <1471654093-6962-1-git-send-email-ahs3@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754617AbcHTAsR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Aug 2016 20:48:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ahs3@redhat.com

Several strange things were found while prototyping a way to correctly
report whether or not an IORT is needed by an arm64 platform.  What the
prototype needed to do was iterate over the MADT subtables and look for
certain types of subtable, count how many there were by type, and capture
some info about some of the subtables.

When I first read through the acpi_parse_entries_array() function, the
comments seemed to describe precisely what I needed to do.  However, what
I found in trying to use the function is that that is not exactly how it
works.

So, the first patch fixes the counts of subtable types found so they are
correct.  Fortunately, nothing has relied on them being correct in the 
past, just non-zero or not.  This has also been noted by Baoquan He in a
patch he recently submitted.

The second patch fixes a problem where iterating over the subtables would
end earlier than necessary, again throwing off the counts; in this case,
I only needed to know how many of certain types of subtables were present,
but would never be able to get to a complete count.

The third patch removes part of a message that always reported an incorrect
value for the number of subtables skipped when there's a limit.  It always
reported zero, so it's never really been useful.

Longer term, I would like to simplify the way MADT and other ACPI tables
with subtables are parsed; mostly, I want to get rid of the need for using
file scoped variables.  The acpi_parse_entries_array() function can be a
good basis to build upon, as long as it works as expected.

Changes since v1:
  -- Much rewrite of the cover letter and changelogs to make sure the 
     motivation for the changes was captured (Rafael)
  -- Verified that the changes in semantics for the function are harmless;
     direct calls, parents/grandparents/.. of the direct calls were checked
     to make sure they did not depend on the current behavior in such a way
     as to break them with these changes (Rafael)
  -- Patch 3/3 was simplified; on further investigation, should additional
     callbacks be made to get the total skipped, there could be side effects
     or dependencies between callbacks that would make the original plan of
     iterating over all callbacks risky, for very little value (Rafael)

Al Stone (3):
  ACPI: fix incorrect counts returned by acpi_parse_entries_array()
  ACPI: fix acpi_parse_entries_array() so it traverses all subtables
  ACPI: do not report the number of entries ignored by
    acpi_parse_entries()

 drivers/acpi/tables.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.7.4


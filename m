From: Al Stone <ahs3@redhat.com>
Subject: [PATCH 0/3] Correct errors in acpi_parse_entries_array()
Date: Fri,  1 Jul 2016 15:21:18 -0600
Message-ID: <1467408081-7418-1-git-send-email-ahs3@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55140 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961AbcGAVWP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Jul 2016 17:22:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ahs3@redhat.com

In examining the function acpi_parse_entries_array() for use in another
patch series, I realized the commentary and the code do not agree.
Assuming the commentary is correct, this function will do as I need;
that is not, however, what it does.

The first patch fixes an error where only the very first count element
of a struct in an array of structs gets incremented.  My understanding
of the comments is that the count element for each struct in the array
should be incremented instead.  With the patch, it will.

The second patch causes the function to actually traverse all subtables
just like the comments indicate.  Previously, on any sort of error the
loop would terminate completely, but I really do want to visit all of
the entries even if some need to be ignored.

The final patch corrects the printout when more entries are found than
can actually be handled.  The original code would incorrectly count the
number of entries ignored since it would alway stop the traversal when
the limit on entries was reached, regardless of whether there were
additional entries that still had not been examined.

Looking at the direct and indirect users of acpi_parse_entries_array(),
they all appear to depend on the return value from the function being
either > 0 or < 0, and not a specific value.  Hence, the changes here
have no effect on them.

However, the use case I have in mind traverses the MADT in order to
count not only subtables of a specific type, but also subtables of a
specific type that contain specific values.  With these fixes, I can
make one call to acpi_parse_entries_array() using very small callback
functions and do what I need, and get the correct results.

Tested on arm64 and x86_64, with simple booting, comparison of boot
logs, and daily use over the last couple of days.


Al Stone (3):
  ACPI: fix incorrect counts returned by acpi_parse_entries_array()
  ACPI: fix acpi_parse_entries_array() so it traverses all subtables
  ACPI: fix acpi_parse_entries_array() so it reports overflow correctly

 drivers/acpi/tables.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
2.7.4


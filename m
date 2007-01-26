From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 0/7] New misc/asus-laptop.c driver
Date: Fri, 26 Jan 2007 02:51:04 -0500
Message-ID: <200701260251.04762.lenb@kernel.org>
References: <200701251254.34491.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35918 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030789AbXAZH6Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jan 2007 02:58:25 -0500
In-Reply-To: <200701251254.34491.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

On Thursday 25 January 2007 06:54, Corentin CHARY wrote:
> Hi,
> I've done a lot of work on asus_acpi
Excellent.

A couple of nits on e-mail patch format:

Please fit the comments within 80 lines.
ie. pipe them through fmt -w 68 or something.

The --- in your e-mail should come before the diffstat, not after.

thanks,
-Len

>From Documentation/SubmittingPatches

12) The canonical patch format

The canonical patch subject line is:

    Subject: [PATCH 001/123] subsystem: summary phrase

The canonical patch message body contains the following:

  - A "from" line specifying the patch author.

  - An empty line.

  - The body of the explanation, which will be copied to the
    permanent changelog to describe this patch.

  - The "Signed-off-by:" lines, described above, which will
    also go in the changelog.

  - A marker line containing simply "---".

  - Any additional comments not suitable for the changelog.

...
The "---" marker line serves the essential purpose of marking for patch
handling tools where the changelog message ends.

One good use for the additional comments after the "---" marker is for
a diffstat, to show what files have changed, and the number of inserted
and deleted lines per file.  A diffstat is especially useful on bigger
patches.  Other comments relevant only to the moment or the maintainer,
not suitable for the permanent changelog, should also go here.
Use diffstat options "-p 1 -w 70" so that filenames are listed from the
top of the kernel source tree and don't use too much horizontal space
(easily fit in 80 columns, maybe with some indentation).

  - The actual patch (diff output).
...

From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: [ibm-acpi-devel] CONFIG_IBM_BAY
Date: Tue, 20 Mar 2007 16:25:11 -0400
Message-ID: <41840b750703201325r37f62427j6b2b5bb5ea063f83@mail.gmail.com>
References: <200703150206.05811.lenb@kernel.org>
	 <20070315080644.c73db24a.kristen.c.accardi@intel.com>
	 <20070315175505.GB6596@khazad-dum.debian.net>
	 <20070315110156.09e80b99.kristen.c.accardi@intel.com>
	 <20070315193123.GB14394@khazad-dum.debian.net>
	 <20070319120455.GI11371@thunk.org>
	 <20070319232419.GC5932@khazad-dum.debian.net>
	 <20070320145722.GB6043@thunk.org>
	 <20070320151443.GB13042@khazad-dum.debian.net>
	 <20070320184541.GB29493@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:15534 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934065AbXCTUZN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Mar 2007 16:25:13 -0400
Received: by wr-out-0506.google.com with SMTP id 41so7417wry
        for <linux-acpi@vger.kernel.org>; Tue, 20 Mar 2007 13:25:12 -0700 (PDT)
In-Reply-To: <20070320184541.GB29493@thunk.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Len Brown <lenb@kernel.org>

On 3/20/07, Theodore Tso <tytso@mit.edu> wrote:
> > Urk.  It is better to either fail the suspend, or to not power down the bay.
> > Or to give the user a choice of which he'd rather happen.  Hmm...
>
> Yeah, I think it needs to be configurable.  In many cases the right
> thing to do is for the user to promise not to swap out bay, and in the
> exception case where they do, all of the processes that have files
> open on that bay will have to get their fd's revoked.  We can try to
> make it less likely for there to be data loss, like asking filesystems
> that support write_super_lockfs() to quiesce the filesystem before the
> suspend, but the assumption should be that users aren't supposed to be
> swapping out the bay if they request the suspend code not to
> disconnect the filesystem.

This is sensical and useful for other devices as well (e.g., USB flash drives).
So the interface, and preferably the implementation too, should be generic.

  Shem

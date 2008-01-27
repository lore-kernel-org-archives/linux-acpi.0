From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] Allocate pnp resources dynamically via krealloc - working version
Date: Sun, 27 Jan 2008 23:03:00 +0200
Message-ID: <84144f020801271303w4d8c1fe9tbf7058ac518d4d29@mail.gmail.com>
References: <1200772810.3708.42.camel@queen>
	 <84144f020801191623i2ad344a8t1c40969578793d13@mail.gmail.com>
	 <1201109917.20940.214.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:28704 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbYA0VDB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Jan 2008 16:03:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2559874wah.23
        for <linux-acpi@vger.kernel.org>; Sun, 27 Jan 2008 13:03:00 -0800 (PST)
In-Reply-To: <1201109917.20940.214.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Rene Herman <rene.herman@keyaccess.nl>, linux-kernel <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>

Hi Thomas,

On Sun, 2008-01-20 at 02:23 +0200, Pekka Enberg wrote:
> > When krealloc() returns NULL, there wasn't enough memory to fit the
> > new size but the original memory region remains unchanged.

On Jan 23, 2008 7:38 PM, Thomas Renninger <trenn@suse.de> wrote:
> Thanks Pekka, this one should be better now:

Yeah, the krealloc() bits look good me. Thanks!

                         Pekka

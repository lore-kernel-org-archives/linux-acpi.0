From: Tony Luck <tony.luck@gmail.com>
Subject: Re: trace, RAS: New eMCA trace event interface
Date: Mon, 10 Mar 2014 11:55:24 -0700
Message-ID: <CA+8MBbLBZLJW=4ahJn5uCvXdj4Q4uP_U9joxgsFJXV5Yp7PBWA@mail.gmail.com>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
	<5316136f1918986e5@agluck-desk.sc.intel.com>
	<20140307061047.5c901413@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:45288 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbaCJSzZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Mar 2014 14:55:25 -0400
Received: by mail-ve0-f175.google.com with SMTP id oz11so7420414veb.6
        for <linux-acpi@vger.kernel.org>; Mon, 10 Mar 2014 11:55:24 -0700 (PDT)
In-Reply-To: <20140307061047.5c901413@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, "arozansk@redhat.com" <arozansk@redhat.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, Mar 7, 2014 at 1:10 AM, Mauro Carvalho Chehab
<m.chehab@samsung.com> wrote:
> As I just pointed, we'll also need some code at the rasdaemon that would
> associate the CPER error location data into the corresponding DIMM label.

In most cases the kernel will provide a label (that it got from
SMBIOS). I assume
this is for the case that the SMBIOS table is bad?

I haven't looked too hard at how EDAC does this - the "--register-labels" option
to edac-ctl?  Since we don't have a sysfs interface for extlog - perhaps any
translation can be handled entirely in rasdaemon(8).

-Tony

From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/5] ACPI: WMI: Add sysfs userspace interface
Date: Wed, 6 Feb 2008 22:49:11 -0500
Message-ID: <200802062249.11619.lenb@kernel.org>
References: <20080205021658.4422.83165.stgit@pacifica> <200802052259.25466.carlos@strangeworlds.co.uk> <200802061136.12426.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40793 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226AbYBGDuM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Feb 2008 22:50:12 -0500
In-Reply-To: <200802061136.12426.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On Wednesday 06 February 2008 06:36, Carlos Corbacho wrote:
> On Tuesday 05 February 2008 22:59:24 Carlos Corbacho wrote:
> > Unfortunately, as you can see this isn't nice, and very racy. To point out
> > the more glaring flaws:
> >
> > 1) instance and method_id can be changed before we start reading and
> > writing in any data.
> >
> > 2) Executing a method involves reading back from the 'data' file (but if we
> > don't care about the output, this makes little sense). If anything changes
> > before this, then either the method will fail, or we may not execute what
> > we intended to.
> 
> On these two points, we could use locking (but this would only be advisory, 
> and rely on other programs not trying to write while we do), but we'd need to 
> rejig how this works a bit (since reading 'data' here triggers execution.
> 
> (So, basically, in future, shoving this all into a C library to abstract the 
> WMI sysfs file access).

In either case, ioctl or sysfs, a library is probably appropriate.
However, with the ioctl, it sounds like the driver is able to enforce
consistency of a transaction, while multiple users of a sysfs I/F
may get confused, or worse.

So the question is if the sysfs I/F is useful for development or not,
since it doesn't look like the right I/F in the long run.

Shall I drop patches #4 and #5, or would you like to send an update?

thanks,
-Len

> > 3) For method execution, this really comes across as rather 'clunky' means
> > to do so
> 
> This point is still valid.
> 
> Maybe changing a method to the following:
> 
> <GUID>/
> |--> instance_count
> |--> instance
> |--> method_id
> |--> in
> |--> out
> |--> execute
> 
> Then to execute a method:
> 
> 1) Write lock instance, method_id, in, out and execute.
> 
> 2) Write the instance and method_id to be executed to their respective files. 
> Write the input data for the method to 'in'.
> 
> 3) Write '1' to execute the method, store the returned data in 'out' 
> (writing '0' to 'execute' would clear everything instead). (We can always 
> return the error code by reading execute).
> 
> 4) Read 'out' to retrieve any data.
> 
> (I don't want to make reading 'out' trigger the execution, since we can't 
> guarantee a read lock between languages).
> 
> For data blocks, we can do something similar.
> 
> Any thoughts? It's still a little clunky, and I'm still not sure whether an 
> ioctl would still be preferable to all this?
> 
> -Carlos

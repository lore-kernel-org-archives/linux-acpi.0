From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 4/5] ACPI: WMI: Add sysfs userspace interface
Date: Wed, 6 Feb 2008 11:36:11 +0000
Message-ID: <200802061136.12426.carlos@strangeworlds.co.uk>
References: <20080205021658.4422.83165.stgit@pacifica> <20080205021721.4422.58508.stgit@pacifica> <200802052259.25466.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cyberslack.slackadelic.com ([216.23.240.152]:48363 "EHLO
	mail.slackadelic.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbYBFLgP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Feb 2008 06:36:15 -0500
In-Reply-To: <200802052259.25466.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tuesday 05 February 2008 22:59:24 Carlos Corbacho wrote:
> Unfortunately, as you can see this isn't nice, and very racy. To point out
> the more glaring flaws:
>
> 1) instance and method_id can be changed before we start reading and
> writing in any data.
>
> 2) Executing a method involves reading back from the 'data' file (but if we
> don't care about the output, this makes little sense). If anything changes
> before this, then either the method will fail, or we may not execute what
> we intended to.

On these two points, we could use locking (but this would only be advisory, 
and rely on other programs not trying to write while we do), but we'd need to 
rejig how this works a bit (since reading 'data' here triggers execution.

(So, basically, in future, shoving this all into a C library to abstract the 
WMI sysfs file access).

> 3) For method execution, this really comes across as rather 'clunky' means
> to do so

This point is still valid.

Maybe changing a method to the following:

<GUID>/
|--> instance_count
|--> instance
|--> method_id
|--> in
|--> out
|--> execute

Then to execute a method:

1) Write lock instance, method_id, in, out and execute.

2) Write the instance and method_id to be executed to their respective files. 
Write the input data for the method to 'in'.

3) Write '1' to execute the method, store the returned data in 'out' 
(writing '0' to 'execute' would clear everything instead). (We can always 
return the error code by reading execute).

4) Read 'out' to retrieve any data.

(I don't want to make reading 'out' trigger the execution, since we can't 
guarantee a read lock between languages).

For data blocks, we can do something similar.

Any thoughts? It's still a little clunky, and I'm still not sure whether an 
ioctl would still be preferable to all this?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D

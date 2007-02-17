From: Len Brown <lenb@kernel.org>
Subject: Re: breakage in current git-acpi
Date: Sat, 17 Feb 2007 02:25:07 -0500
Message-ID: <200702170225.07774.lenb@kernel.org>
References: <20070216223956.d04af327.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45718 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946609AbXBQH03 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Feb 2007 02:26:29 -0500
In-Reply-To: <20070216223956.d04af327.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

On Saturday 17 February 2007 01:39, Andrew Morton wrote:
> 
> Standard FC5 RH install, it is set up to suspend to disk when I close the
> lid.
> 
> With git-acpi.patch applied, this just stops working on the second or third
> attempt.  It's like acpid just didn't see the lid close at all.  Closing
> the lid causes no kernel messages at all.
> 
> Any suggestions as to how to debug this, apart from git-bisect, which will
> take rather a long time?

nuke kacpid and cat /proc/acpi/event

click the lid a bunch of times and also the power button
you should see the acpi line in /proc/interrupts tick each time,
and a message come out of /proc/acpi/event

Also, you should be able to see the state of the lid in a file under /proc/acpi/button/*/

-Len

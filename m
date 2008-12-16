From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: reverted battery current conversion fix
Date: Tue, 16 Dec 2008 11:43:07 +0300
Message-ID: <49476A1B.7020107@suse.de>
References: <87zlixxaht.fsf@szonett.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:36169 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751007AbYLPInI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Dec 2008 03:43:08 -0500
In-Reply-To: <87zlixxaht.fsf@szonett.ki.iif.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-acpi@vger.kernel.org, "Rafael J.Wysocki" <rjw@sisk.pl>

Ferenc Wagner wrote:
> Hi Alex,
> 
> I sadly noticed that your fix 558073dd was overridden by aaad0776 and
> later reverted altogether by f10a3a32.  I haven't found any discussion
> of the latter two patches, but I agree that Rafael's fix was wrong, as
> it converted the current into A instead of uA, since voltage_now is in
> mV and current_now is in mW on the new code path, and mW/mV=A.  I
> skimmed the code, but didn't find a place where the kernel provided
> time estimates, so the wild values Rafael experienced probably came
> from some application, which previously worked around the wrong sysfs
> current value (supposedly correctly interpreting it as power) and thus
> got broken by the fix.  But all of this is guesswork, I'm hunting for
> hard data.  Until I get around compiling and testing a new kernel with
> /proc/acpi, can you provide some insight?  I'm not subscribed to the
> relevant MLs, so maybe just didn't find all the pieces in the archives.
Yes, the application is kpowersaved and it is written with the assumption
that it could get remaining time by dividing either energy_now or charge_now 
by current_now.

Regards,
Alex.

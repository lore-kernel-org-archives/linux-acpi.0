From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/2] ACPI / tables: simplify acpi_parse_entries
Date: Thu, 15 Oct 2015 23:37:18 +0200
Message-ID: <1716674.6oaNdqBolQ@vostro.rjw.lan>
References: <1442408287-10410-1-git-send-email-sudeep.holla@arm.com> <561FC9E9.20507@arm.com> <561FCCF2.8010908@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46470 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752231AbbJOVIf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2015 17:08:35 -0400
In-Reply-To: <561FCCF2.8010908@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>

On Thursday, October 15, 2015 09:57:38 AM Al Stone wrote:
> On 10/15/2015 09:44 AM, Sudeep Holla wrote:
> > Hi Rafael,
> > 
> > On 01/10/15 16:11, Sudeep Holla wrote:
> >> acpi_parse_entries passes the table end pointer to the sub-table entry
> >> handler. acpi_parse_entries itself could validate the end of an entry
> >> against the table end using the length in the sub-table entry.
> >>
> >> This patch adds the validation of the sub-table entry end using the
> >> length field.This will help to eliminate the need to pass the table end
> >> to the handlers.
> >>
> >> It also moves the check for zero length entry early so that execution of
> >> the handler can be avoided.
> >>
> >> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > 
> > Now that Al's MADT is queued, can you consider applying these ?
> > 
> 
> I think we have to remove my patches from the queue until I can make
> them arch-specific; doing these MADT checks breaks far too many existing
> x86 systems where the firmware does things it should not;

Right.  I've dropped the series already.

> re-reading some of the ia64 kernel code, there's a pathological case there
> where it could break (but shouldn't if iasl is being used to compile tables).

I wouldn't count on iasl being used.

> I'll be working on the new version today.

Thanks!

Rafael


From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: 2.6.34-rc1: ACPI: BUG: key f71f0168 not in .data!
Date: Fri, 12 Mar 2010 20:58:36 -0800
Message-ID: <m1sk843jib.fsf@fess.ebiederm.org>
References: <a4423d671003081547v5c955d58t248db945c06d2a7f@mail.gmail.com>
	<86802c441003081612r2f44efd6n9664b4b7c98a636a@mail.gmail.com>
	<m1d3zel4b4.fsf@fess.ebiederm.org> <4B95F37E.6060309@kernel.org>
	<m14okqnczd.fsf@fess.ebiederm.org> <4B99A6F0.4080203@kernel.org>
	<4B9B0868.7080807@kernel.org>
	<1268455576.2802.750.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:38327 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933750Ab0CME6l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Mar 2010 23:58:41 -0500
In-Reply-To: <1268455576.2802.750.camel@mulgrave.site> (James Bottomley's message of "Fri\, 12 Mar 2010 22\:46\:16 -0600")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Alexander Beregalov <a.beregalov@gmail.com>, Greg KH <gregkh@suse.de>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Fri, 2010-03-12 at 19:37 -0800, Yinghai Lu wrote:
>> ---
>>  drivers/base/attribute_container.c |    1 +
>>  drivers/scsi/lpfc/lpfc_attr.c      |    3 +++
>>  drivers/scsi/scsi_sysfs.c          |   15 ++++++++++++---
>>  3 files changed, 16 insertions(+), 3 deletions(-)
>
> Added linux-scsi, since this seems to be a SCSI fix.
>
> I've no idea what actual problem this is fixing, what's the descriptive
> changelog for this?

The root problem is that we occasionally have unrecognized deadlocks
on the sysfs attributes.

For 2.6.33 I managed to get lockdep mostly working but there the way
I did it generated a lot of false positives.

For 2.6.34 I reworked the sysfs lockdep handling to remove the false
positives by treating each sysfs attribute as it's own class.  Most
sysfs attributes are declared statically and don't need any
initialization.  Unfortunately there are a handful of dynamically
allocated sysfs attributes that do need initialization.

This patch is a fix to get one of those last handful of dynamically
allocated sysfs attributes that I missed and apparently do not
exist in my test system.

None of this has any effect (for now) when lockdep is disabled.

Eric

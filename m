From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Buggy BIOS on the HP TX2500-series
Date: Thu, 9 Oct 2008 07:18:57 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308580312311B@orsmsx503.amr.corp.intel.com>
References: <331496.52627.qm@web23007.mail.ird.yahoo.com>
	 <20081008192641.GA1932@srcf.ucam.org> <1223513955.2735.28.camel@rzhang-dt>
	 <20081009011150.GA7496@srcf.ucam.org>
	 <alpine.LFD.1.10.0810082203280.8572@localhost.localdomain>
	 <1223534216.2735.106.camel@rzhang-dt> <1223534725.2735.116.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26365 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757228AbYJIOTh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Oct 2008 10:19:37 -0400
In-Reply-To: <1223534725.2735.116.camel@rzhang-dt>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Gandalf Kristensen <gandkri@yahoo.no>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Lin, Ming M" <ming.m.lin@intel.com>

Yes, windows returns zero in this case, with no error.

Therefore, we have achieved windows compatibility, which is one of the main goals for ACPICA at this time.



>-----Original Message-----
>From: Zhang, Rui
>Sent: Wednesday, October 08, 2008 11:45 PM
>To: Len Brown; Moore, Robert
>Cc: Matthew Garrett; Gandalf Kristensen; linux-acpi@vger.kernel.org; Rafael
>J. Wysocki; Lin, Ming M
>Subject: Re: Buggy BIOS on the HP TX2500-series
>
>On Wed, 2008-10-08 at 23:36 -0700, Zhang Rui wrote:
>> On Wed, 2008-10-08 at 19:04 -0700, Len Brown wrote:
>> >
>> > On Thu, 9 Oct 2008, Matthew Garrett wrote:
>> >
>> > > On Thu, Oct 09, 2008 at 08:59:15AM +0800, Zhang Rui wrote:
>> > > > On Wed, 2008-10-08 at 12:26 -0700, Matthew Garrett wrote:
>> > > > > A patch went into the kernel earlier this year to ignore critical
>trip
>> > > > > points that were below 0.
>> > > > well, I think this patch is wrong.
>> > > > a critical trip point below 0 Celsius doesn't mean it's invalid.
>> > >
>> > > I think it's pretty clear that a critical trip point below 0 celsius
>> > > means that the critical trip point is invalid,
>> well, I agree that this workaround can work here.
>> But I think the proper way to fix this issue is that,
>> ACPICA returns some error code(AE_BAD_DATA) like it did before,
>> and the thermal driver knows that it got an invalid value and
>> should take it carefully.
>Bob, do you mean Windows return 0 in this case?
>
>> or else we may still get potential problems, e.g. what if there
>> is no return value of _PSV method.
>If it's true, then we don't need to waste our time on this.
>it won't happen because windows doesn't work either in this case, unless
>it workarounds this problem again like it has done for _CRT, right?
>
>thanks,
>rui
>>
>> > though I agree that
>> > > ignoring the entire thermal zone as a result is somewhat unfortunate.
>> > >
>> > > > windows can work well on this laptop.
>> > > > please look at:
>> > > > http://bugzilla.kernel.org/show_bug.cgi?id=10686#c13
>> > > > IMO, we need to fix the ACPICA code first of all.
>> > > >
>> > > > Ming, what do you think of the patch in comment #15 and #16?
>> > >
>> > > We could quibble over the technical correctness of this approach, but
>it
>> > > seems to behave in exactly the same way - ie, Linux will ignore the
>> > > thermal zone? The existing code seems fine, other than the fact that
>a
>> > > bad _CRT will result everything failing. I think we'd be better off
>just
>> > > losing the return -ENODEV there and try to use as much of the thermal
>> > > information as we can.
>> >
>> > right, when we put in the workaround we observed that a bad _CRT
>> > would delete an entire thermal zone, and that could be a big
>> > problem on a box with active cooling on that thermal zone.
>> Hmm, I think a patch like this is enough to fix this problem.
>>
>>
>> ignore invalid critical trip point.
>>
>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>> ---
>>  drivers/acpi/thermal.c |    3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> Index: linux-2.6/drivers/acpi/thermal.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/acpi/thermal.c
>> +++ linux-2.6/drivers/acpi/thermal.c
>> @@ -373,9 +373,8 @@ static int acpi_thermal_trips_update(str
>>                 if (ACPI_FAILURE(status) ||
>>                                 tz->trips.critical.temperature <= 2732) {
>>                         tz->trips.critical.flags.valid = 0;
>> -                       ACPI_EXCEPTION((AE_INFO, status,
>> +                       ACPI_DEBUG_PRINT((ACPI_DB_WARN,
>>                                         "No or invalid critical
>threshold"));
>> -                       return -ENODEV;
>>                 } else {
>>                         tz->trips.critical.flags.valid = 1;
>>                         ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


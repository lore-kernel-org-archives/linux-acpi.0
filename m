From: Colin Cross <ccross@android.com>
Subject: Re: PM: Summary of changes for v3.6
Date: Tue, 17 Jul 2012 13:53:52 -0700
Message-ID: <CAMbhsRQHMu-zzkhJxYLvszQ2+=OVEJwKrCTbGCjpYGtnP-tttg@mail.gmail.com>
References: <201207162246.03660.rjw@sisk.pl>
	<87mx2zcq62.fsf@ti.com>
	<201207172252.06093.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:50103 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab2GQUxx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2012 16:53:53 -0400
Received: by ghrr11 with SMTP id r11so886130ghr.19
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2012 13:53:53 -0700 (PDT)
In-Reply-To: <201207172252.06093.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

On Tue, Jul 17, 2012 at 1:52 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> On Tuesday, July 17, 2012, Kevin Hilman wrote:
>> Rafael, Daniel,
>>
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>>
>> > Hi all,
>> >
>> > All of the changes I'd like to include into the first PM pull request during
>> > the v3.6 merge window, except maybe for one or two patches I know are in the
>> > works, is on the 'linux-next' branch of the linux-pm.git tree now.  The summary
>> > of those changes is appended.  If anyone finds any of them objectionable,
>> > please let me know ASAP.  Also please let me know if you have any power
>> > management patches you'd like me to take for v3.6.
>> >
>>
>> Could someone please clarify the status of the coupled CPUidle series?
>>
>> There's a version of these in Daniels cpuidle-next branch and there's a
>> version of these in Len's next branch (included in linux-next), but I'm
>> still not entirely sure which branch is going upstream and which branch
>> has the latest version (but I think Daniel's is the latest)
>
> Colin says that the commits in the Len's tree match his latest version,
> so I think those commits should be merged, since they have been present
> in that tree since the 3.5 merge window.

The disappeared from Len's tree for a little while after the 3.5 merge
window, which is why they started appearing other places.  Now that
they have returned to Len's tree, hopefully to stay, they should be
considered the official version.

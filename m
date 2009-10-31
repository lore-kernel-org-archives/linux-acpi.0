From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [linux-pm] intermittent suspend problem again
Date: Sat, 31 Oct 2009 12:02:02 +0000
Message-ID: <9b2b86520910310502p7fe8e0edmff09220632fab5e2@mail.gmail.com>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <200910301918.53301.rjw@sisk.pl>
	 <87k4yc3drd.fsf@tac.ki.iif.hu> <200910302138.37938.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:58678 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbZJaMCA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 31 Oct 2009 08:02:00 -0400
In-Reply-To: <200910302138.37938.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ferenc Wagner <wferi@niif.hu>, linux-pm@lists.linux-foundation.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>, yakui.zhao@intel.com, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On 10/30/09, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday 30 October 2009, Ferenc Wagner wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>>
>> > On Thursday 29 October 2009, Ferenc Wagner wrote:
>> >
>> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:

>> >> and saving the image as well.  If s2disk didn't report funny huge
>> >> negative
>> >> ratios all the time,
>> >
>> > Hmm.  This looks like a bug in s2disk.
>>
>> Definitely.  Do you also experience this?
>
> Not really, but I use newer versions.
>
>> Probably an easy one, but I've never had the chance to check the CVS
>> version
>> (running 0.7 at the moment).  I can probably give 0.8 a spin if you deem
>> necessary.  I always thought it wasn't more than a cosmetic flaw.
>
> It probably is.  You can try the current version from my git tree at:
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-utils.git
>
> Thanks,
> Rafael

I seem to recall reporting this and finding that the latest version
fixed the bug simply by removing the code which printed the ratio :-).

Regards
Alan

From: ole.rohne-vJEk5272eHo@public.gmane.org
Subject: Re: Radeon PM Support
Date: 06 Aug 2004 08:13:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <yzosmb0hjzu.fsf@pb-d-128-141-40-189.cern.ch>
References: <1091139240.26511.9.camel@6-allhosts>
	<20040730141028.GE21359@luna.mooo.com>
	<20040730162756.4f300a5c@localhost>
	<20040730190047.GH21359@luna.mooo.com>
	<1091560208.24759.15.camel@6-allhosts>
	<41103952.2030707@optonline.net>
	<1091583216.2974.2.camel@localhost.localdomain>
	<1091590835.2304.64.camel@dhcppc4>
	<yzohdrjqu6p.fsf@localhost.localdomain>
	<1091631174.2297.90.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Acpi Devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Erik Tews <erik-KVSZC2aA8+zw/snApU8qRLNAH6kLmebB@public.gmane.org>, Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>, Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Len> I would like a solution that applies to x86_64 in addition to
Len> i386.

What would it take?

I know absolutely nothing about that architecture. From
arch/x86_64/kernel/acpi/wakeup.S it seems to support some form of real
mode, so could it do the return to real mode just like i386?

Len> Can you summarize the feedback you've got so far?

Failures and success:
=====================
One failure report (Stefan), that's the Radeon 7000 failure you're
referring to. It's an AGP system, I'm anxious to know if adding the
bus number helps.

Two success reports, both with Dell d660/Radeon 9000.

My own machine is a Fujitsu P2120/Radeon Mobility M6 LY.

Len> Can you re-post the cleaned up patch?

It's on my todo list:-)

Len> Maybe good to go to lkml with it for broader review and feedback.

"lkml" - is that the linux kernel mailing list? I'm not a seasoned
kernel patch provider.

Ole






-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com

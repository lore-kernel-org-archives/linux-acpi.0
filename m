From: ole.rohne-vJEk5272eHo@public.gmane.org
Subject: Re: Radeon PM Support
Date: 06 Aug 2004 16:05:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <yzo7jscnyyu.fsf@localhost.localdomain>
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
	<yzosmb0hjzu.fsf@pb-d-128-141-40-189.cern.ch>
	<41138A16.5000908@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41138A16.5000908-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ole> One failure report (Stefan), that's the Radeon 7000 failure you're
Ole> referring to. It's an AGP system,

It is actually a Radeon 9000, however AGP

Nathan> Maybe we need proper AGP save/restore before we can POST?

I'd strongly suspect so, I was stupidly assuming it was there
already...

This could be a possible explanation for the problems that the two
Stefans are seeing: POSTing with XFree86 works because XFree86 does
the AGP restoration.

Ole



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com

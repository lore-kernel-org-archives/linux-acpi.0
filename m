From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Is it possible for ACPI to blow up the battery?
Date: Fri, 28 Jan 2005 13:04:08 +0100
Message-ID: <20050128120407.GA6725@elf.ucw.cz>
References: <41F7FD56.8090309@calt129.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41F7FD56.8090309-iP/H7R5l9gZBDgjK7y7TUQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?C=FCneyt?= <cu_lists-iP/H7R5l9gZBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> It may be really a dumb question, but I've really no idea.
> 
> I have a Samsung P10 and found at behnel.de & SF-ACPI page some 
> instructions to patch the DSDT table under Suse 9.1pro. I followed those 
> as close as I can and I guess ACPI works somehow. Well, wakeup after 
> sleep and CPU-throttling doesn't work though :(
> 
> Now to my dismay the battery stopped charging at all, it is completely 
> empty. No matter what I do, it doesn't get charged. The battery is about 
> 2 yrs old but was pretty OK before, i.e. lasted about 1.5 hrs unplugged. 
> Is it possible for DSDT patches to blow up the battery & charging units 
> or you think the battery's (physically) died all of a sudden?

Well, hard to say, everything is possible, and so far I seen a lot of
funny stuff, but every time it recovered at least after removing
battery and removing AC for more than minute.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl

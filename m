From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: Sneaking patches in (was Re: System hang when trying to
 enter sleep/standby state)
Date: Sun, 16 Feb 2003 17:57:58 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302161742160.1039-100000@localhost.localdomain>
References: <20030217150005.GA6429@zaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030217150005.GA6429-VNkyu7EogrqGmfs5Z0+9fw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> Are we playing patch wars or what?

Not at all. The changes were discussed and sent to Andy, who had me 
forward them to Linus. The issue in question - disallowing the user from 
entering S5 directly from /proc/acpi/sleep was discussed on the list, and 
Andy agreed that it should be removed. 

> I have not seen any patch on the lists, *and*
> you also moved big blocks of code to hide your
> changes. That's pretty nasty behaviour.

That's not true. The patch to make that change is here: 

http://marc.theaimsgroup.com/?l=acpi4linux&m=104508487609853&w=2

And the accusation about moving large blocks of code to cover it up is 
completely unfair. It's not a conspiracy. 

It was also explained, along with every other change in the changelog
entries. I know that you are opposed to using BitKeeper, so I recommend 
that you subscribe to, or read, the bk-commits-head list, which has every 
patch Linus commits, with diffstat output and full changelogs for each. 

You can find info here: 

http://vger.kernel.org/vger-lists.html

and an archive here:

http://marc.theaimsgroup.com/?l=bk-commits-head&r=1&w=2

FYI, there is also a bk-commits-24 for 2.4 commits by Marcelo.

	-pat






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

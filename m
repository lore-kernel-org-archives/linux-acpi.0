From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Is it possible to have more than two batteries in a laptop?
Date: Mon, 30 Sep 2002 02:12:14 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020930021214.B35@toy.ucw.cz>
References: <20020929195545.79555136.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020929195545.79555136.hanno-Mmb7MZpHnFY@public.gmane.org>; from hanno-Mmb7MZpHnFY@public.gmane.org on Sun, Sep 29, 2002 at 07:55:45PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?Hanno_B=F6ck?= <hanno-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I'm currently working on a patch for the gnome battery-applet (battstat-applet) to work with two batteries.
> Now I have a version working with two batteries, but it would not work if there are more than two batteries.
> So I wanted to know if there are laptops which can have more than two batteries at the same time?
> If not, my patch is fine. If yes, I would have to enhance it.
> 
> (If you are interested in the patch: it's against gnome-applets-2.0.3 and you can grab it at:
> www.gentoo.org/~hanno/battstat_two_batteries.diff
> )
> 

You should look at ACPI spec. I hope they were not so stupid to limit themselves
to 2...
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.



-------------------------------------------------------
This sf.net email is sponsored by: DEDICATED SERVERS only $89!
Linux or FreeBSD, FREE setup, FAST network. Get your own server 
today at http://www.ServePath.com/indexfm.htm

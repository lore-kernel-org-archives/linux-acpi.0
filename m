From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Several problems on a toshiba S3000-X11
Date: Mon, 30 Sep 2002 02:21:46 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020930022146.D35@toy.ucw.cz>
References: <20020927142320.GB2821@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020927142320.GB2821-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>; from ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org on Fri, Sep 27, 2002 at 04:23:20PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?=C9ric_Brunet?= <ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mcelrath-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> So the computer shuts down, without warning, while it is not particulary
> hot, with nothing written in the logs, while the user was just using vim
> in a xterm, at irregular times, and it can happen two or three times in
> an afternoon.
> 
> That's a major nuisance. By the way, I can confirm that ext3 works very
> nicely at recovering a filesystem.
> 
> I have an hypothesis; somehow I think there is something wrong in the
> reading of the temperature. When I read the temperature, there are some
> very unnatural pics; the computer was at 53 degree, then jumps 3 seconds
> at 60 and comes back at 53. I believe that, some time to time, this
> unnatural jump goes over the critical trippoint and the computer shuts
> down in emergency.

Emergency shutdown implemented in kernel calls /sbin/halt or similar. This
must be something else.
								Pavel


-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.



-------------------------------------------------------
This sf.net email is sponsored by: DEDICATED SERVERS only $89!
Linux or FreeBSD, FREE setup, FAST network. Get your own server 
today at http://www.ServePath.com/indexfm.htm

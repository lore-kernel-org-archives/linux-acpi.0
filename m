From: Petr Olivka <petr.olivka-jmYXjVuSQ4U@public.gmane.org>
Subject: Re: D600 resume from RAM with black screen, ethernet tg3 is
 buggy
Date: Mon, 29 Sep 2003 12:19:44 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.30.0309291142280.26307-100000@pcd403z.vsb.cz>
References: <20030925132427.GJ11901@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030925132427.GJ11901-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Petr Olivka <petr.olivka-jmYXjVuSQ4U@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

thanks for answer,

> >      -suspend to ram work, but after resume is display black. Without
> > test5-pm2 do not resume back and hang with black screen.
>
> So with -test5-pm2 machine resumes okay, you can type commands
> etc, but can't see anything? Try passing cmd line
> option acpi_sleep=s3_mode (or how is it called)...
>
hm, s3_mode and s3_bios reboot computer, when I did try resume.
I did test "echo 3 > /proc/acpi/sleep" and "echo -n "mem" >
/sys/power/state".


> > Where are problems? How can I help to solve them?
>
> Can you mail me diff between vanilla and -test5-pm2?
> Can you try suspending with echo 4 > /proc/acpi/sleep?
> (that should call old working code... provided it propagates down correctly).

I am using 2.6.0-test5 with patch recomended in acpi devel list
"test5-pm2", not vanilla.

"echo 4 > /proc/acpi/sleep" do nothing.

poli





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

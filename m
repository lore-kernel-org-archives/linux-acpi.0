From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: D600 resume from RAM with black screen, ethernet tg3 is buggy
Date: Mon, 29 Sep 2003 21:27:08 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030929192708.GB1825@elf.ucw.cz>
References: <20030925132427.GJ11901@openzaurus.ucw.cz> <Pine.LNX.4.30.0309291142280.26307-100000@pcd403z.vsb.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0309291142280.26307-100000-Rd/Vp7eeBLeOZheNW5JDhQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Petr Olivka <petr.olivka-jmYXjVuSQ4U@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > >      -suspend to ram work, but after resume is display black. Without
> > > test5-pm2 do not resume back and hang with black screen.
> >
> > So with -test5-pm2 machine resumes okay, you can type commands
> > etc, but can't see anything? Try passing cmd line
> > option acpi_sleep=s3_mode (or how is it called)...
> >
> hm, s3_mode and s3_bios reboot computer, when I did try resume.
> I did test "echo 3 > /proc/acpi/sleep" and "echo -n "mem" >
> /sys/power/state".
> 
> 
> > > Where are problems? How can I help to solve them?
> >
> > Can you mail me diff between vanilla and -test5-pm2?
> > Can you try suspending with echo 4 > /proc/acpi/sleep?
> > (that should call old working code... provided it propagates down correctly).
> 
> I am using 2.6.0-test5 with patch recomended in acpi devel list
> "test5-pm2", not vanilla.
> 
> "echo 4 > /proc/acpi/sleep" do nothing.

Try -test6 with echo -n mem, that seem works here. If both s3_mode and
s3_bios reboot computer, tough. That means that you either need to
find out another ugly hack (like s3_mode and s3_bios), or get specs
for your video card and write proper resume support (get the specs is
the hard part here).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

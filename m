From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: RE: acpi-20031203-2.6.0.diff brokes the battery status
 readings with 2.6.0 in DELL Inspiron 8500
Date: Tue, 30 Dec 2003 09:59:05 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031230094935.E98403@root.org>
References: <E1Aa16k-00089f-Ft@sc8-sf-list2.sourceforge.net>
 <3FECC541.10001@videotron.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FECC541.10001-XzQKRVe1yT0V+D8aMU/kSg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Mark M." <maalox-XzQKRVe1yT0V+D8aMU/kSg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Your dmesg shows that this is the same thing we found broken for Dells:
>      -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
>      -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
>      -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
>      -0091: *** Error: ut_allocate: Attempt to allocate zero bytes

Here is the bug info.  Note that Luming's patch does NOT fix the problem
but just silences the warnings.  If you use the ASL patch I have attached
that adds RefOf/DerefOf (credit Mark Santcroos), the problems are fixed.
You can also revert dsmthdat.c back to what it was pre-0619 and that also
fixes the problem.

http://bugme.osdl.org/show_bug.cgi?id=3D1728

The issue is, ACPI-CA is still not getting its argument-passing right
after moving away from "always copy" semantics.

-Nate

On Fri, 26 Dec 2003, Mark M. wrote:
> I have the same problem with my Dell Inspiron 5150. Battery status AND
> temperature reading stopped working when I upgraded from 2.6.0-test11-mm
> to 2.6.0-mm1. I noticed it because klaptop stopped showing the battery
> charge status, and gkrellm2 stopped showing the battery and temperature
> status (stuck at 25C). Actually, the only thing that still works with
> the battery is wether the AC is plugged in or not. Here is my /proc and
> dmesg from 2.6.0-mm1. I can reboot and show you the working test11-mm
> stuff as well, if needed.
> ...
> root-2T+B9ReNDUQ@public.gmane.org maalox # cat /proc/acpi/battery/BAT0/state
> present:                 yes
> capacity state:          ok
> charging state:          unknown
> present rate:            0 mW
> remaining capacity:      0 mWh
> present voltage:         0 mV
>
> All the 0 readings have actual numbers with test11-mm, as well as model
> number, serial number, ...
>
> From: Brown, Len <len-lUQJ9CVx3tM@public.gmane.org>
> RE: acpi-20031203-2.6.0.diff brokes the battery status readings with
> 2.6.0 in DELL Inspiron 8500
> 2003-12-19 08:11
>
>   dmesg from before and after would help, plus the info under
> /proc/acpi/battery.
>
>   Thanks,
>   -Len
>
>   > -----Original Message-----
>   > From: acpi-devel-admin-I+uqrFQUvWk@public.gmane.org
>   > [mailto:acpi-devel-admin-I+uqrFQUvWk@public.gmane.org] On Behalf Of
>   > Pere Casta=F1er
>   > Sent: Thursday, December 18, 2003 7:00 PM
>   > To: acpi-devel
>   > Subject: [ACPI] acpi-20031203-2.6.0.diff brokes the battery
>   > status readings with 2.6.0 in DELL Inspiron 8500
>   >
>   >
>   > I've just aplyied last patch into 2.6.0 stable release and it
>   > brokes the battery monitor from acpi in
>   > /proc/acpi/battery/BAT0/status...because of this
>   > gnome-battery applet don't shows any information.
>   >
>   > Do you need more information?
>   >
>   > PS:with acpi included on 2.6.0 all works fine.
>


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

From: Carl Thompson <cet-GxmFRYwVNOxKOnpN5g9PlQ@public.gmane.org>
Subject: RE: C2 or C3 on Presario 2110US?
Date: Tue, 18 Mar 2003 09:11:49 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1048007509.e1d19c401c6ab@carlthompson.net>
References: <F760B14C9561B941B89469F59BA3A847E96D05@orsmsx401.jf.intel.com>
	<1047626263.be18a116566a8@carlthompson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1047626263.be18a116566a8-GxmFRYwVNOxKOnpN5g9PlQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Just wondering if anyone can help me figure out how to get C2 working on
my laptop...  Someone suggested that my processor P_BLK might be the
wrong size but I have no idea what that is and searching for that string
in the source yields nothing.

Can anyone help me?

Thank you,
Carl Thompson

Quoting Carl Thompson <cet-GxmFRYwVNOxKOnpN5g9PlQ@public.gmane.org>:

> Quoting "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>:
> 
> > > From: Carl Thompson [mailto:cet-GxmFRYwVNOxKOnpN5g9PlQ@public.gmane.org]
> > > Is it possible this machine just doesn't do C2-C3, processor
> limit
> > > control or processor performance control?  If that is the case,
> then
> > > why does Windows seem to be running cooler?  The fan is often off
> > > in Windows but never off in Linux.  Also battery life seems to be
> > > better in Windows whereas on my other laptops it's better in
> Linux.
> > > And yes, I am using CPUFreq's PowerNow support to throttle down
> the
> > > CPU speed and voltage to the minimum.
> >
> > Does the system feel slow, or are there an abnormal number of
> > interrupts shown in /proc/interrupts?
> 
> No, the system operates correctly and the interrupts seem reasonable.
> 
> > Also, the latest code required that the Processor P_BLK have a
> length
> > of 0 or 6, without exception.
> 
> I'm not sure what this is, how I would check it or what I can do
> about it.
> 
> > Finally, C2 and C3 statistics should be exposed through perfmon
> under
> > Windows. You might try finding that information, and seeing if
> indeed
> > it is using C2 or C3.
> 
> Thanks for the info.  According to perfmon, Windows goes into C2 when
> idle, but never into C3.  So C2 is in fact supported on this
> hardware.
> 
> > ...
> 
> This is what I get in /proc/acpi/processor/CPU0:
> 
> [carl@Tweak carl]$ cd /proc/acpi/processor/CPU0
> 
> [carl@Tweak CPU0]$ ls
> info limit performance power throttling
> 
> [carl@Tweak CPU0]$ cat info
> processor id:            0
> acpi id:                 0
> bus mastering control:   yes
> power management:        no
> throttling control:      no
> performance management:  no
> limit interface:         no
> 
> [carl@Tweak CPU0]$ cat limit
> <not supported>
> 
> [carl@Tweak CPU0]$ cat performance
> <not supported>
> 
> [carl@Tweak CPU0]$ cat power
> active state:            C1
> default state:           C1
> bus master activity:     00000000
> states:
>    *C1:                  promotion[--] demotion[--] latency[000]
> usage[00000000]
>     C2:                  <not supported>
>     C3:                  <not supported>
> 
> [carl@Tweak CPU0]$ cat throttling
> <not supported>
> 
> 
> > Regards -- Andy
> 
> Thank you,
> Carl Thompson
> 
> 






-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en

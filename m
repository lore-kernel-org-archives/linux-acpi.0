From: Ian Pilcher <i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Subject: Re: Plea for help
Date: Sun, 21 Dec 2003 19:19:41 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FE646AD.8020804@comcast.net>
References: <3FE28F79.601@comcast.net>	<3FE33B69.1010606@netspace.org>	<3FE39231.4040003@comcast.net>	<20031219160947.79c3fcdf.rddunlap@osdl.org>	<3FE3A142.90407@comcast.net>	<20031219184043.3983572d.rddunlap@osdl.org>	<3FE4A740.4080701@comcast.net> <20031220180854.32e2f56d.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031220180854.32e2f56d.rddunlap-3NddpPZAyC0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Randy.Dunlap wrote:
> Is there some reason that you build a kernel with both APM and ACPI
> support?  Can you test it without APM support, to see if it changes any?

Sorry about the delay.  I had to get all of these kernels, config files,
etc. under control.  (I now have a new appreciation for EXTRAVERSION.)
As a result, I've got three completely new sets of data for your holiday
enjoyment.

The starting point is the i686-smp kernel configuration from Fedora Core
1 (which has both APM and ACPI turned on).  I've built kernel 2.4.23
with ACPI 20031203 with this configuration and called it
2.4.23fc_config.  Then I disabled APM support and built 2.4.23no_apm.
Finally, I turned on frame pointers and build 2.4.23frame_ptrs.

The kernel configs, System.map files, and boot logs for all three of
these kernel are in http://home.comcast.net/~i.pilcher/panics.tar.gz.

> The dmesg files aren't complete boot logs.  Can you provide complete
> boot logs for these 2 cases (panic & hang)?

I knew I wasn't going to get through this without buying a null-modem
cable.  The boot logs in the above tarball were all captured on my
laptop; I hope that's what you're looking for.  Unfortunately, the text
of the panic message is garbled in several of the logs.

I also found that the behavior changes depending on whether I use a
local console (in addition to the serial console) or not.  In the case
of the fc_config kernel, the system actually boots successfully if I use
*only* a serial console.  Check the kernel command line in each boot log
to see what's what.

Am I crazy to think that this almost has to be a race condition?

I'll be out of town until the 29th without access to this system.  I
want to say thanks for taking the time to respond to my "plea".

Happy Holidays!

-- 
========================================================================
Ian Pilcher                                        i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org
========================================================================



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

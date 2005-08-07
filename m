From: Alexander Nyberg <alexn-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
Subject: Re: sluggish/very slow usb mouse on hp nx6110 notebook => acpi problem
Date: Sun, 7 Aug 2005 23:15:05 +0200
Message-ID: <20050807211505.GA1864@localhost.localdomain>
References: <20050805195243.4e9df3de@x90.0x4a47.net> <20050805205651.2cd22f1b@x90.0x4a47.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050805205651.2cd22f1b-g0SnQ0LDSf/kT7Lueh3tMA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: JG <jg-9fI4heB6ewM@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Aug 05, 2005 at 08:56:51PM +0200 JG wrote:

> hm, i currently have "acpi=off noacpi noapic reboot=b" as kernel
> parameter.
> 
> if i remove the acpi stuff and enable acpi, the usb mouse works fine..
> but after some time (5-10min) the kacpid process goes havoc and eats
> all cpu and the whole system is unresponsive- that's the reason i added
> those acpi=off parameters the first time when installing gentoo..
> 
> i tested with gentoo-2.6.12-r7 and vanilla-2.6.13rc5
> 

Indicates a bug in kacpid or similar. Could you make sure you compile in
"Magic SysRq key" under "Kernel Hacking" and boot the vanilla-2.6.13-rc6
(some recent acpi changes have gone in) and then wait for kacpid
to go nuts and do

Alt+Sysrq+t 4 times and then run 'dmesg -s 100000 > logfile' and
send logfile over here so that we can see what kacpid is up to.

If the box becomes so unresponsive you can't extract the log information
it would be good if you could use either network console 
Documentation/networking/netconsole.txt or serial console at
Documentation/serial-console.txt, both require an extra computer
though...


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

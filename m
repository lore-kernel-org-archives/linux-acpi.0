From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: reading files in /proc/acpi hangs machine for a short time
Date: Fri, 25 Jun 2004 21:11:17 -0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040625211117.GA5789@message-id.gmane0305.slipkontur.de>
References: <20040625082929.45335181@tethys.solarsys.org> <opr95d74mf4evsfm@smtp.pacific.net.th> <20040625135036.23f487a0@localhost> <opr95ql7ja4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <opr95ql7ja4evsfm-TBR8pM7LtsqkE96DxU8f+dAkNl5+tjhE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 25, 2004 at 11:57:33PM +0800, Michael Frank wrote:

> >behaves normally. So it seems to me that accessing to files ini
> >/proc/acpi/bla/bla from C code or script behaves the same, it slows down 
> >the
> >machine for a very short while, because of CPU eating.
> 
> Should not be like that. I have not encountered it on 2.4

I have seen this in 2.4 kernels on e.g. asus l8400, reading the
battery. It even lead to "lost time" in the kernel clock (often
reading the battery slowed down the clock considerably). IIUC this
is caused by bad hardware design (battery controllers connected via 
i2c or similar slow serial buses read with busy loops or something 
ugly like that.
It seems this has been resolved in 2.6.

On some hardware, reading battery is still very expensive (causes small
peaks of high load in kernel space) on others it is not. At least i don't
think i saw the clock losing ticks in 2.6.

> Suggest you file a bug report in kernel bugzilla with details of you HW
> so it gets looked into. Get some details of which files cause the problems
> using the script and enclose the script as well.

I am not sure that there can be done much about this if the particular
hardware is badly designed.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

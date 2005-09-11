From: Jan De Luyck <lkml-gY0FE6dpLprYtjvyW6yDsg@public.gmane.org>
Subject: Re: battery status events (RE: Kernel 2.6.13 repeated ACPI events?)
Date: Sun, 11 Sep 2005 16:03:58 +0200
Message-ID: <200509111603.58411.lkml@kcore.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B30048646E9@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30048646E9-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Lebedev, Vladimir P" <vladimir.p.lebedev-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 07 September 2005 22:10, Brown, Len wrote:
> The kernel doesn't created these messages -- presumably
> they're from acpid or some other user-level daemon
> that is monitoring /proc/acpi/event.  Unlikely that
> logging these events is necessary...
>
> Event 0x80 on the battery device is a "Battery Status Changed"
> which you'd expect to see when plugging/charging/discharging
> a battery.  How frequent they are depends on the rate,
> the battery and the firmware that is talking to it.

Ah, okay. I was under the impression that they should only be shown whenever 
there was an actual 'state' change, like battery is flat, is being charged, 
power is unplugged, not for the change of the charge level itself.

> Is there a GUI or something reading the battery status files?
> Do these events stop when running in text mode?

There is indeed klaptopdaemon running which does monitoring of the battery 
levens.

> Did this not happen on this box with earlier kernels?

I have no idea anymore when it started, but it wasn't there on a certain 
earlier kernel - but then i'm talking pre 2.6.7 era. I just didn't bother 
reporting it earlier, since I attributed it to a faulty dsdt line or so. I've 
read that ACER laptops have their share of bad dsdt's, that's why I didn't 
really bother - it works, it's just a tad annoying.
>
> Do the /proc/acpi/battery* files look sane --
> is the status really changing?

Yups, charge levels :)

Thanks, 

Jan

-- 
Food for thought is no substitute for the real thing.
		-- Walt Kelly, "Potluck Pogo"


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: Battery status reading problems
Date: Mon, 22 Sep 2003 12:37:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1064230622.8592.14.camel@dhcp23.swansea.linux.org.uk>
References: <m2vfrpthxt.fsf@tnuctip.rychter.com>
	 <Pine.LNX.4.58.0309192257480.1613@phoenix.kerstin.at>
	 <3F6EAADC.4020509@basmevissen.nl>
	 <Pine.LNX.4.53.0309220954120.9385@dynast.gaugusch.at>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.53.0309220954120.9385-sxQ525G0OhRQK2oVCIMtW7NldLUNz+W/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Llu, 2003-09-22 at 08:56, Markus Gaugusch wrote:
> I don't think, that the code is slow, but during execution of the battery
> query (which takes some time, because it is on a slow bus) the kernel
> seems to hang - probably a kernel thread would cure this problem, but I'm
> no expert in this area.

Several vendors implement the actual battery reading logic as an SMI
trap and disable interrupts during their slow chat with the battery.
There isnt much anyone can do about that bit alas (except read it a lot
less often)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

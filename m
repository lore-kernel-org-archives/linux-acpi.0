From: "Michael Frank" <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: [Swsusp-devel] swsusp and ac status
Date: Thu, 24 Jun 2004 22:37:12 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <opr93r8ap24evsfm@smtp.pacific.net.th>
References: <200406241233.i5OCXiKC002386@fermat.unipv.it>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200406241233.i5OCXiKC002386-xzhXYMPkGmXoPXhRcRtihA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 24 Jun 2004 14:33:44 +0200, Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org> =
wrote:

> Hi,
> I noticed that a change in the ac status is not detected after a swsusp=
.
> I thought this was an acpi related and known issue; I sent a message
> to the acpi-devel list but with no significant answer.
>
> Is anybody aware of this problem? Is there any workaround available?
>
> How to reproduce the bad behavior:
>
> - swsuspend when on ac (resp. battery) power
> - unplug (resp. plug) the ac adapter when the laptop is off
> - resume when on battery (resp. ac) power
>
> Then /proc/acpi/ac_adapter/*/state says "on-line" (resp. "off-line").
> A new change in the status is then correctly detected.
>
> I tried different acpi configurations (ac in the kernel or as a module,=
 unload
> the ac module before suspending and reload it after resuming...) with n=
o
> success.
>
> actual kernel 2.6.7 (same behavior with previous ones), no acpi patch, =
swsusp2
> patch
>
> Compaq EVO N800v laptop.
>
> Same behavior with pm-suspend, swsusp and swsusp2.
>

The root cause is due to the AC module state at the time of suspend
being saved and restored on resume and thus being inconsistent
with the HW on resume which was "touched"  by the BIOS and resuming
kernel (the kernel which reads the image from disk) during its boot.

The problem affects all (2.4/2.6) kernels, most ACPI modules
(AC, Battery an Button seem especialy troublesome) and is due to lack of
PM support in the APCI subsystem.  A few users even reported crashes
on resume which went away when the modules were removed prior
to suspend.

The ACPI spec surely has standard methods for subsystem PM but these
are obviously not usable, whether due to being unimplemented or
broken in ACPI subsystem, DSTD or BIOS.

Guess the least the ACPI subsystem should  do is to disable relevant
modules on suspend event and reinit them in fashion similar to
boot on resume.

I personaly find it undesirable that  PM subsystem components have
no functioning PM :-(

For now, in practice all ACPI modules should be unloaded prior to
suspend and loaded on resume.

I use the AC module and kernel 2.4.24 with swsusp 2.0 and it works
fine as long as it is removed prior to suspend.

	Michael







-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

From: Mads Paulin <paulin-/w0Os/Ss2Sh/SzgSGea1oA@public.gmane.org>
Subject: Re: [Acpi4asus-user] ASUS M2400N / M3700N / S1300N temperature
Date: 26 Aug 2003 11:32:50 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1061890370.1789.5.camel@M2400N>
References: <20030814025858.GA16098@hell.org.pl>
	 <1060944604.1760.1.camel@M2400N> <20030815142258.GA2643@hell.org.pl>
	 <1060959167.2144.19.camel@Home> <20030815205541.GB25102@hell.org.pl>
	 <1061221384.1996.6.camel@M2400N>  <20030819140334.GB4265@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030819140334.GB4265-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have tried to use the DSDT for the asus L3800Cin my M2400N laptop
since Karol reported that this worked ok.

With this dsdt, the M2N laptop can actually read the correct cpu
temperature,but the fan status is always reported as "on" and the trip
points are still all 255C.

Unfortunately I don't have the time right away to starte merging the two
DSDT's or debug the original M2400N DSDT, But now you know: The
temperature code from the L3800C works with M2N alsoo...

Regards 
Mads

P.S. If anyone would like to have a go at correcting the dsdt I could
probably find the time to participate - I just need someone with some
insight into DSDT programming to get me started....



On Tue, 2003-08-19 at 16:03, Karol Kozimor wrote:
> Thus wrote Mads Paulin:
> > I have an ASUS M2400N and is trying to get the fan control right. Karol
> > solved the temperature reading problem, but due to wron thermal trip
> 
> Did I really? From what you said before, I understood it didn't work.
> Let's look at the code:
> #v+
>     Method (_TMP, 0, NotSerialized)
>     {
>         Store (0x05, Local1)
>         While (Local1)
>         {
>             Store (RTMP (), Local0)
>             If (LGreater (Local0, TCRT))
>             {
>                 Decrement (Local1)
>             }
>             Else
>             {
>                 Store (0x00, Local1)
>             }
>         }
> 
>         Return (KELV (Local0))
>     }
> [...]
>     Method (RTMP, 0, NotSerialized)
>     {
>         Store (RBYT (TSAD, 0x01), Local0)
>         If (Not (Local0))
>         {
>             Store (Local0, LTMP)
>         }
> 
>         Return (LTMP)
>     }
> #v-
> 
> This is the original one. If the (RBYT (TSAD, 0x01) is supposed to return
> temperature, it should rather not be zero. Thus, the condition in RTMP
> always fails. Since LTMP is initialized with 0x3c (60d), the _TMP method
> always returns (KELV (60)), and also, since RTMP is also used internally,
> the fan keeps spinning at the same speed. 
> 
> Now, if the aforementioned condition is changed to If (Local0), which looks
> fairly more reasonable, strange things begin to happen (like those trip
> points and temperature being reported as 255 degrees). There is nothing in
> the trip point code that would support such a behaviour, unless the change
> causes some random memory scribbling, or something similarly nasty.
> 
> > By the way, the fan is capable of rotationg at several different rpm's.
> > Have any of you gotten this rigt ? On my laptop, the fan starts at max
> > rpms and then turns completely off. The only way I can get it to rotate
> > at low RPMS is by rebooting the machine when the processor temperature
> > is in the interval giving low rpm's. The bios will then put the fan in
> > low rpm state.
> > 
> > This leads me to think, that the fan is not controlled by acpi at all
> > (possibly due to a buggy DSDT)
> 
> The fan is, and should be, controled by ACPI, though not in the way the
> specification says. The \_TZ.TCHG method compares the actual temperature
> adn stores appropriate values in the fan registers, causing it to change
> its speed. A very similar thermal system exists in ASUS L3800C, where it
> works quite well.
> 
> Could someone take a look in the M2400N DSDT and suggest a way to debug it?
> Best regards,



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0

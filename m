From: Michael Notforyou <sqfreak-goaWJWIt5zpWk0Htik3J/w@public.gmane.org>
Subject: Re: Re: not all irqs detected
Date: Sat, 24 Aug 2002 16:26:05 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <5.1.0.14.0.20020824162249.032ba758@pop-server.triad.rr.com>
References: <200208241939.g7OJdfX03337@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200208241939.g7OJdfX03337-pb599fR3TxVkExQqqHjIK3sFFmKitW5W@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: joerg.beyer-htSm2yLGOjU@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

At 09:39 PM 8/24/2002 +0200, you wrote:
>"M. Warner Losh" <imp-uzTCJ5RojNnQT0dZR+AlfA@public.gmane.org> schrieb am 24.08.02 20:18:47:
>
> > So maybe IRQ 5 and IRQ 10 is all you get, and irq 12 can't be routed
> > to the pins in the original poster's question.
> >
>
>ok, I see here high latencies for the NIC in this laptop and I get _lots_ of
>errors on the NIC (a realtec 8139). Disk accesses are also very slow and
>sound is not working.
>
>I assumed, that this is a result of many things mapped on the same IRQ - is
>this right?
>
>Any idea, what I can do about it?
>
>     Joerg

What type of laptop is this? It sounds oddly like my Compaq Presario 730US 
laptop, which is similar in almost every respect to the entire 700 series.

Mine has a Realtec 8139-compatible NIC integrated in the VIA chipset 
motherboard with integrated ac97_codec sound which works improperly out of 
the box with the 2.4.1x kernels.

If you are using a Compaq Presario 700series laptop, no it's not an IRQ 
problem. I have no errors with my NIC on Linux-Mandrake with a 
recompiled-from-pure-source 2.4.18 kernel. My sound works with a fixed 
ac97_codec.c file, which I'll be happy to give you.

Getting ACPI to work, that's another story.


*Michael Notforyou*

"My God, I'm full of stars!"
Darmok and Jalad at Tanagra!



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390

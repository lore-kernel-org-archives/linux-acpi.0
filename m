From: Herman Sheremetyev <mlists-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
Subject: Re: No APIC interrupts after ACPI suspend
Date: Sun, 27 Jun 2004 14:49:19 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1088362159.2163.38.camel@djinn>
References: <1088160505.3702.4.camel@tyrosine>
	 <1088268145.14987.248.camel@zion.2good.net>
	 <40DDBA7A.6010404@travellingkiwi.com> <40DF0A98.9040604@travellingkiwi.com>
Reply-To: mlists-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-RLHPUgm3Fucauv0Y10DO"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40DF0A98.9040604-CM5YN7r2dWBr4tq51QLIbdBPR1lH4CV8@public.gmane.org>
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


--=-RLHPUgm3Fucauv0Y10DO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi All,

I'm having basically the same issue on my Asus M6N though with different
drivers.  I'm running Fedora Core 2 with a vanilla 2.6.7 kernel.  In my
case snd-intel8x0 and ipw2100, which both share IRQ 11, work ok for a
short while after an S3 resume but then freeze up and refuse to respond
until I unload and reload them.  I think the interrupts not incrementing
is just a symptom of the problem rather than the cause.  A reliable way
to reproduce it is to play music while either transferring a big file or
doing a ping -f.  This usually knocks them out pretty fast however it's
not at all consistent about the length of time they will work after a
resume.  

After reloading both of them, either one will work by itself but as soon
as I try to use them together both freeze again, and this time they
freeze pretty much immediately.  I noticed that PCI registers are set
differently after the machine comes back from S3 so I tried setting them
back manually but that did not fix the problem either.  There are some
that actually refused to be set so maybe that has something to do with
it.  I am attaching outputs of lspci -xxx and lspci -vv from a pre-S3
state and post-S3 if somebody thinks they might be helpful.  I also
tried alternate drivers for both devices (i810-audio and ndiswrapper)
with similar results.

Also, after an S3 resume, I only see 'inu' in yellow on black letters on
the screen, the ASM in wakeup.S is pretty impenetrable to me so I don't
know if this indicates a problem or not.  My laptop also does not reboot
properly after an S3, just hangs there after saying it's about to
restart, but again I'm not sure it that's related or not.

Thanks in advance for any help, and if I should provide any further
information please let me know.

-Herman

On Sun, 2004-06-27 at 13:57, Hamie wrote:
> Hamie wrote:
<snip>
> Nope... A fluke... Mostly...
> 
> FWIW the sound & networking appear to run fine for a while after 
> resuming. But I just started a DVD. It ran fine for about 30 seconds and 
> then the sound went. About 30 seconds later the video froze and the app 
> (xine) has frozen also. (kill -9 time...).
> 
> restarting xine it runs the viodeo for about 10 secs before freezing 
> again... With no sound...
> 
> Checking /proc/interrupts with juk running (Supposedly playing music)
> 
> hamish-ffMD+yyVbvkaXcDfM+S1Mg@public.gmane.org:~$ cat /proc/interrupts; sleep 10; cat /proc/interrupts
>            CPU0      
>   0:   10175817          XT-PIC  timer
>   1:       2077          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:     169347          XT-PIC  Intel 82801DB-ICH4, yenta
>   8:          4          XT-PIC  rtc
>   9:      49257          XT-PIC  acpi
>  11:       8852          XT-PIC  yenta, uhci_hcd, uhci_hcd, uhci_hcd, 
> ehci_hcd, eth0
>  12:     110067          XT-PIC  i8042
>  14:      63045          XT-PIC  ide0
>  15:      38071          XT-PIC  ide1
> NMI:          0
> ERR:          0
>            CPU0      
>   0:   10185825          XT-PIC  timer
>   1:       2077          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:     169347          XT-PIC  Intel 82801DB-ICH4, yenta
>   8:          4          XT-PIC  rtc
>   9:      49301          XT-PIC  acpi
>  11:       8857          XT-PIC  yenta, uhci_hcd, uhci_hcd, uhci_hcd, 
> ehci_hcd, eth0
>  12:     110586          XT-PIC  i8042
>  14:      63055          XT-PIC  ide0
>  15:      38071          XT-PIC  ide1
> NMI:          0
> ERR:          0


--=-RLHPUgm3Fucauv0Y10DO
Content-Disposition: attachment; filename=lspci.tar.bz2
Content-Type: application/x-bzip-compressed-tar; name=lspci.tar.bz2
Content-Transfer-Encoding: base64

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

--=-RLHPUgm3Fucauv0Y10DO--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

From: Jamin W. Collins <jcollins-u0TlgVUp4POoiH3BShWgcg@public.gmane.org>
Subject: Re: C1VN, ACPI and ESD/ASD = const CPU
Date: Tue, 27 Aug 2002 10:30:59 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020827103059.62d2eee1.jcollins@asgardsrealm.net>
References: <20020827091844.7af7a982.jcollins@asgardsrealm.net>
	<20020827145843.GA12836@the.earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020827145843.GA12836-EawVq80k/urhogsy92RK3A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 27 Aug 2002 15:58:43 +0100
Stephen White <stephen-acpi-devel-4QvXXjU8Dv4@public.gmane.org> wrote:

> ---- Original Message ----
> > From Jamin W. Collins <jcollins-u0TlgVUp4POoiH3BShWgcg@public.gmane.org>
> > Date: Tuesday, 27 Aug 2002, 15:18
> > 
> > CPU states:   0.8% user,  25.7% system,   0.0% nice,  73.5% idle
>                             ^^^^^^^^^^^^
> The marked bit means that 25.7% of the CPU time is being spent inside 
> the kernel, this means that it doesn't show up on the process list as 
> it is not a normal process causing the load ..  hence you weren't able 
> to spot where it was being used even when sorting by CPU usage.

Cool, that makes sense.

> A traditional way to create a high system CPU load would be lots of
> network traffic over an encrypted interface (e.g. cipe) .. so the kernel
> itself is spending a lot of time doing cryptography.

Well, as this only occurs when ASD or ESD is running in conjunction with
ACPI, I doubt it's that.

> The fact that ACPI is causing this is a problem.  One thing to try is 
> check that you are not getting lots of ACPI events or that you are not 
> getting lots of interrupts occuring.  The later can be found with 'cat 
> /proc/interrupts' .. run it a few times and compare the results.

I assume I'm supposed to be looking at the CPU0 column for changes?  If
so, I definitely see a drastic increase in the values for interrupts 0 &
9.  The following were grabbed by simply repeatedly running the command in
rapid succession:

**** ASD running ****

jamin-mini:/# cat /proc/interrupts 
           CPU0       
  0:    1189010          XT-PIC  timer
  1:       1219          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       5329          XT-PIC  orinoco_cs
  8:          3          XT-PIC  rtc
  9:    1924005          XT-PIC  acpi, usb-uhci, Ricoh Co Ltd RL5c475,
YMFPCI
 11:         55          XT-PIC  sonypi
 12:       9081          XT-PIC  PS/2 Mouse
 14:      89778          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
jamin-mini:/# cat /proc/interrupts 
           CPU0       
  0:    1189228          XT-PIC  timer
  1:       1219          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       5343          XT-PIC  orinoco_cs
  8:          3          XT-PIC  rtc
  9:    1924413          XT-PIC  acpi, usb-uhci, Ricoh Co Ltd RL5c475,
YMFPCI
 11:         55          XT-PIC  sonypi
 12:       9081          XT-PIC  PS/2 Mouse
 14:      89778          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
jamin-mini:/# cat /proc/interrupts 
           CPU0       
  0:    1189701          XT-PIC  timer
  1:       1219          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       5357          XT-PIC  orinoco_cs
  8:          3          XT-PIC  rtc
  9:    1925301          XT-PIC  acpi, usb-uhci, Ricoh Co Ltd RL5c475,
YMFPCI
 11:         55          XT-PIC  sonypi
 12:       9081          XT-PIC  PS/2 Mouse
 14:      89780          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
jamin-mini:/# cat /proc/interrupts 
           CPU0       
  0:    1190144          XT-PIC  timer
  1:       1219          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       5371          XT-PIC  orinoco_cs
  8:          3          XT-PIC  rtc
  9:    1926132          XT-PIC  acpi, usb-uhci, Ricoh Co Ltd RL5c475,
YMFPCI
 11:         55          XT-PIC  sonypi
 12:       9081          XT-PIC  PS/2 Mouse
 14:      89782          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0


**** ASD stopped ****

jamin-mini:/# cat /proc/interrupts 
           CPU0       
  0:    1203690          XT-PIC  timer
  1:       1219          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       5406          XT-PIC  orinoco_cs
  8:          3          XT-PIC  rtc
  9:    1950699          XT-PIC  acpi, usb-uhci, Ricoh Co Ltd RL5c475,
YMFPCI
 11:         55          XT-PIC  sonypi
 12:       9081          XT-PIC  PS/2 Mouse
 14:      89806          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
jamin-mini:/# cat /proc/interrupts 
           CPU0       
  0:    1203843          XT-PIC  timer
  1:       1219          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       5423          XT-PIC  orinoco_cs
  8:          3          XT-PIC  rtc
  9:    1950699          XT-PIC  acpi, usb-uhci, Ricoh Co Ltd RL5c475,
YMFPCI
 11:         55          XT-PIC  sonypi
 12:       9081          XT-PIC  PS/2 Mouse
 14:      89806          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
jamin-mini:/# cat /proc/interrupts 
           CPU0       
  0:    1203985          XT-PIC  timer
  1:       1219          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       5439          XT-PIC  orinoco_cs
  8:          3          XT-PIC  rtc
  9:    1950699          XT-PIC  acpi, usb-uhci, Ricoh Co Ltd RL5c475,
YMFPCI
 11:         55          XT-PIC  sonypi
 12:       9081          XT-PIC  PS/2 Mouse
 14:      89808          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
jamin-mini:/# cat /proc/interrupts 
           CPU0       
  0:    1204728          XT-PIC  timer
  1:       1219          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       5453          XT-PIC  orinoco_cs
  8:          3          XT-PIC  rtc
  9:    1950699          XT-PIC  acpi, usb-uhci, Ricoh Co Ltd RL5c475,
YMFPCI
 11:         55          XT-PIC  sonypi
 12:       9081          XT-PIC  PS/2 Mouse
 14:      89814          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0


-- 
Jamin W. Collins


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390

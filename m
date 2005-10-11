From: Petros Kolyvas <pk-MB7MuOL9T89txrOg+t5jCQ@public.gmane.org>
Subject: Re: Using the SLPB button for MEM state (suspend to ram)
Date: Mon, 10 Oct 2005 23:22:32 -0400
Message-ID: <BAYC1-PASMTP055FD8C75E7260F6E08296D6780@CEZ.ICE>
References: <BAYC1-PASMTP03F4CB11CD595EA2BC0C07D6780@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Message-ID: <434B2FF8.8060301@shiftfocus.ca>
In-Reply-To: <BAYC1-PASMTP03F4CB11CD595EA2BC0C07D6780-NW7P6tAEKYY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Petros Kolyvas wrote:
> Hi folks,
> 
> I've been using ACPI4Linux's suspend to RAM for some time. Until a
> recent reinstall of gentoo, I had been using the lid button (LID0), and
> a script which polled its state (/proc/acpi/button/lid/LID0/state) and
> consequently, depending on whether the lid was up or down, the laptop
> would either come out of or go into the "mem" state.
> 
> Now the thing is that I've begun to use my laptop in the car quite a
> bit; got myself an inverter and I keep it tucked under the front
> passenger seat - anyway, the why and hows don't matter.
> 
> Basically I want to keep the screen down and keep the laptop powered
> up... no problem... just remove the lid button acpi script. The thing is
> that I would like to be able to put it into the "mem" state when I so
> desire.
> 
> I noticed that the Sleep Button, (/proc/acpi/button/sleep/SLPB) is
> present but that there is no state (/proc/acpi/button/sleep/SLPB/state)
> to poll in a script and therefore I'm unsure if I can use the button at
> all.
> 
> If anyone has any idea on how to possibly use this button, if it can be
> used, or if there's a HOWTO out there that I missed, I'd greatly
> appreciate it.
> 
> All the best for those celebrating Canadian thanksgiving.
> 
> Pk

One small additional note; I did notice that while I never use my power
button to shutdown (opting for my ingrained 'shutdown -h now' procedure)
if I do press the power button the system shuts off (of course - but
just trying to be as obvious as possible).

Looking further into it, i noticed that /proc/acpi/button/power/PWRF
also does not have a 'state' file yet still functions when pressed.

Worst case scenario: maybe I can switch the default behaviour of the
power button to go to "mem" state if the sleep button is unavailable.

Sorry for flooding with inane questions/observations...

Pk



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

From: "Carlo E. Prelz" <fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org>
Subject: Re: Re: Acpi slows down my new Asus portable quite a lot
Date: Tue, 15 Jul 2003 23:25:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030715212554.GC4920@casa.fluido.as>
References: <20030715142915.GB4920@casa.fluido.as> <m2lluzedzy.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2lluzedzy.fsf-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

	Subject: [ACPI] Re: Acpi slows down my new Asus portable quite a lot
	Date: Tue, Jul 15, 2003 at 01:22:57PM -0700

Quoting Jan Rychter (jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org):

> I see the same thing on 2.4.22-pre5, keventd sometimes decides to run a
> lot and consume CPU time. When it happens, keventd doesn't run all the
> time, but runs for a while, then stops, then runs again.
> 
> I've noticed this doesn't happen if I don't use ALSA. But once ALSA has
> been used, this happens even after ALSA has been unloaded.
> 
> I don't know if this is ACPI's fault or ALSA's fault. In fact, I don't
> even know where and how to report it properly.

No, here it happened even when ALSA was out of the picture. On 2.4 I
was running the OSS module for Intel ICH (i8xx) chips. I had this IRQ
problem and tried to see if this would be solved with 2.6. The problem
was still present with 2.6 and alpha, but it is solved by letting ACPI
handle the interrupts. Only, then the slowdown comes over. I see
non-stop load at 99.9%, never resting.

I reach an useable status (let's say, being able to playback a DVD
with MPlayer with acceptable performance) by re-nicing the offending
process. As of default it runs at -10; if I set it to 1 (just higher
than normal processes) I manage to do things. 

I wonder if it is possible to find out where these events that clog
the process come from. 

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0

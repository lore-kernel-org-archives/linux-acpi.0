From: Stephan Krings <stephan-6/4LMolCrz7QLMG2gba6HQ@public.gmane.org>
Subject: Re: Compaq Evo N800v: I have a fixed DSDT table
Date: Mon, 28 Apr 2003 21:41:29 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16045.33769.882186.555363@hotzenplotz.chateau-neukoelln.de>
References: <20030428121157.A20348@fermat.unipv.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030428121157.A20348-xzhXYMPkGmXoPXhRcRtihA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, john.cagle-VXdhtT5mjnY@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

> What is working:
> 
> - batteries (BAT0  BAT1)
> - ac_adapter (ACAD)
> - button (lid  power  sleep)
> - embedded_controller (C0D0)
> - fan (I have 4 of them: C1D9  C1DA  C1DB  C1DC)

I think these are not four hardware-devices, but instead represent 4
different speed-states for the same fan.

> What can be improved
> 
> - sleep states: echo 5 works (shutdown), echo 4 works (it invokes swsusp)
>                 other states do nothing

Same for me. I also tried the swsusp patch and it works for me. It's a
little bit slow to suspend and hibernate this way, so I don't use it
very often. Making S3 (Suspend to RAM) on this machine would be really
nice, but I didn't have the time to try a newer development kernel,
yet.

> - volume control buttons: are they acpi-related?

No, they generate normal scan codes, which any program my use. Check
out lineak (http://lineak.sourceforge.net/). It works fine for
me. There are other similar tools which do the job also.

The same applies to the play/stop etc. buttons (Fn+F9). They can also
be made available to lineak or xmms.

The only buttons which bypass the kernel keyboard routines or ACPI are:

- Fn+F2 (wireless device on/off): This seems to hardwired into the
  keyboard controller. The current power state is also written to
  NVRAM, so it might even be possible to "emulate" this button from a
  program.

- Fn+F4 (Switch display output): Just seems to work for me. Haven't
  tried it with a TV attached, yet.

- Fn+F7 / Fn+F8 (display brightness): Just works for me. The ACPI
  system might be involved here.

- Fn+Scroll: Emulate numeric keypad. Just works for me, seems to be
  hard wired in the keyboard controller.

All other keys are either ACPI controlled (Sleep, Power) or can be
accessed from user space.

Regards,

Stephan


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

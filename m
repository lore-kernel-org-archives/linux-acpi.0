From: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Subject: ACPI interrupts..
Date: Tue, 24 Sep 2002 19:29:00 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0209241923040.7134-100000@home.transmeta.com>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE9B@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE9B-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Ok, can anybody tell me why this happens:

  torvalds@home:~> cat /proc/interrupts | grep acpi ; sleep 10; cat /proc/interrupts | grep acpi
    9:  584623114  590018990  596116838  609754651   IO-APIC-level  acpi
    9:  584810385  590200073  596298554  609925004   IO-APIC-level  acpi
  torvalds@home:~> echo $((584810385-584623114)) $((590200073-590018990)) 
			$((596298554-596116838)) $((609925004-609754651))
  187271 181083 181716 170353

ie why does my dual P4-HT take ~18,000 interrupts per second on each 
virtual CPU?

That's a lot more than all other interrupt sources _combined_ on this 
machine. And comparing it with the uptime shows that that 18kHz interrupt 
rate has been going on steadily for the whole uptime of the machine (yes, 
9+ hours right now, giving 600 million interrupts per virtual CPU).

Silly me thought a 1kHz timer tick rate might be noticeable, but at least
I know it results in something useful getting done on the CPU. In
contrast, that 18kHz irq rate doesn't do any good that I'm aware of.

ACPI people, please enlighten me. Preferably with a patch that turns the 
crap off.

		Linus



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Daniel Thor Kristjansson <danielk-L9gzEf+okJWVc3sceRu5cw@public.gmane.org>
Subject: Re: More than one battery
Date: Sun, 9 Feb 2003 00:35:55 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.SOL.4.44.0302090007190.5451-100000@graphics.cat.nyu.edu>
References: <3E27F563.4070305@muenster.de>
Reply-To: danielk-L9gzEf+okJWVc3sceRu5cw@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E27F563.4070305-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Malte Thoma <thoma-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I put the first revision up at
  http://www.mrl.nyu.edu/~danielk/powerscheme.tbz

The demo is a standalone application that lets you switch between
several basic schemes. It only works with performance. It requires
the set_throttling shell script, and if you want it to know about the
lid state you need to set up your acpid/ospmd script to create a file in
/tmp called .acpi.lid containing one of open, closed, unknown. This is
just because I couldn't find any way to query the state of buttons
through /proc

There are a lot of "TODO"s in the source right now. But the demo should
work, if it doesn't please e-mail me. I'd like to eventually make this
either a standalone deamon or part of acpid or ospmd, but for now, just
look at runPowerScheme() for the what to add to heatload. You can
replace the queryState function with calls to the update*State
functions. I think it might be best to just add this to the next version
of heatload with a little menu for choosing between those four basic
power schemes. The maximum performance scheme only throttles the CPU if
it thinks the CPU is overheating. In the next version I'll add some kind
of capability for reading a configuration file with different power
schemes.

!!!!!!!
There is only one critically important thing. The temperature monitoring
is based on the critical numbers for the Mobile Pentium 3, that is the
chip fries at 95C. If you have any other chip you should fix
  getTemperatureLevel()
The numbers are in Kelvin, add 273 to the Celsius number.
Otherwise the example powerschemes may throttle your chip prematurely or
not do it when it is critical due to an overheating CPU. In anycase I
tried to be conservative, I think the AMD chip takes more heat, though I
don't know about all the different variants of these chips.

Anyone that tries this, please e-mail me your /proc/cpuinfo file, and
the temperature info, the more the better, up to a page maybe. Goggle
should provide this with the approprite search strings.
!!!!!!

-- Daniel
    <<Children today are tyrants. They contradict their parents, gobble
      their food, and tyrannize their teachers.>> - Socrates

On Fri, 17 Jan 2003, Malte Thoma wrote:

]
]
]Daniel Thor Kristjansson wrote:
]
]>Yes, I think the auto-performance should be in there as well. I'm
]>working on something else right now, but the deadline for that is next
]>week. So following, that I'll clean it up and send you the diffs
]>(should be next weekend).
]>
]>
]sounds nice :-)
]
]
]Malte
]
]
]
]>-- Daniel
]>  <<You cant eat before a operashun. Not even cheese.>> -- Charlie Gordon
]>
]>On Mon, 13 Jan 2003, Malte Thoma wrote:
]>
]>]
]>]
]>]Daniel Thor Kristjansson wrote:
]>]
]>]>I found the text below through some googling. The important thing is
]>]>that ospmd is supposed to support acpi policies in the next version. I
]>]>believe this means that you can hand a policy to ospmd and have it
]>]>handle throttling for you, I doubt it would take cpu load into account.
]>]>But I'm going to try to find who's working on that, the cpp files all
]>]>just say "Intel" then find out if they are planning on putting a more
]>]>complete policy support into the ospmd deamon, or could use a
]>]>contribution. Throttling just based on thermal event might save your
]>]>CPU, but won't save as much battery power as throttling the CPU when
]>]>load is low. (I can easly half my battery draw by throttling and turning
]>]>down the LCD, but I wouldn't do it without my hacked heatload
]>]>unthrottling when the system load goes up.)
]>]>
]>]>
]>]Please send my a diff from the hacked heatload.
]>]If I understand you right, you have included an
]>]
]>]'auto-throttling-when-no-load'
]>]
]>]I think this is worth to be included in the offical release, don't you?
]>]We should include 'auto-performance-when-no-load' as welll, what's your
]>]opinion?
]>]
]>]
]>]Greetings,
]>]
]>]Malte
]>]
]>]
]>]
]>]
]>]
]>]>Anyway, I'll keep you informed.
]>]>
]>]>-- Daniel
]>]>
]>]>  http://216.239.37.100/search?q=cache:pOZPEz5rV_8C:www.intel.com/technology/iapc/acpi/downloads/CHANGES.txt+ospmd+cpu+throttling&hl=en&ie=UTF-8
]>]>
]>]>The processor driver (acpi_processor.c) now fully supports ACPI
]>]>2.0-based processor performance control (e.g. Intel(R) SpeedStep(TM)
]>]>technology) Note that older laptops that only have the Intel "applet"
]>]>interface are not supported through this.  The 'limit' and 'performance'
]>]>interface (/proc) are fully functional.  [Note that basic policy for
]>]>controlling performance state transitions will be included in the next
]>]>version of ospmd.] The idle handler was modified to more aggressively
]>]>use C2, and PIIX4 errata handling underwent a
]>]>complete overhaul (big thanks to Dominik Brodowski).
]>]>
]>]>.
]>]>
]>]>
]>]>
]>]
]>
]>.
]>
]>
]>
]



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com

From: Daniel Thor Kristjansson <danielk-L9gzEf+okJWVc3sceRu5cw@public.gmane.org>
Subject: Re: More than one battery
Date: Fri, 17 Jan 2003 07:09:10 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.SOL.4.44.0301170705110.24216-100000@graphics.cat.nyu.edu>
References: <3E226B80.20208@muenster.de>
Reply-To: danielk-L9gzEf+okJWVc3sceRu5cw@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E226B80.20208-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org>
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


Yes, I think the auto-performance should be in there as well. I'm
working on something else right now, but the deadline for that is next
week. So following, that I'll clean it up and send you the diffs
(should be next weekend).

-- Daniel
  <<You cant eat before a operashun. Not even cheese.>> -- Charlie Gordon

On Mon, 13 Jan 2003, Malte Thoma wrote:

]
]
]Daniel Thor Kristjansson wrote:
]
]>I found the text below through some googling. The important thing is
]>that ospmd is supposed to support acpi policies in the next version. I
]>believe this means that you can hand a policy to ospmd and have it
]>handle throttling for you, I doubt it would take cpu load into account.
]>But I'm going to try to find who's working on that, the cpp files all
]>just say "Intel" then find out if they are planning on putting a more
]>complete policy support into the ospmd deamon, or could use a
]>contribution. Throttling just based on thermal event might save your
]>CPU, but won't save as much battery power as throttling the CPU when
]>load is low. (I can easly half my battery draw by throttling and turning
]>down the LCD, but I wouldn't do it without my hacked heatload
]>unthrottling when the system load goes up.)
]>
]>
]Please send my a diff from the hacked heatload.
]If I understand you right, you have included an
]
]'auto-throttling-when-no-load'
]
]I think this is worth to be included in the offical release, don't you?
]We should include 'auto-performance-when-no-load' as welll, what's your
]opinion?
]
]
]Greetings,
]
]Malte
]
]
]
]
]
]>Anyway, I'll keep you informed.
]>
]>-- Daniel
]>
]>  http://216.239.37.100/search?q=cache:pOZPEz5rV_8C:www.intel.com/technology/iapc/acpi/downloads/CHANGES.txt+ospmd+cpu+throttling&hl=en&ie=UTF-8
]>
]>The processor driver (acpi_processor.c) now fully supports ACPI
]>2.0-based processor performance control (e.g. Intel(R) SpeedStep(TM)
]>technology) Note that older laptops that only have the Intel "applet"
]>interface are not supported through this.  The 'limit' and 'performance'
]>interface (/proc) are fully functional.  [Note that basic policy for
]>controlling performance state transitions will be included in the next
]>version of ospmd.] The idle handler was modified to more aggressively
]>use C2, and PIIX4 errata handling underwent a
]>complete overhaul (big thanks to Dominik Brodowski).
]>
]>.
]>
]>
]>
]



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en

From: valvoline <valvoline-KGm45+8e4WzOeuqD6ShaSA@public.gmane.org>
Subject: ACPI and APM
Date: Sat, 24 Aug 2002 19:20:26 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020824192026.0e4811bf.valvoline@tiscalinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

hi all,

i follow the acpi thread under linux, since the first versions,
actually i'm running a 2.4.19 box, under an asus L3860C laptop.

I've tried the last patch for this kernel, and all works fine!
(fans status, temperature, cpu throttling, etc.)...but sleep mode,
doesn't work. i've tried the software suspend patch (swusp), but
without any success.

the system doesn't do nothing, even if i can see five sleep modes
with a 'cat /proc/acpi/sleep'; it show me: S0, S1, S2, S3, S4, S5.
I've checked for the ACPI_CONFIG_SLEEP, flag, and it's set to 'y'.

I've tried all the five states, with a 'echo n > /proc/acpi/sleep',
where n is the number (1,2,3,4,5,0), but without any success: It
does nothing.

reading this ml, i've learned, about a not well support of sleep states
under 2.4.x, and many gurus suggests to use a 2.5.LAST kernel to use this
functions.

since, i need a well-known kernel, and the 2.4.19 is a very stable and
efficent one for me, i've tried another way, to solve the problem:

i've hacked the acpi.c and apm.c drivers files under the arch/i386/kernel,
and i've bypassed some controls, to load both apm and acpi. Next, i've
disabled the Battery, AC-Adapter and Button flags, from ACPI config.
Under APM config, i've enabled the 'PM at boot time' and 'Enable console
Blanking using APM'. 

the system seems to work properly (fans works fine, and are triggered wells),
the thermal zone works fine, and....apmd suspend/standby WORKS!

there're some problems, that i don't know, doing something like above ?
suggests ?, comments ?...any will be welcome!


thanx in advance.

-- 
[ valvoline :: VRL Team :: s0ftpj :: freaknet Medialab :: GPG key available  ]
[ key fingerprint :: - :: B7E2 48BC 705F AE8F 9ABE  E422 076A 2561 1D67 B4DD ]
[ GPG key available on keyserver :: pgp.mit.edu :: with keyID :: 1D67B4DD :: ]


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390

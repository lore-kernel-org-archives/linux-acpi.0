From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: Re: acpi debug messages from compaq presario 2800...
Date: Wed, 7 Aug 2002 17:15:57 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020807231558.6052.qmail@scrye.com>
References: <20020807225425.5804.qmail@scrye.com>
	<200208072307.TAA05468@magic-pi-ball.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200208072307.TAA05468-UAlz0gpoyMvRrlGjHHsfAOmCSIfjHtlf@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Sourav" == Sourav K Mandal <Sourav> writes:

>> Could not install Pci_config handler for C03C, AE_ALREADY_EXISTS
>> ....evrgnini-0243: *** Error: Could not install Pci_config handler
>> for C03C, AE_ALREADY_EXISTS
>> 
>> Is this a problem? Any ideas what C03C is?

Sourav> I have the exact same error messsages.  As I speculated
Sourav> earlier, this could be affecting the soundcard and modem,
Sourav> which are both PCI.  The soundcard ALSA drivers must be
Sourav> unloaded and reloaded on suspend, sound apps die when I hit
Sourav> "pause", and Quake 3 doesn't work any more (complains of
Sourav> "broken pipe" when accessing the emulated OSS device).

This doesn't happen to me at all with the stock 2.4 sound
drivers. Sound appears to work all the time...

Sourav> Second, modem has gotten flakier -- it refuses to connect
Sourav> after coming out of a suspend, requiring a reboot.  I'm trying
Sourav> out unloading/reloading those modules as well in my suspend
Sourav> script ...

modem also appears to work fine for me after suspend. At least it
answers at commands. I don't use dialup, so not sure if it connects. 

Sourav> None of these problems occurred prior to modifying my DSDT.
Sourav> Can you verify these effects?
Sourav> Unfortunately, I haven't yet figured out what C03C is.

It appears to be some kind of embedded_controller? 
I do have: 

[/proc/acpi/embedded_controller/C0D0] cat info
gpe bit:                 0x1d
ports:                   0x66, 0x62
use global lock:         no

Sourav> Sourav
Sourav> PS: There's also token in the DSDT that starts with "*SYN" ...
Sourav> i wonder if that needs to be changed to "SYN" as well.

Might be worth a try. 

kevin

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.6 and Gnu Privacy Guard <http://www.gnupg.org/>

iD8DBQE9Uaou3imCezTjY0ERAq/aAJ9fBDXp8e7VkDatfRe777q9lR1LLQCeNsBB
8GVhOWQR+mPn9dSXzKarSKM=
=svyj
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

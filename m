From: Valdis.Kletnieks-PjAqaU27lzQ@public.gmane.org
Subject: ACPI battery issues on Dell C840 - OK in -test11-mm1, broken in 2.6.0-mm1.
Date: Mon, 05 Jan 2004 18:42:47 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401052342.i05Ngl53009891@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2102990847P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--==_Exmh_-2102990847P
Content-Type: text/plain; charset=us-ascii

(acpi-devel readers please cc: me, am only on lkml list)

Summary: Battery support was working ok for me in -test11-mm1 and earlier,
but is broken in 2.6.0-mm1 and later.  I suspect 2.6.0-mm1's inclusion of 
acpi-20031203.patch, but I haven't found where in the 154K of patch it goes
astray yet.

Symptoms:

At boot, the batteries are found:

Jan  5 14:53:12 turing-police kernel: ACPI: Battery Slot [BAT0] (battery present)
Jan  5 14:53:12 turing-police kernel: ACPI: Battery Slot [BAT1] (battery present)

and files created:

% ls -lR /proc/acpi/battery
/proc/acpi/battery:
total 0
dr-xr-xr-x  2 root root 0 Jan  5 18:33 BAT0
dr-xr-xr-x  2 root root 0 Jan  5 18:33 BAT1

/proc/acpi/battery/BAT0:
total 0
-rw-r--r--  1 root root 0 Jan  5 18:33 alarm
-r--r--r--  1 root root 0 Jan  5 18:33 info
-r--r--r--  1 root root 0 Jan  5 18:33 state

/proc/acpi/battery/BAT1:
total 0
-rw-r--r--  1 root root 0 Jan  5 18:33 alarm
-r--r--r--  1 root root 0 Jan  5 18:33 info
-r--r--r--  1 root root 0 Jan  5 18:33 state

but the contents are broken:

%  cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         0 mWh
last full capacity:      0 mWh
battery technology:      non-rechargeable
design voltage:          0 mV
design capacity warning: 0 mWh
design capacity low:     0 mWh
capacity granularity 1:  0 mWh
capacity granularity 2:  0 mWh
model number:            
serial number:           
battery type:            
OEM info:                
% cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mA
remaining capacity:      0 mAh
present voltage:         0 mV

under -test11-mm1, we had in 'info':
present:                 yes
design capacity:         66000 mWh
last full capacity:      62400 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 3000 mWh
design capacity low:     1000 mWh
capacity granularity 1:  200 mWh
capacity granularity 2:  200 mWh
model number:            0004M778
serial number:           1084
battery type:            LION
OEM info:                SANYO

and 'state':
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            unknown
remaining capacity:      66000 mWh
present voltage:         16682 mV

Even while booted on 2.6.1-rc1-mm2, dmidecode 2.2 can find the info:

Handle 0x1600
        DMI type 22, 26 bytes.
        Portable Battery
                Location: Left Module Bay 
                Manufacturer: SANYO           
                Name: 0004M778        
                Design Capacity: 66000 mWh
                Design Voltage: 14800 mV
                SBDS Version: 1.0
                Maximum Error: 4%
                SBDS Serial Number: 043C
                SBDS Manufacture Date: 2002-04-12
                SBDS Chemistry: LION            
                OEM-specific Information: 0x00000001
Handle 0x1601
        DMI type 22, 26 bytes.
        Portable Battery
                Location: Right Module Bay
                Manufacturer: SANYO           
                Name: 0001J433        
                Design Capacity: 66000 mWh
                Design Voltage: 14800 mV
                SBDS Version: 1.0
                Maximum Error: 4%
                SBDS Serial Number: 014F
                SBDS Manufacture Date: 2002-03-26
                SBDS Chemistry: LION            
                OEM-specific Information: 0x00000001

So my acpi can't be TOO insane, right?

I'd be happy to debug further - the kernel(s) in question already have
CONFIG_ACPI_DEBUG built in, but I'm at a loss as to what to echo
onto the /proc/acpi/debug_layer and debug_level files to actually toggle
the printk's to something useful.

Any comments/hints/ideas/patches? ;)

--==_Exmh_-2102990847P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/+fZ3cC3lWbTT17ARAjdzAJ0Y/h3ogYvdUNjM5frNawoYW1hEzwCfcasx
quDg8qBV40k99lbhT81iuZs=
=WP4M
-----END PGP SIGNATURE-----

--==_Exmh_-2102990847P--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

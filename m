From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI Battery status on Acer TravelMate a-550XV
Date: Fri, 15 Nov 2002 10:45:38 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B907@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'lestat-oqfuaKpTAUt/+UGKtYOvpA@public.gmane.org'" <lestat-oqfuaKpTAUt/+UGKtYOvpA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>From looking at your disassembled dsdt, I think that there is a problem with
the _BIF method:

                    Method (_BIF, 0, NotSerialized)
                    {
                        Name (STAT, Package (0x0D)
                        {
                            0x01, 
                            0x1194, 
                            0x1194, 
                            0x01, 
                            0x39D0, 
                            0x01A4, 
                            0x9C, 
                            0x0108, 
                            0x0EC4, 
                            "PXBAS008", 
                            "3658Q", 
                            "NiMH ", 
                            Zero, 
                            "PANASONIC"
                        })
                        ...

                            Sleep (0x64)
                        ...

                        Return (STAT)
                    }

1) The sleep within the method will allow another thread to begin execution
of the same method -- because the method is declared "NotSerialized"

2) The declaration of the "STAT" package in the namespace will fail with
AE_ALREADY_EXISTS if a second thread reenters the method (exactly the
problem you are seeing when you pop the battery back in.)

My suggested fix:
Disassemble the dsdt (iasl -d dsdt.dat)
Change "NotSerialized" to "Serialized" in the declaration of _BIF.
Recompile and install the new dsdt (Override the BIOS dsdt)

Bob



-----Original Message-----
From: Ciro Mattia Gonano [mailto:lestat-oqfuaKpTAUt/+UGKtYOvpA@public.gmane.org] 
Sent: Wednesday, November 13, 2002 2:54 AM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] ACPI Battery status on Acer TravelMate a-550XV

Hi all.
I'm quite a newbie in kernel hacking, and the same (and maybe more ;) ) in
acpi
hacking.
So, that's my problem: with vanilla kernel acpi support I was not able to
see my
laptop's battery status, and for acpi AC Adapter was online all the time (it
showed me on-line also if really the cable was not on).
So, I tried to apply acpi-20021101-2.4.20-rc1.diff.gz to a 2.4.20-rc1
kernel,
and something seemed to have changed...
The AC Adapter status works fine (it reflects the real status on/off-line of
the
cable), the power button also works fine, but the battery still doesn't work
:(
I use "acpi" cmd to view the status, and, while the first time I run it, it
always outputs me:

lilith:~# acpi -V
     Battery 1: charging, 98%, charging at zero rate - will never fully
charge.
     Thermal 1: ok, 37.0 degrees C
  AC Adapter 1: on-line

starting from the second time, it outputs me the real status, something like
this:

lilith:~# acpi -V
     Thermal 1: ok, 50.0 degrees C
  AC Adapter 1: off-line

..and the battery couldn't be viewed anymore.
I tried to unplug the battery, and then replug in (while the laptop was on
AC,
obviously), and I received some error messages:

    ACPI-0251: *** Error: Looking up [STAT] in namespace, AE_ALREADY_EXISTS

..and obviously the battery still doesn't exists, for acpi.
I tried to look in the drivers/acpi/ dir, and to work around the error, but
I
couldn't be able to do much... :(
Some hints?

My laptop's an Acer TravelMate a-550XV, some OLD informations about what I
done
on it can be found on http://www.CS.UniBO.It/~gonano/a-550XV.htm , and at
the
moment I run on it Debian unstable, with acpid-1.0.1 and acpi 0.06.

Thanks in advance...

Adieu,
-- 
Lestat de Lioncourt  -- a.k.a --  Ciro Mattia Gonano
 Undergraduate student in Computer Science at University of Bologna
 IHGGer #1049   <=>  ICQ#: 52631406   <=>   URL:
http://www.CS.UniBO.It/~gonano
 Debian admin at Students.CS.UniBO.It <=> look at headers for my JabberID &
GPG


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html

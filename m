From: giupil <giupil-nznwD2ikctv02BlrwmTdfg@public.gmane.org>
Subject: Aspire 1511LMI - Aspire 1513LMI DSDT
Date: Fri, 19 Nov 2004 20:03:15 +0000
Message-ID: <419E5183.6030405@aliceposta.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

I've an Acer Aspire 1513lmi; this notebook is a 1511lmi + AMD Athlon 64 
Processor 3400+ and their DSDTs are identical.
I've followed the threads about the 1511lmi and I found the Christian 
Casteyde DSDT and his suggestions in:

http://casteyde.christian.free.fr/laptop/LinuxOnAspire1511LMi.html

and the DSDT in:

http://acpi.sourceforge.net/dsdt/tables/ACER/Aspire_1513LMi/ACER-Aspire_1513LMi-unknown_bios-custom.asl.gz

and these work fine on my system.

My system is a dual boot system Gentoo-64 + Freebsd-64 (5.3 
installation) and then the DSDT problem is also
a Freebsd problem.
In Freebsd the better way to obtain the DSDT is the acpidump solution 
and this DSDT is just like the DSDT that
I obtained by my Linux system, except for some initial notes, for the 
file tail, and a error that the Freebsd iasl and
http://acpi.sourceforge.net/dsdt/tables/ACER/Aspire_1513LMi/ACER-Aspire_1513LMi-unknown_bios-custom.asl.gz 
signal
but the iasl in Linux doesn't signal.

The Linux DSDT tail is:

.
.
.
    Name (FWSO, "FWSO")
}


The Freebsd DSDT tail is:

.
.
.
    Name (FWSO, "FWSO")
    Scope (\_PR.CPU0)
    {
        Name (_PCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 0x00, 0x00, 0x0000000000000000)
            },

            ResourceTemplate ()
            {
                Register (FFixedHW, 0x00, 0x00, 0x0000000000000000)
            }
        })
        Name (_PSS, Package (0x04)
        {
            Package (0x06)
            {
                0x00000898,
                0x00013E5C,
                0x00000064,
                0x00000009,
                0xE020288E,
                0x0000008E
            },

            Package (0x06)
            {
                0x000007D0,
                0x0000FA00,
                0x00000064,
                0x00000009,
                0xE020298C,
                0x0000018C
            },

            Package (0x06)
            {
                0x00000708,
                0x0000B798,
                0x00000064,
                0x00000009,
                0xE0202A8A,
                0x0000028A
            },

            Package (0x06)
            {
                0x00000320,
                0x00004A38,
                0x00000064,
                0x00000009,
                0xE0202C80,
                0x00000480
            }
        })
        Name (_PPC, 0x00)
    }
}



I'm not a acpi-asl expert, but this excerpt, I think, defines the cpu 
object. There are three subobjects:

the _PCT interface, the _PSS declaration about the performance states and
the _PPC method, and they make clear the file part:

    Scope (\_PR)
    {
        Processor (CPU0, 0x00, 0x00008010, 0x06) {}
    }

The only part that, I think, is strange in this excerpt is "Name (_PPC, 
0x00)", because _PPC is a method and its definition
form, in general, is:

Method (_PPC, ...)

{
.
.
}

but here, _PPC has an objectname form.

Anyway in the Freebsd DSDT, the only necessary changes are:


3975,3980d3974
<
<                         Return (Package (0x02)     <------ #### This 
additional lines are absent in the Casteyde DSDT
<                         {               
                                     #### and I obtained its solution by 
the DSDT for
<                             Zero,           
                              #### 1513lmi in:
<                             Zero           
                               #### 
http://acpi.sourceforge.net/dsdt/tables/ACER/-
<                         })               
                                   #### 
ACER-Aspire_1513LMi-unknown_bios-custom.asl.gz
5163,5164c5157,5158                                             #### at 
the line 3893.
<                 0x00,                
                                    #### Note that the iasl decompiler, 
in Linux, doesn't
<                 0x00,                
                                    #### signals this error, but the 
Freebsd one signals it.
---                                                          
 >                 Z005,
 >                 Z005,
5456d5449
<         Return(Package(0x02){0x00, 0x00})

Note that the Freebsd DSDT is longer that the Linux DSDT because the 
first one has some initial notes.
The Freebsd DSDT tail can't be added to the Linux DSDT, because the 
Linux system doesn't boot with this.


I don't know why the Freebsd DSDT is so different, but peraphs someone 
can use this excerpt to improve the DSDT corrections.
I can add that these corrections work in the Freebsd system, and the 
error signals disappear with the corrected DSDT, but
I can't know if the acpi system work fine with Freebsd, because the 
Freebsd S.O. doesn't implement
the powernow-k8 functionalities.
Peraphs this Freebsd DSDT tail is only an external (this is strange 
because the AML decompilers don't print the externals), and in fact the 
powenow-k8 functionalities for the frequencies 2200000 (0x00000898), 
2000000
(0x000007D0), 1800000 (0x00000708), 800000 ( 0x00000320) are correctly 
recognized by Linux, and then this tail isn't
necessary.

About the error that the Freebsd iasl (and the 
http://acpi.sourceforge.net/dsdt/tables/ACER/Aspire_1513LMi/-
ACER-Aspire_1513LMi-unknown_bios-custom.asl.gz) signals and the Linux 
iasl (and Casteyde for 1511lmi) doesn't signal,
I add this comment that I found in http://www.cpqlinux.com/acpi-howto.html:

.
.
.
Note: It may be possible to use iasl with the -d option to dump your 
table to .asl as well; however, one guy at the acpica
ML who showed me this had the following to say:

"I have not checked actually if iasl is 'good' in order to disable the 
AML. It is a new feature, so that it has perhaps
some bugs. I can not be sure.

Using pacpidump should be OK, but the version you point was updated, 
debugged, etc. under FreeBSD, and those changes are
present only under FBSD, not the one you pointed."
.
.
.


Then I think that the acpidump command and iasl command in Freebsd works
better that in Linux and that the freebsd error signals are, peraphs, more
correct.

Sorry for my english, it's terrible, I know!

Bye Giuseppe



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

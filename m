From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Battery Information in 20041105
Date: Tue, 16 Nov 2004 17:07:43 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305758EF2B0@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Peter.Fruehberger-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Oh, looks like the string is output as hex. Please let me know your
kernel version. Just want to verify if it's caused by my
'migrate_to_seqfile_interface' patch.

Thanks,
Shaohua
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Peter.Fruehberger-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org
>Sent: Tuesday, November 16, 2004 4:52 PM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] Battery Information in 20041105
>
>Hi,
>just want to report, that acpi version 20041105 does not show my
battery
>info correct:
>
>#latest acpi version
>version:                 20041105
>alarm:                   2689 mWh
>present:                 yes
>design capacity:         57600 mWh
>last full capacity:      53790 mWh
>battery technology:      rechargeable
>design voltage:          14400 mV
>design capacity warning: 2689 mWh
>design capacity low:     200 mWh
>capacity granularity 1:  1 mWh
>capacity granularity 2:  1 mWh
>model number:            49 42 4D 2D 30 32 4B 36 39 32 38 00 00 00 00
00
>serial number:           20 31 35 32 36 00
>battery type:            4C 49 4F 4E 00
>OEM info:                50 61 6E 61 73 6F 6E 69 63 00 30 32 00 00 00
00
>present:                 yes
>capacity state:          ok
>charging state:          charged
>present rate:            0 mW
>remaining capacity:      53790 mWh
>present voltage:         16629 mV
>
>
>#here the vanilla 2.6.9 version:
>version:                 20040816
>alarm:                   2689 mWh
>present:                 yes
>design capacity:         57600 mWh
>last full capacity:      53790 mWh
>battery technology:      rechargeable
>design voltage:          14400 mV
>design capacity warning: 2689 mWh
>design capacity low:     200 mWh
>capacity granularity 1:  1 mWh
>capacity granularity 2:  1 mWh
>model number:            IBM-02K6928
>serial number:            1526
>battery type:            LION
>OEM info:                Panasonic
>present:                 yes
>capacity state:          ok
>charging state:          charged
>present rate:            0 mW
>remaining capacity:      53790 mWh
>present voltage:         16629 mV
>
>Model Number, serial number, battery type and OEM info are not
displayed
>correct I think
>
>kernel version: 2.6.9 vanilla
>Hardware: IBM Thinkpad R40 2722-B3G
>
>Peter
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: InterSystems CACHE
>FREE OODBMS DOWNLOAD - A multidimensional database that combines
>robust object and relational technologies, making it a perfect match
>for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

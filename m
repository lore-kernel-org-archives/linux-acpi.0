From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Battery Information in 20041105
Date: Tue, 16 Nov 2004 17:57:40 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC07B@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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
Cc: "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

What could happen if revert the following patcheset.

http://linux-acpi.bkbits.net:8080/26-latest-test/patch@1.1803.162.10?nav=3D=
index.html|src/.|src/include|src/include/acpi|related/include/acpi/acconf=
ig.h|cset@1.1803.162.10

Maybe you need to narrow the issue down.=20
If you can point out what was exactly breaking, I think the fix can be =
worked out quickly.=20
As for regression,  narrowing issue down to small wrong patch can help =
developer significantly.

Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Peter.Fruehberger-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org
>Sent: 2004=C4=EA11=D4=C216=C8=D5 16:52
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] Battery Information in 20041105
>
>Hi,
>just want to report, that acpi version 20041105 does not show=20
>my battery
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
>model number:            49 42 4D 2D 30 32 4B 36 39 32 38 00=20
>00 00 00 00
>serial number:           20 31 35 32 36 00
>battery type:            4C 49 4F 4E 00
>OEM info:                50 61 6E 61 73 6F 6E 69 63 00 30 32=20
>00 00 00 00
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
>Model Number, serial number, battery type and OEM info are not=20
>displayed
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
>


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI-bugzilla] Update: ACPI reboot hangs Asus p4b533
Date: Mon, 11 Apr 2005 12:59:29 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575019C2AC2@pdsmsx402.ccr.corp.intel.com>
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
To: Peter Holik <peter-xHLhtm3VSFg@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Did 2.6 kernel work? And how about unload i2c driver?
BTW: please not send email to acpi-bugzilla list.

Shaohua
>-----Original Message-----
>From: acpi-bugzilla-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-bugzilla-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Peter Holik
>Sent: Saturday, April 09, 2005 9:44 PM
>To: acpi-bugzilla-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI-bugzilla] Update: ACPI reboot hangs Asus p4b533
>
>> ACPI reboot hangs Asus p4b533 Motherboard.
>>
>> I've found out that after kernel 2.4.27 this issue happen.
>> I think that acpi_early_init is responsible for this.
>> (Introduced in kernel 2.4.28)
>>
>> if i boot with acpi=3Doff reboot works.
>>
>> I tried also with reboot=3Db and nolapic but no success
>
>Now I disabled acpi_motherboard_init and reboot works.
>
>Before I got following syslog entry:
>
>PCI: Cannot allocate resource region 4 of device 00:1f.3
>
>lspci -vv
>
>0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
SMBus
>Controller
>(rev 01)
>        Subsystem: Asustek Computer, Inc.: Unknown device 8089
>        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr-
>Stepping-
>SERR- FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>TAbort-
><TAbort-
><MAbort- >SERR- <PERR-
>        Interrupt: pin B routed to IRQ 17
>        Region 4: I/O ports at e800 [size=3D32]
>
>cu Peter
>
>
>
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real
users.
>Discover which products truly live up to the hype. Start reading now.
>http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
>_______________________________________________
>acpi-bugzilla mailing list
>acpi-bugzilla-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-bugzilla


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

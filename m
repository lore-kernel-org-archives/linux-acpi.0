From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: HELP with 82855PM chipset issue
Date: Wed, 29 Dec 2004 11:31:46 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8406A73CBE@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
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
To: ron-13hema8v3vg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 Please use setpci to restore the original vaue after S3 resume, and =
re-test=20
memory bandwidth.

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Ron =
Rechenmacher
Sent: 2004=C4=EA12=D4=C229=C8=D5 11:09
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: ron-13hema8v3vg@public.gmane.org
Subject: [ACPI] HELP with 82855PM chipset issue

Hi,

I hope this is considered only a bit off track (sorry)...
I have a Dell Precision M60 and under linux or windows I see significant =
(~17%)
decrease in main memory performance after the 1st software suspend to =
ram or=20
standby. I would appreciated if any one that has an 82855PM system from=20
another vendor could:
    =20
     1a. verify that the chipset is 82855PM and note the rev (03 or 21)
     1b. boot or reboot
     2a. if linux, record the output of "lspci -xxx" (lspci -xxx =
>before.txt)
     2b. measure main memory bandwidth (prior to the 1st suspend after =
reboot)
     3.  software suspend (or standby under windows)
     4.  wake (via power button)
     5a. remeausure main memory bandwith and (potentially) notice =
decrease
         in performance. Note that L1/L2 cache performance does not =
decrease.
     5b. if linux, record the output of "lspci -xxx" (lspci -xxx =
>after.txt)

and reply to me the results.
Further info (including bandwidth measurement software info) can be =
found at:
     http://bugzilla.kernel.org/show_bug.cgi?id=3D3918

Thanks for your help,
Ron




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.=20
http://productguide.itmanagersjournal.com/
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

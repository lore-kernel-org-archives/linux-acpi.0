From: "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Centrino question
Date: Fri, 21 May 2004 11:08:49 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7F740D512C7C1046AB53446D372001730177CE7A@scsmsx402.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

To get longer battery life, you need to use P-state transitions via
Enhanced SpeedStep as well.

Jun
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Ow Mun Heng
>Sent: Friday, May 21, 2004 10:39 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] Centrino question
>
>On Fri, 2004-05-21 at 04:52, Karol Kozimor wrote:
>> Thus wrote Cyril Wattebled:
>> > However, I don't understand, I was told that the centrino processor
and
>chipset
>> > supports C3 and even C4.
>
>C3 is Supported
>
>
>active state:            C2
>default state:           C1
>bus master activity:     ffffffff
>states:
>    C1:  promotion[C2] demotion[--] latency[000] usage[01028830]
>   *C2: promotion[C3] demotion[C1] latency[050] usage[04785987]
>    C3:  promotion[--] demotion[C2] latency[050] usage[00001327]
>
>This is a Dell D600 1.4g. c3 values are low because I have the USB
mouse
>on right now. (note the fffffff??)
>
>I've tested it with and w/o C3. The difference in the battery lifetime
>was only very minmal. I got like maybe 10 mins extra.
>
>I last 2:30 on Linux and 3h on Windows.
>
>Batt Life Sucks..
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: Oracle 10g
>Get certified on the hottest thing ever to hit the market... Oracle
10g.
>Take an Oracle 10g class now, and we'll give you the exam FREE.
>http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click

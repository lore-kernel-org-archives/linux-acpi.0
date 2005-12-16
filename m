From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: unable to set alam using echo to /proc/acpi/alarm
Date: Fri, 16 Dec 2005 09:58:36 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F10120CC25@pdsmsx406>
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
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Ronald Wielink <ronald.mythtv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
>
>> >>    when I try setting the alarm to wake up my pc I get the
following
>> >>    result:
>> >>    [root@mithrandir acpi]# pwd
>> >>    /proc/acpi
>> >>    [root@mithrandir acpi]# cat alarm
>> >>    2005-12-00 00:00:00
>> >>    [root@mithrandir acpi]# echo 2005-12-15 17:18:19 > alarm
>> >>    [root@mithrandir acpi]# cat alarm
>> >>    2005-12-00 17:18:19
>> >>    [root@mithrandir acpi]#
>> >>    BTW, nothing happens at the echo'd date/time. Could someone
please
>> >>    give me a clue where to start looking?  I'm running fedora core
4,
>> my
>> >>    mobo is an ASUS P5S800-VM, the documentation on the motherboard
>> states
>> >>    that ACPI is supported. There is an option to turn acpi 2.0 on,
>> but no
>> >>    difference...
>> >
>> >alarm never worked properly, IIRC.
>
>> It works well on different systems here :).
>
>Okay, so the problem is in me. Could we get some documentation? It
>would be useful to know what to expect, and it should probably end up
>in Documentation/ somewhere.
Yup. Alarm is expected to wakeup the system from S3 sleep at a given
time.
Setting day, month and century is optional and depends on BIOS per ACPI
spec.
S4 alarm is also optional but maybe doesn't work on Linux (never tried).

Thanks,
Shaohua


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

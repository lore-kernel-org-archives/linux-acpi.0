From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: Re: unable to set alam using echo to /proc/acpi/alarm
Date: Wed, 14 Dec 2005 10:22:05 -0700
Message-ID: <20051214172209.8CC56380C1C@ningauble.scrye.com>
References: <59D45D057E9702469E5775CBB56411F1011BD8A4@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Shaohua" == Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:

Shaohua> Hi,
>>
>>> when I try setting the alarm to wake up my pc I get the following
>>> result: [root@mithrandir acpi]# pwd /proc/acpi [root@mithrandir
>>> acpi]# cat alarm 2005-12-00 00:00:00 [root@mithrandir acpi]# echo
>>> 2005-12-15 17:18:19 > alarm [root@mithrandir acpi]# cat alarm
>>> 2005-12-00 17:18:19 [root@mithrandir acpi]# BTW, nothing happens
>>> at the echo'd date/time. Could someone please give me a clue where
>>> to start looking?  I'm running fedora core 4,
Shaohua> my
>>> mobo is an ASUS P5S800-VM, the documentation on the motherboard
Shaohua> states
>>> that ACPI is supported. There is an option to turn acpi 2.0 on,
Shaohua> but no
>>> difference...
>> alarm never worked properly, IIRC.

Shaohua> It works well on different systems here :).

It works fine for me too here. 

One thing that I see, from the orig post: 

>[root@mithrandir acpi]# echo 2005-12-15 17:18:19 > alarm
>[root@mithrandir acpi]# cat alarm 
2005-12-00 17:18:19

Don't you need to ' that string since there is a space?
ie: 

echo '2005-12-15 17:18:19' > alarm

in order to get the year/month/date in correctly?

Shaohua> Thanks, Shaohua

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFDoFTA3imCezTjY0ERAkNMAJ0QmeR1aA99CuJA+F7c8vAdqnxkhQCfUwEH
uTgnG87/Qb8/VkDaC9IXPIU=
=gxQt
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

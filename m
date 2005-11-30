From: Couriousous <couriousous-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: VBEtool 0.5 adds support for amd64
Date: Wed, 30 Nov 2005 22:12:08 +0100
Message-ID: <200511302212.08494.couriousous@gmail.com>
References: <20051130022920.GA19363@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051130022920.GA19363-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Content-Disposition: inline
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

Le Mercredi 30 Novembre 2005 03:29, Matthew Garrett a =E9crit=A0:
> I've just uploaded vbetool 0.5 to
> http://www.srcf.ucam.org/~mjg59/vbetool . This version should work with
> newer kernels and also adds support for non-x86 architectures using the
> Scitech x86emu code found in X.org. My nx6125 successfully resumes video
> using vbestate saving/restoring, though attempting to re-POST it hangs
> the machine. Knowing how well it works for others would be nice.

Here is what a get on my x86_64 with a :
01:00.0 VGA compatible controller: nVidia Corporation GeForce 6200=20
TurboCache(TM) (rev a1)

[root@localhost couriousous]# vbetool vbestate save
Get video state buffer size failed
Allocated buffer at 0x20000 (base is 0x0)
ES: 0x2000 EBX: 0x0000
Erreur de segmentation

Running it with gdb say that is segfault at:
Program received signal SIGSEGV, Segmentation fault.
0x0000000000425815 in rdw (addr=3D38088) at sys.c:269
269                     val =3D *(u16*)(M.mem_base + addr);
(gdb) list
264             else
265     #endif
266     #if defined(__alpha__) || defined(__alpha)
267                     val =3D ldw_u((u16*)(M.mem_base + addr));
268     #else
269                     val =3D *(u16*)(M.mem_base + addr);
270     #endif
271                     DB(     if (DEBUG_MEM_TRACE())
272                     printk("%#08x 2 -> %#x\n", addr, val);)
273         return val;
(gdb) print addr
$1 =3D 38088

Pmap on the process give:
[root@localhost couriousous]# pmap 5549
5549:   /usr/sbin/vbetool vbestate save
0000000000000000      4K rwxs-  /dev/mem
0000000000010000    256K rwxs-  /dev/zero (deleted)
00000000000a0000    384K rw-s-  /dev/mem
0000000000400000    200K r-x--  /usr/sbin/vbetool
0000000000532000      8K rw---  /usr/sbin/vbetool
0000000000534000    136K rw---    [ anon ]
00002aaaaaaab000     88K r-x--  /lib64/ld-2.3.5.so
00002aaaaaac1000      4K rw---    [ anon ]
00002aaaaabc0000      4K r----  /lib64/ld-2.3.5.so
00002aaaaabc1000      4K rw---  /lib64/ld-2.3.5.so
00002aaaaabc2000   1212K r-x--  /lib64/tls/libc-2.3.5.so
00002aaaaacf1000   1020K -----  /lib64/tls/libc-2.3.5.so
00002aaaaadf0000     12K r----  /lib64/tls/libc-2.3.5.so
00002aaaaadf3000     12K rw---  /lib64/tls/libc-2.3.5.so
00002aaaaadf6000     24K rw---    [ anon ]
00007fffff8ac000     84K rw---    [ stack ]
ffffffffff600000   8192K -----    [ anon ]
 total            11644K

Regards,
Couriousous


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

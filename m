From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Re: Samsung P35 and S3 suspend
Date: Tue, 21 Dec 2004 01:39:43 +0100
Message-ID: <41C770CF.1020408@gmx.net>
References: <41BFC3AD.5030001@gmx.net> <1103117333.5924.3.camel@mhcln03>	 <41C07B6F.70900@gmx.net> <1103159022.5924.17.camel@mhcln03>	 <41C0FFF3.4010902@gmx.net> <41C19BD8.7050201@gmx.net>	 <41C1CFA2.20304@gmx.net>  <1103222517.5924.24.camel@mhcln03> <1103224145.5984.72.camel@tyrosine> <41C7374D.6090407@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080407020502040400040608"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41C7374D.6090407-hi6Y0CQ0nG0@public.gmane.org>
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
Cc: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080407020502040400040608
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

PROBLEM SOLVED COMPLETELY! Read on for details (and excuse the yelling)
;-)

Search engine hint: Samsung P30 P35 S3 suspend resume

Carl-Daniel Hailfinger schrieb:
> Matthew Garrett schrieb:
> 
>>On Thu, 2004-12-16 at 19:41 +0100, Matthias Hentges wrote:
>>
>>
>>
>>>1: VGA POST
>>>2. VESA reset
>>
>>
>>Can you try the vm86_video_post and vbestate programs from
>>http://www.srcf.ucam.org/~mjg59/laptops/ ? You want to do something like
>>this:
>>
>>1) chvt away from X on suspend
>>2) vbestate save >/tmp/state
>>3) suspend
>>4) resume
>>5) vm86_video_post
>>6) vbestate restore </tmp/state
>>7) chvt back to X
>>
>>This sequence (possibly with a dpms on in there somewhere) seems to work
>>on a fairly large number of machines.
> 
> 
> It sort of works. Before step 7, the (text mode) display contains garbage.

OK, I have a patch for vbestate which allows resume back to a text console
(no X server involved at all) and you should have clean fonts and usable
text console afterwards. The screen needs to be redrawn and Unicode fonts
have to be reloaded, but that can be handled, too.

The following script makes S3 from text console and/or X a breeze:

#!/bin/bash
statedir=/root/s3/state
curcons=`fgconsole`
fuser /dev/tty$curcons 2>/dev/null|xargs ps -o comm= -p|grep -q X && chvt 2
cat /dev/vcsa >$statedir/vcsa
sync
echo 3 >/proc/acpi/sleep
sync
vm86_video_post
vbestate restore <$statedir/vbe.5
cat $statedir/vcsa >/dev/vcsa
rckbd restart
chvt $[curcons%6+1]
chvt $curcons

IMPORTANT NOTES:
$statedir/vbe should be saved directly after bootup before entering X. It
only has to be saved once, you can use it for every situation afterwards.
That includes new boots, having switched from X to console, etc.
vbestate has to be patched with my patch to work correctly.
The script assumes that no harmful modules are loaded.
The kernel was 2.6.10-rc3 or later and had to be patched with
pci-resume-2.6.10.patch and resume-finish-split.patch.
.config available on request (see earlier in this thread for details).
You don't need a patched X for this to work.

With the above script my machine survived 32 iterations of S3 suspend
without any visible problems (no screen corruption, no freezes, even
umlauts are preserved). Sometimes I was in X, sometimes working on the
text console and it came back every time to the console I had used,
screen contents exactly the same as before.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

--------------080407020502040400040608
Content-Type: text/plain;
 name="vbestate-s3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vbestate-s3.diff"

diff -urN vbestate-0.1/vbestate.c vbestate-0.1-s3/vbestate.c
--- vbestate-0.1/vbestate.c	2004-12-09 00:42:51.000000000 +0100
+++ vbestate-0.1-s3/vbestate.c	2004-12-21 01:37:06.132044112 +0100
@@ -119,6 +119,9 @@
 		short tmpbuffer[524288];
 		size_t i,length=0;
 		
+		/* The loop below doesn't make any sense unless we think our
+		input data contains length/sizeof(tmpbuffer)*sizeof(tmpbuffer)
+		bytes of leading garbage */
 		while (i=read(0, tmpbuffer, sizeof(tmpbuffer))) {
 			length+=i;
 		}
@@ -127,6 +130,12 @@
 		memcpy(data,tmpbuffer,length);
 
 		restore_state(data);
+		text_mode();
+
+		data = LRMI_alloc_real(length);
+		memcpy(data,tmpbuffer,length);
+
+		restore_state(data);
 	} else {
 		fprintf(stderr,"%s: Usage %s [save|restore]\n",
 			argv[0],argv[0]);

--------------080407020502040400040608--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

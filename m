From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: PROBLEM: ACPI crashes (2.6.2-rc2-mm1)
Date: Wed, 28 Jan 2004 20:47:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <401811E8.8060003@pca.it>
References: <m3n087khfl.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000408050600010003000006"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m3n087khfl.fsf-glUV91rXKAHWIjgkaejU9x2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000408050600010003000006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello Georg,

on 01/28/04 20:21, Georg C. F. Greve wrote:
> Suspending to disk (S4) suspends just fine. It also finds the file and
> reads the data back into active memory, as well. But when it comes to
> the message
>
>  "Waiting for DMAs to settle down."
>
> the machine suddenly crashes (reboot).
it seems the same on my M3N, I attached some mails I already sent to
this list, which solved the problem for S4, maybe you could give it a
try. IMHO is still an Intel 855GM problem.

As soon as I'll come back home, I'll try again on my M3N.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAGBHmVAp7Xm10JmkRAk7VAJ9dXJ/P8y3Zwp8dZTY5VfLuCV8hTgCdEpQq
e/d4iqv0uyucrPPuQ0juaic=
=fnF1
-----END PGP SIGNATURE-----

--------------000408050600010003000006
Content-Type: message/rfc822;
 name="Attached Message"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Attached Message"

Return-Path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Delivered-To: 3-luca-wlebWZzHoyE@public.gmane.org
Received: (qmail 27507 invoked by uid 2520); 27 Dec 2003 22:37:04 -0000
Received: from lists.sourceforge.net (HELO sc8-sf-mx2.sourceforge.net) (66.35.250.206)
  by 151.39.103.103 with SMTP; 27 Dec 2003 22:37:03 -0000
Received: from sc8-sf-list2-b.sourceforge.net ([10.3.1.8] helo=sc8-sf-list2.sourceforge.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AaMZO-0007K2-DH; Sat, 27 Dec 2003 14:06:02 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=projects.sourceforge.net)
	by sc8-sf-list2.sourceforge.net with esmtp (Exim 4.24)
	id 1AaMZO-0005AH-3E; Sat, 27 Dec 2003 14:06:02 -0800
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list2.sourceforge.net with esmtp (Exim 4.24)
	id 1AaMZA-00059C-Lk
	for acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Sat, 27 Dec 2003 14:05:48 -0800
Received: from hell.org.pl ([212.244.218.42] ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AaMLt-0005cF-If
	for acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Sat, 27 Dec 2003 13:52:05 -0800
Received: (qmail 14665 invoked by uid 777); 27 Dec 2003 21:51:37 -0000
From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: [ACPI] ASUS M3N and sleep states
Message-ID: <20031227215137.GA28438-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Mail-Followup-To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>,
	ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
References: <3FED7289.1070201-wlebWZzHoyE@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <3FED7289.1070201-wlebWZzHoyE@public.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-BeenThere: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Id: ACPI Development Discussion List <acpi-devel.lists.sourceforge.net>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
X-Original-Date: Sat, 27 Dec 2003 22:51:37 +0100
Date: Sat, 27 Dec 2003 22:51:37 +0100
X-Virus-Scanned: by AMaViS perl-11

Thus wrote Luca Capello:
> - - S1
> obviously, if I leave the USB module on, the resume process hangs trying
> to set the IRQ for the USB controllers. So, I unload the USB modules and
> the resume process hangs again. I found that the other problem are the
> ALSA modules: if I unload them (and the USB as well), the resume process

[the following is for ASUS L3800C]
Same here for USB (actually, unloading {usb-,}uhci suffices, 2.6 doesn't
hang though). ALSA doesn't seem to care in my case.
About the shutdown: it is likely that a PWRF event is issued after resume
like in my case, kill acpid prior to suspending and see if it makes any
difference (I reported the PWRF problem here a while ago, but have
received no feedback so far).

> - - S4
> without USB and ALSA, I got a clear power-down and for the resume
> (passing to the kernel the option 'resume=/dev/hda6' which is my swap
> partition), the OS seems to resume correctly, it sees my resume command,
> reads the resume partition, but then it reboots and my swap partition is
> corrupted (I need a mkswap on my swap partition).

Kill X and unload AGP or use Nigel's patches from swsusp.sf.net.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


--------------000408050600010003000006
Content-Type: message/rfc822;
 name="Attached Message"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Attached Message"

Return-Path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Delivered-To: 3-luca-wlebWZzHoyE@public.gmane.org
Received: (qmail 26774 invoked by uid 2520); 30 Dec 2003 20:31:04 -0000
Received: from lists.sourceforge.net (HELO mail.sourceforge.net) (66.35.250.206)
  by 151.39.103.103 with SMTP; 30 Dec 2003 20:31:02 -0000
Received: from sc8-sf-list2-b.sourceforge.net ([10.3.1.8] helo=sc8-sf-list2.sourceforge.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AbQQI-0002m1-43; Tue, 30 Dec 2003 12:25:02 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=projects.sourceforge.net)
	by sc8-sf-list2.sourceforge.net with esmtp (Exim 4.24)
	id 1AbQQH-0005sI-C2; Tue, 30 Dec 2003 12:25:01 -0800
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list2.sourceforge.net with esmtp (Exim 4.24)
	id 1AbQPU-0005rE-RK
	for acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Tue, 30 Dec 2003 12:24:12 -0800
Received: from [151.39.103.104] (helo=host01.pcaserver.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AbQPU-0002YY-5V
	for acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Tue, 30 Dec 2003 12:24:12 -0800
Received: (qmail 26704 invoked by uid 2520); 30 Dec 2003 20:28:55 -0000
Received: from adsl-88-58.37-151.net24.it (HELO pca.it) (151.37.58.88)
  by 151.39.103.103 with SMTP; 30 Dec 2003 20:28:54 -0000
Message-ID: <3FF1C9D0.2080500-wlebWZzHoyE@public.gmane.org>
From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: [ACPI] ASUS M3N and sleep states
References: <3FED7289.1070201-wlebWZzHoyE@public.gmane.org> <20031227173335.GA1599@elf.ucw.cz>
In-Reply-To: <20031227173335.GA1599-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.3 (/)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to http://sf.net/tracker/?func=add&group_id=1&atid=200001
	0.3 UPPERCASE_25_50        message body is 25-50% uppercase
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-BeenThere: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Id: ACPI Development Discussion List <acpi-devel.lists.sourceforge.net>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
X-Original-Date: Tue, 30 Dec 2003 19:54:08 +0100
Date: Tue, 30 Dec 2003 19:54:08 +0100
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to http://sf.net/tracker/?func=add&group_id=1&atid=200001
X-Virus-Scanned: by AMaViS perl-11

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 12/27/03 18:33, Pavel Machek wrote:
| Select either PM_DISK or SOFTWARE_SUSPEND but not both. Thanks.
ok, I tried the following without the AGP/DRM modules (specifically,
'agpgart', 'intel-agp' and 'i830'):

- - PM_DISK > the OS enters ok in S4, but the resume process doesn't work
(not with resume=/dev/hda6, not with pmdisk=/dev/hda6 neither without).
I got a resume on my ext3 partitions, but the swap isn't lost

- - SWSUSP > it works! But, obviously, as I wrote above, without the
AGP/DRM modules. Anyway, I got a perfect S4, a perfect resume and after
the resume I can successfully resume or shutdown :-)

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/8cnLVAp7Xm10JmkRAnBsAKCFwN1+Ne4u3wd8HgVZB07z80r5aQCgjhVw
xLuaLzjm87MZleKdnsOKZrg=
=LeHG
-----END PGP SIGNATURE-----




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


--------------000408050600010003000006--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

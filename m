From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M6800N: processor has only C1
Date: Fri, 05 Mar 2004 18:49:42 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4048BDB6.2040607@pca.it>
References: <404459FD.1000406@pca.it> <40471A4F.2090909@renninger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40471A4F.2090909-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 03/04/04 13:00, Thomas Renninger wrote:
> I had the same problem.
> Your machine supports the C4 state.
> Change the P_BLK  in your DSDT to 0x06
>
> e.g.:
>    Processor (\_PR.CPU0, 0x01, 0x00001010, 0x07)
> to:
>    Processor (\_PR.CPU0, 0x01, 0x00001010, 0x06)
with all Bruno's patches in this thread and if I change in my DSDT
=====
     Scope (\_PR)
     {
- -        Processor (CPU1, 0x01, 0x00000410, 0x07)
+        Processor (CPU1, 0x01, 0x00000410, 0x06)
         {
             Method (_CST, 0, NotSerialized)
             {
=====

I get
=====
gismo:/# dmesg | grep Processor
ACPI: Processor [CPU1] (supports C1 C2, 8 throttling states)

gismo:/# cat /proc/acpi/processor/CPU1/info
processor id:            0
acpi id:                 1
bus mastering control:   yes
power management:        yes
throttling control:      yes
limit interface:         yes

gismo:/# cat /proc/acpi/processor/CPU1/limit
active limit:            P0:T0
user limit:              P0:T0
thermal limit:           P0:T0

gismo:/# cat /proc/acpi/processor/CPU1/power
active state:            C2
default state:           C1
bus master activity:     00000000
states:
   C1 [1]:               promotion[C2] demotion[--] latency[000] usage[00000010]
  *C2 [2]:               promotion[--] demotion[C1] latency[001] usage[00475240]

gismo:/# cat /proc/acpi/processor/CPU1/throttling
state count:             8
active state:            T0
states:
   *T0:                  00%
    T1:                  12%
    T2:                  25%
    T3:                  37%
    T4:                  50%
    T5:                  62%
    T6:                  75%
    T7:                  87%
=====

> or use the patch from Pavel, posted on the 28.02.2004, 17:10.
With Pavel's patch (posted 20040228 at 17:10) I get the same results.

Again the same results if I don't apply Bruno's patches about _CST methods for
C4, with the exception of
=====
@gismo:/$ cat /proc/acpi/processor/CPU1/power
active state:            C2
default state:           C1
bus master activity:     00000000
states:
   C1:                  promotion[C2] demotion[--] latency[000] usage[00050830]
  *C2:                  promotion[--] demotion[C1] latency[099] usage[00350099]
   C3:                  <not supported>
=====

I re-read the thread 'ACPI C4 support' where Pavel posted his patch to allow
'pblk_length' of 7. I'm not an expert not a programmer, but from what I had
read, it seems that:
- - Pavel's patch could be a good workaround, but Andrew Grover wouldn't avoid it
- - 'pblk_length' can have only 0 or 6 (7 is a bad value)
- - 'iasl' compiler (win32/20040220 and linux/20030918) doesn't recognize
  'pblk_length' of 7 as a bad value (neither as a warning)

Now, my /simple/ question: should I modify my DSDT (as in the first case) or use
Pavel's patch (as in the second) to avoid the 'pblk_length' error?

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD4DBQFASL21VAp7Xm10JmkRAqtyAJihn4lDORPlekXeHzTJL8TfZB0YAJsE6iki
DGM7jSfqkWAufDF82/Q8ig==
=gDrQ
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Compaq Presario 2800T
Date: Sat, 3 Aug 2002 16:06:09 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020803220614.21895.qmail@scrye.com>
References: <200208010551.BAA23125@biohazard-cafe.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200208010551.BAA23125-6sBejHMmrpxoPFBmMDZSOjyo3AZ8UMn9@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Just thought I would update everyone on my presario 2800 acpi
progress. 

Once I modified the dsdt with the correct tool (thanks for the
pointer), most everything is working!

Software suspend still seems to work well. 

Some questions: 

With the processor information in /proc/acpi/processor, I have: 

info:
processor id:            0
acpi id:                 1
bus mastering control:   yes
power management:        yes
throttling control:      yes
performance management:  yes
limit interface:         yes

limit:
active limit:            P0:T0
platform limit:          P0:T0
user limit:              P0:T0
thermal limit:           P0:T0

performance:
state count:             2
active state:            P0
states:
   *P0:                  1800 MHz, 20000 mW, 500 uS
    P1:                  1200 MHz, 10000 mW, 500 uS

power:
active state:            C2
default state:           C1
bus master activity:     ffffffff
states:
    C1:                  promotion[C2] demotion[--] latency[000] usage[00193030]
   *C2:                  promotion[C3] demotion[C1] latency[002] usage[25563637]
    C3:                  promotion[--] demotion[C2] latency[085] usage[00000234]


throttling:
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

The only thing I can change is the "throttling" setting. Is that just
cpu idling? or something else? 

It doesn't seem to want to let me change "power" or "performance". Any
ideas? 

Also, the brightness buttons (Fn-F7 and Fn-F8) work ok in the bios,
but don't seem to do anything once linux is booted. Is that ACPI
related? Something else?

Also, this is a interesting one... the lid button is registered and it
shows an ACPI event each time it closes or opens, but it doesn't show
if it's closed or open, just a incremented number. any way to tell
which state the lid is in? ie, a close, open lid cycle shows as: 

[Sat Aug  3 16:04:55 2002] received event "button/lid C11D 00000080 00000021"
[Sat Aug  3 16:04:55 2002] completed event "button/lid C11D 00000080 00000021"

[Sat Aug  3 16:05:01 2002] received event "button/lid C11D 00000080 00000022"
[Sat Aug  3 16:05:01 2002] completed event "button/lid C11D 00000080 00000022"

so, 21 and 22... next time will be 23 and 24, etc.. Do I just odd/even
to detemine if the lid is closed?

Thanks for all the help on this list... you guys have been great. I am
quite happy with the laptop now. 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.6 and Gnu Privacy Guard <http://www.gnupg.org/>

iD8DBQE9TFPW3imCezTjY0ERAlIjAJ4lehM4D4j4yeKz91ls29f/roKyRACgg/jM
chs01y7UwUfmam1h2SFtT4w=
=iPax
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

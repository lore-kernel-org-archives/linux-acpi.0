From: =?iso-8859-1?q?Jouni=20Laakso?= <jounijl-/E1597aS9LT10XsdtD+oqA@public.gmane.org>
Subject: RE: RTC alarm wake from mechanical power off
Date: Tue, 18 Nov 2003 09:20:03 +0000 (GMT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031118092003.44040.qmail@web25006.mail.ukl.yahoo.com>
References: <F760B14C9561B941B89469F59BA3A84702C93127@orsmsx401.jf.intel.com>
Reply-To: jounijl-/E1597aS9LT10XsdtD+oqA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84702C93127-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Ok. I read from section 4.7.2.4 that wake from s4 is
optional and if implemented in motherboard it should
work in sleep states 1-3. RTC alarm seems to be
optional as a whole as a hardware feature.

Bits RTC_EN and RTC_STS in spec are similar as those
in chips registers. Centenary value CENT is not
supported (if there is not extra space in CMOS RAM to
implement it with a driver?).

Acpi spec includes these lines:
 "The OS will disable the RTC_EN bit prior to entering
the G2/S5 or G3 states." [acpi,4.7.2.4]

If hardware rtc alarm is supported, rtc alarm is
disabled by acpi when entering to G3, shutdown? In my
case it's not even possible to write to these
registers, maby the writes are possible if ACPI is
disabled? I mean that writing is possible, but when
reading, the values are not changed. Are rtc-registers
somehow updated by ACPI-driver so that if rtc-alarm
feature is not found, it tries to disable it by
setting standard bit values trough acpi? Is it
possible that bios disables RTC alarm if it finds that
acpi is used? Should I blame bios or acpi?

What is the purpose to try to disable RTC alarm when
shutting down the computer? At startup it could save
previous values from registers and when entering G2/S5
or G3 again, it maby could return saved previous
values when shutting sown? My opinion is that it
should wake optionally from G3 also.. maby in next
specification revision?

It seems in my case that hardware RTC alarm is not in
use (Abit ZM6, Intel 82371eb)?

regards,

Jouni

 --- "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
> > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On
> Behalf Of 
> > Karol Kozimor
> > Thus wrote Jouni Laakso:
> > > Acpi specification says at page 75 that Real
> time
> > > clock alarm is required, but it's optional as
> fixed
> > > hardware event. I think this means that computer
> can
> > > optionally be woken up from "Mechanical Off" G3?
> Am I
> > > right? (I haven't read it all.)
> > 
> > AFAIR, you're supposed to be able to wake up from
> ACPI S5 state (soft
> > power-off), which is what shutdown -h should do.
> Anyway, see 
> > if any of the
> > patches found at
> http://bugme.osdl.org/show_bug.cgi?id=1320 help.
> > Best regards,
> 
> Have you read section 4.7.2.4 of the ACPI spec? RTC
> appears to wake only
> from S1-S3 and possibly S4.
> 
> Regards -- Andy 


=====
_____________________
Jouni J. Laakso
jounijl-/E1597aS9LT10XsdtD+oqA@public.gmane.org
phone: +358-41-5165554
Helsinki, Finland

,

________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://mail.messenger.yahoo.co.uk


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl

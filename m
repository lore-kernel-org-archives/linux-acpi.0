From: =?iso-8859-1?q?Jouni=20Laakso?= <jounijl-/E1597aS9LT10XsdtD+oqA@public.gmane.org>
Subject: RE: RTC alarm wake from mechanical power off
Date: Sat, 29 Nov 2003 19:45:32 +0000 (GMT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031129194532.56831.qmail@web25001.mail.ukl.yahoo.com>
Reply-To: jounijl-/E1597aS9LT10XsdtD+oqA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Thanks for the help. If anyone asks the same question
again, the right place to look into is
/include/linux/rtc.h and /driver/rtc.c. It's necessary
to compile kernel with option "Character
devices"-->"Enhanced real time support". Still this is
not part of acpi but for you to know if someone asks
again.. This is not supposed to be in acpi list.

Alarm feature is somehow implemented allready in rtc.c
(allthough some ioctl cmd:s seems to be missing). In
my case, writing:
--------clip--------
  if((rtc_fd = open("/dev/rtc", O_WRONLY)) == -1){
    fprintf(stderr, "Could not open /dev/rtc for
writing.\n");
    perror("open");
    return -1;
  }
  if(ioctl(rtc_fd, RTC_ALM_SET, time)<0){
    perror("set: ioctl error\n");
    return -1;
  }
  close(rtc_fd);
--------clip--------
produces:
[root-ogj+s9UvmiI@public.gmane.org uspace]# ./wake
set: ioctl error
: Bad address
[root-ogj+s9UvmiI@public.gmane.org uspace]#

Thus, somehow this can't be done with my computer :(.
Don't know why. I allready disabled PCI_bios_address
mode but it did not help.

Anyways, I'm happily using apic. Many thanks to the
developers for the effort! I don't use much else than
shutdown, because I use desktop, but apic seems to be
working fine considering the use and my equipement
troubles and what can be read from /proc directory.

best regards,

Jouni

 --- Jouni Laakso <jounijl-/E1597aS9LT10XsdtD+oqA@public.gmane.org> wrote: > 
> Ok. I read from section 4.7.2.4 that wake from s4 is
> optional and if implemented in motherboard it should
> work in sleep states 1-3. RTC alarm seems to be
> optional as a whole as a hardware feature.
> 
> Bits RTC_EN and RTC_STS in spec are similar as those
> in chips registers. Centenary value CENT is not
> supported (if there is not extra space in CMOS RAM
> to
> implement it with a driver?).
> 
> Acpi spec includes these lines:
>  "The OS will disable the RTC_EN bit prior to
> entering
> the G2/S5 or G3 states." [acpi,4.7.2.4]
> 
> If hardware rtc alarm is supported, rtc alarm is
> disabled by acpi when entering to G3, shutdown? In
> my
> case it's not even possible to write to these
> registers, maby the writes are possible if ACPI is
> disabled? I mean that writing is possible, but when
> reading, the values are not changed. Are
> rtc-registers
> somehow updated by ACPI-driver so that if rtc-alarm
> feature is not found, it tries to disable it by
> setting standard bit values trough acpi? Is it
> possible that bios disables RTC alarm if it finds
> that
> acpi is used? Should I blame bios or acpi?
> 
> What is the purpose to try to disable RTC alarm when
> shutting down the computer? At startup it could save
> previous values from registers and when entering
> G2/S5
> or G3 again, it maby could return saved previous
> values when shutting sown? My opinion is that it
> should wake optionally from G3 also.. maby in next
> specification revision?
> 
> It seems in my case that hardware RTC alarm is not
> in
> use (Abit ZM6, Intel 82371eb)?
> 
> regards,
> 
> Jouni
> 
>  --- "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> wrote:
> > > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
> > > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]
> On
> > Behalf Of 
> > > Karol Kozimor
> > > Thus wrote Jouni Laakso:
> > > > Acpi specification says at page 75 that Real
> > time
> > > > clock alarm is required, but it's optional as
> > fixed
> > > > hardware event. I think this means that
> computer
> > can
> > > > optionally be woken up from "Mechanical Off"
> G3?
> > Am I
> > > > right? (I haven't read it all.)
> > > 
> > > AFAIR, you're supposed to be able to wake up
> from
> > ACPI S5 state (soft
> > > power-off), which is what shutdown -h should do.
> > Anyway, see 
> > > if any of the
> > > patches found at
> > http://bugme.osdl.org/show_bug.cgi?id=1320 help.
> > > Best regards,
> > 
> > Have you read section 4.7.2.4 of the ACPI spec?
> RTC
> > appears to wake only
> > from S1-S3 and possibly S4.
> > 
> > Regards -- Andy 
> 
> 






>

________________________________________________________________________
Download Yahoo! Messenger now for a chance to win Live At Knebworth DVDs
http://www.yahoo.co.uk/robbiewilliams


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
